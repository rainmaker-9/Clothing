const reloadPage = () => {
  location.reload();
};

if (window.Swal) {
  function showAlert(
    title,
    message,
    icon,
    confirmButtonText,
    confirmButtonStyle,
    callback = null
  ) {
    Swal.fire({
      title: title,
      text: message,
      icon: icon,
      confirmButtonText: confirmButtonText,
      buttonsStyling: false,
      customClass: {
        confirmButton: `btn btn-${confirmButtonStyle}`,
      },
    }).then(() => {
      if (callback) {
        callback();
      }
    });
  }

  function logout(e) {
    e.preventDefault();
    Swal.fire({
      title: "Are you sure",
      text: "Are you sure you want to logout?",
      icon: "question",
      showCancelButton: true,
      confirmButtonText: "Yes",
      cancelButtonText: "No",
      buttonsStyling: false,
      customClass: {
        confirmButton: `btn btn-danger`,
        cancelButton: `btn btn-secondary`,
      },
    }).then((res) => {
      if (res.isConfirmed) {
        location.replace("/logout");
      }
    });
  }
}
