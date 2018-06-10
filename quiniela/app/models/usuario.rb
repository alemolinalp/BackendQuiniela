class Usuario < ApplicationRecord
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)

    return nil if user.nil?
    return user if (user.contrasena == submitted_password)
  end
end
