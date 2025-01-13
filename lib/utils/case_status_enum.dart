enum CaseStatus {
  pending("PENDING", 0.3),
  working("WORKING", 0.66),
  resolved("RESOLVED", 1),
  ;

  const CaseStatus(this.status, this.value);
  final String status;
  final double value;

  static CaseStatus getCaseStatus(String status) {
    return CaseStatus.values.firstWhere(
      (element) {
        return element.status == status;
      },
    );
  }
}
