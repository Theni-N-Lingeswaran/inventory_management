class CreateBasicTables < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :customer_name, null: false, unique: true, limit: 500
      t.string :customer_phone, null: false, unique: true, limit: 15
      t.string :customer_email, null: false, unique: true
      t.string :customer_address, null: false, limit: 5000
      t.boolean :delist, default: 0
      t.timestamps
    end

    create_table :linked_customers do |t|
      t.references :customer, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      t.boolean :delist, default: false
      t.timestamps
    end

    create_table :categories do |t|
      t.string :category_name, null: false, unique: true, limit: 500
      t.boolean :delist, default: false
      t.timestamps
    end

    create_table :sub_categories do |t|
      t.string :sub_category_name, null: false, unique: true, limit: 500
      t.references :category, foreign_key: true, index: true
      t.boolean :delist, default: false
      t.timestamps
    end

    create_table :products do |t|
      t.string :product_name, null: false, unique: true, limit: 250
      t.string :product_code, null: false, unique: true, limit: 100
      t.string :product_detail, null: true, limit: 2000
      t.references :sub_category, foreign_key: true, index: true
      t.boolean :delist, default: false
      t.timestamps
    end

    create_table :linked_products do |t|
      t.references :product, foreign_key: true, index: true
      t.references :customer, foreign_key: true, index: true
      t.boolean :delist, default: false
      t.timestamps
    end

    create_table :compliants do |t|
      t.string :complaint_details, null: false, limit: 5000
      t.references :product, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      t.string :remarks, null: true, limit: 5000
      t.date :estimation_date, null: true
      t.integer :status, default: 0
      t.boolean :delist, default: false
      t.timestamps
    end

    create_table :invoices do |t|
      t.references :compliant, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      t.string :total_amount, null: false, limit: 10
      t.string :part_amount, null: true, limit: 10
      t.boolean :delist, default: false
      t.timestamps
    end

  end
end
