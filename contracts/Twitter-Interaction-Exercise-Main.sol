// SPDX-License-Identifier: MIT

// 2️⃣ Add a getProfile() function to the interface ✅
// 3️⃣ Initialize the IProfile in the contructor ✅
// HINT: don't forget to include the _profileContract address as a input
// 4️⃣ Create a modifier called onlyRegistered that require the msg.sender to have a profile ✅
// HINT: use the getProfile() to get the user
// HINT: check if displayName.length > 0 to make sure the user exists
// 5️⃣ ADD the onlyRegistered modified to createTweet, likeTweet, and unlikeTweet function ✅

import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity ^0.8.0;

interface IProfile {
    struct UserProfile {
        string displayName;
        string bio;
    }

    // CODE HERE

    function getProfile(address _user)
        external
        view
        returns (UserProfile memory);
}

contract Twitter is Ownable {
    uint16 public MAX_TWEET_LENGTH = 280;

    struct Tweet {
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    IProfile profileContract;
    mapping(address => Tweet[]) public tweets;

    event TweetCreated(
        uint256 id,
        address author,
        string content,
        uint256 timestamp
    );
    event TweetLiked(
        address liker,
        address tweetAuthor,
        uint256 tweetId,
        uint256 newLikeCount
    );
    event TweetUnliked(
        address unliker,
        address tweetAuthor,
        uint256 tweetId,
        uint256 newLikeCount
    );

    modifier onlyRegistered() {
        IProfile.UserProfile memory userProfileTemp = profileContract
            .getProfile(msg.sender);
        require(
            bytes(userProfileTemp.displayName).length > 0,
            "USER NOT REGISTERED"
        );
        _;
    }

    constructor(address initialOwner) Ownable(initialOwner) {
        profileContract = IProfile(initialOwner);
    }

    function getTotalLikes(address _author) external view returns (uint256) {
        uint256 totalLikes;

        for (uint256 i = 0; i < tweets[_author].length; i++) {
            totalLikes += tweets[_author][i].likes;
        }

        return totalLikes;
    }

    function createTweet(string memory _tweet) public onlyRegistered{
        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Tweet is too long");

        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);

        emit TweetCreated(
            newTweet.id,
            newTweet.author,
            newTweet.content,
            newTweet.timestamp
        );
    }

    function likeTweet(address author, uint256 id) external onlyRegistered{
        require(id < tweets[author].length, "Tweet does not exist");

        tweets[author][id].likes++;

        emit TweetLiked(msg.sender, author, id, tweets[author][id].likes);
    }

    function unlikeTweet(address author, uint256 id) external onlyRegistered{
        require(id < tweets[author].length, "Tweet does not exist");
        require(tweets[author][id].likes > 0, "Tweet has no likes");

        tweets[author][id].likes--;

        emit TweetUnliked(msg.sender, author, id, tweets[author][id].likes);
    }

    function getTweet(uint256 _i) public view returns (Tweet memory) {
        require(_i < tweets[msg.sender].length, "Tweet index out of bounds");

        return tweets[msg.sender][_i];
    }

    function getAllTweets(address _owner) public view returns (Tweet[] memory) {
        return tweets[_owner];
    }
}
