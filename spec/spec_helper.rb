require 'pry'
Dir['/usr/src/app/lib/**/*.rb'].each do |file|
  require file
end
