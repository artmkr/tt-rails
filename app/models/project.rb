class Project < ActiveRecord::Base
  belongs_to :user

  has_many :requests, dependent: :destroy
  has_many :users, through: :requests

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true, length: {minimum: 3}
  validates :description, presence: true
  validates :short_description, presence: true, length: {minimum: 10}

  self.per_page = 10
end
