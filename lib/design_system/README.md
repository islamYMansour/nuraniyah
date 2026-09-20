# Noor design system

The single source of truth for colour, type, spacing, shape and depth in the
Noor app. Derived from the Claude Design onboarding artboard
(`Noor Arabic Letters App`, 804×1748 @2x → 402×874pt), with every value
sampled from the artboard rather than guessed.

## The one rule

**No screen hard-codes a colour, font size, radius or gap.** Everything comes
from a token:

```dart
import 'package:nuraniyah_app/design_system/design_system.dart';

Container(
  padding: AppSpacing.cardInsets,
  decoration: BoxDecoration(
    color: context.colors.surface,
    borderRadius: AppRadii.card,
    boxShadow: AppElevation.card(context.colors.shadow),
  ),
  child: Text(
    'تعلّم الحروف',
    style: context.typography.titleMedium
        .copyWith(color: context.colors.textPrimary),
  ),
);
```

The raw brand ramp is `private` inside `app_colors.dart`, so reaching past the
semantic layer is not possible from UI code — it will not compile.

## Layout

```
design_system/
├── theme/          tokens + the Material theme built from them
├── icons/          AppIcons, organised by purpose
├── components/     the reusable component library
│   ├── buttons/ textfields/ selection/ chips/ cards/
│   ├── navigation/ feedback/ dialogs/ lists/ avatars/ common/
├── gallery/        the preview harness (a dev tool, not app code)
└── design_system.dart   ← the only file app code imports
```

| File | Holds |
| --- | --- |
| `theme/app_colors.dart` | The private brand ramp, plus `AppColors` — the semantic colour tokens, as a `ThemeExtension`. |
| `theme/app_typography.dart` | `AppFontFamily`, `AppFontWeight`, `AppFontSize`, `AppLineHeight`, `AppLetterSpacing`, plus `AppTypography`. |
| `theme/app_spacing.dart` | `AppSpacing` (the 4pt gap ramp) and `AppSizing` (touch targets, button heights, icon and imagery sizes, stroke widths). |
| `theme/app_radii.dart` | `AppRadius` (the ramp), `AppRadii` (`BorderRadius` by role), `AppShapes` (the same as `ShapeBorder`s). |
| `theme/app_elevation.dart` | `AppElevation` — the solid-slab depth Noor's buttons use, plus soft shadows for cards, sheets and overlays. |
| `theme/app_motion.dart` | `AppDuration` and `AppCurves`. |
| `theme/app_theme.dart` | `AppTheme.light` / `AppTheme.dark` — the only place tokens are wired into Material. |
| `theme/app_theme_context.dart` | `context.colors`, `context.typography`, `context.isRtl`. |
| `icons/app_icons.dart` | Every icon the app names, on Flutter's bundled Material font. |

Flutter has no `Shapes.kt`; `theme/app_radii.dart` plus `theme/app_elevation.dart`
are its equivalent, and `theme/app_theme.dart` applies them through Material's
component themes.

## Components

Every component is presentational — values in, callbacks out. None of them
knows about a screen, a route, a repository or a model.

`AppPressable` is the one to understand first: it is the shared interaction
primitive that renders the design's solid slab, animates it away on press
while the face travels down, and carries hover, keyboard focus (with a visible
ring), press, disabled and semantics. Buttons, cards, chips and list rows all
compose it rather than re-implementing any of that, which is why they all feel
identical under the finger.

