# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



Video.create([
  { title: 'Bugs Bunny, A Cartoon Revue',
    description: 'A Feature Length Laugh Riot Featuring Many of Warner Bros. Famous Cartoon Stars',
    poster_small_url: 'bugs-bunny-a-cartoon-revue-1953.jpg',
    poster_large_url: '' },
  { title: 'Casablanca',
    description: 'In World War II Casablanca, Rick Blaine, exiled American and former freedom fighter, runs the most popular nightspot in town. The cynical lone wolf Blaine comes into the possession of two valuable letters of transit. When Nazi Major Strasser arrives in Casablanca, the sycophantic police Captain Renault does what he can to please him, including detaining a Czechoslovak underground leader Victor Laszlo. Much to Rick\'s surprise, Lazslo arrives with Ilsa, Rick\'s one time love. Rick is very bitter towards Ilsa, who ran out on him in Paris, but when he learns she had good reason to, they plan to run off together again using the letters of transit. Well, that was their original plan....',
    poster_small_url: 'casablanca.jpg',
    poster_large_url: '' },
  { title: 'Gone with the Wind',
    description: 'Scarlett is a woman who can deal with a nation at war, Atlanta burning, the Union Army carrying off everything from her beloved Tara, the carpetbaggers who arrive after the war. Scarlett is beautiful. She has vitality. But Ashley, the man she has wanted for so long, is going to marry his placid cousin, Melanie. Mammy warns Scarlett to behave herself at the party at Twelve Oaks. There is a new man there that day, the day the Civil War begins. Rhett Butler. Scarlett does not know he is in the room when she pleads with Ashley to choose her instead of Melanie.',
    poster_small_url: 'gone-with-the-wind.jpg',
    poster_large_url: '' },
  { title: 'It Happened At the World\'s Fair',
    description: 'Mike and Danny fly a crop duster, but because of Danny\'s gambling debts, a local sheriff seizes it. Trying to earn money, they hitch-hike to the World\'s Fair in Seattle. While Danny tries to earn money playing poker, Mike takes care of a small girl, Sue-Lin, whose Uncle Walter has disappeared. Being a ladies\' man, he also finds the time to court a young nurse, Diane.',
    poster_small_url: 'it-happened-at-the-world-s-fair-1963.jpg',
    poster_large_url: '' },
  { title: 'King Kong',
    description: 'Carl Denham needs to finish his movie and has the perfect location; Skull Island. But he still needs to find a leading lady. This \'soon-to-be-unfortunate\' soul is Ann Darrow. No one knows what they will encounter on this island and why it is so mysterious, but once they reach it, they will soon find out. Living on this hidden island is a giant gorilla and this beast now has Ann is it\'s grasps. Carl and Ann\'s new love, Jack Driscoll must travel through the jungle looking for Kong and Ann, whilst avoiding all sorts of creatures and beasts.',
    poster_small_url: 'king-kong.jpg',
    poster_large_url: '' },
  { title: 'Metropolis',
    description: 'Sometime in the future, the city of Metropolis is home to a Utopian society where its wealthy residents live a carefree life. One of those is Freder Fredersen. One day, he spots a beautiful woman with a group of children, she and the children who quickly disappear. Trying to follow her, he, oblivious to such, is horrified to find an underground world of workers, apparently who run the machinery which keeps the above ground Utopian world functioning. One of the few people above ground who knows about the world below is Freder\'s father, Joh Fredersen, who is the founder and master of Metropolis. Freder learns that the woman is Maria, who espouses the need to join the "hands" - the workers - to the "head" - those in power above - by a mediator or the "heart". Freder wants to help the plight of the workers in the want for a better life. But when Joh learns of what Maria is espousing and that Freder is joining their cause, Joh, with the assistance of an old colleague and now nemesis named ...',
    poster_small_url: 'metropolis.jpg',
    poster_large_url: '' },
  { title: 'Shall We Dance',
    description: 'Ballet star Pete "Petrov" Peters arranges to cross the Atlantic aboard the same ship as the dancer he\'s fallen for but barely knows, musical star Linda Keene. By the time the ocean liner reaches New York, a little white lie has churned through the rumor mill and turned into a hot gossip item: that the two celebrities are secretly married.',
    poster_small_url: 'shall-we-dance.jpg',
    poster_large_url: '' },
  { title: 'Steamboat Willie',
    description: 'Mickey is piloting a steamboat when Captain Pete comes to the bridge and throws him off. They stop to pick up cargo. Minnie just misses the boat and Mickey uses the crane to grab her. She drops her sheet music of "Turkey in the Straw" and a goat eats it. With help from Mickey, she cranks the goat\'s tail, and it plays the tune. Mickey accompanies on percussion and by torturing various animals, until Pete comes down and puts a stop to it, putting Mickey to work peeling potatoes. While this is the first sound Mickey Mouse, there\'s no dialog.',
    poster_small_url: 'steamboat-willie.jpg',
    poster_large_url: '' },
  { title: 'The Wizard of Oz',
    description: 'In this charming film based on the popular L. Frank Baum stories, Dorothy and her dog Toto are caught in a tornado\'s path and somehow end up in the land of Oz. Here she meets some memorable friends and foes in her journey to meet the Wizard of Oz who everyone says can help her return home and possibly grant her new friends their goals of a brain, heart and courage.',
    poster_small_url: 'the-wizard-of-oz-1939.jpg',
    poster_large_url: '' }
])

Category.create([
  { name: 'Action & Adventure' },
  { name: 'Anime' },
  { name: 'Children & Family' },
  { name: 'Classics' },
  { name: 'Comedies' },
  { name: 'Cult Movies' },
  { name: 'Documentaries' },
  { name: 'Dramas' },
  { name: 'Faith & Spirituality' },
  { name: 'Foreign' },
  { name: 'Gay & Lesbian' },
  { name: 'Horror' },
  { name: 'Independent' },
  { name: 'Music' },
  { name: 'Musicals' },
  { name: 'Romance' },
  { name: 'Sci-Fi & Fantasy' },
  { name: 'Sports Movies' },
  { name: 'Thrillers' },
  { name: 'TV Shows' }
])

VideoCategory.create([
  { video_id: 1, category_id: 4 },
  { video_id: 2, category_id: 4 },
  { video_id: 3, category_id: 4 },
  { video_id: 4, category_id: 4 },
  { video_id: 5, category_id: 4 },
  { video_id: 6, category_id: 4 },
  { video_id: 7, category_id: 4 },
  { video_id: 8, category_id: 4 },
  { video_id: 9, category_id: 4 },
  { video_id: 1, category_id: 5 },
  { video_id: 2, category_id: 8 },
  { video_id: 3, category_id: 8 },
  { video_id: 4, category_id: 5 },
  { video_id: 5, category_id: 8 },
  { video_id: 6, category_id: 8 },
  { video_id: 7, category_id: 15 },
  { video_id: 8, category_id: 5 },
  { video_id: 9, category_id: 8 }
])

