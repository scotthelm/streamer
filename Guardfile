notification :off unless ENV['GNTP_NOTIFY']
notification :gntp, host: '10.0.2.2', sticky: false if ENV['GNTP_NOTIFY']

guard :rake, task: :test do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { 'spec' }
  watch('spec/spec_helper.rb')  { 'spec' }
end

guard :rubocop do
  watch(%r{/.+\.rb$/})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
