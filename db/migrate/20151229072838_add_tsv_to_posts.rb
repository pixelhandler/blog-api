class AddTsvToPosts < ActiveRecord::Migration
  def up
    execute <<-DOC
      ALTER TABLE posts ADD COLUMN tsv tsvector;
      CREATE FUNCTION posts_generate_tsv() RETURNS trigger AS $$
      begin
        new.tsv :=
          setweight(to_tsvector('pg_catalog.english', coalesce(new.title, '')), 'A') ||
          setweight(to_tsvector('pg_catalog.english', coalesce(new.excerpt, '')), 'B') ||
          setweight(to_tsvector('pg_catalog.english', coalesce(new.body, '')), 'C');
        return new;
      end
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER posts_tsv_upsert_trigger BEFORE INSERT OR UPDATE
        ON posts
        FOR EACH ROW EXECUTE PROCEDURE posts_generate_tsv();

      UPDATE posts SET tsv =
        setweight(to_tsvector('pg_catalog.english', coalesce(title, '')), 'A') ||
        setweight(to_tsvector('pg_catalog.english', coalesce(excerpt, '')), 'B') ||
        setweight(to_tsvector('pg_catalog.english', coalesce(body, '')), 'C');

      CREATE INDEX posts_tsv_idx ON posts USING gin(tsv);
    DOC
  end

  def down
    execute <<-DOC
      DROP INDEX posts_tsv_idx;
      DROP TRIGGER posts_tsv_upsert_trigger ON posts;
      DROP FUNCTION posts_generate_tsv();
      ALTER TABLE posts DROP COLUMN tsv;
    DOC
  end
end
