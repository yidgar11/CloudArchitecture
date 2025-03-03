import boto3

# pip install pyboto3 - for autocomplete of boto3

mys3 = boto3.client('s3')
mys3.create_bucket(Bucket='my-experts-yidgar')
mys3.upload_file('/tmp/file.txt', 'my-experts-yidgar', 'test.txt')
response = mys3.list_objects(Bucket='my-experts-yidgar')
for obj in response['Contents']:
    print(obj['Key'])

