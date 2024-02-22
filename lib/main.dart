import 'package:flutter/material.dart';
import 'package:applicationbuilder/screens/upload.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
    String getTitle() {
    final currentTime = DateTime.now();
    final lateAfternoonTime = DateTime(currentTime.year, currentTime.month, currentTime.day, 17, 40);

    if (currentTime.isAfter(lateAfternoonTime)) {
      return 'დასვენების დროა!';
    } else {
      return 'გამარჯობა!';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'gettext',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: colorScheme.onSurfaceVariant,
          background: colorScheme.background,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.onSurfaceVariant,
          toolbarHeight:0
        ),
      ),
      home:  MyHomePage(title: getTitle()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  Future<void> fetchData() {
    return Future.delayed(const Duration(seconds: 2));
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final int _selectedIndex = 0;
  bool isLoading = true;

  Widget getPage() {
    switch (_selectedIndex) {
      case 0:
        return const UploadScreen();
      default:
        throw UnimplementedError("Page not found");
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await widget.fetchData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130), // Set your preferred height
        child: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(color: colorScheme.surfaceVariant),
            
          ),
          toolbarHeight:90,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.gif"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.transparent,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              )
            : getPage(),
      ),
    );
  }
}
