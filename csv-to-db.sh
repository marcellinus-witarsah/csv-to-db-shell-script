# define variables
extracted_file='extracted_data.txt'
transformed_file='transformed_data.txt'

# download the access log file
echo 'getting data'
rm web-server-access.log.txt.gz
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz

echo 'extract the data'
# unzip the .gz file
gunzip -v  web-server-access-log.txt.gz

echo 'preprocess the data'
# extract the file
cut -d '#' -f1-4 web-server-access-log.txt > $extracted_file

# transformed '#' to ','
tr '#' ',' < $extracted_file > $transformed_file 

echo 'input data to DB'
# input to the database
echo "\c template1; \COPY access_log FROM '$(pwd)/$transformed_file' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost


echo 'return database results'
# print out the database
echo '\c template1; \\SELECT * from access_log;' | psql --username=postgres --host=localhost 

