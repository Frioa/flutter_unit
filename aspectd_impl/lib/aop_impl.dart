import 'package:aspectd/aspectd.dart';

@Aspect()
@pragma('vm:entry-point')
class InjectDemo {
  @pragma('vm:entry-point')
  InjectDemo();

  // @Execute('package:flutter_unit/main.dart', 'MyApp', '+build')
  // @pragma('vm:entry-point')
  // void build(PointCut pointcut) {
  //   pointcut.proceed();
  //   print('l依赖注入 build');
  // }

  @Inject('package:flutter_unit/main.dart', 'MyApp', '+build', lineNum: 11)
  @pragma('vm:entry-point')
  static void build() {
    print('l依赖注入 build');
  }
}
