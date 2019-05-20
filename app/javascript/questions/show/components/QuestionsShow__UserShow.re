[@bs.config {jsx: 3}];

open QuestionsShow__Types;

let str = React.string;

[@react.component]
let make = (~userProfile, ~createdAt, ~textForTimeStamp) =>
  <div>
    <p className="text-xs text-gray-600">
      {textForTimeStamp ++ " on " ++ createdAt |> str}
    </p>
    <div
      className="p-2 flex flex-row items-center bg-yellow-100 rounded-lg mt-1">
      <div
        className="w-10 h-10 rounded-full bg-gray-500 text-white border border-yellow-400 flex items-center justify-center overflow-hidden">
        <img src={userProfile |> UserData.avatarUrl} />
      </div>
      <div className="pl-2">
        <p className="font-semibold text-xs">
          {userProfile |> UserData.name |> str}
        </p>
        <p className="text-xs mt-1">
          {userProfile |> UserData.title |> str}
        </p>
      </div>
    </div>
  </div>;