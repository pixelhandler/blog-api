# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

author = Author.create({ name: 'admin', email: 'admin@me.com' })

Post.create({
  body: 'First post body',
  excerpt: 'First post excerpt',
  slug: 'first-post-slug',
  title: 'First post title',
  date: Date.new(2015, 5, 4),
  author: author
})

User.create({
  username: 'admin123',
  password: 'admin456',
  author: author
})
