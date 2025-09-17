import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(SwiftRideApp());
}

class SwiftRideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SwiftRide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: SplashScreen(),
    );
  }
}

// ==================== MODELS ====================
class Vehicle {
  final int id;
  final String name;
  final String type;
  final String number;
  final String driverName;
  final String eta;
  final double rating;
  final double lat;
  final double lng;

  Vehicle({
    required this.id,
    required this.name,
    required this.type,
    required this.number,
    required this.driverName,
    required this.eta,
    required this.rating,
    required this.lat,
    required this.lng,
  });
}

// ==================== MOCK DATA ====================
class MockData {
  static List<Vehicle> vehicles = [
    Vehicle(
      id: 1,
      name: 'Toyota Camry',
      type: 'taxi',
      number: 'KA-01-ABC-123',
      driverName: 'Raj Kumar',
      eta: '5 min',
      rating: 4.8,
      lat: 12.9716,
      lng: 77.5946,
    ),
    Vehicle(
      id: 2,
      name: 'Maruti Swift',
      type: 'taxi',
      number: 'KA-02-XYZ-456',
      driverName: 'Priya Singh',
      eta: '8 min',
      rating: 4.6,
      lat: 12.9716,
      lng: 77.5946,
    ),
    Vehicle(
      id: 3,
      name: 'Tata Sumo',
      type: 'bus',
      number: 'KA-03-DEF-789',
      driverName: 'Suresh Babu',
      eta: '12 min',
      rating: 4.2,
      lat: 12.9716,
      lng: 77.5946,
    ),
    Vehicle(
      id: 4,
      name: 'Bajaj Auto',
      type: 'auto',
      number: 'KA-04-GHI-012',
      driverName: 'Ravi Prakash',
      eta: '3 min',
      rating: 4.5,
      lat: 12.9716,
      lng: 77.5946,
    ),
    Vehicle(
      id: 5,
      name: 'Mahindra Bolero',
      type: 'bus',
      number: 'KA-05-JKL-345',
      driverName: 'Kumar Swamy',
      eta: '15 min',
      rating: 4.3,
      lat: 12.9716,
      lng: 77.5946,
    ),
  ];
}

// ==================== SPLASH SCREEN ====================
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );
    
    _controller.forward();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignupPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3B82F6), Color(0xFF93C5FD)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SwiftRide',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 4,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Your Journey, Our Priority',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ==================== COMMON WIDGETS ====================
class CustomInputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final bool isPassword;
  final VoidCallback? onTogglePassword;
  final bool obscureText;

  CustomInputField({
    required this.label,
    required this.icon,
    required this.controller,
    this.isPassword = false,
    this.onTogglePassword,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Color(0xFF3B82F6)),
          labelText: label,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Color(0xFF3B82F6),
                  ),
                  onPressed: onTogglePassword,
                )
              : null,
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final List<Color>? colors;

  GradientButton({
    required this.text,
    required this.onPressed,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors ?? [Color(0xFF3B82F6), Color(0xFF60A5FA)],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: (colors?[0] ?? Color(0xFF3B82F6)).withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== SIGNUP PAGE ====================
class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  void handleSignup() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      _showSnackBar('Please fill in all fields', isError: true);
      return;
    }
    
    _showSnackBar('Account created successfully!');
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF93C5FD), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60),
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3B82F6),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Sign up to start your SwiftRide journey',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 50),
                CustomInputField(
                  label: 'Email',
                  icon: Icons.email,
                  controller: emailController,
                ),
                CustomInputField(
                  label: 'Password',
                  icon: Icons.lock,
                  controller: passwordController,
                  isPassword: true,
                  obscureText: _obscurePassword,
                  onTogglePassword: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                SizedBox(height: 20),
                GradientButton(
                  text: 'Create Account',
                  onPressed: handleSignup,
                ),
                SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Already have an account? Login',
                      style: TextStyle(
                        color: Color(0xFF3B82F6),
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== LOGIN PAGE ====================
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  void handleLogin() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      _showSnackBar('Please fill in all fields', isError: true);
      return;
    }
    
    _showSnackBar('Welcome back to SwiftRide!');
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RoleSelectionPage()),
      );
    });
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF93C5FD), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60),
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3B82F6),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Login to continue using SwiftRide',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 50),
                CustomInputField(
                  label: 'Email',
                  icon: Icons.email,
                  controller: emailController,
                ),
                CustomInputField(
                  label: 'Password',
                  icon: Icons.lock,
                  controller: passwordController,
                  isPassword: true,
                  obscureText: _obscurePassword,
                  onTogglePassword: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                SizedBox(height: 30),
                GradientButton(
                  text: 'Login to SwiftRide',
                  onPressed: handleLogin,
                ),
                SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: Text(
                      'Don\'t have an account? Sign up',
                      style: TextStyle(
                        color: Color(0xFF3B82F6),
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== ROLE SELECTION PAGE ====================
class RoleSelectionPage extends StatelessWidget {
  Widget _roleCard({
    required String title,
    required String subtitle,
    required String emoji,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 25),
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color, color.withOpacity(0.8)]),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 20,
              offset: Offset(0, 10),
            )
          ],
        ),
        child: Column(
          children: [
            Text(
              emoji,
              style: TextStyle(fontSize: 50),
            ),
            SizedBox(height: 15),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Role'),
        backgroundColor: Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3F4F6), Color(0xFFE5E7EB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _roleCard(
                  title: 'Driver Panel',
                  subtitle: 'Bus/Auto/Taxi Owner',
                  emoji: '🚗',
                  color: Color(0xFF3B82F6),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DriverPanel()),
                    );
                  },
                ),
                _roleCard(
                  title: 'Passenger Panel',
                  subtitle: 'Student/Worker/Commuter',
                  emoji: '🚶',
                  color: Color(0xFF10B981),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PassengerPanel()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== DRIVER PANEL ====================
class DriverPanel extends StatefulWidget {
  @override
  _DriverPanelState createState() => _DriverPanelState();
}

class _DriverPanelState extends State<DriverPanel> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  bool isTripActive = false;

  void startTrip() {
    if (fromController.text.isEmpty || toController.text.isEmpty) {
      _showSnackBar('Please enter both start and destination locations', isError: true);
      return;
    }
    
    setState(() {
      isTripActive = true;
    });
    
    _showSnackBar('Trip started! Live tracking is now active');
    
    Timer(Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DriverMapScreen(
            fromLocation: fromController.text,
            toLocation: toController.text,
            onTripEnd: () {
              setState(() {
                isTripActive = false;
                fromController.clear();
                toController.clear();
              });
            },
          ),
        ),
      );
    });
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Dashboard'),
        backgroundColor: Color(0xFF3B82F6),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF8FAFC),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // Trip Status Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isTripActive 
                        ? [Color(0xFF10B981), Color(0xFF34D399)]
                        : [Color(0xFF6B7280), Color(0xFF9CA3AF)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      isTripActive ? '🚗 Trip Active' : 'Ready to Start Trip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      isTripActive 
                          ? 'Live tracking enabled'
                          : 'Enter your route details below',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 25),
              
              // Trip Details Section
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('📍', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 10),
                        Text(
                          'Trip Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF374151),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomInputField(
                      label: 'Start Location (From)',
                      icon: Icons.my_location,
                      controller: fromController,
                    ),
                    CustomInputField(
                      label: 'Destination (To)',
                      icon: Icons.location_on,
                      controller: toController,
                    ),
                    SizedBox(height: 10),
                    GradientButton(
                      text: isTripActive ? '🚀 Trip In Progress' : '🚀 Start Trip',
                      onPressed: isTripActive ? () {} : startTrip,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 25),
              
              // Statistics Section
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('📊', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 10),
                        Text(
                          'Trip Statistics',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF374151),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _statCard('12', 'Trips Today', Color(0xFF3B82F6)),
                        _statCard('₹850', 'Today\'s Earning', Color(0xFF10B981)),
                        _statCard('4.8', 'Rating', Color(0xFFF59E0B)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF6B7280),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ==================== PASSENGER PANEL ====================
class PassengerPanel extends StatefulWidget {
  @override
  _PassengerPanelState createState() => _PassengerPanelState();
}

class _PassengerPanelState extends State<PassengerPanel> {
  final TextEditingController pickupController = TextEditingController(text: 'MG Road, Bangalore');
  final TextEditingController dropController = TextEditingController(text: 'Electronic City');
  
