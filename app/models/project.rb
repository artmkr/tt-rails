class Project < ActiveRecord::Base
  has_many :notes
  belongs_to :user

  has_many :requests, dependent: :destroy
  has_many :users, through: :requests

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true, length: {minimum: 3}
  validates :description, presence: true
  validates :short_description, presence: true, length: {minimum: 10}

  acts_as_taggable
  
  acts_as_votable

  self.per_page = 10
end
