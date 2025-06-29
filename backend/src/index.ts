import fastify from 'fastify';
import cors from '@fastify/cors';
import jwt from '@fastify/jwt';
import cookie from '@fastify/cookie';
import multipart from '@fastify/multipart';
import { config } from 'dotenv';

// Charger les variables d'environnement
config();

const server = fastify({
  logger: {
    level: process.env.LOG_LEVEL || 'info',
    transport: process.env.NODE_ENV === 'development' ? {
      target: 'pino-pretty'
    } : undefined
  }
});

// Enregistrement des plugins
async function buildApp() {
  // CORS
  await server.register(cors, {
    origin: process.env.FRONTEND_URL || 'http://localhost:5173',
    credentials: true
  });

  // JWT
  await server.register(jwt, {
    secret: process.env.JWT_SECRET || 'super-secret-key-change-in-production',
    cookie: {
      cookieName: 'token',
      signed: false
    }
  });

  // Cookies
  await server.register(cookie);

  // Upload de fichiers
  await server.register(multipart);

  // Routes de base
  server.get('/api/health', async (request, reply) => {
    return { 
      status: 'healthy', 
      timestamp: new Date().toISOString(),
      environment: process.env.NODE_ENV || 'development'
    };
  });

  server.get('/api', async (request, reply) => {
    return { 
      message: 'CSE SaaS API v1.0',
      docs: '/api/docs',
      health: '/api/health'
    };
  });

  return server;
}

// Démarrage du serveur
async function start() {
  try {
    const app = await buildApp();
    
    const port = Number(process.env.PORT) || 3000;
    const host = process.env.HOST || '0.0.0.0';
    
    await app.listen({ port, host });
    
    console.log(`🚀 Server ready at http://${host}:${port}`);
    console.log(`📊 Health check: http://${host}:${port}/api/health`);
    
  } catch (err) {
    console.error('❌ Error starting server:', err);
    process.exit(1);
  }
}

// Gestion propre de l'arrêt
process.on('SIGINT', async () => {
  console.log('⏹️  Graceful shutdown...');
  await server.close();
  process.exit(0);
});

if (require.main === module) {
  start();
}

export { buildApp };
