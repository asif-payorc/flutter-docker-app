# ---------- Stage 1: Build ----------
FROM ghcr.io/cirruslabs/flutter:3.41.6 AS builder

WORKDIR /app

COPY pubspec.* ./
RUN flutter pub get

COPY . .

RUN flutter build apk --release


# ---------- Stage 2: Final (Lightweight) ----------
FROM alpine:3.19

WORKDIR /app

COPY --from=builder /app/build/app/outputs/flutter-apk/app-release.apk .

CMD ["ls", "-lh"]