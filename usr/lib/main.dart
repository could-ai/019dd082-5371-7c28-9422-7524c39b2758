import 'package:flutter/material.dart';

void main() {
  runApp(const GameMeatApp());
}

class GameMeatApp extends StatelessWidget {
  const GameMeatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heritage Game Meat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F0F), // Very dark earth tone
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD4A373), // Warm golden brown / amber
          surface: Color(0xFF1A1A1A),
          onSurface: Colors.white70,
        ),
        useMaterial3: true,
      ),
      home: const PresentationScreen(),
    );
  }
}

class MeatItem {
  final String name;
  final String subtitle;
  final String description;
  final String imageUrl;
  final List<String> notes;
  final String cookingTip;

  MeatItem({
    required this.name,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
    required this.notes,
    required this.cookingTip,
  });
}

final List<MeatItem> gameMeats = [
  MeatItem(
    name: 'Wild Venison',
    subtitle: 'Lean, earthy, and refined',
    description: 'Sourced from free-roaming deer, venison is celebrated for its deep, ruby-red color and rich, herbaceous flavor profile. Naturally foraging on wild grasses and berries imparts a unique terrestrial taste that is remarkably low in fat and rich in iron.',
    imageUrl: 'https://images.unsplash.com/photo-1627907228175-2bf846b3ce27?auto=format&fit=crop&q=80&w=1000',
    notes: ['Earthy', 'Lean', 'High Iron'],
    cookingTip: 'Best served rare to medium-rare. Due to its extremely low fat content, overcooking will quickly dry out the meat.',
  ),
  MeatItem(
    name: 'Wild Boar',
    subtitle: 'Robust, nutty, and sweet',
    description: 'Unlike domestic pork, wild boar offers an intense, sweet, and nutty flavor due to a natural diet of acorns, roots, and wild flora. Its natural marbling provides a succulent, rich texture that stands up beautifully to bold spices.',
    imageUrl: 'https://images.unsplash.com/photo-1603048297172-c92544798d5e?auto=format&fit=crop&q=80&w=1000',
    notes: ['Nutty', 'Rich', 'Succulent'],
    cookingTip: 'Slow braising in red wine or roasting at lower temperatures enhances its natural tenderness and deepens the flavor.',
  ),
  MeatItem(
    name: 'Pheasant',
    subtitle: 'Delicate, gamey, and aromatic',
    description: 'A classic upland game bird offering a slightly gamey but highly accessible flavor. Pheasant meat is subtly sweet, lean, and pairs beautifully with autumnal fruits, root vegetables, and robust herbs like thyme and sage.',
    imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&q=80&w=1000',
    notes: ['Aromatic', 'Delicate', 'Subtle Sweetness'],
    cookingTip: 'Baste frequently with butter or wrap the breast in pancetta to retain vital moisture during roasting.',
  ),
  MeatItem(
    name: 'Bison',
    subtitle: 'Bold, clean, and pure',
    description: 'A distinctly North American heritage meat. Bison is lighter, sweeter, and more robust than traditional beef. As a naturally foraging animal, the meat is nutrient-dense, highly sustainable, and remarkably tender.',
    imageUrl: 'https://images.unsplash.com/photo-1558030006-450675393462?auto=format&fit=crop&q=80&w=1000',
    notes: ['Sweet', 'Clean Finish', 'Nutrient-Dense'],
    cookingTip: 'Cook at lower temperatures and for less time than traditional beef. Remove from heat just before your desired doneness.',
  ),
];

class PresentationScreen extends StatelessWidget {
  const PresentationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: const Text(
                'HERITAGE GAME',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2.0,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1559842602-0eeb3d5c5890?auto=format&fit=crop&q=80&w=1200',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Theme.of(context).scaffoldBackgroundColor,
                        ],
                        stops: const [0.4, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final meat = gameMeats[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: MeatCard(meat: meat),
                  );
                },
                childCount: gameMeats.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MeatCard extends StatelessWidget {
  final MeatItem meat;

  const MeatCard({super.key, required this.meat});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
              opacity: animation,
              child: MeatDetailScreen(meat: meat),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: meat.name,
              child: Image.network(
                meat.imageUrl,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meat.name.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    meat.subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MeatDetailScreen extends StatelessWidget {
  final MeatItem meat;

  const MeatDetailScreen({super.key, required this.meat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: meat.name,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      meat.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.4),
                            Colors.transparent,
                            Theme.of(context).scaffoldBackgroundColor,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 48.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meat.name.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    meat.subtitle,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Georgia',
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'THE PROFILE',
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    meat.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.8,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'TASTING NOTES',
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: meat.notes.map((note) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        ),
                        child: Text(
                          note.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 48),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.outdoor_grill, color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 12),
                            const Text(
                              'CHEF\'S TIP',
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          meat.cookingTip,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            fontStyle: FontStyle.italic,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
