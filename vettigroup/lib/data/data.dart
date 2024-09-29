import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:vettigroup/model/post.dart';
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

List<Post> mockPosts = [
  Post(
    userId: 'user123',
    createdAt: Timestamp.now(),
    type: PostType.text,
    mediaUrl: '',
    content: 'This is my first text post!',
  ),
  Post(
    userId: 'user123',
    createdAt: Timestamp.now(),
    type: PostType.image,
    mediaUrl: 'https://images.unsplash.com/photo-1501594907352-04cda38ebc29',
    content: 'A beautiful sunset view!',
  ),
  Post(
    userId: 'user124',
    createdAt: Timestamp.now(),
    type: PostType.video,
    mediaUrl: 'https://www.w3schools.com/html/mov_bbb.mp4',
    content: 'Watch this cool video!',
  ),
  Post(
    userId: 'user124',
    createdAt: Timestamp.now(),
    type: PostType.image,
    mediaUrl: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
    content: 'Delicious cup of coffee.',
  ),
  Post(
    userId: 'user125',
    createdAt: Timestamp.now(),
    type: PostType.image,
    mediaUrl: 'https://images.unsplash.com/photo-1516802273409-68526ee1bdd6',
    content: 'Nature at its best!',
  ),
  Post(
    userId: 'user126',
    createdAt: Timestamp.now(),
    type: PostType.text,
    mediaUrl: '',
    content: 'Good morning, everyone!',
  ),
  Post(
    userId: 'user124',
    createdAt: Timestamp.now(),
    type: PostType.video,
    mediaUrl: 'https://www.w3schools.com/html/movie.mp4',
    content: 'Check out this amazing short film!',
  ),
  Post(
    userId: 'user123',
    createdAt: Timestamp.now(),
    type: PostType.image,
    mediaUrl: 'https://images.unsplash.com/photo-1522770179533-24471fcdba45',
    content: 'Look at this amazing waterfall!',
  ),
  Post(
    userId: 'user125',
    createdAt: Timestamp.now(),
    type: PostType.image,
    mediaUrl: 'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0',
    content: 'My latest mountain adventure.',
  ),
  Post(
    userId: 'user127',
    createdAt: Timestamp.now(),
    type: PostType.text,
    mediaUrl: '',
    content: 'Excited to share more soon!',
  ),
  Post(
    userId: 'user123',
    createdAt: Timestamp.now(),
    type: PostType.video,
    mediaUrl: 'https://www.w3schools.com/html/mov_bbb.mp4',
    content: 'A quick behind-the-scenes video.',
  ),
  Post(
    userId: 'user127',
    createdAt: Timestamp.now(),
    type: PostType.image,
    mediaUrl: 'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa',
    content: 'The city lights are mesmerizing.',
  ),
];
