import 'package:cinerating/models/crew_model.dart';
import 'package:flutter/material.dart';

class CastCard extends StatelessWidget {
  final dynamic actor;
  final List<dynamic> roles;
  const CastCard(this.actor, {super.key, required this.roles});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (actor?.profilePath != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              height: 100,
              width: 70,
              decoration: BoxDecoration(color: Colors.grey.shade400),
              child: Image.network(
                actor!.profilePath!,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loading) {
                  return loading == null
                      ? child
                      : Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ] else ...[
          Container(
            height: 100,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(Icons.person, size: 50, color: Colors.grey.shade700),
          ),
        ],
        SizedBox(height: 10),
        Column(
          children: [
            Text(
              actor?.name ?? "N/A",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            if (roles.isNotEmpty)
              Text(
                "as ${roles.first.character}",
                style: TextStyle(color: Colors.white, fontSize: 10),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            if (roles.isEmpty)
              SizedBox(
                width: 70,
                child: Text(
                  "as ${actor?.character}",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
