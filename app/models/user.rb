class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || crypted_password_changed? } # or you can use changes[:crypted_password] instead of crypted_password_changed? if you wish
  # the confirmation setting checks whether the password and password_confirmation match
  validates :password, confirmation: true, if: -> { new_record? || crypted_password_changed? }
  validates :password_confirmation, presence: true, if: -> { new_record? || crypted_password_changed? }

  validates :email, uniqueness: true

  def admin=(type)
    # Handles passing string from forms, can also accept boolean
    if type == "Admin" || type
      admin = true
    else
      admin = false
    end
    super(admin)
  end

end
