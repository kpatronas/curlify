# curlify
The lovechild of inotify and curl: Perform an http request to a url in case of a file-system event

# setup
Make the script executable
```
chmod +x ./curlify.sh
```
# How to use
If used without a URL (-u parameter) will just print the changes as JSON to STDOUT
```
./curlify.sh 
Setting up watches.  Beware: since -r was given, this may take a while!
Watches established.
{'ts':'2023-05-16T14:27:06','path':'/home/kpatronas/github/','file':'1.txt','event':'DELETE'}
```
If URL is used will by default POST the JSON to the specified URL

# Parameters

-e|--events: Inotify events, default: create,delete,modify
-p|--path: Path to look for changes, default: $PWD
-t|--ts: Timestamp format, default: %Y-%m-%dT%H:%M:%S
-u|--url: Url, if no used no curl action will be used, instead will just print to STDOUT
-m|--method: HTTP METHOD, default: POST
-c|--curl_parameters: Extended curl parameters
-i|--inotify_parameters: Extended inotify parameters
