The `index.pl` script indexes all sysadvent posts till now using elasticsearch, and uses the [Blogger API](https://developers.google.com/blogger/) to retrieve posts. So, you need an [API Key](https://developers.google.com/blogger/docs/3.0/using#APIKey) to access the api and set `$apikey` in the script. Only the url, title and publishing date are displayed, but you can search on all or selective fields.  
Some example queries (edited out some metadata):
    
    $ curl 'localhost:9200/advent/_search?q=lables:puppet&pretty=true'
    {
    "hits": {
      "hits": [
        {
          "_index": "advent",
          "_type": "sysadvent",
          "_id": "FrBN5qW9TkCTexa5iB12wA",
          "_score": 1.3651153,
          "_source": {
            "title": "Scaling Operability with Truth",
            "published": "2010-12-12T01:10:00-08:00",
            "url": "http://sysadvent.blogspot.com/2010/12/day-12-scaling-operability-with-truth.html"
          }
        },
        {
          "_index": "advent",
          "_type": "sysadvent",
          "_id": "KVXS6VlQQ4qO9wVbPSYatA",
          "_score": 1.1700988,
          "_source": {
            "title": "Capistrano or Puppet?",
            "published": "2008-12-12T01:22:00-08:00",
            "url": "http://sysadvent.blogspot.com/2008/12/day-12-capistrano-or-puppet.html"
          }
        }
      ]
     }
    }

    $ curl 'localhost:9200/advent/_search?q=content:monitoring&pretty=true'
    {
      "hits": {
        "hits": [
          {
            "_index": "advent",
            "_type": "sysadvent",
            "_id": "gvGs1V8xT464JfA_JrJ7tA",
            "_score": 0.20470792,
            "_source": {
              "title": "Who Watches the Watcher?",
              "published": "2009-12-18T02:07:00-08:00",
              "url": "http://sysadvent.blogspot.com/2009/12/day-18-who-watches-watcher.html"
            }
          },
          {
            "_index": "advent",
            "_type": "sysadvent",
            "_id": "KWrBCFo-T_eRuqqE2Zc-lA",
            "_score": 0.18549284,
            "_source": {
              "title": "Looking for Trouble",
              "published": "2009-12-11T00:40:00-08:00",
              "url": "http://sysadvent.blogspot.com/2009/12/day-11-looking-for-trouble.html"
            }
          },
          {
            "_index": "advent",
            "_type": "sysadvent",
            "_id": "Bmn05vDjROK6ZYa6ESJTMg",
            "_score": 0.16668946,
            "_source": {
              "title": "Automating Web Monitoring",
              "published": "2011-12-21T00:01:00-08:00",
              "url": "http://sysadvent.blogspot.com/2011/12/day-21-automating-web-monitoring.html"
            }
          },
          {
            "_index": "advent",
            "_type": "sysadvent",
            "_id": "E24VK9lZRIO2ewnybvxT2w",
            "_score": 0.15944588,
            "_source": {
              "title": "Monitoring with Xymon",
              "published": "2009-12-17T01:42:00-08:00",
              "url": "http://sysadvent.blogspot.com/2009/12/day-17-monitoring-with-xymon.html"
            }
          },
          {
            "_index": "advent",
            "_type": "sysadvent",
            "_id": "qHJl7ygcSyWZjrkh05OLGQ",
            "_score": 0.15400729,
            "_source": {
              "title": "Aggregating Monitoring Checks for Better Alerts",
              "published": "2010-12-06T01:50:00-08:00",
              "url": "http://sysadvent.blogspot.com/2010/12/day-6-aggregating-monitoring-checks-for.html"
            }
          }
        ]
      }
    }



