# Test Login Credentials

For testing the login functionality in the admin panel, use the following credentials:

## Test Credentials
- **Email**: admin@gmail.com
- **Password**: password1234567890

## Usage
1. Navigate to the login screen
2. Enter the test credentials above
3. Click the "Login" button
4. You should be redirected to the main dashboard

## Error Handling
If you enter incorrect credentials, you will see an error message:
"Invalid credentials. Use admin@gmail.com / password1234567890 for testing."

## Integration Notes
When integrating with a real backend authentication system:
1. Replace the mock login logic in `lib/screens/login/provider/login_provider.dart`
2. Implement actual API calls to your authentication endpoint
3. Handle JWT tokens or session management as needed
4. Update the validation logic as per your requirements