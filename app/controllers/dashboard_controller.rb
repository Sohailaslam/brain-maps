class DashboardController < ApplicationController
    
    before_action :authenticate_user!
    
    def dashboard
        if(current_user.educator?)
          @edu = Educator.find_by_user_id(current_user.id)
        elsif(current_user.student?)
          @stu = Student.find_by_user_id(current_user.id)
        end
    end
    
    
end
