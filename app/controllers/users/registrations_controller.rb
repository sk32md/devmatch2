class Users::RegistrationsController < Devise::RegistrationsController  #given to us by Devise
    #creating a class Users and inheriting devise
    def create  #When the user submits their form
       super do |resource| #importing to create action code that is inside the devise gem
          if params[:plan] #when user submits basic or pro form
              resource.plan_id = params[:plan] #were going to cath that form and see if param :plan was submitted and if yes then we save to resource.plan_id
              if resource.plan_id == 2 # if User.first_plan.id = 2
                  resource.save_with_payment # if id does = 2 then we save_with_payment defined in models/user.rb otherwise
              else  #if id = 1
                  resource.save #just do a regular save to resources
              end
          end
       end
    end
    
end