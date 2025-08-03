import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { Text, View, StyleSheet } from 'react-native';
import { StatusBar } from 'expo-status-bar';

function DashboardScreen() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Teacher Dashboard</Text>
      <Text>Welcome to Harry School Teacher Portal</Text>
      <StatusBar style="auto" />
    </View>
  );
}

function AttendanceScreen() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Attendance</Text>
      <Text>Mark student attendance</Text>
    </View>
  );
}

function HomeworkScreen() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Homework Review</Text>
      <Text>Review and grade student submissions</Text>
    </View>
  );
}

function RankingsScreen() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Rankings</Text>
      <Text>Student and teacher performance</Text>
    </View>
  );
}

const Tab = createBottomTabNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Tab.Navigator
        screenOptions={{
          tabBarActiveTintColor: '#1d7452',
          tabBarInactiveTintColor: 'gray',
        }}
      >
        <Tab.Screen name="Dashboard" component={DashboardScreen} />
        <Tab.Screen name="Attendance" component={AttendanceScreen} />
        <Tab.Screen name="Homework" component={HomeworkScreen} />
        <Tab.Screen name="Rankings" component={RankingsScreen} />
      </Tab.Navigator>
    </NavigationContainer>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 10,
    color: '#1d7452',
  },
});
