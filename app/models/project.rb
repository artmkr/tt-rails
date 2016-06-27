class Project < ActiveRecord::Base
  has_many :requests
  has_many :users, through: :requests

  has_many :memberships
  has_many :users, through: :memberships
end
