import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Data Layer
import 'data/datasources/local/message_local_datasource.dart';
import 'data/datasources/local/message_local_datasource_impl.dart';
import 'data/repositories/message_repository_impl.dart';

// Domain Layer
import 'domain/usecases/add_message_usecase.dart';
import 'domain/usecases/clear_messages_usecase.dart';
import 'domain/usecases/get_agent_response_usecase.dart';
import 'domain/usecases/get_messages_usecase.dart';

// Presentation Layer
import 'presentation/providers/message_provider.dart';
import 'presentation/screens/messages_screen.dart';
import 'presentation/screens/webview_screen.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // ============ Dependency Injection Setup ============

  // 1. Create Data Source (SQLite)
  final localDataSource = MessageLocalDataSourceImpl();

  // 2. Create Repository (connects to data source)
  final repository = MessageRepositoryImpl(
    localDataSource: localDataSource,
  );

  // 3. Create Use Cases (business logic)
  final getMessagesUseCase = GetMessagesUseCase(repository);
  final addMessageUseCase = AddMessageUseCase(repository);
  final clearMessagesUseCase = ClearMessagesUseCase(repository);
  final getAgentResponseUseCase = GetAgentResponseUseCase(repository);

  // 4. Run app with Provider
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MessageProvider(
            getMessagesUseCase: getMessagesUseCase,
            addMessageUseCase: addMessageUseCase,
            clearMessagesUseCase: clearMessagesUseCase,
            getAgentResponseUseCase: getAgentResponseUseCase,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Messaging App',
      debugShowCheckedModeBanner: false,

      // Light Theme
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.light,
      ),

      // Dark Theme
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),

      // Auto switch based on system
      themeMode: ThemeMode.system,

      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // The two main screens
  final List<Widget> _screens = [
    const MessagesScreen(),
    const WebViewScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}