| Group | Components |
| --- | --- |
| Buttons | `AppButton` (`.primary` `.secondary` `.outlined` `.text` `.danger` × 3 sizes, with icon, loading, full-width), `AppIconButton` (plain/tonal/filled), `AppFab` (icon-only or extended) |
| Text fields | `AppTextField` (+ `.number`, `.multiline`), `AppSearchField`, `AppPasswordField` |
| Selection | `AppCheckbox` (incl. tristate), `AppRadioGroup` + `AppRadioOption`, `AppSwitch`, `AppSegmentedControl` + `AppSegment`, `AppDropdown` + `AppDropdownItem` |
| Chips & tags | `AppChip` (assist / filter / input), `AppTag` (7 tones) |
| Containers | `AppCard` (filled / elevated / outlined, tappable, selectable), `AppSurface` (+ `.circle`), `AppSection`, `AppDivider` (+ `.vertical`) |
| Navigation | `AppAppBar`, `AppBackButton`, `AppBottomNav` + `AppNavDestination`, `AppTabBar` + `AppTab` |
| Feedback | `AppMessage` (success/warning/error/info), `AppSnackbar` helpers, `AppEmptyState`, `AppLoadingState`, `AppProgressIndicator`, `AppProgressBar`, `AppSkeleton` (+ `.text`, `.circle`), `AppSkeletonParagraph` |
| Dialogs | `AppDialog`, `AppDialogs.alert/confirm/custom`, `AppBottomSheet`, `AppBottomSheets.show` |
| Lists | `AppListItem`, `AppExpandableListItem`, `AppListSectionHeader` |
| Identity | `AppAvatar` (4 sizes, image → initials → glyph fallback), `AppBadge` (+ `.dot`) |
| Common | `AppPressable`, `AppTooltip` |

### States

Interactive components handle default, hover, pressed, focused, selected,
disabled, loading and error, all coloured from the tokens. Two rules worth
knowing:

* **Nothing interactive is smaller than 48pt.** Noor is used by children,
  whose taps are less precise than an adult's. Checkbox, radio and switch rows
  are tappable across their whole width, not just on the control.
* **Loading never moves the layout.** A button in `isLoading` keeps its exact
  size and swaps its content for a spinner.

### What was deliberately not built

Date picker, time picker, calendar, pagination and a navigation drawer. Nothing
in the design calls for them, and a speculative component is a component that
gets built twice. Add them when a screen needs one.

`AppTextField` also covers the "number", "multiline" and "read-only" cases
through named constructors and flags rather than separate widgets — same API,
no duplication.

## The gallery

`gallery/design_system_gallery.dart` is a live catalogue: every token and every
component, with toggles for light/dark and RTL/LTR. It is a **test harness, not
an application screen**, and is deliberately not exported from
`design_system.dart`.

To look at it, point the entry point at it temporarily:

```dart
import 'package:nuraniyah_app/design_system/gallery/gallery.dart';

MaterialApp(home: const DesignSystemGallery());
```

The LTR toggle is the quickest way to catch a component that used `left`/`right`
where it should have used `start`/`end`. `test/design_system_test.dart` pumps
the whole gallery through both themes and both directions on every test run.

## Colour tokens

Every `onX` token is the content colour for the `X` ground it names. Every
foreground/ground pair below meets **WCAG AA (4.5:1)** in both themes, with two
documented exceptions:

* `textDisabled` — disabled text is exempt from contrast minimums by design.
* White on `primary` (`#2E9A93`) is **3.4:1**. That is the design's own CTA
  fill, and it is kept exactly. It passes AA for large text (≥24sp), which is
  the only way the design uses it. **For teal text or icons below 24sp, use
  `primaryStrong` (`#217A75`, 4.8:1 on the cream ground) instead.**

#### Brand — primary

| Token | Light | Dark |
| --- | --- | --- |
| `primary` | `#2E9A93` | `#5CC4BC` |
| `onPrimary` | `#FFFFFF` | `#14544F` |
| `primaryPressed` | `#217A75` | `#86D5CE` |
| `primaryStrong` | `#217A75` | `#86D5CE` |
| `primaryContainer` | `#E2F3F1` | `#1E3B39` |
| `onPrimaryContainer` | `#14544F` | `#9FE3DC` |

#### Brand — secondary

| Token | Light | Dark |
| --- | --- | --- |
| `secondary` | `#5C4A8A` | `#AD9BDC` |
| `onSecondary` | `#FFFFFF` | `#2A1F47` |
| `secondaryPressed` | `#4A3B73` | `#C4B6E8` |
| `secondaryContainer` | `#EDE9F5` | `#2E2748` |
| `onSecondaryContainer` | `#3B2F5C` | `#CFC2F0` |

