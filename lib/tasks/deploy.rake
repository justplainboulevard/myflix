
 require 'paratrooper'

 namespace :deploy do

   desc 'Deploy app in staging environment'

   task :staging do

     deployment = Paratrooper::Deploy.new('vast-sea-1450-staging', tag: 'staging')

     deployment.deploy
   end

   desc 'Deploy app in production environment'

   task :production do

     deployment = Paratrooper::Deploy.new('vast-sea-1450') do |deploy|

       deploy.tag              = 'production'
       deploy.match_tag        = 'staging'
       # deploy.maintenance_mode = !ENV['NO_MAINTENANCE'] # Gem changed. See this post: http://www.zaccodes.com/done-with-week-5-of-course-3-at-tealeaf-academy/.
     end

     deployment.deploy
   end
 end
