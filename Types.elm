module Types (..) where


type alias Model =
  { time: Int,
    counting: Bool,
    button: String,
    sessions: List Session,
    currentCategory: String,
    catList: List String
  }


type alias Session =
  { date: String,
    time: Int,
    category: String
  }

type Action = NoOp | Count | Reset | ChangeCategory String