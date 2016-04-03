#!/usr/bin/ruby

GPIO_HOME="/sys/class/gpio"

if ARGV.empty?
  print "You have to specify GPIO port number.\n"
  exit 1
end

port = ARGV[0]
print "Use #{port}\n"

export = open("#{GPIO_HOME}/export", "w")
export.write(port)
export.close

direction = open("#{GPIO_HOME}/gpio#{port}/direction", "w")
direction.write("out")
direction.close

out = 1
value = "#{GPIO_HOME}/gpio#{port}/value"
20.times do
  v = open(value, "w")
  v.write(out)
  v.close
  out = out === 1 ? 0 : 1
  sleep 0.5
end

unexport = open("#{GPIO_HOME}/unexport", "w")
unexport.write(port)
unexport.close
