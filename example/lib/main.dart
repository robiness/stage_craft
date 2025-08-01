import 'package:flutter/material.dart';
import 'package:stage_craft/stage_craft.dart';
import 'package:stage_craft/src/recording/recording.dart';
import 'package:stage_craft/src/recording/scenario_repository.dart';

Future<void> main() async {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyAwesomeWidgetStage(),
      ),
    ),
  );
}

class MyAwesomeWidgetStage extends StatefulWidget {
  const MyAwesomeWidgetStage({super.key});

  @override
  State<MyAwesomeWidgetStage> createState() => _MyAwesomeWidgetStageState();
}

class _MyAwesomeWidgetStageState extends State<MyAwesomeWidgetStage> {
  late final StageController _stageController;
  late final PlaybackController _playbackController;

  final avatarSize = DoubleControl(
    label: 'Avatar Size',
    initialValue: 80,
    min: 40,
    max: 120,
  );

  final name = StringControl(
    label: 'Name',
    initialValue: 'Sarah Johnson',
  );

  final title = StringControl(
    label: 'Title',
    initialValue: 'Senior Flutter Developer',
  );

  final primaryColor = ColorControl(
    label: 'Primary Color',
    initialValue: const Color(0xFF6366F1),
  );

  final secondaryColor = ColorControl(
    label: 'Secondary Color',
    initialValue: const Color(0xFF8B5CF6),
  );

  final backgroundColor = ColorControl(
    label: 'Background',
    initialValue: Colors.white,
  );

  final cornerRadius = DoubleControl(
    label: 'Corner Radius',
    initialValue: 20,
    min: 0,
    max: 50,
  );

  final elevation = DoubleControl(
    label: 'Elevation',
    initialValue: 8,
    min: 0,
    max: 24,
  );

  final showStats = BoolControl(
    label: 'Show Stats',
    initialValue: true,
  );

  final followers = IntControl(
    label: 'Followers',
    initialValue: 1234,
    min: 0,
    max: 999999,
  );

  final following = IntControl(
    label: 'Following',
    initialValue: 567,
    min: 0,
    max: 999999,
  );

  final posts = IntControl(
    label: 'Posts',
    initialValue: 89,
    min: 0,
    max: 999999,
  );

  @override
  void initState() {
    super.initState();
    _stageController = StageController(
      scenarioRepository: SharedPreferencesScenarioRepository(),
    );
    _playbackController = PlaybackController();
  }

  @override
  void dispose() {
    _stageController.dispose();
    _playbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RecordingStageBuilder(
      stageController: _stageController,
      playbackController: _playbackController,
      controls: [
        name,
        title,
        avatarSize,
        backgroundColor,
        cornerRadius,
        elevation,
        ControlGroup(
          label: 'Colors',
          controls: [
            primaryColor,
            secondaryColor,
          ],
        ),
        ControlGroup(
          label: 'Social Stats',
          controls: [
            showStats,
            followers,
            following,
            posts,
          ],
        ),
      ],
      builder: (context) {
        return AnimatedProfileCard(
          name: name.value,
          title: title.value,
          avatarSize: avatarSize.value,
          primaryColor: primaryColor.value,
          secondaryColor: secondaryColor.value,
          backgroundColor: backgroundColor.value,
          cornerRadius: cornerRadius.value,
          elevation: elevation.value,
          showStats: showStats.value,
          followers: followers.value,
          following: following.value,
          posts: posts.value,
        );
      },
    );
  }
}

class AnimatedProfileCard extends StatefulWidget {
  const AnimatedProfileCard({
    super.key,
    required this.name,
    required this.title,
    required this.avatarSize,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.cornerRadius,
    required this.elevation,
    required this.showStats,
    required this.followers,
    required this.following,
    required this.posts,
  });

  final String name;
  final String title;
  final double avatarSize;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final double cornerRadius;
  final double elevation;
  final bool showStats;
  final int followers;
  final int following;
  final int posts;

  @override
  State<AnimatedProfileCard> createState() => _AnimatedProfileCardState();
}

class _AnimatedProfileCardState extends State<AnimatedProfileCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(
      CurvedAnimation(
        parent: _hoverController,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _hoverController.dispose();
    super.dispose();
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: MouseRegion(
        onEnter: (_) {
          setState(() => _isHovered = true);
          _hoverController.forward();
        },
        onExit: (_) {
          setState(() => _isHovered = false);
          _hoverController.reverse();
        },
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 320 * _scaleAnimation.value,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(widget.cornerRadius),
                boxShadow: [
                  BoxShadow(
                    color: widget.primaryColor.withValues(alpha: 0.15),
                    blurRadius: widget.elevation + (_isHovered ? 4 : 0),
                    offset: Offset(0, widget.elevation / 2 + (_isHovered ? 2 : 0)),
                    spreadRadius: _isHovered ? 1 : 0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        width: widget.avatarSize,
                        height: widget.avatarSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [widget.primaryColor, widget.secondaryColor],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: widget.primaryColor.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.person,
                          size: widget.avatarSize * 0.6,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: widget.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (widget.showStats) ...[
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: widget.primaryColor.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: widget.primaryColor.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatItem(
                            label: 'Followers',
                            value: _formatNumber(widget.followers),
                            color: widget.primaryColor,
                          ),
                          _StatItem(
                            label: 'Following',
                            value: _formatNumber(widget.following),
                            color: widget.secondaryColor,
                          ),
                          _StatItem(
                            label: 'Posts',
                            value: _formatNumber(widget.posts),
                            color: widget.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
