# Set up a [Json Server](https://egghead.io/lessons/javascript-creating-demo-apis-with-json-server) for data

## Run it from a GitHub repo
pros
- easy to setup

cons
- You are not able to create, update und delete the data.  


Use this Url in the request:
```
https://my-json-server.typicode.com/maexeler/jsondata
```


## Run a Json Serval localy and publish it to the Web
pros
- You are able to create, read, update und delete the data.
- Your data persists localy in a jsom file.  

cons
- You have to bring the server to the Web

First install json server with npm:

```
npm install -g json-server
```

- Then create a file db.json with the content:

```
{ "cookies" : [
        {
            "id": "1",
            "wisdom": "Love is everything",
            "author": "(unknown)"
        },
        {
            "id": "2",
            "wisdom": "Make love not war",
            "author": "The Hippies"
        }
    ] 
}
```

Afterwards start the Json Server an port 3000
```
json-server db.json
```
in the same directory.

# Bring up the server to the web
You may have to [install](https://ngrok.com/docs/getting-started) ngrok first.

run
```ngrok http 3000```
in a terminal, copy the forwarding Url and paste it into the [WebRepository](../lib/repository/cookie_repository_web.dart).


