# Flask Gunicorn Container with json stdout

tweaked log stdout to json format.

credit to: https://stackoverflow.com/a/53587072

here is the sample output
```
{'remote_ip':'172.17.0.1','request_id':'-','response_code':'404','request_method':'GET','request_path':'/test','request_querystring':'','request_timetaken':'1761','response_length':'207'}
{'remote_ip':'172.17.0.1','request_id':'-','response_code':'200','request_method':'GET','request_path':'/','request_querystring':'','request_timetaken':'610','response_length':'17'}
```

## Get Started

### Docker Build
```bash
docker build -t cloudacode/gunicorn .
```

### Docker Run
```bash
docker run -p 8000:8000 -d cloudacode/gunicorn
or
docker run --env PORT=8090 --publish 8090:8090 --detach cloudacode/gunicorn
```