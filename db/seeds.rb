# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: 'Test User', username: 'test_user_1', email: 'testuser@example.com', password: 'password', password_confirmation: 'password')
User.create(name: 'Test Admin', username: 'test_admin_1', email: 'testadmin@example.com', password: 'password', password_confirmation: 'password', is_admin: true)