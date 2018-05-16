class Wiki < ApplicationRecord
  include ActiveModel::Dirty

  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  after_initialize :set_defaults

  scope :is_public, -> { where(private: false) }
  scope :owned_by, -> (user) { where(user: user) }

  def is_collaboration_of(user)
    self.collaborators.include?(user)
  end
  private

  def set_defaults
    self.private ||= false
  end
end

