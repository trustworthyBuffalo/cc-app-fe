import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../model_post.dart';

class HomePage extends StatefulWidget {
  final Function(Map<String, dynamic>) onOpenDetail;

  const HomePage({super.key, required this.onOpenDetail});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RewardedAd? _rewardedAd;
  bool _isAdLoading = false;

  final Set<String> unlockedPosts = {};

  Stream<List<Post>> readPosts() {
    return FirebaseFirestore.instance
        .collection("posts")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Post.fromDocSnapshot(doc)).toList(),
        );
  }

  String formatTime(Timestamp timestamp) {
    return DateFormat('dd MMM yyyy • HH:mm').format(timestamp.toDate());
  }

  void _loadRewardedAd(String postId) {
    if (_isAdLoading) return;
    _isAdLoading = true;

    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isAdLoading = false;
          _showRewardedAd(postId);
        },
        onAdFailedToLoad: (error) {
          _isAdLoading = false;
          debugPrint("RewardedAd failed: $error");
        },
      ),
    );
  }

  void _showRewardedAd(String postId) {
    _rewardedAd?.show(
      onUserEarnedReward: (ad, reward) {
        setState(() {
          unlockedPosts.add(postId);
        });
      },
    );

    _rewardedAd = null;
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: RichText(
          text: TextSpan(
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            children: [
              TextSpan(
                text: 'Campus',
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(text: 'Collab'),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: Colors.black),
        ),
      ),

      body: StreamBuilder<List<Post>>(
        stream: readPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Belum ada postingan"));
          }

          final posts = snapshot.data!;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];

              final isUnlocked = unlockedPosts.contains(post.id);
              final shouldBlur = post.isChecked && !isUnlocked;

              return Column(
                children: [
                  Card(
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text("U"),
                          ),
                          title: Text(
                            "User",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            formatTime(post.createdAt),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),

                        if (post.imageUrl.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 60),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ImageFiltered(
                                    imageFilter: shouldBlur
                                        ? ImageFilter.blur(sigmaX: 6, sigmaY: 6)
                                        : ImageFilter.blur(
                                            sigmaX: 0,
                                            sigmaY: 0,
                                          ),
                                    child: Image.network(
                                      post.imageUrl,
                                      width: 250,
                                      height: 250,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  if (shouldBlur)
                                    GestureDetector(
                                      onTap: () {
                                        _loadRewardedAd(post.id);
                                      },
                                      child: Container(
                                        width: 250,
                                        height: 250,
                                        color: Colors.black.withOpacity(0.25),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Tap untuk membuka\n(Lihat Iklan)",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),

                        SizedBox(height: 12),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 60,
                            vertical: 12,
                          ),
                          child: Text(
                            post.description,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 0),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
