class Product < ApplicationRecord
    belongs_to :category
    belongs_to :seller, class_name: 'User'

    has_many_attached :images

    #Validations
    validates :name, presence: true, length: {maximum: 255}
    validates :description, presence: true, length: {maximum: 1000}
    validates :price, presence: true, numericality: {greater_than_or_equal_to: 0.01}
    validates :quantity_available, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :seller_id, presence: true
    validates :category_id, presence: true
end