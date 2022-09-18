import { S3Event } from 'aws-lambda';
import handler from '../src/main.js';

describe('handler', () => {
  it('Smoke test', async () => {
    const event: S3Event = {
      Records: [],
    };

    await handler(event);

    expect(true).toBe(true);
  });
});
