class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :requests, dependent: :destroy
  has_many :projects, through: :requests

  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships

  has_many :projects, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  def is_admin?
    self.email && Settings.admins.emails.include?(self.email)
  end
end
