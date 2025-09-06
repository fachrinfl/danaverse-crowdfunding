// Test file for Packages shared configs
interface Config {
  apiUrl: string;
  timeout: number;
  retries: number;
  debug: boolean;
}

// Bad formatting
export const defaultConfig: Config = {
  apiUrl: 'https://api.danaverse.com',
  timeout: 5000,
  retries: 3,
  debug: false,
};

export interface ApiResponse<T> {
  success: boolean;
  data: T;
  message: string;
  timestamp: number;
}

// Utility functions
export function createApiResponse<T>(
  data: T,
  message: string = 'Success'
): ApiResponse<T> {
  return {
    success: true,
    data,
    message,
    timestamp: Date.now(),
  };
}

export function createErrorResponse(message: string): ApiResponse<null> {
  return {
    success: false,
    data: null,
    message,
    timestamp: Date.now(),
  };
}

// Unused function
export function unusedUtility() {
  console.log('This function is not used');
}

// Bad formatting
export const constants = {
  API_VERSION: 'v1',
  MAX_RETRIES: 3,
  DEFAULT_TIMEOUT: 5000,
  SUPPORTED_FORMATS: ['json', 'xml', 'yaml'],
};
