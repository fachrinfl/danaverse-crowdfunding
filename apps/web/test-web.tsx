// Test file for Web Next.js
import React, { useEffect, useState } from 'react';

interface WebTestProps {
  title: string;
  initialCount: number;
}

const WebTestComponent: React.FC<WebTestProps> = ({ title, initialCount }) => {
  const [count, setCount] = useState(initialCount);
  const [loading, setLoading] = useState(false);
  const unused = 'unused variable';

  useEffect(() => {
    console.log('Component mounted');
  }, []);

  const handleClick = () => {
    setCount(prev => prev + 1);
  };

  return (
    <div className='container'>
      <h1 className='title'>{title}</h1>
      <p className='count'>Count: {count}</p>
      <button onClick={handleClick} disabled={loading}>
        Increment
      </button>
    </div>
  );
};

// Bad formatting
const styles = {
  container: {
    padding: '20px',
    backgroundColor: '#f5f5f5',
    borderRadius: '8px',
  },
  title: { color: '#333', fontSize: '24px', marginBottom: '16px' },
  count: { color: '#666', fontSize: '18px' },
};

export default WebTestComponent;
