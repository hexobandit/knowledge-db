# Dynatrace (DQL) Cheat Sheet 🐙

## Filtering 
    fetch log
    | filter startsWith(host.name, "nginx001")

### Filtering Using Contains:

    fetch log
    | filter contains(content, "something-you-search-for")
    
And to exclude things:
    
    fetch log
    | filter NOT contains(content, "something-you-search-for") 

### Display Only Selected Collumns

    | fields timestamp, content

### Content Parsing to New Collumn
- ```"LD:``` start by matching any line data at the beginning of the field (works only for single line of data)
- - ```"DATA:``` If you need to parse multi-line use The 'DATA' content type
- ```'serverName: '``` is the string in the content
- ```STRING:newCollumnName"``` is the name of the new collumn populated by the value of ```'serverName: '```

Looks like:

    | parse content, "LD 'serverName: ' STRING:newCollumnName"

Or like this:

    | parse content, "DATA 'serveName: ' STRING:newCollumnNameII"

## Time 🕗
T minus 10 Day : Fetch way:

    fetch logs, from:now()-10d

T minus 10 Day : Filter way:

    | filter timestamp >= now() - 10d and timestamp <= now()

Specify timeframe - Fetch way:

    fetch logs, from:now() - 15d, to:now() - 10d

Specify timeframe : Fetch way with absolute time ranges with the timeframe parameter

    fetch logs, timeframe:"2024-10-01T00:00:00Z/2024-10-01T23:59:59Z

Sort Timestamp Desc

    | sort timestamp desc

## Scan Limit GB (Your execution was stopped after ... )🗻

    fetch logs, from:now()-10d, scanLimitGBytes:800

## Scan Limit # of Records (Your result has been limited to 1000)🗻
- Use Dynatrace Notebook (new feature)

## Simple Summary  

    | fieldsSummary newCollumnName

## Summary Count By + Filter and Sort

    | summarize count(), by:{newCollumnName}
    | filter `count()` > 10
    | sort `count()` desc

Probably better way:

    | summarize count = count(), by: {newCollumnName}
    | filter count > 10
    | sort count desc

## Summary Count By + Timestamp 〽️
**Displays events per minute in the graph bar** 

    | fields timestamp, event.type, content
    | sort timestamp desc
    | summarize count(), by: {bin(timestamp, 1m)}

    
