/// Enum that defines the layout strategy for each article.
///
/// Each layout provides a different visual structure optimized for
/// specific types of content and narrative styles.
enum WritingLayout {
  /// Traditional article layout: linear content with proper typography.
  /// Ideal for engineering writeups, technical deep-dives, and educational content.
  standard,

  /// Timeline-based layout with vertical progression.
  /// Perfect for project evolution stories, career journeys, and historical breakdowns.
  timeline,

  /// Diagram and flow-focused layout with connected visual nodes.
  /// Excellent for architecture articles, workflows, and conceptual explanations.
  diagramHeavy,

  /// Insights and takeaways layout with highlighted key learnings.
  /// Great for lessons learned, best practices, and case study conclusions.
  insights,
}
