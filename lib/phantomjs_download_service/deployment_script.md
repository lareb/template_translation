# Introduction

File named app.js in the current directory is a service that uses phantomjs to render PDF, PNG and JPG files from html

# Running the script

## Dependencies
    - NodeJS
    - PhantomJS
    - NPM

## Scripts

Run command to install NodeJS

```
sudo yum install nodejs
```

Run command to install PhantomJS

```
sudo yum install phantomjs
```

Install pm2 (script manager for Node)

```
sudo npm install pm2 -g
```

Enter directory that contains service code

```
cd /directory/that/contains/rails/app/lib/phantomjs_download_service/
```

Install node packages

```
npm install
```

Create ecosystem file

```
pm2 ecosystem
```

Run ecosystem file to activate app.js in the background
This will run the service on PORT=8000

```
pm2 start ecosystem.config.js
```

List all pm2 processes by running

```
pm2 list
```

If the service needs to be stopped, run

```
pm2 stop <id of service from pm2 list>
```

# Rails Integration

Add the lines to the environment file

```
DOWNLOAD_SERVICE_URL="http://localhost"
DOWNLOAD_SERVICE_PORT="8000"
```
