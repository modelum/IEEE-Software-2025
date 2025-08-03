MATCH (u:User)
SET u.avatar_url = u.profile.avatar_url
REMOVE u.profile.avatar_url;