/*PUCIT Aggregate Calculator
Developed by: Syed Faateh Sultan Kazmi*/


function formula(matricO, matricT, interO, interT, entry, hafiz) {
  var A = (matricO / 4) + interO;
  if(hafiz === true) {
    A += 20;
  }
  A /= (matricT / 4) + interT;
  A *= 70;
  var B = (entry / 140) * 30;
  return A + B;
}


function calculateAggregate() {
  //getting values from html form
  var entry = Number(document.getElementById('entry-test-marks').value);
  var interO = Number(document.getElementById('inter-marks-O').value);
  var interT = Number(document.getElementById('inter-marks-T').value);
  var matricO = Number(document.getElementById('matric-marks-O').value);
  var matricT = Number(document.getElementById('matric-marks-T').value);
  var hafiz = Boolean(document.getElementById('hafiz').checked);

  //validation
  valid = true;
  if(entry < 0 || entry > 140 || interO < 0 || interT < 0 || matricO < 0
  matricT < 0) {
    valid = false;
  }

  //now output result
  if(valid === true) {
    document.getElementById('answer').innerHTML = formula(matricO,
     matricT, interO, interT, entry, hafiz);
  }
  else {
    document.getElementById('answer').innerHTML = "Invalid Input!";
  }
}
