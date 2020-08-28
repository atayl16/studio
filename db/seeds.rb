# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user_list = [
  ['john@test.com', '111111', '111111', 'Owner', 'John', 'Snow', '123121'],
  ['gandalf@test.com', '111111', '111111', 'Owner', 'Gandal', 'Stormcrow', '123122'],
  ['pippin@test.com', '111111', '111111', 'Staff', 'Peregrin', 'Took', '123123'],
  ['aragorn@test.com', '111111', '111111', 'Staff', 'Aragorn', 'King', '123124'],
  ['legolas@test.com', '111111', '111111', 'Staff', 'Legolas', 'Elf', '123125'],
  ['elmo@test.com', '111111', '111111', 'Owner', 'Elmo', 'Monster', '123126'],
  ['grover@test.com', '111111', '111111', 'Staff', 'Grover', 'Monster', '123127'],
  ['bill@test.com', '111111', '111111', 'User', 'Bill', 'User', '123128'],
  ['admin@test.com', '111111', '111111', 'AdminUser', 'Admin', 'User', '123129'],
  ['alisha@test.com', '111111', '111111', 'AdminUser', 'Alisha', 'Taylor', '123120']
]

user_list.each do |email, password, password_confirmation, type, first_name, last_name, stripe_id|
  User.create(email: email, password: password, password_confirmation: password_confirmation, type: type, first_name: first_name, last_name: last_name, stripe_id: stripe_id)
end

Company.create(name: 'GoT', user_id: '1')
Company.create(name: 'LotR', user_id: '2')
Company.create(name: 'SS', user_id: '6')
