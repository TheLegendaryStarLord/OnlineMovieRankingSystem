-- Database schema script 

-- Create database
CREATE DATABASE IF NOT EXISTS mymovie_ranker; 
USE movie_ranker; 

-- Reset database when schema changes 
DROP TABLE IF EXISTS UserWatchList;
DROP TABLE IF EXISTS UserReviews;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Movies;

-- Create tables
-- Movies: stores movie details, pulled from TMDB API
CREATE TABLE Movies (
    MovieID      INT PRIMARY KEY,              -- TMDB movie ID
    Name         VARCHAR(255) NOT NULL,
    Description  TEXT NOT NULL DEFAULT ('No description available.'),
    MatureRating VARCHAR(10)  NOT NULL DEFAULT 'NR',
    AvgReview    DECIMAL(3,2) NOT NULL DEFAULT 0.00,    -- calculated 
    ReleaseDate  DATE NOT NULL,
    Language     VARCHAR(10)  NOT NULL,
    PosterIMG    VARCHAR(255) NOT NULL DEFAULT '/static/images/no_poster.png'
);

-- Users: stores user info and login credentials
CREATE TABLE Users (
    UserID       INT AUTO_INCREMENT PRIMARY KEY,
    Username     VARCHAR(50)  NOT NULL UNIQUE,
    Email        VARCHAR(255) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    TimeCreated  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ProfileIMG   VARCHAR(255) NOT NULL DEFAULT '/static/images/default_avatar.png'
);

-- UserReviews: stores movie review and ranking data
CREATE TABLE UserReviews (
    ReviewID      INT AUTO_INCREMENT PRIMARY KEY,
    UserID        INT NOT NULL,
    MovieID       INT NOT NULL,
    Content       TEXT NOT NULL,
    StarRating    TINYINT NOT NULL CHECK (StarRating BETWEEN 1 AND 5),
    PublishedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdateDate    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID)  REFERENCES Users(UserID)   ON DELETE CASCADE,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID) ON DELETE CASCADE,
    UNIQUE (UserID, MovieID)                      -- one review per user per movie
);

CREATE TABLE UserWatchList (
    UserID    INT NOT NULL,
    MovieID   INT NOT NULL,
    DateAdded DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (UserID, MovieID),
    FOREIGN KEY (UserID)  REFERENCES Users(UserID)   ON DELETE CASCADE,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID) ON DELETE CASCADE
);