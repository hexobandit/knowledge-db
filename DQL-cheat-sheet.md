# Dynatrace (DQL) Cheat Sheet 🐙

### Normal Filtering
    fetch log
    | filter startsWith(host.name, "nginx001")

### Content Filtering
    fetch log
    | filter contains(content, "something-you-search-for")

### Content Parsing to New Collumn
- ```"LD:``` start by matching any line data at the beginning of the field
- ```'serverName: '``` is the string in the content
- ```STRING:newCollumnName"``` is the name of the new collumn populated by the value of ```'serverName: '```

Looks like:

    | parse content, "LD 'serverName: ' STRING:newCollumnName"

### Time T - 10 Days 🕗
Fetch way:

    fetch logs, from:now()-1d

Filter way:

    | filter timestamp >= now() - 10d and timestamp <= now()

### Scan Limit GB

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
