import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:os_basecode/os_basecode.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return SafeArea(
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Syarat dan Ketentuan Registrasi',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Dengan mendaftar dan membuat akun di aplikasi ini, Anda setuju untuk mematuhi syarat dan ketentuan berikut:',
              style: GoogleFonts.roboto(fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildSection(
              '1. Ketentuan Data Registrasi',
              '''
Untuk membuat akun di aplikasi kami, Anda harus menyediakan informasi berikut:

- Nama Lengkap: Nama asli Anda yang digunakan untuk identifikasi akun.
- Nomor Telepon: Nomor telepon yang valid untuk komunikasi dan verifikasi.
- Email: Alamat email aktif yang digunakan untuk login dan notifikasi.
- Kata Sandi: Kata sandi pribadi yang aman dan tidak boleh dibagikan kepada pihak lain.

Harap diperhatikan:

- Data yang Anda berikan harus akurat dan benar. Jika ditemukan pelanggaran atau data palsu, kami berhak menonaktifkan akun Anda.
- Anda bertanggung jawab untuk menjaga kerahasiaan kata sandi dan informasi login Anda.
                        ''',
            ),
            const SizedBox(height: 16),
            _buildSection(
              '2. Privasi Data',
              '''
Kami menghormati privasi Anda dan berkomitmen untuk melindungi data pribadi Anda sesuai dengan kebijakan privasi yang berlaku:

- Informasi pribadi Anda hanya akan digunakan untuk keperluan operasional aplikasi.
- Kami tidak akan membagikan data Anda kepada pihak ketiga tanpa izin, kecuali diwajibkan oleh hukum.
                        ''',
            ),
            const SizedBox(height: 16),
            _buildSection(
              '3. Berbagi Data dengan Pihak Ketiga untuk Fitur AI',
              '''
Beberapa fitur AI dalam aplikasi ini memerlukan pengiriman data tertentu ke pihak ketiga yang menyediakan layanan AI. 

Data yang mungkin dibagikan mencakup:
- Pola penggunaan aplikasi
- Data interaksi dengan fitur AI
- Metadata teknis terkait operasional AI

Data yang dibagikan akan:
- Dianiimisasi untuk menghilangkan identitas pribadi
- Diagregasi untuk mencegah pelacakan individu
- Dilindungi dengan enkripsi selama transmisi

Dengan menggunakan fitur AI dalam aplikasi, Anda menyetujui pengiriman data ini ke penyedia layanan AI terkait yang bekerja sama dengan kami.
''',
            ),
            const SizedBox(height: 16),
            _buildSection(
              '4. Ketentuan Penggunaan',
              '''
Dengan membuat akun, Anda setuju untuk:

- Menggunakan aplikasi ini dengan cara yang sesuai hukum.
- Tidak menyalahgunakan informasi atau fitur aplikasi untuk tindakan yang melanggar hukum atau merugikan pihak lain.
- Memastikan bahwa perangkat Anda aman dan tidak digunakan oleh pihak lain untuk mengakses akun Anda.
                        ''',
            ),
            const SizedBox(height: 16),
            _buildSection(
              '5. Tanggung Jawab Pengguna',
              '''
- Anda bertanggung jawab sepenuhnya atas semua aktivitas yang dilakukan melalui akun Anda.
- Jika Anda mencurigai adanya akses tidak sah ke akun Anda, segera hubungi kami melalui email atau nomor dukungan.
                        ''',
            ),
            const SizedBox(height: 16),
            _buildSection(
              '6. Perubahan dan Pembaruan',
              '''
Kami berhak untuk mengubah atau memperbarui syarat dan ketentuan ini sewaktu-waktu. Perubahan akan diberitahukan melalui aplikasi atau email Anda. Dengan terus menggunakan aplikasi, Anda dianggap telah menyetujui perubahan tersebut.
                        ''',
            ),
            const SizedBox(height: 16),
            _buildSection(
              '7. Penonaktifan Akun',
              '''
Kami berhak menonaktifkan akun Anda tanpa pemberitahuan sebelumnya jika:

- Anda melanggar syarat dan ketentuan ini.
- Terjadi aktivitas mencurigakan yang melibatkan akun Anda.
- Informasi yang Anda berikan tidak valid atau tidak akurat.
                ''',
            ),
            PrimaryButton(
              title: "Setuju Dan Tutup",
              onPressed: () {
                if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
                  context.pop(true);
                }
                // context.pop();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          textAlign: TextAlign.justify,
          style: GoogleFonts.roboto(fontSize: 16),
        ),
      ],
    );
  }
}
