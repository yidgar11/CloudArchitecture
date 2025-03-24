import boto3

# Set up AWS credentials for the IAM user (without KMS decryption access)
session = boto3.Session(
    aws_access_key_id='AKIA247A72R6O4YPNZAO',
    aws_secret_access_key='E0CgyryvcepMfu9muza0SCP673DL/KCKmu0BERsy',
    region_name='us-east-1'  # Replace with your region if needed

    # in the IAM Service , open the user  with KMS and in "security " create
    # a security access key and secret key nd place above
    # run the script and it will download the file from S3 Bucket .

    # Repeat with User that dont have KMS and this script will not be able to download the file
)

# S3 client using the IAM user credentials
s3 = session.client('s3')

# Define bucket and file details
bucket_name = "yidgar-cool-bucket"
file_name = "myfile.txt"
download_file_name = "myfile_download2.txt"  # File to download locally

# Attempt to download the file
try:
    print(f"Downloading {file_name} from {bucket_name} with IAM user...")
    s3.download_file(bucket_name, file_name, download_file_name)
    print(f"File downloaded successfully as {download_file_name}")
except Exception as e:
    print(f"Error: {e}")