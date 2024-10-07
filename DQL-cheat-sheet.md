# Dynatrace (DQL) Cheat Sheet 🐙

### Filtering 💬
    fetch log
    | filter startsWith(host.name, "nginx001")

### Filtering Using Contains:

    fetch log
    | filter contains(host.name, "something-you-search-for")

### Content Parsing to New Collumn
- ```"LD:``` start by matching any line data at the beginning of the field
- ```'serverName: '``` is the string in the content
- ```STRING:newCollumnName"``` is the name of the new collumn populated by the value of ```'serverName: '```

Looks like:

    | parse content, "LD 'serverName: ' STRING:newCollumnName"

### Time 🕗
T minus 10 Day : Fetch way:

    fetch logs, from:now()-10d

T minus 10 Day : Filter way:

    | filter timestamp >= now() - 10d and timestamp <= now()

Specify timeframe - Fetch way:

    fetch logs, from:now() - 15d, to:now() - 10d

Specify timeframe : Fetch way with absolute time ranges with the timeframe parameter

    fetch logs, timeframe:"2024-10-01T00:00:00Z/2024-10-05T12:00:00Z"

### Scan Limit GB 🗻

    fetch logs, from:now()-10d, scanLimitGBytes:800

### Simple Summary  

    | fieldsSummary newCollumnName

### Summary Count By + Filter and Sort

    | summarize count(), by:{newCollumnName}
    | filter `count()` > 10
    | sort `count()` desc

Probably better way:

    | summarize count = count(), by: {newCollumnName}
    | filter count > 10
    | sort count desc

### Summary Count By + Timestamp 〽️
**Displays events per minute in the graph bar** 

    | fields timestamp, event.type, content
    | sort timestamp desc
    | summarize count(), by: {bin(timestamp, 1m)}
