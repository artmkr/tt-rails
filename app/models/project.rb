class Project < ActiveRecord::Base
  has_many :requests
  has_many :users, through: :requests
end
