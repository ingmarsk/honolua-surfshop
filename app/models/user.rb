class User < ActiveRecord::Base

	validates :name, presence: true, uniqueness: true

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
