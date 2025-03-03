import boto3
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('MyTable')
table.put_item(
    Item={
        'id': '123',
        'name': 'John Doe',
        'age': 30
    }
)
print('Inserted item into MyTable')


response = table.get_item(
    Key={
        'id': '123'
    }
)
item = response['Item']
print(f'Retrieved item: {item}')

table.delete()