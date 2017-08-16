#!/bin/bash

clear

PATH=/Users/<user>/<YOUR WEBSITES>
DESKTOP=/<PATH TO DESKTOP>/Desktop

cd $PATH
for d in *; do
 echo "######## GETTING LICENSES FROM PROJECT - "$d"  ###########"	
 PATH=/Users/<user>/<YOUR WEBSITES>
 cd $PATH
 tasks_path=$PATH'/'$d'/lib/tasks/'
 if [ -d "$tasks_path" ]; then 
  rake_file=$tasks_path'license.rake'
  /bin/cat <<EOM >$rake_file
task prepare_gem_licenses: :environment do
  puts 'Start prepare_gem_licenses rake'
  output_path = '/Users/<user>/<YOUR WEBSITES>'
  gem_hash = []
  Gem.loaded_specs.each do |_key, spec|
    gem_hash << {
      name: spec.name.to_s.tr('|', ' '),
      version: spec.version.to_s.tr('|', ' '),
      licenses: spec.licenses.join(',').tr('|', ' '),
      source: spec.homepage.to_s.tr('|', ' ')
    }
  end
  puts 'Writing to file my_licenses.csv'
  File.open(output_path + '/my_licenses.csv', 'a') do |f|
    gem_hash.each do |spec|
      f.puts "#{spec[:name]}|#{spec[:version]}|#{spec[:licenses]}|#{spec[:source]}"
    end
  end
  puts 'Finish prepare_gem_licenses rake'
end	
EOM

  cd $PATH'/'$d
  #echo $PWD
  R_VERSION='2.3.1'
  while read p; do
   stringarray=($p)
   first_w=${stringarray[0]}
   second_w=${stringarray[1]}
   if [ "$first_w" == 'ruby' ]; then
   	second_w="${second_w%\'}"
    second_w="${second_w#\'}"
   	R_VERSION=$second_w
   fi
  done <gemfile
  echo "Loading ruby version "$R_VERSION
  source "/<PATH TO RVM>/.rvm/environments/ruby-$R_VERSION"
  wait
  echo "Running bundle install"
  bundle install
  wait
  echo "Running rake"
  bundle exec rake RAILS_ENV=development prepare_gem_licenses
  wait
  echo "Done"
 fi
done

cd $DESKTOP





