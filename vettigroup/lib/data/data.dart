import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:vettigroup/model/story.dart';
import 'package:vettigroup/model/user.dart';

final uuid = Uuid();

// AppUser list with unique profile pictures
const List<AppUser> appUserList = [
  AppUser(
      username: 'john_doe',
      email: 'john.doe@example.com',
      userId: 'user123',
      profilePicture:
          'https://images.unsplash.com/photo-1578133671540-edad0b3d689e',
      phoneNumber: 9876543210,
      gender: 'Male',
      bio: 'smple',
      connecting: [],
      connections: []),
  AppUser(
      username: 'jane_smith',
      email: 'jane.smith@example.com',
      userId: 'user124',
      profilePicture:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
      phoneNumber: 9876543211,
      gender: 'Male',
      bio: 'smple',
      connecting: [],
      connections: []),
  AppUser(
      username: 'mike_jordan',
      email: 'mike.jordan@example.com',
      userId: 'user125',
      profilePicture:
          'https://images.unsplash.com/photo-1532298229144-0ec0c57515c7',
      phoneNumber: 9876543212,
      gender: 'Male',
      bio: 'smple',
      connecting: [],
      connections: []),
  AppUser(
      username: 'sarah_lee',
      email: 'sarah.lee@example.com',
      userId: 'user126',
      profilePicture:
          'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0',
      phoneNumber: 9876543213,
      gender: 'Male',
      bio: 'smple',
      connecting: [],
      connections: []),
  AppUser(
      username: 'chris_evans',
      email: 'chris.evans@example.com',
      userId: 'user127',
      profilePicture:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
      phoneNumber: 9876543214,
      gender: 'Male',
      bio: 'smple',
      connecting: [],
      connections: []),
  AppUser(
      username: 'emma_watson',
      email: 'emma.watson@example.com',
      userId: 'user128',
      profilePicture:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2',
      phoneNumber: 9876543215,
      gender: 'Male',
      bio: 'smple',
      connecting: [],
      connections: []),
  AppUser(
      username: 'robert_downey',
      email: 'robert.downey@example.com',
      userId: 'user129',
      profilePicture:
          'https://images.unsplash.com/photo-1519631128182-433895475ffe',
      phoneNumber: 9876543216,
      gender: 'Male',
      bio: 'smple',
      connecting: [],
      connections: []),
];

// Story list associated with AppUsers
final List<Story> stories = [
  Story(
    id: uuid.v4(),
    createdAt: Timestamp.now(),
    isVideo: false,
    mediaUrl: 'https://images.unsplash.com/photo-1578133671540-edad0b3d689e',
    userid: 'user123', // john_doe
  ),
  Story(
    id: uuid.v4(),
    createdAt: Timestamp.now(),
    isVideo: false,
    mediaUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
    userid: 'user124', // jane_smith
  ),
  Story(
    id: uuid.v4(),
    createdAt: Timestamp.now(),
    isVideo: true,
    mediaUrl: 'https://images.unsplash.com/photo-1532298229144-0ec0c57515c7',
    userid: 'user125', // mike_jordan
  ),
  Story(
    id: uuid.v4(),
    createdAt: Timestamp.now(),
    isVideo: false,
    mediaUrl: 'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0',
    userid: 'user126', // sarah_lee
  ),
  Story(
    id: uuid.v4(),
    createdAt: Timestamp.now(),
    isVideo: false,
    mediaUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
    userid: 'user127', // chris_evans
  ),
  Story(
    id: uuid.v4(),
    createdAt: Timestamp.now(),
    isVideo: false,
    mediaUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2',
    userid: 'user128', // emma_watson
  ),
  Story(
    id: uuid.v4(),
    createdAt: Timestamp.now(),
    isVideo: false,
    mediaUrl: 'https://images.unsplash.com/photo-1519631128182-433895475ffe',
    userid: 'user129', // robert_downey
  ),
  Story(
    id: uuid.v4(),
    createdAt: Timestamp.now(),
    isVideo: true,
    mediaUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
    userid: 'user124', // jane_smith
  ),
  Story(
    id: uuid.v4(),
    createdAt: Timestamp.now(),
    isVideo: true,
    mediaUrl: 'https://images.unsplash.com/photo-1532298229144-0ec0c57515c7',
    userid: 'user125', // mike_jordan
  ),
  Story(
    id: uuid.v4(),
    createdAt: Timestamp.now(),
    isVideo: false,
    mediaUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
    userid: 'user127', // chris_evans
  ),
];

// List of background colors represented as hexadecimal strings
List<String> colors = [
  '0xffffffff', // Colors.white
  '0xfff44336', // Colors.red
  '0xffe91e63', // Colors.pink
  '0xff9c27b0', // Colors.purple
  '0xff673ab7', // Colors.deepPurple
  '0xff3f51b5', // Colors.indigo
  '0xff2196f3', // Colors.blue
  '0xff03a9f4', // Colors.lightBlue
  '0xff00bcd4', // Colors.cyan
  '0xff009688', // Colors.teal
  '0xff4caf50', // Colors.green
  '0xff8bc34a', // Colors.lightGreen
  '0xffcddc39', // Colors.lime
  '0xffffeb3b', // Colors.yellow
  '0xffffc107', // Colors.amber
  '0xffff9800', // Colors.orange
  '0xffff5722', // Colors.deepOrange
  '0xff795548', // Colors.brown
  '0xff9e9e9e', // Colors.grey
  '0xff607d8b', // Colors.blueGrey
  '0xff000000', // Colors.black
];

// List of font colors represented as hexadecimal strings
final List<String> fontColors = [
  '0xffffffff', // Colors.white
  '0xff000000', // Colors.black
  '0xfff44336', // Colors.red
  '0xff4caf50', // Colors.green
  '0xff2196f3', // Colors.blue
  '0xffffeb3b', // Colors.yellow
  '0xffff9800', // Colors.orange
  '0xff9c27b0', // Colors.purple
  '0xffe91e63', // Colors.pink
  '0xff795548', // Colors.brown
  '0xff9e9e9e', // Colors.grey
  '0xff009688', // Colors.teal
  '0xff00bcd4', // Colors.cyan
  '0xff3f51b5', // Colors.indigo
  '0xffcddc39', // Colors.lime
  '0xffffc107', // Colors.amber
  '0xffff5722', // Colors.deepOrange
  '0xff673ab7', // Colors.deepPurple
  '0xff03a9f4', // Colors.lightBlue
  '0xff8bc34a', // Colors.lightGreen
  '0xff607d8b', // Colors.blueGrey
];
