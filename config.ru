require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Please run "rake db:migrate" to continue'
end

use Rack::MethodOverride
use GroceryListController
use UserController
run ApplicationController
