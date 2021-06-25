import Rails from "@rails/ujs";
import Swal from "sweetalert2";

const confirmed = (element, result) => {
  if (result.value) {
    // User clicked confirm button
    element.removeAttribute("data-confirm-swal");
    element.click();
  }
};

// Display the confirmation dialog
const showConfirmationDialog = (element) => {
  const title = element.getAttribute("data-confirm-swal");
  const text = element.getAttribute("data-text");
  const yesMessage = element.getAttribute("data-yes-text");
  const noMessage = element.getAttribute("data-no-text");
  const icon = element.getAttribute("data-icon");

  Swal.fire({
    title: title || "Are you sure?",
    text: text || "",
    icon: icon || "question",
    timer: 5000,
    timerProgressBar: true,
    showCancelButton: true,
    confirmButtonText: yesMessage || "Sim",
    cancelButtonText: noMessage || "Não",
  }).then((result) => confirmed(element, result));
};

const allowAction = (element) => {
  if (element.getAttribute("data-confirm-swal") === null) {
    return true;
  }

  showConfirmationDialog(element);
  return false;
};

const handleConfirm = function handleConfirm(element) {
  if (!allowAction(this)) {
    Rails.stopEverything(element);
  }
};

// Add event listener before the other Rails event listeners like the one
// for `method: :delete`
Rails.delegate(document, "a[data-confirm-swal]", "click", handleConfirm);
