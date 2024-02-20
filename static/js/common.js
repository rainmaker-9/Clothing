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
        confirmButton: `btn btn-${confirmButtonStyle} rouned-1`,
      },
    }).then(() => {
      if (callback) {
        callback();
      }
    });
  }

  function showConfirm(
    title,
    message,
    confirmButtonText,
    confirmButtonStyle,
    cancelButtonText,
    cancelButtonStyle,
    icon = "question"
  ) {
    return Swal.fire({
      title: title,
      text: message,
      icon: icon,
      confirmButtonText: confirmButtonText,
      cancelButtonText: cancelButtonText,
      buttonsStyling: false,
      showCancelButton: true,
      customClass: {
        confirmButton: `btn btn-${confirmButtonStyle} rouned-1`,
        cancelButton: `btn btn-${cancelButtonStyle} rouned-1`,
      },
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
        confirmButton: `btn btn-danger rounded-1`,
        cancelButton: `btn btn-secondary rounded-1`,
      },
    }).then((res) => {
      if (res.isConfirmed) {
        location.replace("/logout");
      }
    });
  }
}

const disableFields = (fields, val) => {
  fields.forEach((field) => {
    if (val) {
      field.setAttribute("disabled", "");
    } else {
      field.removeAttribute("disabled");
    }
  });
};

const removeAllChildNodes = (parent) => {
  while (parent.firstChild) {
    parent.removeChild(parent.firstChild);
  }
};
