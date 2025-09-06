// Test file for Mobile React Native
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';

interface TestProps {
  title: string;
  count: number;
}

const TestComponent: React.FC<TestProps> = ({ title, count }) => {
  const unused = 'unused variable';

  return (
    <View style={styles.container}>
      <Text style={styles.title}>{title}</Text>
      <Text style={styles.count}>Count: {count}</Text>
    </View>
  );
};

// Bad formatting
const styles = StyleSheet.create({
  container: { flex: 1, padding: 20, backgroundColor: 'white' },
  title: { fontSize: 18, fontWeight: 'bold', marginBottom: 10 },
  count: { fontSize: 16, color: 'blue' },
});

export default TestComponent;
