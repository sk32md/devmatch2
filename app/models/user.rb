class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :plan
  attr_accessor :stripe_card_token
  
  def save_with_payment #method used in /app/controllers/users/registrations_controller.rb
    if valid?
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token) #using stripe gem to send out information to stripe server to create and charge customer and create customer id
      self.stripe_customer_token = customer.id #setting property of user to user id returned from stripe
      save! #saving entire user object to database by creating new migration file
    end
  end
end
