import { describe, test, expect } from '@jest/globals';
import { validateEmail, formatDate, generateRandomCode } from './helpers';

describe('Helpers Utils', () => {
  describe('validateEmail', () => {
    test('should validate correct email addresses', () => {
      expect(validateEmail('test@example.com')).toBe(true);
      expect(validateEmail('user.name@domain.co.uk')).toBe(true);
      expect(validateEmail('test+label@gmail.com')).toBe(true);
    });

    test('should reject invalid email addresses', () => {
      expect(validateEmail('')).toBe(false);
      expect(validateEmail('test@')).toBe(false);
      expect(validateEmail('@domain.com')).toBe(false);
      expect(validateEmail('invalid.email')).toBe(false);
      expect(validateEmail('test@domain')).toBe(false);
    });
  });

  describe('formatDate', () => {
    test('should format date to YYYY-MM-DD', () => {
      const date = new Date('2024-12-25T15:30:00.000Z');
      expect(formatDate(date)).toBe('2024-12-25');
    });

    test('should handle different dates correctly', () => {
      const date1 = new Date('2023-01-01T00:00:00.000Z');
      const date2 = new Date('2023-12-31T23:59:59.999Z');

      expect(formatDate(date1)).toBe('2023-01-01');
      expect(formatDate(date2)).toBe('2023-12-31');
    });
  });

  describe('generateRandomCode', () => {
    test('should generate code with default length', () => {
      const code = generateRandomCode();
      expect(code).toHaveLength(8);
      expect(/^[A-Z0-9]+$/.test(code)).toBe(true);
    });

    test('should generate code with specified length', () => {
      const code = generateRandomCode(12);
      expect(code).toHaveLength(12);
      expect(/^[A-Z0-9]+$/.test(code)).toBe(true);
    });

    test('should generate different codes', () => {
      const code1 = generateRandomCode();
      const code2 = generateRandomCode();

      expect(code1).not.toBe(code2);
    });
  });
});
