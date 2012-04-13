class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :username, :display_name, :first_name, :last_name, :email, 
    :password, :password_confirmation, :admin

  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password
  validates :email, :uniqueness => true
  validates :first_name, :last_name, :presence => true 
  validates :display_name, :allow_blank => true, :length => { :in => 2..32 }
  has_one :shopping_cart
  has_many :orders
  has_many :shipping_addresses
  has_many :billing_addresses

  def cart?
    if shopping_cart.nil?
      false
    else
      true
    end
  end
  
  def admin?
    admin
  end
end
