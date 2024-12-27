class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  # e.g., validate quantity
  validates :quantity, numericality: { greater_than: 0 }
end
