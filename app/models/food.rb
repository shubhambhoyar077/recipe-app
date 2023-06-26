class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_food
  has_many :recipe, through: :recipe_food
end
