class Profile < ActiveRecord::Base #Each profile must have a seperate record
    belongs_to :user
end
