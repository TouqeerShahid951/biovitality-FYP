import 'package:flutter/material.dart';

class AboutBioVitality extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About BioVitality"),
        centerTitle: true,
        backgroundColor: Colors.green, // Customizing app bar color
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("About BioVitality"),
            _buildParagraph(
              "BioVitality is a comprehensive agricultural app designed to empower farmers and growers with essential tools for crop care and management. Our mission is to provide accurate and timely information, advanced technologies, and a supportive community to help you achieve optimal crop yields and sustainable agricultural practices.",
            ),
            SizedBox(height: 24),
            _buildSectionTitle("Key Features"),
            _buildFeatureTile(Icons.grass, "Crop Disease Detection",
                "Identify crop diseases using AI-powered image recognition."),
            _buildFeatureTile(Icons.store, "Agri Shop",
                "Find and purchase agricultural supplies and products."),
            _buildFeatureTile(Icons.wb_sunny, "Weather Forecasts",
                "Access detailed weather information and predictions."),
            _buildFeatureTile(Icons.notifications, "News and Bulletin",
                "Stay updated with the latest agricultural news and industry trends."),
            SizedBox(height: 24),
            _buildSectionTitle("Our Vision"),
            _buildParagraph(
              "At BioVitality, we envision a future where farmers and growers are equipped with the knowledge, technology, and resources to cultivate thriving crops and contribute to a sustainable food system. We strive to empower every farmer with the tools they need to succeed.",
            ),
            SizedBox(height: 24),
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
          color: Colors.green, // Customizing section title color
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

  Widget _buildFeatureTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(
        icon,
        size: 36,
        color: Colors.green, // Customizing icon color
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 14),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
    );
  }
}
