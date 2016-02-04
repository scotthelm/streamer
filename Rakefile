require 'guard'

task :guards do
  Guard.setup
  Guard.state.session.plugins.all.each(&:run_all)
end

task default: :guards
