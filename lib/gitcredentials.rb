GITCONFIG = "#{ENV['HOME']}/.gitconfig"

def gitconfig
  credentials = Hash.new

  if File.exists?(GITCONFIG)
    file = File.open(GITCONFIG)

    file.each do |line|
      if line.match(/name/)
        credentials["username"] = line.split(" ").last
      end

      if line.match(/password/)
        credentials["password"] = line.split(" ").last
      end
    end

    file.close
  else
    raise "gitconfig doesn't exist"
  end

  credentials
end
