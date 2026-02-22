# PLC Inspection Mobile App

## Introduction
The PLC Inspection Mobile App is designed to facilitate inspections of Programmable Logic Controllers (PLCs) efficiently and effectively, ensuring that all parameters are met during the inspection process.

## Setup Instructions
To set up the PLC Inspection app, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/wesellcells/PLC_Inspector.git
   cd PLC_Inspector
   ```

2. Install the required dependencies:
   ```bash
   npm install
   ```

3. Set up the environment variables. Create a `.env` file in the root directory and fill in the necessary configurations.

4. Run the application:
   ```bash
   npm start
   ```

## Features List
- Inspection Checklist
- Real-time data entry
- Historical data access
- User authentication
- Cloud synchronization
- Notifications & Alerts

## Testing Checklist
- [ ] Ensure all features are functional
- [ ] Test on multiple devices for compatibility
- [ ] Validate user authentication
- [ ] Confirm data synchronization with the cloud
- [ ] Check for UI responsiveness

## How to Run the PLC Inspection Mobile App
You can run the app on physical devices or emulators. To do this:
- For Android, use:
  ```bash
  npx react-native run-android
  ```
- For iOS, use:
  ```bash
  npx react-native run-ios
  ```

Ensure that your development environment is properly set up according to the React Native documentation.
