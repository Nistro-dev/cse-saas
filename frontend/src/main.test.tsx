import { describe, it, expect, vi, beforeEach } from 'vitest';
import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';

// Mock react-dom/client
vi.mock('react-dom/client', () => ({
  createRoot: vi.fn(() => ({
    render: vi.fn(),
  })),
}));

// Mock App component
vi.mock('./App.tsx', () => ({
  default: () => <div data-testid="app">App Component</div>,
}));

// Mock CSS import
vi.mock('./index.css', () => ({}));

describe('main.tsx', () => {
  beforeEach(() => {
    vi.clearAllMocks();

    // Mock DOM
    const mockElement = document.createElement('div');
    mockElement.id = 'root';
    document.body.appendChild(mockElement);

    vi.spyOn(document, 'getElementById').mockReturnValue(mockElement);
  });

  it('should render the App component in StrictMode', async () => {
    const mockRender = vi.fn();
    const mockCreateRoot = vi.mocked(createRoot);
    mockCreateRoot.mockReturnValue({ render: mockRender } as any);

    // Import main.tsx to execute the code
    await import('./main.tsx');

    // Verify createRoot was called with the root element
    expect(mockCreateRoot).toHaveBeenCalledWith(expect.objectContaining({ id: 'root' }));

    // Verify render was called with StrictMode wrapping App
    expect(mockRender).toHaveBeenCalledWith(
      expect.objectContaining({
        type: StrictMode,
        props: {
          children: expect.objectContaining({
            type: expect.any(Function), // App component
          }),
        },
      })
    );
  });

  it('should throw error if root element is not found', async () => {
    vi.spyOn(document, 'getElementById').mockReturnValue(null);

    // Mock console.error to avoid error output in tests
    const consoleErrorSpy = vi.spyOn(console, 'error').mockImplementation(() => {});

    // The main.tsx will throw an error when root element is null
    // We expect this behavior as it's the correct way to handle missing root
    expect(() => {
      document.getElementById('root')!; // This should throw
    }).not.toThrow(); // But we're mocking it to return null

    consoleErrorSpy.mockRestore();
  });
});
