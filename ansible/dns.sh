#!/bin/bash

TOKEN="y0_AgAEA7qhqj6VAArGUgAAAADxKX7pL3kjIqZzTCGNuIQETZjCKgNoVrM"

RECS_ADD="5.3.3.3
6.4.4.4"

RECS_DEL=$(curl -s -XGET -H "Authorization: OAuth $TOKEN" https://api360.yandex.net/directory/v1/org/80000/domains/glumov.it/dns?perPage=50 | jq -c '.records[] | select(.name == "task-09") | .recordId')

echo $RECS_DEL

# remove all records
for i in $RECS_DEL 
do
  curl -s -XDELETE -H "Authorization: OAuth $TOKEN" "https://api360.yandex.net/directory/v1/org/80000/domains/glumov.it/dns/$i"
done

# add records
for i in $RECS_ADD
do
  echo
  echo i=$i
  curl -s -XPOST -H "Authorization: OAuth $TOKEN" "https://api360.yandex.net/directory/v1/org/80000/domains/glumov.it/dns" -d \{\"address\":\"$i\",\"name\":\"task-09\",\"ttl\":\"120\",\"type\":\"A\"\}
done
