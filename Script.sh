## Intial summaries of searching Elsevier’s Scopus was grouped in in folders by the dental search terms 
## where each folder has the summaries of searching for this term and all possible omic terms

## Concatinate & de-duplicate search summaries
for d in *;do 
  if [ -d "$d" ];then 
    echo "$d"
    for f in "$d"/*.csv;do head -n+1 "$f";done | sort | uniq > "$d".csv
    for f in "$d"/*.csv;do tail -n+2 "$f";done | sort | uniq >> "$d".csv
  fi
done


## stats of individual input csv files
for d in *;do if [ -d "$d" ];then
  for f in "$d"/*.csv;do
    echo "$f";
    tail -n+2 "$f" | wc -l;
  done;
fi; done | paste - - | tr '\t' ',' > record.details
cat record.details | sed 's|/.*vs |,|' | sort -t"," -k2,2 > record.details2

## Final total stats 
for d in *;do
  if [ -d "$d" ];then
    bef=$(for f in "$d"/*.csv;do tail -n+2 "$f";done | wc -l)
    aft=$(tail -n+2 "$d".csv | wc -l)
    echo "$d" "Before = $bef" ", After = $aft"
  fi
done

for d in *;do if [ -d "$d" ];then head -n+1 "$d".csv; fi;done | sort | uniq > all.csv
for d in *;do if [ -d "$d" ];then tail -n+2 "$d".csv; fi;done | sort | uniq >> all.csv
echo "Total count after complete deduplication = " $(tail -n+2 all.csv | wc -l)


