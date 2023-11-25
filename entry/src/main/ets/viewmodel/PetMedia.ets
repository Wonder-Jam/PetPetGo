
export function getAMedia(fullness: number, cleanliness: number, mood: number){
  if(mood==100){
    return stateMedia[0];
  } else {
    return stateMedia[1];
  }
}

const stateMedia = [$r('app.media.want_to_sese'), $r('app.media.looking_stupid')];

