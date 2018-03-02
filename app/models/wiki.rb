<<<<<<< HEAD
class Wiki < ApplicationRecord
  belongs_to :user

end
=======
class Wiki < ApplicationRecord
  belongs_to :user

    after_initialize :set_defaults

    scope :is_public, -> { where(private: false) }
    scope :owned_by, -> (user) { where(user: user) }

    private

    def set_defaults
      self.private ||= false
    end
end
>>>>>>> master
