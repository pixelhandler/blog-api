# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

author = Author.create({ name: 'admin', email: 'admin@me.com' })

post = Post.create({
  body: 'First post body',
  excerpt: 'First post excerpt',
  slug: 'first-post-slug',
  title: 'First post title',
  date: Date.new(2015, 5, 4),
  author: author
})

user = User.create({
  username: 'admin123',
  password: 'admin456',
  author: author
})