#### Surfaces

| Token | Light | Dark |
| --- | --- | --- |
| `background` | `#FAF8F5` | `#16151B` |
| `onBackground` | `#2F2D3A` | `#F2F0F5` |
| `surface` | `#FFFFFF` | `#201F27` |
| `onSurface` | `#2F2D3A` | `#F2F0F5` |
| `surfaceVariant` | `#F4F1EB` | `#2A2933` |
| `onSurfaceVariant` | `#514F5E` | `#C9C6D4` |
| `surfaceInverse` | `#2F2D3A` | `#F2F0F5` |
| `onSurfaceInverse` | `#FAF8F5` | `#201F27` |

#### Text

| Token | Light | Dark |
| --- | --- | --- |
| `textPrimary` | `#2F2D3A` | `#F2F0F5` |
| `textSecondary` | `#6B6978` | `#B8B5C4` |
| `textDisabled` | `#A8A6B2` | `#74717F` |
| `textLink` | `#7661A8` | `#B9A6E8` |
| `textInverse` | `#FAF8F5` | `#201F27` |

#### Lines

| Token | Light | Dark |
| --- | --- | --- |
| `border` | `#E9E4DC` | `#393845` |
| `borderStrong` | `#DAD4C9` | `#4D4B5C` |
| `borderFocus` | `#2E9A93` | `#5CC4BC` |
| `divider` | `#F0ECE4` | `#2E2D38` |

#### Status

| Token | Light | Dark |
| --- | --- | --- |
| `success` | `#2C7A4B` | `#5FC98A` |
| `onSuccess` | `#FFFFFF` | `#06301A` |
| `successContainer` | `#E7F5EC` | `#1B3A28` |
| `onSuccessContainer` | `#1E5E38` | `#A8E8C0` |
| `error` | `#BC4038` | `#F0938A` |
| `onError` | `#FFFFFF` | `#3A100C` |
| `errorContainer` | `#FDE7E4` | `#3A1F1C` |
| `onErrorContainer` | `#7A2A23` | `#F7B8B0` |
| `warning` | `#966406` | `#F0C05A` |
| `onWarning` | `#FFFFFF` | `#382703` |
| `warningContainer` | `#FDF3D8` | `#3A2C10` |
| `onWarningContainer` | `#6B4A06` | `#F7D28C` |
| `info` | `#2A6FA5` | `#7FB8E6` |
| `onInfo` | `#FFFFFF` | `#08243A` |
| `infoContainer` | `#EFF6FC` | `#16344A` |
| `onInfoContainer` | `#1B4D75` | `#B5D9F5` |

#### Playful accents

| Token | Light | Dark |
| --- | --- | --- |
| `accentSky` | `#DCECF7` | `#2A4A5E` |
| `onAccentSky` | `#1B4D75` | `#CDE6F7` |
| `accentSun` | `#F6C94A` | `#F0C05A` |
| `onAccentSun` | `#4A3608` | `#382703` |
| `accentCoral` | `#F28C82` | `#F0938A` |
| `onAccentCoral` | `#5C1F1A` | `#3A100C` |

#### Effects

| Token | Light | Dark |
| --- | --- | --- |
| `shadow` | `#2F2D3A` | `#000000` |
| `primaryShadow` | `#217A75` | `#1A6560` |
| `secondaryShadow` | `#4A3B73` | `#3B2F5C` |
| `scrim` | `#2F2D3A` | `#000000` |
| `disabled` | `#E5E1DA` | `#2A2933` |
| `onDisabled` | `#A8A6B2` | `#74717F` |

### The brand ramp

For reference only — these are private and unreachable from UI code. The four
values marked ✦ are sampled directly off the artboard.

