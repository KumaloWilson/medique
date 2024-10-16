import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medique/views/admin_home/tabs/staff_tab.dart';
import '../../../core/utils/providers.dart';
import '../../core/constants/color_constants.dart';
import '../../core/constants/dimensions.dart';
import '../../models/user_profile.dart';
import '../../widgets/drawer/admin_drawer.dart';
import '../../widgets/text_fields/custom_text_field.dart';

class AdminHomeScreen extends ConsumerStatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  ConsumerState<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends ConsumerState<AdminHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.amber
  ];
  final _key = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;
  String searchTerm = '';
  final TextEditingController _searchTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProfileAsync = ref.watch(ProviderUtils.profileProvider(user!.email!));

    final staffState = ref.watch(
      ProviderUtils.staffProvider,
    );

    return userProfileAsync.hasValue
        ? Scaffold(
      key: _key,
      drawer: AdminDrawer(
              user: user!,
            ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(150),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (Dimensions.isSmallScreen)
                          IconButton(
                            onPressed: () {
                              _key.currentState!.openDrawer();
                            },
                            icon: const Icon(
                                Icons.menu
                            ),
                          ),
                        Container(
                          width: 120,
                          height: 120,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Image.network(
                            user!.photoURL ?? userProfileAsync.value!.profilePicture!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user!.displayName ?? '',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              user!.email ?? '',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Find Staff',
                      prefixIcon: const Icon(Icons.search),
                      controller: _searchTextEditingController,
                      onChanged: (value) {
                        setState(() {
                          searchTerm = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: staffState.when(
            data: (users) => _buildContent(users),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
          ),
        )
        : const Scaffold(
      body: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(List<UserProfile> users) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Staff',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TabBar(
            controller: _tabController,
            physics: const BouncingScrollPhysics(),
            isScrollable: true,
            unselectedLabelStyle: TextStyle(
              color: Pallete.greyAccent,
              fontSize: 14,
            ),
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            tabAlignment: TabAlignment.start,
            tabs: const [
              Tab(text: 'Nurses'),
              Tab(text: 'Social Workers'),
              Tab(text: 'Care/Support Workers'),
            ],
          ),
          SizedBox(
            height: 400,
            child: TabBarView(
              controller: _tabController,
              children: [
                StaffTab(
                  searchTerm: searchTerm,
                  users: users
                      .where((user) =>
                  user.post!.toLowerCase() == 'nurse' &&
                      user.role!.toLowerCase() == 'user')
                      .toList(),
                ),
                StaffTab(
                  searchTerm: searchTerm,
                  users: users
                      .where((user) =>
                  user.post!.toLowerCase() == 'social worker' &&
                      user.role!.toLowerCase() == 'user')
                      .toList(),
                ),
                StaffTab(
                  searchTerm: searchTerm,
                  users: users
                      .where((user) =>
                  user.post!.toLowerCase() == 'care/support worker' &&
                      user.role!.toLowerCase() == 'user')
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
