module User exposing (..)

type alias User = {
    uid: Int,
    name: String,
    point: Int
    }

remove : User -> List User -> List User
remove user users = 
    case users of
        [] -> []
        (usr::rest) -> if usr.uid == user.uid then
            remove user rest else
            usr :: (remove user rest)
initialUsers = 
    [
        {uid=1, name="Name 1", point=12},
        {uid=2, name="Name 2", point=17},
        {uid=3, name="Boštjan", point=100},
        {uid=4, name="Andrej", point=200},
        {uid=5, name="Marko", point=200},
        {uid=6, name="Matej", point=200},
        {uid=7, name="Nevem", point=200}
    ]