| Ramp | Steps |
| --- | --- |
| Teal (primary) | `#14544F` `#1A6560` ✦`#217A75` ✦`#2E9A93` `#5CC4BC` `#86D5CE` `#9FE3DC` `#E2F3F1` `#1E3B39` |
| Purple (secondary) | `#2A1F47` `#3B2F5C` `#4A3B73` ✦`#5C4A8A` ✦`#7661A8` `#AD9BDC` `#B9A6E8` `#C4B6E8` `#CFC2F0` `#EDE9F5` `#2E2748` |
| Sun (yellow) | `#382703` `#4A3608` `#6B4A06` `#966406` ✦`#F6C94A` `#F0C05A` `#F7D28C` `#FDF3D8` `#3A2C10` |
| Coral | `#3A100C` `#5C1F1A` `#7A2A23` `#BC4038` ✦`#F28C82` `#F0938A` `#F7B8B0` `#FDE7E4` `#3A1F1C` |
| Sky | `#08243A` `#1B4D75` `#2A6FA5` `#7FB8E6` `#B5D9F5` `#CDE6F7` ✦`#DCECF7` `#EFF6FC` `#2A4A5E` `#16344A` |
| Leaf (success) | `#06301A` `#1E5E38` `#2C7A4B` `#5FC98A` `#A8E8C0` `#E7F5EC` `#1B3A28` |
| Ink (cool text neutrals) | `#16151B` `#201F27` `#2A2933` `#2F2D3A` `#514F5E` ✦`#6B6978` `#74717F` `#A8A6B2` `#B8B5C4` `#C9C6D4` `#F2F0F5` |
| Sand (warm surface neutrals) | `#FFFFFF` ✦`#FAF8F5` `#F4F1EB` `#F0ECE4` `#E9E4DC` `#E5E1DA` `#DAD4C9` |

Noor's warmth comes from pairing **warm sand grounds with cool ink text** — the
cream `#FAF8F5` background under the faintly violet `#6B6978` subtitle grey.
Keep that pairing when extending the ramp.

## Typography

One family, Arabic-first. Colour is never baked into a style — apply it with
`.copyWith(color: context.colors.…)`.

| Token | Size | Weight | Line height | Used for |
| --- | --- | --- | --- | --- |
| `wordmark` | 56 | 800 | 1.30 | The "نُور" logo lockup — one use only |
| `displayLarge` | 56 | 700 | 1.30 | Splash / celebration headlines |
| `displayMedium` | 44 | 700 | 1.30 | Large hero numbers and letters |
| `displaySmall` | 36 | 700 | 1.35 | Section hero text |
| `headlineLarge` | 32 | 700 | 1.35 | Screen titles |
| `headlineMedium` | 28 | 700 | 1.35 | Card and dialog titles |
| `headlineSmall` | 24 | 600 | 1.45 | Sub-section titles |
| `titleLarge` | 22 | 600 | 1.45 | App bar title, prominent list headers |
| `titleMedium` | 20 | 600 | 1.45 | List tile titles |
| `titleSmall` | 18 | 600 | 1.50 | Dense list titles, tab labels |
| `bodyLarge` | 18 | 400 | 1.75 | Lead paragraph — the onboarding subtitle |
| `bodyMedium` | 16 | 400 | 1.75 | Default body copy |
| `bodySmall` | 14 | 400 | 1.70 | Secondary body copy, helper text |
| `labelLarge` | 16 | 600 | 1.45 | Form labels, chips, prominent metadata |
| `labelMedium` | 14 | 600 | 1.45 | Compact labels — the "تسجيل الدخول" link |
| `labelSmall` | 12 | 600 | 1.35 | Badges, counters, overlines |
| `caption` | 12 | 400 | 1.50 | Timestamps, footnotes, image captions |
| `button` | 22 | 700 | 1.30 | Primary button label — "هيّا نبدأ" |

Weights: 400 regular · 500 medium · 600 semiBold · 700 bold · 800 extraBold.

### Two rules that are specific to Arabic

