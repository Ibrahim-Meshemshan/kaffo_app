class ProblemsResponse {
  final List<ProblemsContentEntity>? content;
  final Pageable? pageable;
  final bool? last;
  final int? totalPages;
  final int? totalElements;
  final bool? first;
  final int? size;
  final int? number;
  final Sort? sort;
  final int? numberOfElements;
  final bool? empty;

  ProblemsResponse({
    this.content,
    this.pageable,
    this.last,
    this.totalPages,
    this.totalElements,
    this.first,
    this.size,
    this.number,
    this.sort,
    this.numberOfElements,
    this.empty,
  });

}

class ProblemsContentEntity {
  final int? id;
  final String? title;
  final String? description;
  final bool? isReal;
  final bool? forContribution;
  final bool? forDonation;
  final String? submissionDate;
  final String? status;
  final int? addressId;
  final int? submittedByUserId;
  final int? approvedByUserId;
  final int? categoryId;


  ProblemsContentEntity({
    this.id,
    this.title,
    this.description,
    this.isReal,
    this.forContribution,
    this.forDonation,
    this.submissionDate,
    this.status,
    this.addressId,
    this.submittedByUserId,
    this.approvedByUserId,
    this.categoryId,
  });

}

class Pageable {
  final int? pageNumber;
  final int? pageSize;
  final Sort? sort;
  final int? offset;
  final bool? paged;
  final bool? unpaged;

  Pageable({
    this.pageNumber,
    this.pageSize,
    this.sort,
    this.offset,
    this.paged,
    this.unpaged,
  });
}

class Sort {
  final bool? sorted;
  final bool? empty;
  final bool? unsorted;

  Sort({
    this.sorted,
    this.empty,
    this.unsorted,
  });

}
