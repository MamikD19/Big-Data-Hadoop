ls -l
echo "Enter the avro file name "
read af
avro-tools getmeta $af
avro-tools getschema $af
avro-tools tojson $af
echo "Enter the json file"
read aj
avro-tools fromjson $aj
avro-tools getschema $af > $aj.avsc
echo "avsv build complete"
cat $aj.avsc
