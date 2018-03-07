class User < ApplicationRecord
  include ActiveModel::Dirty
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :collaborators
  has_many :wikis, through: :collaborators
  after_initialize :set_defaults

  private

  def set_defaults
    self.role ||= "standard"
  end
end
