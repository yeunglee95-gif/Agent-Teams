# Code-smell baseline

Part of the `hidden-failure-check` skill; its `## Source` section covers this file. The smells are from Martin Fowler's _Refactoring_, chapter 3. Used on the standards axis of a review, on top of the rules in the app's `CLAUDE.md`.

Two rules bind it:

- **The app's rules win.** Where the app's documented rules allow something a smell below would flag, do not flag it. Skip anything a linter in the gate already enforces.
- **Always a judgment call.** Report a smell as "possible <name>", minor, with the hunk quoted. It never blocks on its own.

Each line: what it is, then the usual fix. Match it against the diff only.

- **Mysterious name:** a function, variable or type whose name does not say what it does or holds. Rename it; if no honest name comes, the design is unclear.
- **Duplicated code:** the same logic shape in more than one hunk or file of the change. Pull out the shared shape and call it from both.
- **Feature envy:** a function that reaches into another object's data more than its own. Move it next to the data.
- **Data clumps:** the same few fields or parameters always travelling together. Bundle them into one type.
- **Primitive obsession:** a plain string or number standing in for a domain idea that deserves its own type. Give it one.
- **Repeated switches:** the same branch on the same type in several places in the change. One map or one dispatch both places share.
- **Shotgun surgery:** one logical change forces scattered edits across many files. Gather what changes together into one module.
- **Divergent change:** one file edited for several unrelated reasons. Split it so each part changes for one reason.
- **Speculative generality:** an abstraction, parameter or hook for a need the spec does not have. Delete it until a real need shows.
- **Message chains:** long `a.b().c().d()` walks the caller should not depend on. Hide the walk behind one call.
- **Middle man:** a class or function that only passes calls on. Cut it and call the real target.
- **Refused bequest:** a subclass or implementation that ignores most of what it inherits. Use composition instead.
