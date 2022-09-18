import { S3Event } from 'aws-lambda';

export const handler = async (event: S3Event) => {
  if (event.Records.length > 0) {
    console.log(
      'event.Records[0].s3',
      JSON.stringify(event.Records[0].s3, null, 2),
    );
  }

  const response = {
    statusCode: 200,
    body: JSON.stringify('Hello from Lambda!'),
  };
  return response;
};

export default handler;
