import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kaffo/feature/app/view_prblem/presentation/cubit/view_problem_cubit.dart';
import '../../../../../core/utils/status.dart';
import '../../../problems/data/models/problems/problem_by_id_model.dart';
import '../cubit/address/address_cubit.dart';
import '../cubit/category/category_cubit.dart';

class ProblemDetailWidget extends StatelessWidget {
  final ProblemByIdModel problem;

  const ProblemDetailWidget({super.key, required this.problem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Problem Title
            _buildDetailCard(
              title: 'Problem Title',
              content: problem.title ?? '',
              icon: Icons.title,
            ),

            const SizedBox(height: 16),

            // Problem Description
            _buildDetailCard(
              title: 'Description',
              content: problem.description ?? '',
              icon: Icons.description,
            ),

            const SizedBox(height: 16),

            // Category Information
            _buildCategorySection(context),

            const SizedBox(height: 16),

            // Address Information
            _buildAddressSection(context),

            const SizedBox(height: 16),

            // Additional Details
            _buildAdditionalDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue[700], size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, categoryState) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.category, color: Colors.green, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (categoryState.categoryState == Status.loading)
                  const Center(child: CircularProgressIndicator()),
                if (categoryState.categoryState == Status.error)
                  Text(
                    'Error loading category: ${categoryState.categoryError}',
                    style: const TextStyle(color: Colors.red),
                  ),
                if (categoryState.categoryState == Status.success &&
                    categoryState.category != null)
                  Text(
                    categoryState.category!.name,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                if (categoryState?.categoryState == Status.initial)
                  const Text('Loading category...'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddressSection(BuildContext context) {
    if (problem.addressId == null) {
      return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.location_on, color: Colors.red, size: 20),
              SizedBox(width: 8),
              Text(
                'No address specified',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, addressState) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Address',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (addressState?.addressState == Status.loading)
                  const Center(child: CircularProgressIndicator()),
                if (addressState?.addressState == Status.error)
                  Text(
                    'Error loading address: ${addressState?.addressError}',
                    style: const TextStyle(color: Colors.red),
                  ),
                if (addressState.addressState == Status.success &&
                    addressState.address != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'City: ${addressState.address!.city}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      if (addressState.address!.description!.isNotEmpty)
                        Text(
                          'Street: ${addressState.address!.description}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      if (addressState.address!.description != null &&
                          addressState.address!.description!.isNotEmpty)
                        Text(
                          'Details: ${addressState.address!.description}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                    ],
                  ),
                if (addressState.addressState == Status.initial)
                  const Text('Loading address...'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAdditionalDetails() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.info, color: Colors.purple, size: 20),
                SizedBox(width: 8),
                Text(
                  'Additional Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoRow('Problem ID', '#${problem.id}'),
            _buildInfoRow('Category ID', problem.categoryId.toString()),
            if (problem.addressId != null)
              _buildInfoRow('Address ID', problem.addressId.toString()),
            _buildInfoRow(
              'Created Date',
              DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper extension for status management
extension ProblemDetailExtensions on BuildContext {
  void loadDependencies(int problemId, int? addressId, int categoryId) {
    read<ViewProblemCubit>().getProblemById(problemId);
    if (addressId != null) {
      read<AddressCubit>().getAddressById(addressId);
    }
    read<CategoryCubit>().getCategoryById(categoryId);
  }
}