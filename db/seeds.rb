
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

Fabricate.times(25, :user)

