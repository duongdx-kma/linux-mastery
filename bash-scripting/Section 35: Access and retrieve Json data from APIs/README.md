# Section 35: Access and retrieve Json data from APIs

## I. `curl` program

### 1. introduction:
```
curl:
- It's a program that allows us to transfer data over multiple protocols (HTTP, HTTPS, FTP, SFTP,...)
- Data retrieval: Fetch and display web pages or API content
- It's especially useful to integrate it into shell scripts
```

### 2. curl option:

**-v / --verbose**
```
# explanation
-v/--verbose: Display detailed information about request and response, useful for debugging

# command:
> curl -v https://api.domain.com
```

**-o / --output**
```
# explanation
-o / --output: Saves the response to a file instead display it in the console

# command:
> curl -v https://api.domain.com -o response.json
```

**-L / --location:**
```
# explanation
-L / --location: Follows HTTP redirects (3xx) to retrieve final resource

# command:
> curl -v https://api.domain.com -L
```

**-s / --silent:**
```

# -s / --silent:
- silent mode: do not display program meter / error data
- It still outputs the data we're accessing

# command:
> curl -v https://api.domain.com -s -o response.json
```

## II. `jq` program

**data**:
```
[
  {
    "id": "10",
    "name": "Apple iPad Mini 5th Gen",
    "data": {
      "Capacity": "64 GB",
      "Screen size": 7.9
    }
  },
  {
    "id": "11",
    "name": "Apple iPad Mini 5th Gen",
    "data": {
      "Capacity": "254 GB",
      "Screen size": 7.9
    }
  },
  {
    "id": "12",
    "name": "Apple iPad Air",
    "data": {
      "Generation": "4th",
      "Price": "419.99",
      "Capacity": "64 GB"
    }
  },
  {
    "id": "13",
    "name": "Apple iPad Air",
    "data": {
      "Generation": "4th",
      "Price": "519.99",
      "Capacity": "256 GB"
    }
  }
]
```

**print json file with colors**
```
> cat api.json | jq
```
**

**get first element in the array**:
```
> cat api.json | jq '.[0]'

# result:
{
  "id": "1",
  "name": "Google Pixel 6 Pro",
  "data": {
    "color": "Cloudy White",
    "capacity": "128 GB"
  }
}


> cat api.json | jq '.[0].data.color'

# result:
"Cloudy White"
```

**get specific key in a element**
```
# command:
> cat api.json | jq '.[].name'

# result:
"Google Pixel 6 Pro"
"Apple iPhone 12 Mini, 256GB, Blue"
"Apple iPhone 12 Pro Max"
"Apple iPhone 11, 64GB"
"Samsung Galaxy Z Fold2"
"Apple AirPods"
"Apple MacBook Pro 16"
"Apple Watch Series 8"
"Beats Studio3 Wireless"
"Apple iPad Mini 5th Gen"
"Apple iPad Mini 5th Gen"
"Apple iPad Air"
"Apple iPad Air"

# command:
> cat api.json | jq '.[].data.color'

# result:
"Cloudy White"
null
"Cloudy White"
"Purple"
"Brown"
null
```

**get array length**
```
> cat  api.json | jq '. | length'
```