class HomeModel {
  String? name, image, type, mass, radius, distanceFromSun, description;

  HomeModel(
      {this.name,
      this.image,
      this.type,
      this.mass,
      this.radius,
      this.distanceFromSun,
      this.description});

  factory HomeModel.mapToModel(Map m1) {
    return HomeModel(
      name: m1["name"],
      image: m1['image'],
      type: m1['type'],
      mass: m1['mass'],
      radius: m1['radius'],
      distanceFromSun: m1['distanceFromSun'],
      description: m1['description'],
    );
  }
}
