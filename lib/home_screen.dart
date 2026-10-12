import 'package:flutter/material.dart';
import 'add_service_screen.dart';
import 'login_screen.dart';
import 'ui.dart';

class ServiceItem {
  final String name;
  final String url;
  final String time;
  final String status;
  final Color color;

  const ServiceItem(this.name, this.url, this.time, this.status, this.color);
}

const List<ServiceItem> services = [
  ServiceItem('Payments API', 'api.payflow.io/v2', '142 мс', 'Работает', greenColor),
  ServiceItem('Auth Service', 'auth.nimbus.dev', '88 мс', 'Работает', greenColor),
  ServiceItem('Media CDN', 'cdn.mediabox.app', '310 мс', 'Деградация', yellowColor),
  ServiceItem('Search API', 'search.quanta.io', '—', 'Недоступен', redColor),
  ServiceItem('Notifications', 'push.relay.net', '64 мс', 'Работает', greenColor),
];

const List<double> barHeights = [
  10.0, 14.0, 8.0, 16.0, 22.0, 12.0, 26.0, 18.0, 30.0, 14.0,
  10.0, 12.0, 20.0, 24.0, 18.0, 12.0, 16.0, 10.0, 22.0, 26.0,
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tab = 0;

  void openAddService() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const AddServiceScreen()),
    );
  }

  void logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  Widget buildHeader(String title, String subtitle, bool withAdd) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: textColor, fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: mutedColor, fontSize: 13)),
            ],
          ),
        ),
        if (withAdd)
          IconButton(
            onPressed: openAddService,
            icon: const Icon(Icons.add),
            style: IconButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: textColor,
            ),
          ),
      ],
    );
  }

  Widget buildUptimeCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF121732), Color(0xFF1F2A5C)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(color: greenColor, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              const Text(
                'Все системы работают',
                style: TextStyle(color: greenColor, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            '99.97%',
            style: TextStyle(color: textColor, fontSize: 40, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          const Text(
            'Аптайм за последние 30 дней',
            style: TextStyle(color: mutedColor, fontSize: 12),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 32,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final height in barHeights)
                  Container(
                    width: 4,
                    height: height,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B4A9E),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildServicesTitle() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Сервисы',
            style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2447),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${services.length}',
            style: const TextStyle(color: mutedColor, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget buildServiceRow(ServiceItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: item.color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(item.url, style: const TextStyle(color: mutedColor, fontSize: 11)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.time,
                style: const TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              Text(item.status, style: TextStyle(color: item.color, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildServiceList() {
    final List<Widget> rows = [];
    for (int i = 0; i < services.length; i++) {
      if (i > 0) {
        rows.add(const Divider(height: 1, color: borderColor));
      }
      rows.add(buildServiceRow(services[i]));
    }
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(children: rows),
    );
  }

  Widget buildOverview() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      children: [
        buildHeader('Мониторинг', '${services.length} сервисов под наблюдением', true),
        const SizedBox(height: 20),
        buildUptimeCard(),
        const SizedBox(height: 24),
        buildServicesTitle(),
        const SizedBox(height: 12),
        buildServiceList(),
      ],
    );
  }

  Widget buildServicesTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      children: [
        buildHeader('Сервисы', 'Все проверяемые адреса', true),
        const SizedBox(height: 20),
        buildServiceList(),
      ],
    );
  }

  Widget buildSettingRow(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: mutedColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title, style: const TextStyle(color: textColor, fontSize: 14)),
          ),
          const Icon(Icons.chevron_right, color: mutedColor, size: 20),
        ],
      ),
    );
  }

  Widget buildSettings() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      children: [
        buildHeader('Настройки', 'Аккаунт и уведомления', false),
        const SizedBox(height: 20),
        buildSettingRow(Icons.person_outline, 'Профиль'),
        buildSettingRow(Icons.notifications_none, 'Уведомления'),
        buildSettingRow(Icons.dark_mode_outlined, 'Тема оформления'),
        buildSettingRow(Icons.info_outline, 'О приложении'),
        const SizedBox(height: 14),
        PrimaryButton(text: 'Выйти', onPressed: logout, secondary: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (tab == 0) {
      body = buildOverview();
    } else if (tab == 1) {
      body = buildServicesTab();
    } else {
      body = buildSettings();
    }

    return Scaffold(
      body: SafeArea(child: body),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: borderColor)),
        ),
        child: BottomNavigationBar(
          currentIndex: tab,
          onTap: (index) => setState(() => tab = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: bgColor,
          selectedItemColor: primaryColor,
          unselectedItemColor: mutedColor,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Обзор'),
            BottomNavigationBarItem(icon: Icon(Icons.dns_rounded), label: 'Сервисы'),
            BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Настройки'),
          ],
        ),
      ),
    );
  }
}
