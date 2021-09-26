# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
User.create!([{contact_name: 'admin', contact_number: '9566337623', alternate_contact_number: '8710479062', role: 1, email:'admin@inventory.com', password: 123456}, {contact_name: 'employee', contact_number: '1111111111', alternate_contact_number: '1111111111', role: 2, email: 'employee@inventory.com', password: 123456}, {contact_name: 'customer', contact_number: '2222222222', alternate_contact_number: '2222222222', role: 3, email: 'customer@inventory.com', password: 123456}])

Category.destroy_all
Category.create!([{category_name: 'Printer'}, {category_name: 'System'}])

SubCategory.destroy_all
SubCategory.create!([{sub_category_name: 'Ink-jet', category_id: 1},{sub_category_name: 'Laser-jet', category_id: 1},{sub_category_name: 'Desktop', category_id: 2},{sub_category_name: 'laser-jet', category_id: 2}])

Product.destroy_all
Product.create([{product_name: 'marq-printer', product_code:'marq12345', product_detail:'dot-matrix printer', sub_category_id: 1}, {product_name: 'Acer laptop', product_code:'laptop12345', product_detail:'touch screen with optical mouse', sub_category_id: 3}])

SidePanelLink.destroy_all
SidePanelLink.create([{link_name: 'Settings', parent_link_id: nil, link_icon: 'fas fa-cogs', link_url: '/settings', link_for: [1,2,3]}])