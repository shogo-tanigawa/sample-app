class Task < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 100 }
end
