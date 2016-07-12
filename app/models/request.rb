class Request < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :role, presence: true
end
