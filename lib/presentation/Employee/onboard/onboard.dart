part of 'onboard_imports.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).primaryColor.withOpacity(0.7),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Curved lines background
            Positioned.fill(
              child: CustomPaint(
                painter: CurvePainter(),
              ),
            ),

            // Main content
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(flex: 4),
                    // Heading text
                    AppTextstyle(
                      text: 'Fleek HR, don\'t just manage ideas,',
                      style: appStyle(
                        size: 20,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodyLarge?.color ??
                            Colors.black,
                      ),
                    ),
                    SizedBox(height: 12),
                    AppTextstyle(
                      text: 'Drive Innovation & Success',
                      style: appStyle(
                        size: 28,
                        fontWeight: FontWeight.w700,
                        color:
                            Theme.of(context).textTheme.headlineLarge?.color ??
                                Colors.black,
                      ),
                    ),

                    Spacer(flex: 1),

                    // Buttons
                    Appbtn(
                      text: "Login",
                      fontSize: 18,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      width: double.infinity,
                      height: 56,
                      onPressed: () {
                        context.push('/login');
                      },
                    ),
                    SizedBox(height: 16),
                    
                    Spacer(),

                    // Footer
                    Center(
                      child: Text(
                        'All Rights Reserved By Md Abir Hasan',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).textTheme.bodySmall?.color ??
                              Colors.black54,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
