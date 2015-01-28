# SCoreData
Swift-CoreData Tutorial

# Loi_HitList
1: The First Core Data App
Several fundamental Core Data concepts: data models, entities, attributes, managed object contexts and fetch requests
a few rough edges in HitList:
(1) have to get the managed object context from the app delegate each time
(2) use KVC to access the attributes rather than some more natural way

# Bow Ties
2: NSManagedObject Subclasses
fetching and saving
create managed object subclasses in Swift
explored different types of Core Data attributes
validation.

# Dog Walk
3: The Core Data Stack
The stack is made up of four Core Data classes:
• NSManagedObjectModel
• NSPersistentStore
• NSPersistentStoreCoordinator • NSManagedObjectContext

# Bubble Tea
4: Intermediate Fetching
• fetch only what you need to;
• refine your fetched results using predicates;
• fetch in the background to avoid blocking the UI; and
• avoid unnecessary fetching by updating objects directly in the persistent store.

# World Cup
5: NSFetchedResultsController
