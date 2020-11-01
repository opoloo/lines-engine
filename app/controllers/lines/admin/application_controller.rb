# Parent controller for the whole admin area. All controllers for the +Admin+ namespace
# inherit from <tt>Admin::ApplicationController</tt>
# 
# The +authorize+ before filter ensures that all inherited controllers and actions 
# require a logged in user.
require_dependency "lines/application_controller"

module Lines
  module Admin
    class ApplicationController < Lines::ApplicationController
      protect_from_forgery

      before_action :authorize

      layout 'lines/admin'
    end
  end
end