port module App exposing (..)

import Bootstrap.Grid as Grid
import Browser exposing (element)
import Html
import User exposing (..)
import Html.Events as He
import Bootstrap.Button as Button

type alias Model =
    { value : Int
    , numberOfClicks : Int
    , users : List User
    }


type Msg
    = Initialize
    | Increment
    | Decrement
    | Reset
    | Random
    | DeleteUser User

--type Msg = Initialize | Increment | Decrement | EditUserMsg User EditUser
--type editUser = Delete | IncrementPoints |DecPoints
initialModel : () -> ( Model, Cmd Msg )
initialModel () =
    ( { value = 0, numberOfClicks = 0, users = initialUsers }, Cmd.none )


view model =
    Grid.container []
        ([ Html.h1 [] [ Html.text "Hello world" ]
         , Html.h2 [] [ Html.text (String.fromInt model.value) ],
        Button.button [Button.success, Button.block, Button.attrs [He.onClick Increment]] [Html.text "Increment"],
        Button.button [Button.danger, Button.block,Button.attrs [He.onClick Decrement]] [Html.text "Decrement"],
        Button.button [Button.dark, Button.block, Button.attrs [He.onClick Reset]] [Html.text "Reset"],
        Button.button [Button.large, Button.block,Button.attrs [He.onClick Random]] [Html.text "Random Number Generator"]
         , Grid.row []
            [ Grid.col [] [ Html.text "Uid" ]
            , Grid.col [] [ Html.text "Ime" ]
            , Grid.col [] [ Html.text "Tocke" ]
            , Grid.col [] [Html.text "Zbriši juzerja"]
            ]
         ]
            ++ List.map
                (\user ->
                    Grid.row []
                        [ Grid.col [] [ Html.text (String.fromInt user.uid) ]
                        , Grid.col [] [ Html.text user.name ]
                        , Grid.col [] [ Html.text (String.fromInt user.point) ]
                        , Grid.col [] [Button.button [Button.danger, Button.onClick (DeleteUser user)] [Html.text "Delete"]]
                        ]
                )
                (List.reverse (List.sortBy .point model.users))
        )





update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | value = model.value + 1, numberOfClicks = model.numberOfClicks + 1 }, Cmd.none )

        Decrement ->
            ( { model | value = model.value - 1, numberOfClicks = model.numberOfClicks - 1 }, Cmd.none )

        Reset ->
            ( { model | value = 0, numberOfClicks = 0 }, Cmd.none )

        Random ->
            ( { model | value = 212, numberOfClicks = 0 }, Cmd.none )
        DeleteUser user -> ({model | users = remove user model.users}, sendAlert user.name)
        _ ->
            ( model, Cmd.none )


main =
    element
        { init = initialModel
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }

port sendAlert: String -> Cmd msg