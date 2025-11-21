import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  // Claves para scrollear a secciones específicas
  final GlobalKey _bioKey = GlobalKey();
  final GlobalKey _musicKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.7),
        elevation: 0,
        title: const Text(
          'CARMOMIX',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
        centerTitle: isMobile,
        actions: isMobile
            ? null // En móvil usamos drawer o simplificamos
            : [
                _NavBarItem(title: 'BIOGRAFÍA', onTap: () => _scrollToSection(_bioKey)),
                _NavBarItem(title: 'MÚSICA', onTap: () => _scrollToSection(_musicKey)),
                _NavBarItem(title: 'CONTACTO', onTap: () => _scrollToSection(_contactKey)),
                const SizedBox(width: 20),
              ],
      ),
      drawer: isMobile
          ? Drawer(
              backgroundColor: const Color(0xFF121212),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(color: Color(0xFFE50914)),
                    child: Center(
                      child: Text(
                        'CARMOMIX',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person, color: Colors.white),
                    title: const Text('Biografía', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                      _scrollToSection(_bioKey);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.music_note, color: Colors.white),
                    title: const Text('Música', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                      _scrollToSection(_musicKey);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.mail, color: Colors.white),
                    title: const Text('Contacto', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                      _scrollToSection(_contactKey);
                    },
                  ),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // HERO SECTION
            _buildHeroSection(size),

            // BIO SECTION
            _buildBioSection(key: _bioKey, isMobile: isMobile),

            // MUSIC SECTION
            _buildMusicSection(key: _musicKey, isMobile: isMobile),

            // CONTACT SECTION
            _buildContactSection(key: _contactKey, isMobile: isMobile),

            // FOOTER
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(Size size) {
    return Container(
      height: size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          // Placeholder image - en producción usaría una foto real del artista
          image: const NetworkImage('https://images.unsplash.com/photo-1516280440614-6697288d5d38?q=80&w=2070&auto=format&fit=crop'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'CARMOMIX',
            style: TextStyle(
              fontSize: size.width < 600 ? 48 : 96,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 4.0,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE50914), width: 2),
            ),
            child: const Text(
              'ARGENTINA • BUENOS AIRES',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBioSection({required Key key, required bool isMobile}) {
    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: const Color(0xFF0A0A0A),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              const Text(
                'BIOGRAFÍA',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE50914),
                ),
              ),
              const SizedBox(height: 40),
              isMobile
                  ? Column(children: _buildBioContent())
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildBioContent(),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBioContent() {
    return [
      Expanded(
        flex: 1,
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              // Placeholder para foto del artista
              image: NetworkImage('https://images.unsplash.com/photo-1520333789090-1afc82db536a?q=80&w=2071&auto=format&fit=crop'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      const SizedBox(width: 40, height: 40),
      Expanded(
        flex: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'EL ORIGEN',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nacido el 9 de Enero de 1993, Carmomix es la nueva voz que emerge desde el corazón de Buenos Aires.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 15),
            Text(
              'Orgullosamente representando a Lugano 1 y 2, Capital Federal, su música refleja la autenticidad y la pasión de sus raíces argentinas.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 15),
            Text(
              'Con un estilo único que fusiona ritmos urbanos con la esencia del barrio, Carmomix busca llevar su mensaje más allá de las fronteras.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildMusicSection({required Key key, required bool isMobile}) {
    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: const Color(0xFF121212),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              const Text(
                'ÚLTIMOS LANZAMIENTOS',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Container(width: 60, height: 4, color: const Color(0xFFE50914)),
              const SizedBox(height: 50),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _MusicCard(title: 'Noches en Lugano', year: '2023', coverColor: Colors.blueGrey),
                  _MusicCard(title: 'Ritmo Capital', year: '2024', coverColor: Colors.deepPurple),
                  _MusicCard(title: 'Enero 93', year: '2024', coverColor: Colors.redAccent),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection({required Key key, required bool isMobile}) {
    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0A0A0A), Color(0xFF1A0505)],
        ),
      ),
      child: Center(
        child: Column(
          children: [
            const Text(
              'CONTRATACIONES',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              '¿Quieres a Carmomix en tu evento?',
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _launchUrl('mailto:contacto@carmomix.com?subject=Contratación%20Carmomix');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE50914),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text(
                'CONTACTAR AHORA',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SocialIcon(
                  icon: Icons.camera_alt, 
                  label: 'Instagram',
                  onTap: () => _launchUrl('https://instagram.com'),
                ),
                const SizedBox(width: 30),
                _SocialIcon(
                  icon: Icons.play_arrow, 
                  label: 'YouTube',
                  onTap: () => _launchUrl('https://youtube.com'),
                ),
                const SizedBox(width: 30),
                _SocialIcon(
                  icon: Icons.music_note, 
                  label: 'Spotify',
                  onTap: () => _launchUrl('https://spotify.com'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(30),
      color: Colors.black,
      child: Column(
        children: [
          const Text(
            'CARMOMIX',
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2.0, color: Colors.white),
          ),
          const SizedBox(height: 10),
          const Text(
            '© 2024 Todos los derechos reservados.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 5),
          const Text(
            'Buenos Aires, Argentina',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavBarItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _MusicCard extends StatelessWidget {
  final String title;
  final String year;
  final Color coverColor;

  const _MusicCard({required this.title, required this.year, required this.coverColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: coverColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: const Center(
              child: Icon(Icons.music_note, size: 60, color: Colors.white54),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  year,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialIcon({
    required this.icon, 
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
