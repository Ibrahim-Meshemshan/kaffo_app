
class AddProblemResponseEntity {
  final int? id;
  final String? title;
  final String? description;
  final bool? isReal;
  final bool? forContribution;
  final bool? forDonation;
  final DateTime? submissionDate;
  final String? status;
  final String? rejectionReason;
  final int? addressId;
  final int? submittedByUserId;
  final int? categoryId;

  AddProblemResponseEntity({
    this.id,
    this.title,
    this.description,
    this.isReal,
    this.forContribution,
    this.forDonation,
    this.submissionDate,
    this.status,
    this.rejectionReason,
    this.addressId,
    this.submittedByUserId,
    this.categoryId,
  });

}