1. **Letter spacing is `0` on every style.** Arabic is cursive — its letters
   join. Positive tracking forces gaps into those joins and makes a word look
   broken. `AppLetterSpacing.latinWide` exists only for Latin-only strings
   (version numbers, locale switchers) and must never touch Arabic text.
2. **Body line height is 1.75, not the ~1.5 a Latin app would use.** Harakat
   rise above the letter body and several letters descend well below the
   baseline; without that room, diacritics collide with the line above — which
   matters more here than in most apps, because teaching harakat *is* the
   product.

### Fonts

`AppFontFamily.primary` is `Tajawal`. The `.ttf` files are **not yet bundled**,
so Flutter currently falls back through `AppFontFamily.fallback` to the
platform's Arabic system font (Noto Sans Arabic on Android, Geeza Pro on
iOS/macOS). That renders correctly everywhere — it is simply not yet the
intended face.

To bundle it, drop the weights into `assets/fonts/` and add to `pubspec.yaml`:

```yaml
flutter:
  fonts:
    - family: Tajawal
      fonts:
        - asset: assets/fonts/Tajawal-Regular.ttf
          weight: 400
        - asset: assets/fonts/Tajawal-Medium.ttf
          weight: 500
        - asset: assets/fonts/Tajawal-Bold.ttf
          weight: 700
        - asset: assets/fonts/Tajawal-ExtraBold.ttf
          weight: 800
```

Weight 600 is not a Tajawal weight; Flutter resolves it to the nearest bundled
weight. If the semiBold steps matter, bundle a 600 or retune
`AppFontWeight.semiBold`. Changing the face is a one-line change to
`AppFontFamily.primary` — nothing else in the app names a font.

## Spacing, sizing, shape, depth

* **`AppSpacing`** — a 4pt ramp (`xs` 4 … `x6` 64) plus named roles
  (`screenHorizontal`, `sectionGap`, `contentGap`, `itemGap`, `cardPadding`).
  Prefer the named roles in layouts: they say *why* a gap exists.
* **`AppSizing`** — `minTouchTarget` 48 (nothing interactive may be smaller;
  Noor is used by children), button heights 44/56/**72** (72 is the design's
  hero CTA), icon sizes, `medallion` 200 (the character's circular plate),
  `dotSmall` 10 / `dotMedium` 14 (the confetti dots), stroke widths, and
  `maxContentWidth` 600 so Arabic lines stay a comfortable measure on tablets.
* **`AppRadius` / `AppRadii` / `AppShapes`** — Noor rounds generously; that is
  what makes it read as a children's app. Buttons are a full stadium
  (`AppRadii.button`), cards 24, dialogs and sheets 32.
* **`AppElevation`** — two kinds of depth, not interchangeable:
  * `AppElevation.solid(context.colors.primaryShadow)` is the house style for
    anything pressable — an un-blurred slab of a darker shade offset 5pt
    straight down, exactly as under the design's CTA. Animate the offset to
    zero on press so the key travels into the page.
  * `card` / `raised` / `overlay` are the diffuse shadows for passive
    surfaces. All take the shadow colour from `context.colors.shadow` so depth
    inverts correctly in dark mode.

## Dark theme

The design specifies light only. `AppColors.dark` is a faithful inversion —
same hues, re-tuned for a dark ground, every pair verified against AA. When the
design gains dark artboards, reconcile them here.

## Layout direction

Noor is Arabic-first. Build layouts direction-agnostically —
`EdgeInsetsDirectional`, `start`/`end`, `AlignmentDirectional` — rather than
`left`/`right`, and consult `context.isRtl` only where a decision genuinely
depends on direction. Note that the app does not yet configure `MaterialApp`
with Arabic locales or `localizationsDelegates`; that is app wiring, outside
this design system.

## Extending it

1. Add the raw value to the private `_Palette` / the relevant ramp.
2. Give it a **semantic** name on the token class — what it is *for*, not what
   it looks like.
3. Add the matching dark value.
4. Check contrast for any new foreground/ground pair.
5. Document it in the tables above.

Never add a token straight to a screen.
