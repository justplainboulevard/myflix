
# Do not use, as per K. Wang recommendation in week 7, lesson 6 video. Initially getting rid of this code caused 57 errors. Every one was:
# Failure/Error: Unable to find matching line from backtrace
#      Errno::EADDRINUSE:
#        Address already in use - bind(2) for 127.0.0.1:52662
# Restarting my computer and running the specs without first starting Redis and Foreman got everything passing again.

# class ActiveRecord::Base
#   mattr_accessor :shared_connection
#   @@shared_connection = nil

#   def self.connection
#     @@shared_connection || retrieve_connection
#   end
# end
# ActiveRecord::Base.shared_connection=ActiveRecord::Base.connection
