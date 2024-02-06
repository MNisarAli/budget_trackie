class Category < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :expenses, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :icon, presence: true, length: { maximum: 300 }
end
