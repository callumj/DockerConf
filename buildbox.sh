curl "https://api.buildbox.io/v1/projects/callumj/dockerconf/builds?api_key=$BUILDBOX_API_KEY" \
-X POST \
-F "commit=master" \
-F "branch=master" \
-F "author[name]=Callum Jones" \
-F "author[email]=push@callumj.com" \
-F "message=Update push" 