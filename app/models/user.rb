class User < ActiveRecord::Base

	validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  # Adds functionality to save passwords securely using the Bcrypt algorithm.
  # when a user logs in again, has_secure_password will collect the password that was submitted,
  # hash it with bcrypt, and check if it matches the hash from password_digest column.
  has_secure_password

  # Call method after the SQL delete for User's objects
  after_destroy :ensure_at_least_an_admin_remains

  private

  # If the SQL transaction 'delete' raises an exception, roll it back.
  # Raising an exception inside a transaction causes an automatic rollback.
  # In this case restore the last deleted user.
  # 
  # The exception signals the error back to the controller, so we can report a flash to the user.
  def ensure_at_least_an_admin_remains
  	if User.count.zero?
  		raise "Can't delete last admin user!"
  	end
  end

end
