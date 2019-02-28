done: foo.zip
	aws lambda create-function --function-name testPort --runtime nodejs8.10 --role arn:aws:iam::535370547254:role/s3uploadTest-dev-ap-southeast-2-lambdaRole --handler index.testPort --zip-file fileb://foo.zip && touch done ; rm -f foo.zip || rm -f done

foo.zip: index.js
	zip -r foo.zip *.js ./node_modules

update: foo.zip
	aws lambda update-function-code --function-name testPort  --zip-file fileb://foo.zip | jq . && touch updated && rm -f foo.zip

invoke:
	aws lambda invoke --function-name testPort /dev/stdout | jq .

result:
	aws s3 cp s3://msz-test-inbox/date ./date && echo "-- result --" && cat ./date && echo "" && rm -f ./date

clean:
	 aws lambda delete-function --function-name testPort && aws s3 rm  s3://msz-test-inbox/date && rm -f foo.zip done update
