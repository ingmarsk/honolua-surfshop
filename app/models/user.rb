class User < ActiveRecord::Base

  # Validations

	validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  # Active Record callbacks

  # Handler method 
  before_save :set_default_user_role

  # Handler block (receives the object model as a param)
  after_create do |user|
    logger.info "User #{user.id} - #{user.first_name} created"
  end

  # Handler method 
  after_destroy :ensure_at_least_an_admin_remains

  # Adds functionality to save passwords securely using the Bcrypt algorithm.
  # when a user logs in again, has_secure_password will collect the password that was submitted,
  # hash it with bcrypt, and check if it matches the hash from password_digest column.
  has_secure_password

  # The buyers uses the app to browse the products that the sellers have to sell
  def buyer?
    self.role == 'buyer'
  end

  # The sellers uses the app to create and sell products
  def seller?
    self.role == 'seller'
  end

  # The admins uses the app to monitor and manage all products, users and their transactions 
  def admin?
    self.role == 'admin'
  end

  private

  # Assign role attr to 'buyer' if role is false or nil
  def set_default_user_role
    self.role ||= 'buyer'
  end

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
