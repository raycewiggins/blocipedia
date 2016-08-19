class User < ActiveRecord::Base
  has_many :collaborations
  has_many :wikis, through: :collaborations, source: :collaborable, source_type: :Wiki
  after_initialize :init

  def init
    self.role ||= :standard
  end

  enum role: [:standard, :premium, :admin]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #method used in forms to add collaborators to a wiki
  def self.update_users(user_string)
    return User.none if user_string.blank?

    user_string.split(',').map do |user|
      User.find_or_create_by(email: user.strip)
    end
  end
end
