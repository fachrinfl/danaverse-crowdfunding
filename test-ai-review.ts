// Test file for AI Code Review
// This file contains various code patterns to test AI review functionality

import React, { useState, useEffect } from 'react';

// ❌ Test case: Using 'any' type (should trigger AI review)
interface TestProps {
  data: any; // AI should suggest specific type
  onAction: () => void;
}

// ❌ Test case: Class component (should trigger AI review)
class TestComponent extends React.Component<TestProps> {
  render() {
    return <div>Test</div>;
  }
}

// ❌ Test case: Console.log in production code (should trigger AI review)
export const TestFunction: React.FC<TestProps> = ({ data, onAction }) => {
  console.log('This should trigger AI review'); // AI should suggest removing console.log
  
  // ❌ Test case: Missing error handling (should trigger AI review)
  const fetchData = async () => {
    const response = await fetch('/api/data'); // AI should suggest try-catch
    const result = await response.json();
    return result;
  };

  // ❌ Test case: useEffect without dependency array (should trigger AI review)
  useEffect(() => {
    fetchData();
  }); // AI should suggest adding dependency array

  // ❌ Test case: Performance issue - array length in loop (should trigger AI review)
  const processArray = (items: string[]) => {
    for (let i = 0; i < items.length; i++) { // AI should suggest caching length
      console.log(items[i]);
    }
  };

  // ❌ Test case: Using var instead of let/const (should trigger AI review)
  var globalVar = 'test'; // AI should suggest using let/const

  // ❌ Test case: Using == instead of === (should trigger AI review)
  const compareValues = (a: string, b: string) => {
    if (a == b) { // AI should suggest using ===
      return true;
    }
    return false;
  };

  return (
    <div>
      <h1>Test Component for AI Review</h1>
      <button onClick={onAction}>Click me</button>
      <p>Data: {JSON.stringify(data)}</p>
    </div>
  );
};

// ❌ Test case: Hardcoded secret (should trigger security scan)
const API_KEY = 'sk-1234567890abcdef'; // AI should detect hardcoded secret

// ❌ Test case: Potential XSS vulnerability (should trigger security scan)
const renderHTML = (html: string) => {
  return <div dangerouslySetInnerHTML={{ __html: html }} />; // AI should warn about XSS
};

// ❌ Test case: Insecure HTTP protocol (should trigger security scan)
const fetchInsecureData = async () => {
  const response = await fetch('http://api.example.com/data'); // AI should suggest HTTPS
  return response.json();
};

export default TestFunction;
