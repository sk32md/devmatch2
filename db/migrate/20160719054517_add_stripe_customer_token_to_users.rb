class AddStripeCustomerTokenToUsers < ActiveRecord::Migration
  def change
      add_column :users, :stripe_customer_token, :string 
  end #add a column to the user database and call it stripe ciutomer token as a string
end #bundle exec rake db:migrate after you created this
