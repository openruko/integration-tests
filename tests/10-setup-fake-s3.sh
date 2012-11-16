sudo gem install fakes3

echo "export S3_HOST=localhost" >> ~/.bashrc
echo "export S3_PORT=4567" >> ~/.bashrc
source ~/.bashrc

mkdir /tmp/fakes3
fakes3 -r /tmp/fakes3 -p $S3_PORT
