import boto3
import os

client = boto3.client('ecr')

response = client.list_images(
    registryId=os.getenv("AWS_ACCOUNT_ID"),
    repositoryName='product_review',
)

imageIds = (response["imageIds"])

for imageId in imageIds:
    client.batch_delete_image(
      registryId=os.getenv("AWS_ACCOUNT_ID"),
      repositoryName='product_review',
      imageIds=[
        {
             'imageDigest':  imageId["imageDigest"]
        },
      ]
    )