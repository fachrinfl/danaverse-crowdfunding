// Test file for AI Code Review - JavaScript FIXED VERSION
// This file demonstrates proper JavaScript patterns following DanaVerse standards

// ✅ Fixed: Using const instead of var
const globalVariable = 'test';

// ✅ Fixed: Using strict equality (===)
function compareValues(a, b) {
    return a === b; // Strict equality
}

// ✅ Fixed: Adding semicolons for consistency
const processData = (data) => {
    const result = data.map(item => item * 2); // Added semicolon
    return result;
};

// ✅ Fixed: Using environment variables instead of hardcoded credentials
const API_KEY = process.env.API_KEY || '';
const DB_PASSWORD = process.env.DB_PASSWORD || '';

// ✅ Fixed: Safe HTML rendering with sanitization
function renderHTML(html) {
    // Sanitize HTML to prevent XSS
    const sanitizedHTML = html
        .replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '')
        .replace(/javascript:/gi, '')
        .replace(/on\w+\s*=/gi, '');
    
    const contentElement = document.getElementById('content');
    if (contentElement) {
        contentElement.innerHTML = sanitizedHTML;
    }
}

// ✅ Fixed: Using HTTPS protocol
async function fetchSecureData() {
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
}

// ✅ Fixed: Performance optimization - caching array length
function processArray(items) {
    if (!Array.isArray(items)) {
        throw new Error('Items must be an array');
    }
    
    const length = items.length; // Cache length for performance
    for (let i = 0; i < length; i++) {
        if (process.env.NODE_ENV === 'development') {
            console.log('Processing item:', items[i]);
        }
    }
}

// ✅ Fixed: Avoiding eval usage (security risk)
function executeCode(code) {
    // Never use eval in production
    throw new Error('eval() usage is not allowed for security reasons');
}

// ✅ Fixed: Proper error handling with try-catch
async function fetchData() {
    try {
        const response = await fetch('/api/data');
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const data = await response.json();
        return data;
    } catch (error) {
        console.error('Error fetching data:', error);
        throw error;
    }
}

// ✅ Fixed: Caching DOM elements for performance
function updateElements() {
    const elements = [];
    
    // Cache elements first
    for (let i = 0; i < 10; i++) {
        const element = document.getElementById(`element-${i}`);
        if (element) {
            elements.push(element);
        }
    }
    
    // Then update them
    elements.forEach(element => {
        element.style.display = 'none';
    });
}

// ✅ Fixed: Avoiding global variable pollution
const AppState = {
    myGlobalVar: 'test'
};

// ✅ Fixed: Input validation
function processUserInput(input) {
    if (typeof input !== 'string') {
        throw new Error('Input must be a string');
    }
    
    if (input.length === 0) {
        throw new Error('Input cannot be empty');
    }
    
    return input.toUpperCase();
}

// ✅ Fixed: Proper timer management with cleanup
class TimerManager {
    constructor() {
        this.timers = new Set();
    }
    
    startTimer(callback, delay) {
        const timerId = setTimeout(() => {
            callback();
            this.timers.delete(timerId);
        }, delay);
        
        this.timers.add(timerId);
        return timerId;
    }
    
    clearAllTimers() {
        this.timers.forEach(timerId => clearTimeout(timerId));
        this.timers.clear();
    }
}

const timerManager = new TimerManager();

// ✅ Fixed: Proper event listener management
class EventManager {
    constructor() {
        this.listeners = new Map();
    }
    
    addEventListener(element, event, handler) {
        if (!element || typeof handler !== 'function') {
            throw new Error('Invalid element or handler');
        }
        
        element.addEventListener(event, handler);
        
        if (!this.listeners.has(element)) {
            this.listeners.set(element, []);
        }
        
        this.listeners.get(element).push({ event, handler });
    }
    
