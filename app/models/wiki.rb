class Wiki < ApplicationRecord
  include ActiveModel::Dirty

  belongs_to :author, polymorphic: true
  has_many :collaborators
  has_many :users, through: :collaborators

  after_initialize :set_defaults

  scope :is_public, -> { where(private: false) }
  scope :owned_by, -> (user) { where(user: user) }
  scope :collaborates_on, -> (user) { where(Collaborator.include?(user)) }
  private

  def set_defaults
    self.private ||= false
  end
end
