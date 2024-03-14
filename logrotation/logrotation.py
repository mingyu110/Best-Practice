"""
-*- coding: utf-8 -*-
@File  : logrotation.py
@author: mingyu110
@Description : 
@Time  : 2024/03/14 09:19
"""
import boto3
from datetime import datetime, timedelta
def lambda_handler(event, context):
    # Set your S3 bucket name and the number of days to retain logs
    bucket_name = "your-s3-bucket-name"
    retention_days = 30
    # Initialize the S3 client
    s3_client = boto3.client('s3')
    # Calculate the date before which logs should be deleted
    deletion_date = datetime.now() - timedelta(days=retention_days)
    # List objects in the S3 bucket
    objects = s3_client.list_objects_v2(Bucket=bucket_name)
    if 'Contents' in objects:
        for obj in objects['Contents']:
            # Get the object key (filename) and last modified date
            obj_key = obj['Key']
            last_modified = obj['LastModified']
            # Check if the object is a log and is older than the deletion date
            if obj_key.endswith('.log') and last_modified < deletion_date:
                # Delete the log object
                s3_client.delete_object(Bucket=bucket_name, Key=obj_key)
                print(f"Deleted: s3://{bucket_name}/{obj_key}")
    return {
        'statusCode': 200,
        'body': 'Log rotation and deletion complete'
    }


