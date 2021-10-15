# frozen_string_literal: true

class SidePanelLink < ApplicationRecord
  serialize :link_for, Array
  has_many :side_panel_sub_links, class_name: :SidePanelLink, foreign_key: :parent_link_id, dependent: :destroy
  belongs_to :side_panel_links, class_name: :SidePanelLink, optional: true
  scope :side_panel_main_links, -> { where(parent_link_id: nil) }
end
