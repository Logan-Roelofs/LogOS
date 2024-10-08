export default (icon) => {
  if (Utils.lookUpIcon(`${icon}-symbolic`)) {
    return `${icon}-symbolic`
  } else {
    return icon
  }
}
