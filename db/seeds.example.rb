# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Create an author of the post resources, an author may have a related user record
author = Author.create({ name: 'pixelhandler', email: 'pixelhandler@gmail.com' })

# Create a user, w/ credentials may login & use Auth header to create, edit & remove resources
User.create({
  username: 'xxxxxxxx',
  password: 'yyyyyyyy',
  author: author
})

# Load Post records from a JSON file, and assign the author to each
json = ActiveSupport::JSON.decode(File.read('db/seeds/posts.json'))
json.each do |post|
  record = Post.new post
  record.author = author;
  record.save!
end
