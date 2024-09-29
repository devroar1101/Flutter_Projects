import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Story {
  final String id;
  final String userid;
  final String mediaUrl;
  final bool isVideo;
  final Timestamp createdAt;

  Story(
      {String? id,
      required this.createdAt,
      required this.isVideo,
      required this.mediaUrl,
      required this.userid})
      : id = id ?? uuid.v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'isVideo': isVideo,
      'mediaUrl': mediaUrl,
      'userid': userid
    };
  }

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
        id: map['id'],
        createdAt: map['createdAt'],
        isVideo: ['isVideo'] as bool,
        mediaUrl: map[' mediaUrl'],
        userid: map['userid']);
  }
}

class FireStoreStoryRepository {
  FireStoreStoryRepository(this.fireStore);

  FirebaseFirestore fireStore;

  void addStory(Story story) async {
    await fireStore.collection('stories').doc(story.id).set(story.toMap());
  }

  void updateStory(Story story) async {
    await fireStore.collection('stories').doc(story.id).update(story.toMap());
  }

  void deleteStory(Story story) async {
    await fireStore.collection('stories').doc(story.id).delete();
  }

  Future<Story?> getStoryById(String storyId) async {
    final snapShot = await fireStore.collection('stories').doc(storyId).get();

    if (snapShot.exists) {
      return Story.fromMap(snapShot.data()!);
    }

    return null;
  }

  Future<List<Story?>> getAllStory() async {
    final snapShot = await fireStore.collection('stories').get();

    return snapShot.docs
        .map(
          (m) => Story.fromMap(
            m.data(),
          ),
        )
        .toList();
  }
}
