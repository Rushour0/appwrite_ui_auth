enum BreakPoints { sm, md, lg, xl, xxl }

extension BreakPointExtension on BreakPoints {
  int get value {
    switch (this) {
      case BreakPoints.sm:
        return 480;
      case BreakPoints.md:
        return 768;
      case BreakPoints.lg:
        return 992;
      case BreakPoints.xl:
        return 1280;
      case BreakPoints.xxl:
        return 1536;
    }
  }
}
