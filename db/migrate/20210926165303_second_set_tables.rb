# frozen_string_literal: true

class SecondSetTables < ActiveRecord::Migration[6.1]
  def change
    create_table :side_panel_links do |t|
      t.string :link_name, null: false, limit: 500
      t.references :parent_link, null: true
      t.string :link_icon, null: false, limit: 100
      t.string :link_url, null: false, limit: 500
      t.string :link_for, array: true, default: '[]'
      t.boolean :delist, default: 0
      t.timestamps
    end
    add_reference :compliants, :customer, foreign_key: true, index: true, after: :complaint_details
  end
end
