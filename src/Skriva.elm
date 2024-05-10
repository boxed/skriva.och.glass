module Skriva exposing (..)

import Browser
import Html exposing (Attribute, Html, div, h1, img, input, label, text)
import Html.Attributes exposing (checked, class, classList, src, style, type_, value)
import Html.Events exposing (onInput)


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { size = 20
      , extraLineDistance = True
      , showSecondaryLine = True
      , showTertiaryLines = True
      }
    , Cmd.none
    )



-- Model


type alias Model =
    { size : Int
    , extraLineDistance : Bool
    , showSecondaryLine : Bool
    , showTertiaryLines : Bool
    }



-- Update


type Msg
    = SetSize (Maybe Int)
    | ToggleExtraLineDistance
    | ToggleSecondaryLine
    | ToggleTertiaryLines


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetSize size ->
            case size of
                Just s ->
                    ( { model | size = s }, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )

        ToggleExtraLineDistance ->
            ( { model | extraLineDistance = not model.extraLineDistance }, Cmd.none )

        ToggleSecondaryLine ->
            ( { model | showSecondaryLine = not model.showSecondaryLine }, Cmd.none )

        ToggleTertiaryLines ->
            ( { model | showTertiaryLines = not model.showTertiaryLines }, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    div []
        [ h1 [ class "no-print" ] [ text "Skriva" ]
        , div
            [ class "no-print" ]
            [ div []
                [ input
                    [ style "width" "400px"
                    , type_ "range"
                    , min_ "5"
                    , max_ "20"
                    , value (String.fromInt model.size)
                    , onInput (\x -> SetSize (String.toInt x))
                    , class "slider"
                    ]
                    []
                , text (String.fromInt model.size)
                ]
            , div []
                [ label []
                    [ input
                        [ type_ "checkbox"
                        , class "checkbox"
                        , checked model.extraLineDistance
                        , onInput (\_ -> ToggleExtraLineDistance)
                        ]
                        []
                    , text "Extra radavstånd"
                    ]
                ]
            , div []
                [ label []
                    [ input
                        [ type_ "checkbox"
                        , class "checkbox"
                        , checked model.showSecondaryLine
                        , onInput (\_ -> ToggleSecondaryLine)
                        ]
                        []
                    , text "Stöd-linje 2"
                    ]
                ]
            , div []
                [ label []
                    [ input
                        [ type_ "checkbox"
                        , class "checkbox"
                        , checked model.showTertiaryLines
                        , onInput (\_ -> ToggleTertiaryLines)
                        ]
                        []
                    , text "Stöd-linjer 3 och 4"
                    ]
                ]
            ]
        , div
            [ classList
                [ ( "with-secondary-line", model.showSecondaryLine )
                , ( "with-tertiary-lines", model.showTertiaryLines )
                ]
            ]
            (List.map (viewLine model) (List.range 0 100))
        ]


viewLine : Model -> Int -> Html Msg
viewLine model _ =
    let
        height =
            style "height" (String.fromFloat (toFloat model.size / 10) ++ "rem")
    in
    div
        [ class "line"
        , style "margin-bottom"
            (if model.extraLineDistance then
                String.fromFloat (toFloat model.size / 6) ++ "rem"

             else
                String.fromFloat (toFloat model.size / 20) ++ "rem"
            )

        --, style "background-image" "url(a.svg)"
        , style "background-size" (String.fromFloat (toFloat model.size * 0.9 / 10) ++ "rem")
        , style "background-position-y" ("calc(" ++ (String.fromFloat (toFloat model.size * 0.945 / 10) ++ "rem") ++ " + 2px)")
        , style "background-repeat" "no-repeat"
        ]
        [ div [ class "top", height ] []
        , div [ class "base", height ] []
        , div [ class "bottom", height ] []
        ]



--


min_ : String -> Attribute msg
min_ =
    Html.Attributes.min


max_ : String -> Attribute msg
max_ =
    Html.Attributes.max
