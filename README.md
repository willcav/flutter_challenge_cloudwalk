# Flutter Challenge Cloudwalk

> App Challenge for Cloudwalk Interview Process.

An app that loads the current location of the user in the map with and without the device's location
feature.

More details about the challenge can be
found [here](https://gist.github.com/cloudwalk-tests/0945f56177d3498d38cd9002d96fda4f).

---

## Preview

![Preview](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExcjMwNmRqeDFzYW4wdWZiZng5dHY2M2s4bGVsaDlqNW92cGMyY2dyNyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/J75S0NdR7sHuIQRQgi/giphy.gif)

---

## Table of Contents

- [Environment](#environment)
    - [How to run](#how-to-run)
- [Project Structure](#project-structure)
    - [Multi-Package Structure](#multi-package-structure)
    - [Multi-Package Mono Repo vs Multi Repo](#multi-package-mono-repo-vs-multi-repo)
    - [Micro Frontends](#micro-frontends)
- [App package](#app-package)
- [Core Package](#core-package)
    - [Resources](#resources)
- [Map Package](#map-package)
- [Architecture Overview](#architecture-overview)
    - [Dependency Injection](#dependency-injection)
    - [SOLID Principles](#solid-principles)
- [Feature Overview](#feature-overview)
- [Testing](#testing)

---

<br>

## Environment

Follow the [flutter](https://docs.flutter.dev/get-started/install) documentation step by step to
prepare your environment.

- **Flutter**
  | Environment | Version |
  | ------------------------ | ------- |
  | Flutter (channel Stable) | 3.19.6 |
  | Dart | >=3.3.4 <4.0.0 |

### How to run

This project uses [Melos](https://github.com/invertase/melos) to manage the project and its
dependencies.

#### Installing Melos

First, make sure that `.pub-cache/bin` is saved in the `PATH` variable, this folder contains all
global packages that will be used:

```bash
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

To install Melos, run the following command in your terminal:

```bash
dart pub global activate melos
```

To initialize the workspace and link the local packages together and install remaining package
dependencies, run the following command at the root of the project:

```bash
melos bs
```

#### Running the App

To run the app, navigate to the `app` package and run the following command:

```bash
cd packages/app
flutter run
```

You can also set the app entry point as `packages/app/lib/main.dart` through the Android Studio or
Visual Studio Code and simply run by clicking the play button.

---

## Project Structure

Even though this is a small app with basically one feature, the project was structured into
multiple
packages, as defined in the `melos.yaml` file. This structure allows for better organization and
this project can be easily scaled in the future.

### Multi-Package Structure

This project adopts a multi-package structure, which means it is divided into multiple packages,
each with its own specific functionality. This structure has several advantages:

- Separation of Concerns: Each package can focus on a specific feature or functionality, making the
  code easier to understand and maintain.
- Reusability: Packages can be reused across different parts of the project or even in different
  projects, reducing code duplication.
- Independent Development and Testing: Each package can be developed and tested independently, which
  can speed up the development process.
- Scalability: It's easier to scale a project with a multi-package structure as new features or
  functionalities can be added as new packages.

### Multi-Package Mono Repo vs Multi Repo

A multi-package mono repo is a single repository that contains multiple packages. This is different
from a multi-repo approach where each package is in its own repository.

- Multi-Package Mono Repo: All packages live in the same repository. This makes it easier to
  coordinate changes across packages, enforce coding standards, and manage dependencies. However, it
  can also lead to a large, monolithic repository that can be difficult to navigate and manage.
- Multi Repo: Each package has its own repository. This allows for more granular access control and
  can make each repository simpler to understand. However, it can make coordinating changes across
  repositories more difficult and can lead to duplication of configuration and tooling.

### Micro Frontends

This project does not aim to implement a micro frontend architecture. However, it's worth mentioning
that `Micro Frontends` is an architectural style where a frontend app is decomposed
into `micro-apps`, each
corresponding to a business subdomain. This approach can have some similarities with a multi-package
structure in terms of separation of concerns and independent development. However, it's primarily
used for decomposing large frontend applications into smaller.

## App package

The `app` package is the entry point of the application. It initializes resources and starts the
Flutter application. The main widget of the application is `MyApp`, which sets up the MaterialApp
with a theme and a home page. The home page is a Scaffold that calls the `MapPage` from
the `map feature`.

The `app` package depends on the `core` and `map` packages, which are local packages as defined in
the `pubspec.yaml` file.

## Core Package

The core package is a crucial part of this project. It contains shared functionalities that are used
across different parts of the app. By placing this shared code in a
separate package, it can be easily reused and maintained, leading to a more consistent and efficient
codebase.

### Resources

Some of the features in the core package are abstractions of popular dependencies. Abstractions
serve as a high-level representation of the functionality
provided by third-party libraries.

By leveraging abstractions and wrappers, we can achieve greater maintainability in our codebases.
When the need arises to switch to a different library or upgrade to a newer version, the changes can
be confined to the implementation of the abstraction or wrapper.

- **Network**: Provides a comprehensive network layer abstraction with domain-driven design. It
  separates concerns into domain, data, and infrastructure layers, offering flexibility and ease of
  testing. The Network implements the `Dio` package to handle HTTP requests.
- **Geolocation**: Provides a comprehensive geolocation abstraction with domain-driven design. It
  separates concerns into domain, data, and infrastructure layers, offering flexibility and ease of
  testing. The Geolocation implements the `geolocator` package to handle location requests.
- **ServiceLocator**: In this project, the GetIt dependency is encapsulated within the GetItDriver
  implementation,
  adhering to the interface we've defined.
- **Utils**: Provides a set of utility functions that can be used across the application.

### Map Package

The map package holds the main feature of the app. It provides the `MapPage` component and uses
the `Geolocation` to handle the user's location.

---

## Architecture Overview

The main architectural concept used in the App was the `Clean Architecture`. A
multi-layer architecture that facilitates unit testing and helps us with separation of
responsibilities. Another objective of this architecture is to facilitate the scalability of the App
features.

### Dependency Injection

The project uses the `get_it` package through the `ServiceLocator` to facilitate the organization of
dependency injection. The control is done by each package/feature.

### SOLID Principles

Other good practices present in the project are Clean Code for more descriptive nomenclature and the
SOLID principles.

---

## Feature Overview

### Flow

The logic to retrieve the user's location is managed by the `Map Package`.

The first source for the
data is the device's location, but if the user denies the permission, the app will use the IP
address to get the location.

If the GPS location is unavailable, but the permission is granted, the
app will try to show the last known location.

The worst case scenario is when both sources for location are unavailable, in this case, the button
will show a text "try again".

<img src="https://i.imgur.com/rhtIKth.png" width="600" alt="location feature"/>

### Structure

As mentioned before, the `GeoLocation` feature is implemented in the `core` package and is
responsible for managing the user's location. The `Map` package uses this feature through the
implementation of the repository.

The `Network` feature is also implemented in the `core` package and is responsible for managing the
HTTP requests. The `Map` package uses this feature through the implementation of the repository to
make a request to the `http://ip-api.com` API.

Both the `GeoLocation` and `Network` work as sources for the user's location.

<img src="https://i.imgur.com/oCU8jQ2.png" width="600" alt="architecture"/>
---

## Testing

The project uses `mocktail` for mocking and `flutter_test` for unit tests.

Tests can be run using the `melos test` command as defined in the `melos.yaml` file.

<img src="https://i.imgur.com/oqM3Jtu.png" width="500" alt="core tests"/>