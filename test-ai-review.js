// Test file for AI Code Review - JavaScript
// This file contains various JavaScript patterns to test AI review functionality

// ❌ Test case: Using var instead of let/const (should trigger AI review)
var globalVariable = 'test'; // AI should suggest using let/const

// ❌ Test case: Using == instead of === (should trigger AI review)
function compareValues(a, b) {
    if (a == b) { // AI should suggest using ===
        return true;
    }
    return false;
}

// ❌ Test case: Missing semicolons (should trigger AI review)
const processData = (data) => {
    const result = data.map(item => item * 2) // AI should suggest adding semicolon
    return result
}

// ❌ Test case: Hardcoded credentials (should trigger security scan)
const API_KEY = 'sk-1234567890abcdef'; // AI should detect hardcoded secret
const DB_PASSWORD = 'secretpassword123'; // AI should detect hardcoded credentials

// ❌ Test case: Potential XSS vulnerability (should trigger security scan)
function renderHTML(html) {
    document.getElementById('content').innerHTML = html; // AI should warn about XSS
}

// ❌ Test case: Insecure HTTP protocol (should trigger security scan)
async function fetchInsecureData() {
    const response = await fetch('http://api.example.com/data'); // AI should suggest HTTPS
    return response.json();
}

// ❌ Test case: Performance issue - array length in loop (should trigger AI review)
function processArray(items) {
    for (let i = 0; i < items.length; i++) { // AI should suggest caching length
        console.log(items[i]);
    }
}

// ❌ Test case: Using eval (should trigger security scan)
function executeCode(code) {
    return eval(code); // AI should warn about eval usage
}

// ❌ Test case: Missing error handling (should trigger AI review)
async function fetchData() {
    const response = await fetch('/api/data'); // AI should suggest try-catch
    const data = await response.json();
    return data;
}

// ❌ Test case: Using document.getElementById in loop (should trigger AI review)
function updateElements() {
    for (let i = 0; i < 10; i++) {
        document.getElementById('element-' + i).style.display = 'none'; // AI should suggest caching elements
    }
}

// ❌ Test case: Global variable pollution (should trigger AI review)
window.myGlobalVar = 'test'; // AI should suggest avoiding global variables

// ❌ Test case: Missing input validation (should trigger AI review)
function processUserInput(input) {
    // AI should suggest adding input validation
    return input.toUpperCase();
}

// ❌ Test case: Using setTimeout without cleanup (should trigger AI review)
function startTimer() {
    setTimeout(() => {
        console.log('Timer fired');
    }, 1000); // AI should suggest cleanup mechanism
}

// ❌ Test case: Memory leak potential (should trigger AI review)
const eventListeners = [];
function addEventListener() {
    const element = document.getElementById('button');
    const handler = () => console.log('clicked');
    element.addEventListener('click', handler);
    eventListeners.push({ element, handler }); // AI should suggest cleanup
}

// ❌ Test case: Using innerHTML with user input (should trigger security scan)
function updateContent(userInput) {
    document.getElementById('content').innerHTML = userInput; // AI should warn about XSS
}

// ❌ Test case: Missing error handling in async function (should trigger AI review)
async function processAsyncData() {
    const data = await fetchData(); // AI should suggest error handling
    const processed = data.map(item => item * 2);
    return processed;
}

// ❌ Test case: Using console.log in production (should trigger AI review)
function debugFunction() {
    console.log('Debug information'); // AI should suggest removing console.log
    console.error('Error occurred'); // AI should suggest proper error handling
}

// ❌ Test case: Missing type checking (should trigger AI review)
function processData(data) {
    // AI should suggest adding type checking
    return data.length > 0 ? data[0] : null;
}

// ❌ Test case: Using deprecated methods (should trigger AI review)
function deprecatedFunction() {
    // AI should suggest modern alternatives
    const element = document.getElementById('test');
    element.setAttribute('onclick', 'alert("clicked")'); // AI should suggest addEventListener
}

// ❌ Test case: Missing null checks (should trigger AI review)
function accessProperty(obj) {
    return obj.property.subProperty; // AI should suggest null checks
}

// ❌ Test case: Using magic numbers (should trigger AI review)
function calculateTax(amount) {
    return amount * 0.1; // AI should suggest using named constants
}

// ❌ Test case: Missing error handling for JSON parsing (should trigger AI review)
function parseJSON(jsonString) {
    return JSON.parse(jsonString); // AI should suggest try-catch
}

// ❌ Test case: Using localStorage for sensitive data (should trigger security scan)
function storeSensitiveData(data) {
    localStorage.setItem('sensitive', JSON.stringify(data)); // AI should warn about localStorage security
}

// ❌ Test case: Missing input sanitization (should trigger security scan)
function searchQuery(query) {
    // AI should suggest input sanitization
    const sql = `SELECT * FROM users WHERE name LIKE '%${query}%'`; // AI should warn about SQL injection
    return sql;
}
