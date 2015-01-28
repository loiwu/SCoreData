# Versioning and Migration

1 - When to migrate
“when you need to make changes to the data model.”

2 - The migration process
To start the migration process, Core Data needs the original data model and the destination model. It uses these two versions to load or create a mapping model for the migration, which it uses to convert data in the original store to data that it can store in the new store. Once Core Data determines the mapping model, the migration process can start in earnest.
Migrations happen in three steps:
(1) First, Core Data copies over all the objects from one data store to the next.
(2) Next, Core Data connects and relates all the objects according to the relationship mapping.
(3) Enforce any data validations in the destination model. Core Data disables destination model validations during the data copy.
With nearly all types of Core Data migrations, nothing happens to the original store unless the migration completes without error. Only when a migration is successful, will Core Data remove the original data store.

3 - Types of migrations
(1) Lightweight migrations
A lightweight migration is Apple’s term for the migration with the least amount of work involved on your part. Simply enable a couple of flags when setting up a Core Data stack, and the migration happens automatically. There are some limitations on how much you can change the data model, but because of the small amount of work required to enable this option, it is the ideal setting.
(2) Manual migrations
Manual migrations involve a little more work on your part. You need to specify how to map the old set of data onto the new set, but you get the benefit of a more explicit mapping model file to configure. Setting up a mapping model in Xcode is much like setting up a data model, with similar GUI tools and some automation.
(3) Custom manual migrations
This is level 3 of the migration complexity index. You still use a mapping model, but add to that custom code with the ability to also specify custom transformation logic on data. In this case, custom entity transformation logic involves creating an NSEntityMigrationPolicy subclass and performing custom transformations there.
(4) Fully manual migrations
Fully manual migrations are for those times when even specifying custom transformation logic isn’t enough to fully migrate data from one model version to another. In this case, custom version detection logic and custom handling of the migration process are necessary. 
