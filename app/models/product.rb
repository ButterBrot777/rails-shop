# frozen_string_literal: true

class Product < ApplicationRecord
  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true # rubocop warning: Uniqueness validation should be with a unique index.
  validates :image_url, allow_blank: true, format: {
    with: /\.(gif|jpg|png|jpeg)\z/i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
end
