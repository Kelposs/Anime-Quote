
// @ChopperApi(baseUrl: "https://animechan.vercel.app/api")
// abstract class ApiService extends ChopperService {
//   // @Get()
//   // Future<Response> getRandom();

//   @Get(path: "/random")
//   Future<Response> getRandom();

//   @Get(path: "/quotes/anime?title={title}")
//   Future<Response> getRandomByTitle(@Path('title') String title);

//   @Get(path: "/quotes/character?name={name}")
//   Future<Response> getRandomByCharacter(@Path('name') String name);

//   @Get(path: "/available/anime")
//   Future<Response> getAllAnimations();

//   static ApiService create() {
//     final client = ChopperClient(
//       // The first part of the URL is now here
//       baseUrl: 'https://animechan.vercel.app',
//       services: [
//         // The generated implementation
//         _$ApiService(),
//       ],
//       // Converts data to & from JSON and adds the application/json header.
//       converter: const JsonConverter(),
//     );

//     // The generated class with the ChopperClient passed in
//     return _$ApiService(client);
//   }
// }
