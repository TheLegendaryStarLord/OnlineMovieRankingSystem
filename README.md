# Online Movie Ranking System
A web-based platform for film fans to keep track of their rankings for movies they have watched and see others’ rankings. This system will make it easier for users to remember the movies they watched, when they watched them, and what their opinions on them were.  

## Tech Stack
 
| Tier | Technology |
|---|---|
| Presentation | HTML, CSS (Tailwind), JavaScript, Jinja templates |
| Application | Python, Flask, mysql-connector-python (raw SQL, no ORM) |
| Data | MySQL |

## Project Structure
 
```
OnlineMovieRankingSystem/
├── app.py            # Flask entry point
├── config.py         # settings loaded from .env
├── requirements.txt
├── .env              
├── db/
│   ├── schema.sql    # database schema
│   ├── seed.sql      # pre-fill table rows
│   └── connection.py # connection helper
├── dao/              # SQL statements by entity
├── services/         # business logic, authorization, TMDB client
├── routes/           # Flask blueprints (URL handlers)
├── templates/        # HTML pages
└── static/           # css/, js/, images/

## Ownership
 
| Who | Folders |
|---|---|
| Frontend | `templates/`, `static/` |
| Backend | `dao/`, `services/`, `routes/`, `db/`, `app.py`, `config.py` |

## Setup
 
```bash
# 1. Clone the repo and enter it
cd movie-ranker
 
# 2. Create and activate a virtual environment
python3 -m venv venv
source venv/bin/activate
 
# 3. Install dependencies
pip install -r requirements.txt
 
# 4. Install and start MySQL (if needed)
brew install mysql
brew services start mysql
 
# 5. Create a .env file in the project root
```
 
`.env` contents (use your own values):
 
```
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=movie_ranker
TMDB_API_KEY=your_tmdb_key
```
 
 ## Database
 
Build (or rebuild) the database from the project root:
 
```bash
mysql -u root -p < db/schema.sql
mysql -u root -p < db/seed.sql
```
 
 ### Tables
 
- **Movies**: `MovieID` (TMDB id), `Name`, `Description`, `MatureRating`, `AvgReview`, `ReleaseDate`, `Language`, `PosterIMG`
- **Users**: `UserID`, `Username`, `Email`, `PasswordHash`, `TimeCreated`, `ProfileIMG`
- **UserReviews**: `ReviewID`, `UserID`, `MovieID`, `Content`, `StarRating` (1-5), `PublishedDate`, `UpdateDate`. One review per user per movie.
- **UserWatchList**: `UserID`, `MovieID`, `DateAdded`. Primary key is `(UserID, MovieID)`.

## Run the App
 
```bash
source venv/bin/activate
flask run
```
 
Then open http://localhost:5000.

## Security Rules
 
- Passwords are stored hashed (`werkzeug.security`), never in plain text.
- Only the author can edit or delete their review (enforced in the SQL `WHERE UserID = ...`).
- Users cannot edit movie info. Only `AvgReview` changes, and only through review changes.