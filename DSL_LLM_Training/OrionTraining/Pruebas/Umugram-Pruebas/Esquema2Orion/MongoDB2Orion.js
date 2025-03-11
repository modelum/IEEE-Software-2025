db.User.updateMany({}, { $rename: { "profile.nameProfile": "profile.fullName" } });
db.User.updateMany({}, { $unset: { "userComments": "" } });