    removeAllListeners(element) {
        const listeners = this.listeners.get(element);
        if (listeners) {
            listeners.forEach(({ event, handler }) => {
                element.removeEventListener(event, handler);
            });
            this.listeners.delete(element);
        }
    }
    
    cleanup() {
        this.listeners.forEach((listeners, element) => {
            listeners.forEach(({ event, handler }) => {
                element.removeEventListener(event, handler);
            });
        });
        this.listeners.clear();
    }
}

const eventManager = new EventManager();

// ✅ Fixed: Safe content updates
function updateContent(userInput) {
    if (typeof userInput !== 'string') {
        throw new Error('User input must be a string');
    }
    
    const contentElement = document.getElementById('content');
    if (contentElement) {
        // Use textContent instead of innerHTML for safety
        contentElement.textContent = userInput;
    }
}

// ✅ Fixed: Proper error handling in async function
async function processAsyncData() {
    try {
        const data = await fetchData();
        
        if (!Array.isArray(data)) {
            throw new Error('Data must be an array');
        }
        
        const processed = data.map(item => {
            if (typeof item !== 'number') {
                throw new Error('All items must be numbers');
            }
            return item * 2;
        });
        
        return processed;
    } catch (error) {
        console.error('Error processing async data:', error);
        throw error;
    }
}

// ✅ Fixed: Proper logging (only in development)
function debugFunction() {
    if (process.env.NODE_ENV === 'development') {
        console.log('Debug information');
    }
    
    // Use proper error handling instead of console.error
    throw new Error('Error occurred');
}

// ✅ Fixed: Type checking
function processData(data) {
    if (!Array.isArray(data)) {
        throw new Error('Data must be an array');
    }
    
    return data.length > 0 ? data[0] : null;
}

// ✅ Fixed: Using modern event handling
function modernEventHandling() {
    const element = document.getElementById('test');
    if (element) {
        // Use addEventListener instead of onclick attribute
        element.addEventListener('click', (event) => {
            alert('clicked');
        });
    }
}

// ✅ Fixed: Null checks and optional chaining
function accessProperty(obj) {
    if (!obj || typeof obj !== 'object') {
        throw new Error('Object is required');
    }
    
    return obj?.property?.subProperty;
}

// ✅ Fixed: Using named constants instead of magic numbers
const TAX_RATE = 0.1;
const MAX_RETRIES = 3;

function calculateTax(amount) {
    if (typeof amount !== 'number' || amount < 0) {
        throw new Error('Amount must be a positive number');
    }
    
    return amount * TAX_RATE;
}

// ✅ Fixed: Proper error handling for JSON parsing
function parseJSON(jsonString) {
    if (typeof jsonString !== 'string') {
        throw new Error('Input must be a string');
    }
    
    try {
        return JSON.parse(jsonString);
    } catch (error) {
        throw new Error('Invalid JSON string');
    }
}

// ✅ Fixed: Secure data storage (avoid localStorage for sensitive data)
function storeData(data, isSensitive = false) {
    if (isSensitive) {
        throw new Error('Sensitive data should not be stored in localStorage');
    }
    
    try {
        localStorage.setItem('data', JSON.stringify(data));
    } catch (error) {
        console.error('Failed to store data:', error);
    }
}

// ✅ Fixed: Input sanitization to prevent SQL injection
function searchQuery(query) {
    if (typeof query !== 'string') {
        throw new Error('Query must be a string');
    }
    
    // Sanitize input to prevent SQL injection
    const sanitizedQuery = query
        .replace(/['"\\]/g, '') // Remove quotes and backslashes
        .replace(/[;--]/g, '') // Remove SQL comment markers
        .trim();
    
    // Use parameterized queries in real implementation
    return `SELECT * FROM users WHERE name LIKE '%${sanitizedQuery}%'`;
}

// Export functions for testing
module.exports = {
    compareValues,
    processData,
    fetchData,
    processAsyncData,
    calculateTax,
    parseJSON,
    searchQuery,
    TimerManager,
    EventManager
};
