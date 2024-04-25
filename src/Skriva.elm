module Skriva exposing (..)

import Browser
import Html exposing (Attribute, Html, div, h1, text)
import Html.Attributes exposing (class)


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( {}
    , Cmd.none
    )



-- Model


type alias Model =
    {}



-- Update


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- View


view : Model -> Html Msg
view _ =
    div []
        [ h1 [ class "no-print" ] [ text "Skriva" ]
        , div [] (List.map viewPage (List.range 0 10))
        ]


linesPerPage =
    5


viewPage : Int -> Html Msg
viewPage _ =
    div [ class "page-break" ] (List.map viewLine (List.range 0 (linesPerPage - 1)))


viewLine : Int -> Html Msg
viewLine _ =
    div [ class "line" ]
        [ div [ class "top" ] []
        , div [ class "base" ] []
        , div [ class "bottom" ] []
        ]
