import { test, expect, describe, beforeAll, afterAll } from '@jest/globals';
import fastify, { FastifyInstance } from 'fastify';
import { config } from 'dotenv';

// Load test environment
config({ path: '.env.test' });

describe('Server Health Check', () => {
  let app: FastifyInstance;

  beforeAll(async () => {
    app = fastify({
      logger: false, // Disable logging during tests
    });

    // Register basic health route
    app.get('/api/health', async () => {
      return {
        status: 'healthy',
        timestamp: new Date().toISOString(),
        environment: 'test',
      };
    });

    await app.ready();
  });

  afterAll(async () => {
    await app.close();
  });

  test('should respond to health check', async () => {
    const response = await app.inject({
      method: 'GET',
      url: '/api/health',
    });

    expect(response.statusCode).toBe(200);

    const body = JSON.parse(response.body);
    expect(body.status).toBe('healthy');
    expect(body.environment).toBe('test');
    expect(body.timestamp).toBeDefined();
  });

  test('should return 404 for unknown routes', async () => {
    const response = await app.inject({
      method: 'GET',
      url: '/api/unknown',
    });

    expect(response.statusCode).toBe(404);
  });
});
