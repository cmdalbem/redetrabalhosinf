class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # If we delete the user, the person will be deleted too
  has_one :person, :dependent => :destroy

  # Automatically creates a person after this user is created
  after_create :create_person
  def create_person
    self.person = Person.new(name: :email, email: :email)
  end

end
