const fs = require('fs');
fs.readFile('allTeams.json',(err, data) => {
  if (err) {
    console.log(err);
    throw err;
  };
  const allTeams = JSON.parse(data);
  printTeamsCsv(allTeams)
})

function printTeamsCsv(allTeams){
  let count = 0;
  for (let team of allTeams) {
    console.log(team.id + ': ' + team.acronym);
    count ++;
  }
  console.log(count + ' teams found');
}
