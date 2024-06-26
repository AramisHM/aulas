const myImage = document.querySelector("img");

// easteregg contador
myImage.onclick = () => {
  const mySrc = myImage.getAttribute("src");
  if (mySrc === "images/aviao.jpg") {
    myImage.setAttribute("src", "images/aviao2.jpg");
  } else {
    myImage.setAttribute("src", "images/aviao.jpg");
    // window.alert("");
  }
};