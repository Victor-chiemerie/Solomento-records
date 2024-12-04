class FilterCriteria {
  final String? repairStatus;
  final bool? approvalStatus;
  final String? technician;

  const FilterCriteria({
    this.repairStatus,
    this.approvalStatus,
    this.technician,
  });

  /// Empty FilterCriteria which represents an unFiltered car
  static FilterCriteria empty = FilterCriteria(
    repairStatus: '',
    approvalStatus: false,
    technician: '',
  );

  /// Convenience getter to determine whether the current FilterCriteria has no details
  bool get isEmpty => this == FilterCriteria.empty;

  /// Convenience getter to determine whether the current FilterCriteria has details
  bool get isNotEmpty => this != FilterCriteria.empty;
}