class AddMyCompanyIdColumn < ActiveRecord::Migration[6.1]
  def change
    add_reference :categories, :company, foreign_key: { to_table: :customers }, index: true, after: :category_id
    add_reference :compliants, :company, foreign_key: { to_table: :customers }, index: true, after: :user_id
    add_reference :linked_customers, :company, foreign_key: { to_table: :customers }, index: true, after: :user_id
    add_reference :linked_products, :company, foreign_key: { to_table: :customers }, index: true, after: :user_id
    add_reference :users, :current_company, foreign_key: { to_table: :customers }, index: true, after: :role
  end
end
