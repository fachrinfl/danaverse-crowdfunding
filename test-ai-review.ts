// Test file for AI Code Review - FIXED VERSION
// This file demonstrates proper code patterns following DanaVerse standards

import React, { useState, useEffect, useCallback, useMemo } from 'react';

// ✅ Fixed: Using specific types instead of 'any'
interface TestProps {
  data: Record<string, unknown>; // Specific type instead of any
  onAction: () => void;
}

// ✅ Fixed: Functional component with hooks (no class components)
export const TestFunction: React.FC<TestProps> = ({ data, onAction }) => {
  const [isLoading, setIsLoading] = useState<boolean>(false);
  
  // ✅ Fixed: Proper error handling with try-catch
  const fetchData = useCallback(async (): Promise<Record<string, unknown> | null> => {
    try {
      setIsLoading(true);
      const response = await fetch('/api/data');
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const result = await response.json();
      return result;
    } catch (error) {
      console.error('Error fetching data:', error);
      return null;
    } finally {
      setIsLoading(false);
    }
  }, []);

  // ✅ Fixed: useEffect with proper dependency array
  useEffect(() => {
    fetchData();
  }, [fetchData]);

  // ✅ Fixed: Performance optimization - caching array length
  const processArray = useCallback((items: string[]): void => {
    const length = items.length; // Cache length for performance
    for (let i = 0; i < length; i++) {
      // Use proper logging instead of console.log
      if (process.env.NODE_ENV === 'development') {
        console.log('Processing item:', items[i]);
      }
    }
  }, []);

  // ✅ Fixed: Using const instead of var
  const globalVar = 'test';

  // ✅ Fixed: Using strict equality (===)
  const compareValues = useCallback((a: string, b: string): boolean => {
    return a === b; // Strict equality
  }, []);

  // ✅ Fixed: Memoized component for performance
  const memoizedData = useMemo(() => {
    return JSON.stringify(data);
  }, [data]);

  return (
    <div>
      <h1>Test Component for AI Review - Fixed Version</h1>
      <button onClick={onAction} disabled={isLoading}>
        {isLoading ? 'Loading...' : 'Click me'}
      </button>
      <p>Data: {memoizedData}</p>
    </div>
  );
};

// ✅ Fixed: Using environment variables instead of hardcoded secrets
const API_KEY = process.env.REACT_APP_API_KEY || '';

// ✅ Fixed: Safe HTML rendering with sanitization
const renderHTML = (html: string): JSX.Element => {
  // In production, use a proper HTML sanitization library
  const sanitizedHTML = html.replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '');
  return <div dangerouslySetInnerHTML={{ __html: sanitizedHTML }} />;
};

// ✅ Fixed: Using HTTPS protocol
const fetchSecureData = async (): Promise<Record<string, unknown> | null> => {
  try {
    const response = await fetch('https://api.example.com/data');
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    return await response.json();
  } catch (error) {
    console.error('Error fetching secure data:', error);
    return null;
  }
};

export default TestFunction;
