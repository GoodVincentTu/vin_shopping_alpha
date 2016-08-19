class Product < ApplicationRecord
	belongs_to :meta_item
	has_many :image_groups, dependent: :destroy

	accepts_nested_attributes_for :image_groups

	validates_presence_of :name, :description, :price
end
