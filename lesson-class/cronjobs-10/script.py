import logging
import datetime

# Configure logging
logging.basicConfig(filename='/tmp/cronjob.log', level=logging.INFO)

def log_message():
    current_time = datetime.datetime.now()
    message = f"CronJob executed at {current_time}"
    logging.info(message)
    print(message)  # Print to stdout as well

if __name__ == "_main_":
    log_message()