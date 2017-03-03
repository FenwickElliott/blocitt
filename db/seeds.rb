require 'random_data'

# Create Users
5.times do
    User.create!(
    name:     RandomData.random_name,
    email:    RandomData.random_email,
    password: RandomData.random_sentence
    )
end
users = User.all

# Create Topics
15.times do
  Topic.create!(
    name:         RandomData.random_sentence,
    description:  RandomData.random_paragraph
  )
end
topics = Topic.all

20.times do
    Advertisement.create!(
    title: RandomData.random_sentence,
    copy: RandomData.random_paragraph,
    price: rand(1..999)
    )
end
advertisements = Advertisement.all


# Create Posts
50.times do
# #1
  Post.create!(
# #2
    user: users.sample,
    topic: topics.sample,
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
  )
end
posts = Post.all

# Create Comments
# #3
100.times do
  Comment.create!(
# #4
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

user = User.first
user.update_attributes!(
    name: 'Charles',
    email: 'charles.fenwick.elliott@gmail.com',
    password: 'helloworld'
    )


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Advertisement.count} advertisements created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
