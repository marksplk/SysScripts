for files in `ls  /net/qa-kickstart/depot/internal/twitter/*.tgz`
do
/export/home/clustering/splunk/bin/splunk add monitor $files -index twitter -auth admin:changeme
done

