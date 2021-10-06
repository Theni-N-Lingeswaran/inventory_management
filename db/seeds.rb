# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


SidePanelLink.destroy_all
SidePanelLink.create([{link_name: 'Dashbord', parent_link_id: nil, link_icon: 'fa fa-laptop-house', link_url: '/', link_for: [1,2,3]}, {link_name: 'Settings', parent_link_id: nil, link_icon: 'fa fa-cogs', link_url: '/settings/[token]', link_for: [1,2]}, {link_name: 'Profile', parent_link_id: nil, link_icon: 'fa fa-user-cog', link_url: '/profile_settings/[token]', link_for: [1,2,3]}, {link_name: 'Manage Invoices', parent_link_id: 2, link_icon: 'fa fa-file-invoice', link_url: '/manage_invoices/[token]', link_for: [1,2]}, {link_name: 'Manage Complaints', parent_link_id: 2, link_icon: 'fa fa-radiation-alt', link_url: '/manage_complaints/[token]', link_for: [1,2]}, {link_name: 'Manage Products', parent_link_id: 2, link_icon: 'fa fa-cubes', link_url: '/manage_products/[token]', link_for: [1,2]}, {link_name: 'Manage categories', parent_link_id: 2, link_icon: 'fa fa-list', link_url: '/manage_categories/[token]', link_for: [1,2]}, {link_name: 'Manage Customers', parent_link_id: 2, link_icon: 'fa fa-user-tie', link_url: '/manage_customers/[token]', link_for: [1,2]}, {link_name: 'Manage Employees', parent_link_id: 2, link_icon: 'fa fa-user', link_url: '/manage_users/[token]', link_for: [1]}, {link_name: 'My Profile', parent_link_id: 3, link_icon: 'fa fa-user-shield', link_url: '/my_profile/[token]', link_for: [1,2]}, {link_name: 'My Company Profile', parent_link_id: 3, link_icon: 'fa fa-building', link_url: '/company_profile/[token]', link_for: [1]}])

User.destroy_all
User.create!([{contact_name: 'Super User', contact_number: '9566337623', alternate_contact_number: '8710479062', role: 1, email:'lingeswaran66@gmail.com', password: '123456', encrypted_password: '$2a$12$nKFzHK8FYmM5tAQFqu8fUeWZsx0VUy1wd4emFbbnPq/.LiFCNPbSO'}, {contact_name: 'Admin', contact_number: '1111111111', alternate_contact_number: '', role: 1, email:'admin@gmail.com', password: '123456', encrypted_password: '$2a$12$nKFzHK8FYmM5tAQFqu8fUeWZsx0VUy1wd4emFbbnPq/.LiFCNPbSO'}, {contact_name: 'Employee', contact_number: '2222222222', alternate_contact_number: '', role: 2, email:'employee@gmail.com', password: '123456', encrypted_password: '$2a$12$nKFzHK8FYmM5tAQFqu8fUeWZsx0VUy1wd4emFbbnPq/.LiFCNPbSO'}, {contact_name: 'User', contact_number: '3333333333', alternate_contact_number: '', role: 3, email:'user@gmail.com', password: '123456', encrypted_password: '$2a$12$nKFzHK8FYmM5tAQFqu8fUeWZsx0VUy1wd4emFbbnPq/.LiFCNPbSO'}])

Customer.destroy_all
Customer.create!([{customer_name: 'Test Customer', customer_phone: '1234567890', customer_email: 'test_customer@gmail.com', customer_address: 'Test Customer Address'}, {customer_name: 'Test Customer1', customer_phone: '1111111111', customer_email: 'test_customer1@gmail.com', customer_address: 'Test Customer Address1'}])

LinkedCustomer.destroy_all
LinkedCustomer.create!([{customer_id: 1, user_id: 2}, {customer_id: 2, user_id: 4}])

Category.destroy_all
Category.create!([{category_name: 'Printer'}, {category_name: 'System'}, {category_name: 'Ink-jet', category_id: 1},{category_name: 'Laser-jet', category_id: 1},{category_name: 'Desktop', category_id: 2},{category_name: 'laser-jet', category_id: 2}])

Product.destroy_all
Product.create([{product_name: 'marq-printer', product_code:'marq12345', product_detail:'dot-matrix printer', category_id: 3}, {product_name: 'Acer laptop', product_code:'laptop12345', product_detail:'touch screen with optical mouse', category_id: 4}])

LinkedProduct.destroy_all
LinkedProduct.create!([{product_id: 1, customer_id: 2, user_id: 3}, {product_id: 2, customer_id: 2, user_id: 3}])

Compliant.destroy_all
Compliant.create!([{complaint_details: 'Printer not working', product_id: 1, user_id: 2, remarks: 'Dead Condition', estimation_date: '2021-12-24', total_amount: '2553', status: 1}, {complaint_details: 'Display not working', product_id: 2, user_id: 2, remarks: 'Display problem', estimation_date: '2021-12-24', total_amount: '5000', status: 2}])

Invoice.destroy_all
Invoice.create!([{compliant_id: 1, user_id: 2, total_amount: '2553', part_amount: '553'}, {compliant_id: 1, user_id: 2, total_amount: '2553', part_amount: '500'}, {compliant_id: 1, user_id: 2, total_amount: '5000', part_amount: '553'}, {compliant_id: 2, user_id: 2, total_amount: '5000', part_amount: '2500'}, {compliant_id: 2, user_id: 2, total_amount: '5000', part_amount: '1500'}, {compliant_id: 2, user_id: 2, total_amount: '5000', part_amount: '1000'}])