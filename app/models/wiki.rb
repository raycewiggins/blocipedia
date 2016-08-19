class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborations, as: :collaborable
  has_many :users, through: :collaborations
end
