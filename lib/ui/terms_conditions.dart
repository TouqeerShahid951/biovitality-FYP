import 'package:flutter/material.dart';

class TermsConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms and Conditions"),
        centerTitle: true,
        backgroundColor: Colors.green, // Custom app bar color
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Terms and Conditions"),
            _buildParagraph(
              "Welcome to BioVitality, your go-to agricultural app for crop care and management. By using our app, you agree to comply with and be bound by the following terms and conditions of use, which together with our privacy policy govern BioVitality's relationship with you in relation to this app.",
            ),
            SizedBox(height: 16),
            _buildSectionTitle("Content Liability"),
            _buildParagraph(
              "The content of the pages of this app is for your general information and use only. It is subject to change without notice.",
            ),
            _buildParagraph(
              "Neither we nor any third parties provide any warranty or guarantee as to the accuracy, timeliness, performance, completeness, or suitability of the information and materials found or offered on this app for any particular purpose. You acknowledge that such information and materials may contain inaccuracies or errors and we expressly exclude liability for any such inaccuracies or errors to the fullest extent permitted by law.",
            ),
            SizedBox(height: 16),
            _buildSectionTitle("Modifications"),
            _buildParagraph(
              "BioVitality reserves the right to modify or discontinue, temporarily or permanently, the app or any part of it with or without notice. You agree that BioVitality shall not be liable to you or any third party for any modification, suspension, or discontinuance of the app.",
            ),
            SizedBox(height: 16),
            _buildSectionTitle("Governing Law"),
            _buildParagraph(
              "Your use of this app and any dispute arising out of such use of the app is subject to the laws of Pakistan.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.green, // Custom section title color
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16),
    );
  }
}
