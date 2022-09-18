import { S3Event } from 'aws-lambda';

export const handler = async (event: S3Event) => {
  console.log('event', event);

  const response = {
    statusCode: 200,
    body: JSON.stringify('Hello from Lambda!'),
  };
  return response;
};

export default handler;
