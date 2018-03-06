<<<<<<< HEAD
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis

  after_initialize :set_role

  private

  def set_role
    self.role ||= "standard"
  end
end
=======
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis, dependent: :destroy

  after_initialize :set_defaults

  private

  def set_defaults
    self.role ||= "standard"
  end
end
>>>>>>> refs/heads/story-5-seeding-data
