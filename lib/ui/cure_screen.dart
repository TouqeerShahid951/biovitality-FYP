import 'package:flutter/material.dart';

class Cure extends StatelessWidget {
  final String diseaseName;
  final Map<String, String> disease;
  final Map<String, String> diseaseDetails;
  final Image? img;


  Cure(this.diseaseName, this.img, {Key? key}) :
        disease = {
          // Existing labels with cures
          "Apple Scab":
          "Choose resistant varieties when possible. Rake under trees and destroy infected leaves to reduce the number of fungal spores available to start the disease cycle over again next spring. Water in the evening or early morning hours (avoid overhead irrigation) to give the leaves time to dry out before infection can occur.",
          "Apple Black Root":
          "Fungicides like copper-based sprays and lime sulfur, can be used to control black rot.",
          "Apple Cedar Apple":
          "Remove galls from infected junipers. In some cases, juniper plants should be removed entirely. Apply preventative, disease-fighting fungicides labeled for use on apples weekly, starting with bud break, to protect trees from spores being released by the juniper host.",
          "Apple Healthy": "Your plant is already healthy",
          "Corn Cercospora Leaf Spot":
          "The disease can be reduced when a crop other than corn is planted for ≥2 years in that given area. Also Fungicides, if sprayed early in season before initial damage, can be effective in reducing disease.",
          "Corn Common Rust":
          "Spray of mancozeb@ 2.5g/litre of water at first appearance of pustules. Prefer early maturing varieties.",
          "Corn Northern Leaf Blight":
          "Fungicide application to reduce yield loss and improve harvestability.",
          "Corn Healthy": "Your plant is already healthy",
          "Tomato Bacterial Spot":
          "A plant with bacterial spot cannot be cured. Remove symptomatic plants from the field or greenhouse to prevent the spread of bacteria to healthy plants. Burn, bury or hot compost the affected plants and DO NOT eat symptomatic fruit.",
          "Tomato Early Blight":
          "Treat organically with copper spray. Follow label directions. You can apply until the leaves are dripping, once a week and after each rain. Or you can treat it organically with a biofungicide like Serenade.",
          "Tomato Late Blight":
          "Remove all affected leaves and burn them or place them in the garbage. Mulch around the base of the plant with straw, wood chips or other natural mulch to prevent fungal spores in the soil from splashing on the plant.",
          "Tomato Leaf Mold":
          "By adequating row and plant spacing that promote better air circulation through the canopy reducing the humidity; preventing excessive nitrogen on fertilization since nitrogen out of balance enhances foliage disease development.",
          "Tomato Septoria Leaf Spot":
          "Apply sulfur sprays or copper-based fungicides weekly at first sign of disease to prevent its spread. These organic fungicides will not kill leaf spot, but prevent the spores from germinating.",
          "Tomato Spider Mites spotted":
          "A natural way to kill spider mites on your plants is to mix one part rubbing alcohol with one part water, then spray the leaves. The alcohol will kill the mites without harming the plants. Another natural solution to get rid of these tiny pests is to use liquid dish soap.",
          "Tomato Target Spot":
          "Target spot tomato treatment requires a multi-pronged approach. Pay careful attention to air circulation, as target spot of tomato thrives in humid conditions. Grow the plants in full sunlight. Be sure the plants aren’t crowded and that each tomato has plenty of air circulation. Cage or stake tomato plants to keep the plants above the soil.",
          "Tomato Mosaic Virus":
          "By treating seeds with 10% Trisodium Phosphate for at least 15 minutes. Whenever possible, virus resistant tomatoes should be planted. Additionally, removal of symptomatic plants may slow the spread of disease once it occurs.",
          "Tomato Yellow Leaf Curl Virus":
          "Treatment for this disease includes insecticides, hybrid seeds, and growing tomatoes under greenhouse conditions.",
          "Tomato Healthy": "Your plant is already healthy",
          "Potato Early Blight":
          "Avoid overhead irrigation. Do not dig tubers until they are fully mature in order to prevent damage. Do not use a field for potatoes that was used for potatoes or tomatoes the previous year.",
          "Potato Late Blight":
          "Fungicides are available for management of late blight on potato.",
          "Potato Healthy": "Your plant is already healthy",
          "Citrus Tristeza Virus":
          "No known cure; control measures focus on using tolerant rootstocks and removing infected trees to prevent spread.",
          "Citrus Huanglongbing":
          "Bactericides are a topical treatment aimed at slowing the bacteria that cause citrus greening. The bactericides do not absorb into the tree or fruit. While this is a relatively new treatment for citrus trees.",
          "Citrus Black Spot":
          "Remove and destroy infected fruit to prevent the spread of spores. Fungicide applications can help control the disease.",
          "Citrus Canker":
          "Copper-based sprays can help manage the disease. Infected trees should be removed and destroyed to prevent spread.",
          "Citrus Healthy": "Your plant is already healthy",
          "Grape Black Rot":
          "Cut off the affected parts of the grape vine with a sterile knife. Remove all spotted leaves and the black, mummified grapes. Be extremely thorough and make sure you remove all parts of the plant that are affected by the black rot. Place fans in the growing area to keep the plants dry.",
          "Grape Black Measles":
          "Lime sulfur sprays can manage the trio of pathogens that cause black measles.",
          "Grape Isariopsis Leaf Spot":
          "Fungicides sprayed for other diseases in the season may help to reduce this disease.",
          "Grape Healthy": "Your plant is already healthy",
          "Chili Leaf Curl":
          "Manage whiteflies to reduce the spread of the virus that causes leaf curl. Insecticidal soaps and oils can be used to control whitefly populations.",
          "Chili Leaf Spot":
          "Apply fungicides if necessary and remove infected leaves to prevent the spread of the disease.",
          "Chili Whitefly":
          "Use yellow sticky traps to monitor and reduce whitefly populations. Insecticidal soaps and neem oil can also help control them.",
          "Chili Yellowish":
          "Ensure proper watering and nutrient management. Use fertilizers with balanced nutrients to address any deficiencies.",
          "Chili Healthy": "Your plant is already healthy",

          // New labels with enhanced cures
          "Banana Cordana":
          "Remove and destroy affected leaves. Improve air circulation around the plants. Fungicide applications can help control the spread of the disease.",
          "Banana Pestalotiopsis":
          "Prune and destroy affected leaves. Ensure proper irrigation and avoid overhead watering. Fungicides can help manage the disease.",
          "Banana Sigatoka":
          "Remove and destroy infected leaves. Use resistant varieties if available. Apply fungicides regularly to control the disease.",
          "Banana Healthy": "Your plant is already healthy",
          "Cotton Bacterial Blight":
          "Use disease-free seeds and resistant varieties. Apply copper-based bactericides if necessary. Practice crop rotation to reduce disease incidence.",
          "Cotton Curl Virus":
          "Control whitefly populations to reduce the spread of the virus. Use insecticides and reflective mulches to manage whiteflies. Remove and destroy infected plants.",
          "Cotton Fussarium Wilt":
          "Use resistant varieties and avoid planting in fields with a history of the disease. Improve soil drainage and practice crop rotation.",
          "Cotton Healthy": "Your plant is already healthy",
          "Mango Leaf Twisting Weevil":
          "Prune and destroy affected leaves and twigs. Apply insecticides to control the weevil population.",
          "Mango White Scale":
          "Use horticultural oils or insecticidal soaps to control scale populations. Prune and destroy heavily infested branches.",
          "Mango Red Wax Scale":
          "Apply horticultural oils to smother scales. Use insecticidal soaps or systemic insecticides for control.",
          "Mango Cyberoptics Kenya":
          "Monitor and manage pest populations using integrated pest management techniques. Use appropriate insecticides if necessary.",
          "Mango Breadfruit Whitefly":
          "Use yellow sticky traps to monitor and control whitefly populations. Apply insecticidal soaps or neem oil to manage infestations.",
          "Mango Seychelles Scale":
          "Apply horticultural oils or insecticidal soaps to control scale populations. Prune and destroy heavily infested branches.",
          "Mango Shoot Borer":
          "Prune and destroy infested shoots. Apply insecticides to control borer populations.",
          "Mango Neomelicharia Sparsa":
          "Monitor and manage pest populations using integrated pest management techniques. Apply insecticides if necessary.",
          "Mango Healthy": "Your plant is already healthy",
          "Papaya Mosaic":
          "Use virus-free planting material. Control aphid populations to reduce the spread of the virus. Remove and destroy infected plants.",
          "Papaya Ring Spot":
          "Use resistant varieties and virus-free planting material. Control aphid populations to reduce the spread of the virus.",
          "Papaya Anthracnose":
          "Apply fungicides to control the disease. Remove and destroy affected fruits and plant parts. Improve air circulation around plants.",
          "Papaya Powdery Mildews":
          "Apply sulfur or potassium bicarbonate-based fungicides. Ensure proper air circulation around plants.",
          "Rice Bacterial Leaf Blight":
          "Use resistant varieties and disease-free seeds. Practice good field sanitation and crop rotation.",
          "Rice Blast":
          "Use resistant varieties and apply fungicides. Practice crop rotation and ensure proper field drainage.",
          "Rice Brownspot":
          "Use disease-free seeds and resistant varieties. Apply fungicides and practice crop rotation.",
          "Rose Black Spot":
          "Remove and destroy infected leaves. Apply fungicides regularly to control the disease. Ensure proper air circulation around plants.",
          "Downy Mildew":
          "Apply fungicides to control the disease. Ensure proper spacing and air circulation around plants.",
          "Fresh Leaf": "Your plant is already healthy",
          "Rose Botrytis":
          "Remove and destroy infected plant parts. Apply fungicides and ensure proper air circulation around plants.",
          "Rose Crown Gall":
          "Remove and destroy infected plants. Avoid planting in fields with a history of the disease.",
          "Rose Dying":
          "Identify the underlying cause (e.g., disease, pests, environmental factors) and take appropriate measures to address it.",
          "Tea Algal":
          "Apply copper-based fungicides to control the disease. Ensure proper air circulation around plants.",
          "Tea Anthracnose":
          "Apply fungicides to control the disease. Remove and destroy infected plant parts.",
          "Tea Bird Eye Spot":
          "Apply fungicides and ensure proper spacing and air circulation around plants.",
          "Tea Brown Blight":
          "Use fungicides to control the disease. Remove and destroy affected plant parts.",
          "Tea Gray Light":
          "Ensure proper air circulation around plants. Apply fungicides if necessary.",
          "Tea Red Leaf Spot":
          "Apply fungicides to control the disease. Ensure proper air circulation around plants.",
          "Tea White Spot":
          "Use fungicides to control the disease. Ensure proper air circulation around plants.",
          "Tea Healthy": "Your plant is already healthy"
        },
        diseaseDetails = {
          "Apple Scab":
          "Symptoms include dark, scabby spots on leaves and fruits. It thrives in wet conditions and can cause defoliation if severe.",
          "Apple Black Rot":
          "Causes circular, sunken lesions on fruits and cankers on twigs. Infected fruits shrivel and become mummified.",
          "Apple Cedar Apple Rust":
          "Identified by yellow-orange spots or lesions on leaves, often with a rusty appearance. Can cause premature leaf drop and reduce fruit yield.",
          "Apple Healthy": "No symptoms observed.",
          "Corn Cercospora Leaf Spot":
          "Manifests as small, grayish-brown spots with yellow halos on leaves. Leads to premature leaf senescence and reduced yield.",
          "Corn Common Rust":
          "Characterized by orange to reddish-brown pustules primarily on leaves. Can cause significant yield loss if severe.",
          "Corn Northern Leaf Blight":
          "Causes cigar-shaped lesions with gray centers and dark borders on leaves. Can reduce photosynthetic capacity and yield.",
          "Corn Healthy": "No symptoms observed.",
          "Tomato Bacterial Spot":
          "Shows as dark brown to black spots with a yellow halo on leaves and fruits. Leads to defoliation and fruit lesions.",
          "Tomato Early Blight":
          "Identified by concentric rings with dark centers on older leaves. Leads to defoliation and reduced fruit quality.",
          "Tomato Late Blight":
          "Characterized by water-soaked lesions on leaves that quickly enlarge to become brown and necrotic. Can cause complete defoliation in severe cases.",
          "Tomato Leaf Mold":
          "Causes yellowing and wilting of leaves, often with grayish-white mold on the underside. Thrives in humid conditions.",
          "Tomato Septoria Leaf Spot":
          "Manifests as small, dark spots with white centers on leaves. Leads to premature defoliation and reduced fruit yield.",
          "Tomato Spider Mites spotted":
          "Shows as stippling or yellow speckling on leaves due to mite feeding. Fine webbing may be visible under leaves.",
          "Tomato Target Spot":
          "Identified by concentric rings with dark centers and yellow halos on leaves. Can cause premature leaf drop and reduce fruit quality.",
          "Tomato Mosaic Virus":
          "Causes mosaic patterns of light and dark green on leaves. Infected plants may be stunted with distorted fruits.",
          "Tomato Yellow Leaf Curl Virus":
          "Leads to curling and yellowing of leaves, often with stunted growth and reduced fruit yield.",
          "Tomato Healthy": "No symptoms observed.",
          "Potato Early Blight":
          "Characterized by dark lesions with concentric rings on lower leaves. Leads to defoliation and reduced tuber yield.",
          "Potato Late Blight":
          "Shows as water-soaked lesions on leaves that quickly turn brown and necrotic. Can cause tuber rot if severe.",
          "Potato Healthy": "No symptoms observed.",
          "Citrus Tristeza Virus":
          "Causes yellowing and stunting of leaves, often with decline in fruit quality and yield. No cure is available.",
          "Citrus Huanglongbing":
          "Leads to blotchy mottling of leaves, yellow shoots, and bitter fruits. No cure is available; affects tree health.",
          "Citrus Black Spot":
          "Characterized by circular, depressed spots with a black center on leaves and fruits. Leads to premature fruit drop.",
          "Citrus Canker":
          "Shows as raised, corky lesions on leaves, twigs, and fruits. Can cause defoliation and fruit deformation.",
          "Citrus Healthy": "No symptoms observed.",
          "Grape Black Rot":
          "Causes circular, brown lesions on leaves and fruits. Infected fruits shrivel and become mummified.",
          "Grape Black Measles":
          "Identified by small, black pustules on leaves and fruits. Leads to premature leaf drop and reduced fruit yield.",
          "Grape Isariopsis Leaf Spot":
          "Manifests as small, dark spots with yellow halos on leaves. Can lead to defoliation and reduced grape quality.",
          "Grape Healthy": "No symptoms observed.",
          "Chili Leaf Curl":
          "Leads to curling and puckering of leaves, often with yellowing and stunted growth. Spread by whiteflies.",
          "Chili Leaf Spot":
          "Shows as dark brown to black spots on leaves, often with yellow halos. Can cause defoliation and reduced fruit yield.",
          "Chili Whitefly":
          "Identified by white, waxy secretions on leaves and stems. Can cause yellowing and stunted growth of plants.",
          "Chili Yellowish":
          "Shows as yellowing of leaves, often due to nutrient deficiencies or improper watering.",
          "Chili Healthy": "No symptoms observed.",
          // New entries
          "Banana Cordana":
          "Manifests as dark, water-soaked lesions on leaves and fruits. Can lead to premature leaf drop and reduced fruit yield.",
          "Banana Pestalotiopsis":
          "Shows as dark, irregular lesions on leaves and stems. Can cause defoliation and reduced fruit quality.",
          "Banana Sigatoka":
          "Characterized by yellow spots or streaks on leaves, often with premature leaf drop. Can reduce fruit yield.",
          "Banana Healthy": "No symptoms observed.",
          "Cotton Bacterial Blight":
          "Causes water-soaked lesions on leaves and bolls, often with ooze. Leads to defoliation and reduced fiber quality.",
          "Cotton Curl Virus":
          "Leads to curling and puckering of leaves, often with yellowing and stunted growth. Spread by whiteflies.",
          "Cotton Fussarium Wilt":
          "Shows as wilting of leaves and stems, often with yellowing and necrosis. Can cause plant death in severe cases.",
          "Cotton Healthy": "No symptoms observed.",
          "Mango Leaf Twisting Weevil":
          "Manifests as twisting and curling of leaves, often with necrotic areas. Can cause defoliation and reduced fruit yield.",
          "Mango White Scale":
          "Identified by white, waxy secretions on leaves and stems. Can cause yellowing and stunted growth of plants.",
          "Mango Red Wax Scale":
          "Shows as red, waxy secretions on leaves and stems. Can cause yellowing and stunted growth of plants.",
          "Mango Cyberoptics Kenya":
          "Characterized by irregular lesions and discoloration on leaves and stems. Can lead to defoliation and reduced fruit quality.",
          "Mango Breadfruit Whitefly":
          "Identified by white, waxy secretions on leaves and stems. Can cause yellowing and stunted growth of plants.",
          "Mango Seychelles Scale":
          "Shows as white, waxy secretions on leaves and stems. Can cause yellowing and stunted growth of plants.",
          "Mango Shoot Borer":
          "Manifests as holes and tunnels in shoots and stems, often with frass. Can cause dieback and reduced fruit yield.",
          "Mango Neomelicharia Sparsa":
          "Characterized by irregular lesions and discoloration on leaves and stems. Can lead to defoliation and reduced fruit quality.",
          "Mango Healthy": "No symptoms observed.",
          "Papaya Mosaic":
          "Causes mosaic patterns of light and dark green on leaves. Infected plants may be stunted with distorted fruits.",
          "Papaya Ring Spot":
          "Identified by ringspots and line patterns on leaves and fruits. Can cause leaf distortion and reduced fruit yield.",
          "Papaya Anthracnose":
          "Shows as dark, sunken lesions on leaves and fruits. Can cause premature fruit drop and reduced fruit quality.",
          "Papaya Powdery Mildews":
          "Manifests as white, powdery growth on leaves and fruits. Thrives in humid conditions and can reduce photosynthetic capacity.",
          "Rice Bacterial Leaf Blight":
          "Causes water-soaked lesions on leaves, often with yellow halos. Leads to defoliation and reduced grain yield.",
          "Rice Blast":
          "Identified by small, elliptical lesions with gray centers on leaves. Can cause complete panicle blast in severe cases.",
          "Rice Brownspot":
          "Shows as small, circular lesions with brown centers on leaves. Can lead to premature leaf senescence and reduced grain yield.",
          "Rose Black Spot":
          "Characterized by circular, black spots with fringed edges on leaves. Leads to defoliation and reduced flower production.",
          "Downy Mildew":
          "Manifests as grayish-white, fuzzy growth on leaves. Can cause defoliation and reduced flower production.",
          "Fresh Leaf": "No symptoms observed.",
          "Rose Botrytis":
          "Causes gray mold on flowers, stems, and leaves, often with brown spots. Leads to flower blight and reduced flower production.",
          "Rose Crown Gall":
          "Shows as galls or tumors on stems and roots. Can cause stunting and reduced vigor of plants.",
          "Rose Dying":
          "Shows as wilting, yellowing, or necrosis of leaves and stems. Can be caused by various pathogens, pests, or environmental factors.",
          "Tea Algal":
          "Identified by green, slimy growth on leaves and stems. Thrives in moist conditions and can reduce photosynthetic capacity.",
          "Tea Healthy": "No symptoms observed.",
        },
        super(key: key);

  @override
  @override
  @override
  @override
  @override
  Widget build(BuildContext context) {
    String cure = disease[diseaseName] ?? "No cure information available.";
    String details = diseaseDetails[diseaseName] ?? "No details available.";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Disease $diseaseName',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Center the image container
            Center(
              child: Material(
                elevation: 5.0,
                shadowColor: Colors.greenAccent,
                surfaceTintColor: Colors.greenAccent,
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 600,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 2, color: Colors.grey),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: FittedBox(
                      fit: BoxFit.cover, // Zoom and fill the box
                      child: img,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Details of $diseaseName',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 10),
            Text(
              details,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            Text(
              'Cure for $diseaseName',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 10),
            Text(
              cure,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

