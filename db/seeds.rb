# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

gender = ['male', 'female']
option_match = ['A', 'B', 'C', 'D']

ActiveRecord::Base.transaction do
  puts "== Create Admin =="
  # User.create!(email: 'admin@example.com', password: 'Abc123456', fullName: 'Admin', gender: 'male',
  #   year_birthday: '6-9-1996', role: 1, address: 'Hanoi')

  puts "== Create User =="
  (1..5).each do |n|
	User.create!(email: "user#{n}@example.com", password: "Abc123456", fullName: "New User", 
	  gender: gender.sample, year_birthday: '6-9-1996', address: "No.#{n}, Hanoi")
  end

  puts "== Create Class =="
  (1..12).each do |n|
  	Category.create!(name: "Class #{n}")
  end

  puts "== Create Subject =="
  Subject.create!(name: "English")
  Subject.create!(name: "Math")
  Subject.create!(name: "Physical")

  puts "== Create Quiz"
  subjects = Subject.all.ids
  categories = Category.all.ids
  users = User.all.ids

  (1..60).each do |n|
  	Qbank.create!(question: "Question Test #{n}", optionA: 'Option A', optionB: 'Option B',
  	  optionC: 'Option C', optionD: 'Option D', option_match: option_match.sample, answer: 'Answer',
  	  user_id: users.sample, accept: 1, category_id: categories.sample, subject_id: subjects.sample)
  end

  puts "== Test =="
  Test.create!(name: "Quiz Test 2", description: "Description For Quiz Test 2", full_score: 990, duration: 120, category_id: 1, subject_id: 1, user_id: users.sample)

  test_id = Test.first.id

  Qbank.all.each do |q|
  	TestQbank.create!(qbank_id: q.id, test_id: test_id)
  end
end