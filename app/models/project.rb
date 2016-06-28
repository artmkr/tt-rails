class Project < ActiveRecord::Base
  belongs_to :user

  has_many :requests, dependent: :destroy
  has_many :users, through: :requests

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
end
