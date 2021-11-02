#head -n1 1.csv > ../all.csv
#for f in *.csv;do tail -n+2 $f;done | sort | uniq >> ../all.csv

for d in *;do 
  if [ -d "$d" ];then 
    echo "$d"
    for f in "$d"/*.csv;do head -n+1 "$f";done | sort | uniq > "$d".csv
    for f in "$d"/*.csv;do tail -n+2 "$f" | awk -F"\"" '{x=index($0,FS);z=index($0,"[");if(x==1 || z==1)printf "\n%s",$0;else printf "%s",$0;}END{printf "\n"}' | sed '/^[[:space:]]*$/d';done | sort | uniq >> "$d".csv
  fi
done

## stats of individual input csv files
for d in *;do if [ -d "$d" ];then
  for f in "$d"/*.csv;do
    echo "$f";
    tail -n+2 "$f" | awk -F"\"" '{x=index($0,FS);z=index($0,"[");if(x==1 || z==1)printf "\n%s",$0;else printf "%s",$0;}END{printf "\n"}' | sed '/^[[:space:]]*$/d' | wc -l;
  done;
fi; done | paste - - | tr '\t' ',' > record.details
cat record.details | sed 's/caries vs //' | sed 's/carious vs //' | sed 's|/|,|' | sort -t"," -k2,2 > record.details2

## Final total stats 
for d in *;do
  if [ -d "$d" ];then
    bef=$(for f in "$d"/*.csv;do tail -n+2 "$f" | awk -F"\"" '{x=index($0,FS);z=index($0,"[");if(x==1 || z==1)printf "\n%s",$0;else printf "%s",$0;}END{printf "\n"}' | sed '/^[[:space:]]*$/d';done | wc -l)
    aft=$(tail -n+2 "$d".csv | wc -l)
    echo "$d" "Before = $bef" ", After = $aft"
  fi
done



for d in *;do if [ -d "$d" ];then head -n+1 "$d".csv; fi;done | sort | uniq > all.csv
for d in *;do if [ -d "$d" ];then tail -n+2 "$d".csv; fi;done | sort | uniq >> all.csv

gzip all.csv



###########