  List<Vehicle> vehicles = [];
  List<Vehicle> filteredVehicles = [];
  bool isLoading = false;
  String selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    vehicles = MockData.vehicles;
    filteredVehicles = vehicles;
  }

  void findRide() {
    if (pickupController.text.isEmpty || dropController.text.isEmpty) {
      _showSnackBar('Please enter both pickup and drop locations', isError: true);
      return;
    }
    
    setState(() {
      isLoading = true;
    });
    
    _showSnackBar('Searching for available rides...');
    
    Timer(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
        filteredVehicles = vehicles;
        selectedFilter = 'all';
      });
      _showSnackBar('Found ${vehicles.length} available rides nearby!');
    });
  }

  void filterVehicles(String filter) {
    setState(() {
      selectedFilter = filter;
      if (filter == 'all') {
        filteredVehicles = vehicles;
      } else {
        filteredVehicles = vehicles.where((v) => v.type == filter).toList();
      }
    });
  }

  void selectVehicle(Vehicle vehicle) {
    _showSnackBar('Vehicle selected! Tracking ${vehicle.driverName}');
    
    Timer(Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PassengerMapScreen(vehicle: vehicle),
        ),
      );
    });
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Your Ride'),
        backgroundColor: Color(0xFF10B981),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFF8FAFC)),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // Trip Request Section
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('📍', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 10),
                        Text(
                          'Where are you going?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF374151),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomInputField(
                      label: 'Pickup Location (From)',
                      icon: Icons.my_location,
                      controller: pickupController,
                    ),
                    CustomInputField(
                      label: 'Drop Location (To)',
                      icon: Icons.location_on,
                      controller: dropController,
                    ),
                    SizedBox(height: 10),
                    GradientButton(
                      text: '🔍 Find Available Rides',
                      onPressed: findRide,
                      colors: [Color(0xFF10B981), Color(0xFF34D399)],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 25),
              
              // Filter Section
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('🚗', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 10),
                        Text(
                          'Filter by Vehicle Type',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF374151),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildFilterChip('All', 'all'),
                        _buildFilterChip('Taxi', 'taxi'),
                        _buildFilterChip('Bus', 'bus'),
                        _buildFilterChip('Auto', 'auto'),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 25),
              
              // Results Section
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : filteredVehicles.isEmpty
                      ? Center(child: Text('No rides found.', style: TextStyle(fontSize: 16)))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Available Rides (${filteredVehicles.length})',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF374151),
                              ),
                            ),
                            SizedBox(height: 15),
                            ...filteredVehicles.map((vehicle) {
                              return _vehicleCard(vehicle);
                            }).toList(),
                          ],
                        ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String filter) {
    final isSelected = selectedFilter == filter;
    return GestureDetector(
      onTap: () => filterVehicles(filter),
      child: Chip(
        label: Text(label),
        backgroundColor: isSelected ? Color(0xFF10B981) : Color(0xFFE5E7EB),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Color(0xFF6B7280),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
    );
  }
  
  Widget _vehicleCard(Vehicle vehicle) {
    String emoji = '';
    if (vehicle.type == 'taxi') emoji = '🚕';
    if (vehicle.type == 'bus') emoji = '🚌';
    if (vehicle.type == 'auto') emoji = '🛺';

    return GestureDetector(
      onTap: () => selectVehicle(vehicle),
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFE5F5EF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(emoji, style: TextStyle(fontSize: 30)),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${vehicle.name} (${vehicle.number})',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Driver: ${vehicle.driverName}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  vehicle.eta,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF10B981),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.star, color: Color(0xFFF59E0B), size: 16),
                    SizedBox(width: 4),
                    Text(
                      '${vehicle.rating}',
                      style: TextStyle(color: Color(0xFFF59E0B)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== DRIVER MAP SCREEN ====================
class DriverMapScreen extends StatelessWidget {
  final String fromLocation;
  final String toLocation;
  final VoidCallback onTripEnd;

  DriverMapScreen({
    required this.fromLocation,
    required this.toLocation,
    required this.onTripEnd,
  });

  void _showTripCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text('Trip Complete!', style: TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.bold)),
          content: Text('You have successfully completed the trip from $fromLocation to $toLocation.', textAlign: TextAlign.center),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onTripEnd();
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Trip'),
        backgroundColor: Color(0xFF3B82F6),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // This would be where a map widget (like google_maps_flutter) would go
          Container(
            color: Colors.grey[300],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '📍 Live Map View',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Showing route from $fromLocation to $toLocation'),
                  // 
                ],
              ),
            ),
          ),
          
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Trip Progress',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF374151),
                    ),
                  ),
                  SizedBox(height: 15),
                  LinearProgressIndicator(
                    value: 0.75, // Mock progress
                    backgroundColor: Colors.grey[300],
                    color: Color(0xFF10B981),
                    minHeight: 10,
                  ),
                  SizedBox(height: 20),
                  GradientButton(
                    text: 'End Trip',
                    onPressed: () => _showTripCompleteDialog(context),
                    colors: [Colors.red, Color(0xFFEF4444)],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== PASSENGER MAP SCREEN ====================
class PassengerMapScreen extends StatelessWidget {
  final Vehicle vehicle;

  PassengerMapScreen({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Your Ride'),
        backgroundColor: Color(0xFF10B981),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // This would be where a map widget (like google_maps_flutter) would go
          Container(
            color: Colors.grey[300],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '📍 Live Map View',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Showing live location of ${vehicle.name}'),
                  // 
                ],
              ),
            ),
          ),
          
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your driver is arriving in:',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Text(
                            vehicle.eta,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF10B981),
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[200],
                        child: Icon(Icons.person, size: 40, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vehicle.driverName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${vehicle.name} (${vehicle.number})',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        Icon(Icons.call, color: Color(0xFF10B981)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}