# coding: utf-8
require "thor"
require "thor/group"
require "active_support/inflector"
require "fileutils"

module CreateTmpl
  class CLI < Thor::Group

    include Thor::Actions

    argument :name

    TEMPLATES_FILE = %w[
      Gemfile
      README.md
      bin/app
      lib/app.rb
      lib/app/command.rb
      lib/app/version.rb
    ]
    
    def self.source_root
      File.dirname(__FILE__)
    end

    def createfile
      TEMPLATES_FILE.each do |file|
        f = file.gsub("app", "#{name}")
        template("templates/" + file, "#{name}/#{f}")
      end
    end

    def chgfile
      FileUtils.chmod(0755, "#{name}/bin/#{name}")
    end

    def cli_complete
      say "Template files created.", :green
    end
  end
end

