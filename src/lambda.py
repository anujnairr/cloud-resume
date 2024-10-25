import json
import boto3
import os

dynamo = boto3.resource('dynamodb')
dynamodb_table_name = os.environ['database_name']
table = dynamo.Table('dynamodb_table_name')

def lambda_handler(event, context):
    try:
        res = table.update_item(
        Key ={"id":"1"},
        UpdateExpression="SET view_count = view_count + :val",
        ExpressionAttributeValues={':val':1},
        ReturnValues="UPDATED_NEW"
    )
    except:
        res = table.put_item(
            Item = {
                'id': '1',
                'view_count': 1
            },ReturnValues="ALL_OLD")
    return{
        "statusCode": 200,
        "isBase64Encoded": False,
        "body": res['Attributes']['view_count'],
        "headers": {
            "Access-Control-Allow-Origin": '*',
            "Access-Control-Allow-Credentials": True,
            'Content-Type': 'application/json',
            "Access-Control-Allow-Methods": 'OPTIONS,POST,GET'
        }
    }