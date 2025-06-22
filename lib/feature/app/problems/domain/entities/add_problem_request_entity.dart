class AddProblemRequest {
  final String? title;
  final String? description;
  final int? addressId;
  final int? categoryId;

  AddProblemRequest({
    this.title,
    this.description,
    this.addressId,
    this.categoryId,
  });
}
