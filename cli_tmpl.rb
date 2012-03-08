# coding: utf-8

require "fileutils"

module CreateTmpl
  extend self
  
  def run(argv)
    @name = argv
    @capitalize = argv.capitalize
    create_dir
    create_rootfile
    create_batch
    chmod_batch
    create_lib
    create_version
    create_command
  end

  def create_dir
    FileUtils.mkdir_p("#{@name}")
    FileUtils.mkdir_p("./#{@name}/bin")
    FileUtils.mkdir_p("./#{@name}/lib")
    FileUtils.mkdir_p("./#{@name}/lib/#{@name}")
  end

  def create_rootfile
    File.open("./#{@name}/Gemfile", "w") do |f|
      f.write <<GEMFILE
source "http://rubygems.org"

GEMFILE
    end
    File.open("./#{@name}/README.md", "w") do |f|
      f.write <<README
# #{@capitalize} 

* 
* 

## Install

    $ 
    $ 


## Usage

    $ ./bin/#{@name}
    

    
README
    end
  end
  
  def create_batch
    File.open("./#{@name}/bin/#{@name}", "w") do |f|
      f.write <<BATCH
#!/usr/bin/env ruby

$:.unshift File.expand_path("../../lib", __FILE__)

require "#{@name}"

#{@capitalize}.run(ARGV)

BATCH
    end
  end
  
  def chmod_batch
    FileUtils.chmod(0755, "./#{@name}/bin/#{@name}")
  end
  
  def create_lib
    File.open("./#{@name}/lib/#{@name}.rb", "w") do |f|
      f.write <<LIB
require "#{@name}/version"
require "#{@name}/command"

LIB
    end
  end
  
  def create_version
    File.open("./#{@name}/lib/#{@name}/version.rb", "w") do |f|
      f.write <<VERSION
module #{@capitalize}
  VERSION = "0.0.1"
end

VERSION
    end
  end

  def create_command
    File.open("./#{@name}/lib/#{@name}/command.rb", "w") do |f|
      f.write <<COMMAND
# encoding: utf-8
#require ""

module #{@capitalize}
  extend self
  
  def run(argv)
  
  end

end

COMMAND
    end
  end

end

# run script
CreateTmpl.run(ARGV[0])

