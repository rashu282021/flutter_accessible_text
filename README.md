# Flutter Accessible Text

`flutter_accessible_text` is a Flutter package that helps you automatically scale text according to accessibility settings and WCAG/Material guidelines. It provides **full scaling for content** and **capped scaling for UI/Chrome text** to prevent layout breakage.

---

## Features

- **Content Text**: fully respects system text scaling (paragraphs, values, descriptions)
- **Chrome/UI Text**: capped scaling for buttons, tabs, labels, and UI elements
- **Responsive**: auto-adjusts for tablets
- **Accessible Widgets**: `AccessibleText.text` integrates with `Semantics` for screen readers
- **Helper Methods**: scale icons, touch targets, layout sizes according to accessibility

---

## Installation

Add this to your package `pubspec.yaml`:

```yaml
dependencies:
  flutter_accessible_text:
    git:
      url: https://github.com/rashu282021/flutter_accessible_text.git