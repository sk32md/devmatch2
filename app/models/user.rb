class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :plan
  attr_accessor :stripe_card_token #stripe_card_token hidden field value
  
  def save_with_payment #method used in /app/controllers/users/registrations_controller.rb
    if valid? #If user filled out form properly
      customer = Stripe::Customer.create(description: email, plan: plan_id, source: stripe_card_token)
      self.stripe_customer_token = customer.id #setting property of user to user id returned from stripe
      save! #saving entire user object to database by creating new migration file
    end
  end
end
