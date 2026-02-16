# Project Handoff: Query Combat (Detroit Edition)
1. Project Scope & Objective
We have transformed a generic prototype into a branded Motor City experience.
The Goal: Players navigate a digital representation of Detroit, conquering trivia "Combat Nodes" to prove their mastery of the city’s history and culture.
The Objective: Success requires clearing every node on the path to trigger the "Detroit Conquered" victory state.
Visual Theme: A high-contrast industrial look featuring a black background, a custom gray asphalt road, and high-visibility yellow dashed lines.
Safe Area Optimization: UI elements are scaled to fit within tvOS Safe Area margins to prevent clipping on physical television screens.

# 3. Core "Live" Infrastructure
The app uses a "Live" infrastructure, meaning the game world isn't static; it reacts in real-time to user input and keeps services running globally regardless of which screen is visible.
Audio System: A centralized AudioManager singleton loops the QueryCombatLoop.mp3 globally, ensuring the "vibe" never cuts out during transitions.
Character Animation: The Rat_Icon uses a vertical "Idle Bob" effect, providing rhythmic movement to the player's board position.
Tactile Feedback: The AnswerButton features a "squish" scale effect, offering physical confirmation—crucial for users navigating via the Siri Remote.
Progression Logic: Level nodes use dynamic states—gold (unlocked), gray (locked), and checkmarks (completed).

# 4. Professional MVVM Architecture
We organized the code using the Model-View-ViewModel (MVVM) pattern. This is a "Separation of Concerns" strategy that keeps the app’s "Brain" (logic) separate from its "Face" (UI), making the project easier to debug and scale without breaking the visual layout.

# 5. Developer Coding & Documentation Standards
To maintain a high-quality collaborative environment, we follow these Swift Documentation and Clean Code conventions:
Documentation Comments (///): Used to describe the purpose of a file or function. Option-Click these in Xcode to see professional documentation pop-ups.
Inline Comments (//): Used for "quick notes" to explain the why behind complex logic inside a function.
Organization Headers (// MARK: -): These create bold separators in the Xcode Jump Bar, allowing you to skip directly to "Logic" or "UI" sections.
Naming Conventions: We use CamelCase (e.g., isGameComplete) to ensure the code remains readable and consistent with Apple’s native Swift APIs.

# 6. Key Learnings & tvOS Best Practices
Focus Engine: Node sizes are set to 150pt so the native tvOS "card glow" doesn't overlap other board elements when a user hovers over them.
Asset Management: New assets must be checked in the Target Membership box in the File Inspector to be bundled correctly with the app.
State-Driven Navigation: We use a "Master Switch" in the App file to swap views instantly based on the hasStartedGame variable, keeping the navigation stack clean.
