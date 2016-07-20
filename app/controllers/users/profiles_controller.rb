class ProfilesController < ApplicationController
    def new
       # form where a user can fill out their own profile.
       @user = User.find( params[:user_id] )
#lets reach into database and find the user that is logged in
#params accessess the hash that is generated in the http response(URL). 
#The hash info in this case is in the user link in home.html.erb
#to demonstrate check the line below
#      @variable = params[:user_id]
#now goto 
       @profile = @user.build_profile #this works because we have the nested profile inside routes.rb
    end
end