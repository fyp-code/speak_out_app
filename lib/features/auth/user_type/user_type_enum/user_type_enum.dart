enum UserRole {
  administrator("ADMINISTRATOR"),
  student("STUDENT");

  const UserRole(this.role);
  final String role;

  static UserRole getShippingStatus(String role) {
    return UserRole.values.firstWhere(
      (element) {
        return element.role == role;
      },
    );
  }
}
