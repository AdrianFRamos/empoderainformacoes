import 'package:flutter/material.dart';

IconData getIconForGrandArea(String grandArea) {
    switch (grandArea.toLowerCase()) {
      case 'aposentadoria':
        return Icons.account_balance;
      case 'direitos inclusivos':
        return Icons.all_inclusive;
      case 'seguro social':
        return Icons.lock;
      case 'violência contra a mulher':
        return Icons.shield;
      case 'direitos trabalhistas':
        return Icons.balance;
      case 'saude':
        return Icons.local_hospital;
      case 'educacao':
        return Icons.school;
      case 'profissional':
        return Icons.work;
      case 'comunidade':
        return Icons.monetization_on;
      case 'mercado de trabalho':
        return Icons.work_outline;
      default:
        return Icons.question_mark;
    }
  }