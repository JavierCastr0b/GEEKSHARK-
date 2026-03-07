import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/widgets/gs_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _dailyReminder = true;
  bool _weeklyReport = false;
  bool _darkMode = false;
  String _currency = 'PEN (S/.)';
  String _language = 'Espanol';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      appBar: AppBar(
        backgroundColor: AppColors.navy700,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Configuracion',
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSection(
            'Notificaciones',
            [
              _buildToggle(
                icon: Icons.notifications_outlined,
                color: AppColors.amber,
                label: 'Notificaciones',
                subtitle: 'Recibe recordatorios y novedades',
                value: _notificationsEnabled,
                onChanged: (v) => setState(() => _notificationsEnabled = v),
              ),
              _buildToggle(
                icon: Icons.alarm_outlined,
                color: AppColors.cyan,
                label: 'Recordatorio diario',
                subtitle: 'Aprende algo nuevo cada dia',
                value: _dailyReminder,
                onChanged: (v) => setState(() => _dailyReminder = v),
              ),
              _buildToggle(
                icon: Icons.bar_chart_rounded,
                color: AppColors.green,
                label: 'Reporte semanal',
                subtitle: 'Resumen de tu progreso cada semana',
                value: _weeklyReport,
                onChanged: (v) => setState(() => _weeklyReport = v),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildSection(
            'Apariencia',
            [
              _buildToggle(
                icon: Icons.dark_mode_outlined,
                color: AppColors.navy500,
                label: 'Modo oscuro',
                subtitle: 'Interfaz en tonos oscuros',
                value: _darkMode,
                onChanged: (v) => setState(() => _darkMode = v),
              ),
              _buildSelector(
                icon: Icons.language_rounded,
                color: AppColors.purple,
                label: 'Idioma',
                value: _language,
                options: ['Espanol', 'English'],
                onChanged: (v) => setState(() => _language = v),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildSection(
            'Finanzas',
            [
              _buildSelector(
                icon: Icons.attach_money_rounded,
                color: AppColors.green,
                label: 'Moneda',
                value: _currency,
                options: ['PEN (S/.)', 'USD (\$)', 'EUR (€)'],
                onChanged: (v) => setState(() => _currency = v),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildSection(
            'Cuenta',
            [
              _buildTile(
                icon: Icons.lock_reset_rounded,
                color: AppColors.amber,
                label: 'Cambiar contrasena',
                onTap: () {},
              ),
              _buildTile(
                icon: Icons.download_rounded,
                color: AppColors.navy500,
                label: 'Exportar mis datos',
                onTap: () {},
              ),
              _buildTile(
                icon: Icons.delete_outline_rounded,
                color: AppColors.red,
                label: 'Eliminar cuenta',
                isDestructive: true,
                onTap: () => _showDeleteDialog(),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildSection(
            'Informacion',
            [
              _buildTile(
                icon: Icons.info_outline_rounded,
                color: AppColors.gray500,
                label: 'Version de la app',
                trailing: Text(
                  'v1.0.0',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.gray400,
                  ),
                ),
                onTap: () {},
              ),
              _buildTile(
                icon: Icons.description_outlined,
                color: AppColors.gray500,
                label: 'Terminos y condiciones',
                onTap: () {},
              ),
              _buildTile(
                icon: Icons.privacy_tip_outlined,
                color: AppColors.gray500,
                label: 'Politica de privacidad',
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 32),

          Center(
            child: Text(
              'GeekShark v1.0.0 · Hecho con ❤️ en Peru',
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: AppColors.gray400,
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title.toUpperCase(),
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.gray400,
              letterSpacing: 0.6,
            ),
          ),
        ),
        GsCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: children.asMap().entries.map((entry) {
              return Column(
                children: [
                  entry.value,
                  if (entry.key < children.length - 1)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(height: 1),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildToggle({
    required IconData icon,
    required Color color,
    required String label,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray800,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColors.gray400,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.navy500,
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required Color color,
    required String label,
    bool isDestructive = false,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
      title: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isDestructive ? AppColors.red : AppColors.gray800,
        ),
      ),
      trailing: trailing ??
          const Icon(Icons.chevron_right_rounded,
              color: AppColors.gray300, size: 20),
      onTap: onTap,
    );
  }

  Widget _buildSelector({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
    required List<String> options,
    required ValueChanged<String> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
      title: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.gray800,
        ),
      ),
      trailing: DropdownButton<String>(
        value: value,
        underline: const SizedBox(),
        style: GoogleFonts.poppins(
          fontSize: 13,
          color: AppColors.gray500,
        ),
        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.gray400, size: 18),
        items: options.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Eliminar cuenta',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Esta accion es irreversible. Se eliminaran todos tus datos, progreso y metas de ahorro.',
          style: GoogleFonts.poppins(fontSize: 13, color: AppColors.gray500),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: GoogleFonts.poppins(color: AppColors.gray500),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
            child: Text(
              'Eliminar',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
