echo "RUNNING RELEASE"
rake db:migrate
rake db:seed
echo "DONE WITH RELEASE"