require 'pry'

def check_stale_pid pid_file
  if File.exists?(pid_file)
    stale_pid = File.open(pid_file, 'r') { |file| file.read }.to_i
    begin
      Process.getpgid( stale_pid )

      puts "Stale PID - Killing #{stale_pid}"
      Process.kill('HUP', stale_pid)

      while true #Until an exception occurs
        Process.getpgid( stale_pid )
        sleep(1)
      end
    rescue Errno::ESRCH
      File.delete(pid_file)
    end
  end
end

check_stale_pid('server.pid')
check_stale_pid('client.pid')

unless File.exists? './drew-web-client/dist/index.html'
  print 'Building drew-web-client... '
  result = system('npm run build --prefix ./drew-web-client/', out: 'test.out', err: 'test.out')
  if result
    puts 'Success'
  else
    puts 'Failed (check test.out for more info)'
    exit
  end
end

@__server_pid = spawn("BUNDLE_GEMFILE=./drew-server/Gemfile puma ./drew-server/config.ru -p 8001", out: "test.out")
npm_bin = `npm bin`.strip
client_command = "#{npm_bin}/ws -d ./drew-web-client/dist/ --spa index.html --rewrite '/api/* -> http://localhost:8001/api/$1'"
@__client_pid = spawn(client_command, out: "test.out", err: 'test.out')


File.open('server.pid', 'w') { |file| file.write(@__server_pid)}
File.open('client.pid', 'w') { |file| file.write(@__client_pid)}

require 'capybara/cucumber'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_driver = :chrome

at_exit do
  Process.kill('HUP', @__server_pid)
  File.delete('server.pid')
  Process.kill('HUP', @__client_pid)
  File.delete('client.pid')
end