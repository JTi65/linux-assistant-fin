class LinuxCommand {
  /// Defines the user, which will run the command. Has to be numeric.
  /// - '0' stands for root
  /// - '1000' for the normal user e.g.
  ///
  /// Linux.currentEnvironment.currentUserId can help.
  late int userId;

  late String command;
  late Map<String, String>? environment;

  // Used as explanation to users
  late String description;

  LinuxCommand({
    required this.userId,
    required this.command,
    this.environment,
    this.description = "",
  });

  @override
  String toString() {
    // TODO: implement toString
    return command;
  }
}
