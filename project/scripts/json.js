const links = [
    "https://islands.smp.uq.edu.au/islander.php?id=aafftndc77",
    "https://islands.smp.uq.edu.au/islander.php?id=97lkcywdnp",
    "https://islands.smp.uq.edu.au/islander.php?id=aeq94ldepu",
    "https://islands.smp.uq.edu.au/islander.php?id=wtwg5c63aw",
    "https://islands.smp.uq.edu.au/islander.php?id=p5wdqtd2l2",
    "https://islands.smp.uq.edu.au/islander.php?id=hylzjdbmsp",
    "https://islands.smp.uq.edu.au/islander.php?id=ynuern6886",
    "https://islands.smp.uq.edu.au/islander.php?id=sjzydfmwdz",
    "https://islands.smp.uq.edu.au/islander.php?id=grj5dkd6tx",
    "https://islands.smp.uq.edu.au/islander.php?id=bsugq752m6",
    "https://islands.smp.uq.edu.au/islander.php?id=5jcgvuqlem",
    "https://islands.smp.uq.edu.au/islander.php?id=wq3mnmp4re",
    "https://islands.smp.uq.edu.au/islander.php?id=ya7g65eakq",
    "https://islands.smp.uq.edu.au/islander.php?id=4h38w6jfjj",
    "https://islands.smp.uq.edu.au/islander.php?id=lw8uvnlge2",
    "https://islands.smp.uq.edu.au/islander.php?id=kp9eyw5254",
    "https://islands.smp.uq.edu.au/islander.php?id=j9tpxvxkba"
  ];
  
  const formattedLinks = links.map(link => ({
    url: link,
    village: "helluland",
    responses: ""
  }));
  
  console.log(JSON.stringify(formattedLinks, null, 2));
  