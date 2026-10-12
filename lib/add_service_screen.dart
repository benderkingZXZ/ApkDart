import 'package:flutter/material.dart';
import 'ui.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController codeController = TextEditingController(text: '200');
  final List<String> methods = ['GET', 'POST'];
  final List<String> intervals = ['30 сек', '60 сек', '5 мин', '15 мин'];
  String method = 'GET';
  String interval = '60 сек';
  bool notify = true;

  @override
  void dispose() {
    nameController.dispose();
    urlController.dispose();
    codeController.dispose();
    super.dispose();
  }

  void close() {
    Navigator.of(context).pop();
  }

  Widget buildDropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: mutedColor, fontSize: 12)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: fieldColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              dropdownColor: cardColor,
              icon: const Icon(Icons.keyboard_arrow_down, color: mutedColor, size: 18),
              style: const TextStyle(color: textColor, fontSize: 14),
              items: [
                for (final item in items)
                  DropdownMenuItem<String>(value: item, child: Text(item)),
              ],
              onChanged: (newValue) {
                if (newValue != null) {
                  onChanged(newValue);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNotifyRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Уведомления при сбое',
              style: TextStyle(color: textColor, fontSize: 14),
            ),
          ),
          Switch(
            value: notify,
            onChanged: (value) => setState(() => notify = value),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 20, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: close,
                    icon: const Icon(Icons.chevron_left, size: 28),
                  ),
                  const Text(
                    'Новый сервис',
                    style: TextStyle(color: textColor, fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppField(
                      label: 'Название',
                      hint: 'Orders API',
                      controller: nameController,
                    ),
                    const SizedBox(height: 16),
                    AppField(
                      label: 'URL для проверки',
                      hint: 'https://api.example.com/health',
                      controller: urlController,
                      keyboardType: TextInputType.url,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: buildDropdown(
                            'Метод',
                            method,
                            methods,
                            (value) => setState(() => method = value),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: buildDropdown(
                            'Интервал',
                            interval,
                            intervals,
                            (value) => setState(() => interval = value),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AppField(
                      label: 'Ожидаемый код ответа',
                      hint: '200',
                      controller: codeController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    buildNotifyRow(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryButton(text: 'Отмена', onPressed: close, secondary: true),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(text: 'Сохранить', onPressed: close),
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
