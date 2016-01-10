# Graphene
A small graph library for Ruby. Extracted from my Cinchcli project.
**A work in progress!**

## Documentation
The library is being documented heavily through Yard. So to generate
documentation, please install *yard* using

```bash
gem install yard
```

Once *yard* is done installing, navigate up to the root folder of this library
and run

```bash
yard
```

to generate the full documentation. This library is still unfinished. So a lot
of changes are expected until the library hits 1.0. Also a very detailed
tutorial style guide will replace this readme once the library is finished. So
stay tuned!

## Version Numbers
We will be using Semantic Versioning. But don't expect the semantic versioning
to start until we hit 1.0.

## Rubocop Offenses
Graphene uses Rubocop to make sure that the library is in compliance with the
Ruby style guide. As it stands, Graphene's classes are too complex for Ruby
Style Guide. If you run, Rubocop on the master branch, the errors you should
see should only be related to the complexity. Those issues will be fixed
before the library hits 1.0. If you see any other errors, please report them
through Github issues.
