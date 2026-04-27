# ToDoTasks

This is a list of Tasks that still need to be completed for the MVP

### Tasks

<!--1.  Need a way to store the various amounts of data around the players and the game information-->
<!--2.  Need to be able to save any changes to data-->
<!--3.  Need to fetch the information on command-->
<!--+  Fetch Relevant Game data on the game screen-->
<!--+  Fetch Player data on the player screen-->
4.  Need to be able to edit game or player information
5.  Edit Set information
6.  Edit Rally information
7.  Test cases around the differen't logic
8.  Call save at the appropriate locations to save player information and game information
<!--9.  Setup CoreData examples for testing-->
<!--+  Game with a Set, with Rallies-->
<!--+  Player, with data for 3 games-->
<!--10.  Create a screen to choose which player to view information on-->
11.  Determine how to store the rally information to ensure it stays in the appropriate order when fetched
+  Could look into using Date().  That would enable me to keep them in the order that they were set up in (that or I could use an integer)
12.  Look into setting up the trendline for the actual values.  The line seemed off when running the initial tests using a Data Transfer Object
<!--13.  Setup a repository for getting the game information-->
14.  Dark mode functionality
15.  Redo (not just point lost or won)
16.  Auto tracking rotation
17.  Better indicator for current rotation
18.  Guest name
<!--19.  Save game/player-->
<!--    + Save Player-->
<!--    + Save Game-->
20.  Domain model with references
<!--21.  A central cache/registry that holds the actual data models-->
<!--   + Player Cache-->
<!--   + Game Cache-->
<!--22.  Repository just looks at the caches-->
23.  Model the UI for setting up the Rally (PlayerAndStat) off of the UI for setting up a new event in the iOS calendar
24.  Function for initiating another fetch of the data from the backend (CoreData) (PlayerRepository, GameRepository)
<!--25.  Finish the create game flow-->
<!--    +  Save Game-->
<!--    +  Save Set-->
<!--    +  Save Rally-->
26.  Look into removing static singleton's from Previews and recreating the ".preview" in real time.  That way Database persistence doesn't persist across runs
27.  Test out CoreData saving a game in the manual tests
<!--28.  Update the player's data after a game has been saved-->
29.  Update the CDRepositories to make their requests on background threads (Not needed but helps with stability and future proofing)
30.  Investigate adding a SwiftData Repository/Backend as well
31.  Add error handling for initial fetching for GameRepository and PlayerRepository
    + Need to account for issues when the player repository fails to update a specific player
32.  Dry run of MVP (Create players, Create 2 Games, Observe results)
33. Investigate making the different lists (Game, Player) refreshable (pull to refresh ex: .refreshable { } ) 
34. Look into deleting players (and how that would translate to a game)
35. Need to address the initial player no games state (Player recently added.  ex: Showing text "Please return after this player has recorded games" or disabling the navigation link)
36. Cancel adding a game
37. Need to show the Rally values when the row is clicked
38. Investigate editing issue (the rally statistic that is edited isn't the one that was selected (2 statistics have a matching name and stat))
39. Setup a repository protocol for all repositories to extend
40. Add a 'shank' stat (Low prio)
41. Investigate 'Edit' rally bugs
42. Way to delete rally rows
43. Look into autotracking rotations
44. Set view screen resets whenever the set chart object is clicked (AddGameView)
45. Look at players in the game/sets whenever saving/updating player values
46. Save button needs better location for AddSetView (Add in alert message when a user tries to back out of creating the rally/set/Game without hitting the "Save/Done" button)
47. Look into retry whenever a save fails (better error descriptions in debug/for now (we can tailor them for users later))
48. Unit tests
49.  Integration Tests
50.  UI Tests
    
