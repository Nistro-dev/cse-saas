// Setup global test configuration
import { config } from 'dotenv';

// Load test environment variables
config({ path: '.env.test' });

// Setup test database or other test-specific configurations
beforeAll(async () => {
  // Configuration globale des tests
});

afterAll(async () => {
  // Nettoyage après tous les tests
});

// Mock console pour éviter les logs durant les tests
const originalConsole = { ...console };

beforeEach(() => {
  console.log = jest.fn();
  console.error = jest.fn();
  console.warn = jest.fn();
});

afterEach(() => {
  Object.assign(console, originalConsole);
});
