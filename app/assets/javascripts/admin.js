//= require pace/pace.min.js
//= require modernizr.custom
//= require jquery-ui/jquery-ui.min
//= require tether/js/tether.min
//= require popper/umd/popper.min
//= require bootstrap/js/bootstrap.min
//= require jquery/jquery-easy
//= require jquery-unveil/jquery.unveil.min
//= require jquery-actual/jquery.actual.min
//= require jquery-scrollbar/jquery.scrollbar.min
//= require jquery.number.min
//= require alerts/sweet-alert.min
//= require bootstrap-checkbox/js/bootstrap-checkbox
//= require bootstrap-collapse/bootstrap-tabcollapse
//= require bootstrap-datepicker/js/bootstrap-datepicker
//= require bootstrap-daterangepicker/daterangepicker
//= require bootstrap-form-wizard/js/jquery.bootstrap.wizard.min
//= require bootstrap-tag/bootstrap-tagsinput.min
//= require bootstrap-typehead/typeahead.jquery.min
//= require classie/classie
//= require codrops-dialogFx/dialogFx
//= require codrops-stepsform/js/stepsForm
//= require d3/d3.min
//= require dropzone/dropzone.min
//= require feather-icons/feather.min
//= require handlebars/handlebars-v4.0.5
//= require highlight/highlight.pack
//= require imagesloaded/imagesloaded.pkgd.min
//= require interactjs/interact.min
//= require moment/moment-with-locales.min
//= require ion-slider/js/ion.rangeSlider.min
//= require jquery-autonumeric/autoNumeric
//= require jquery-bez/jquery.bez.min
//= require jquery-bootgrid/jquery.bootgrid.min
//= require jquery-inputmask/jquery.inputmask.min
//= require jquery-ios-list/jquery.ioslist.min
//= require jquery-isotope/isotope.pkgd.min
//= require jquery-lookingfor/jquery.lookingfor.min
//= require jquery-menuclipper/jquery.menuclipper.min
//= require jquery-metrojs/MetroJs.min
//= require jquery-mousewheel/jquery.mousewheel.min
//= require jquery-nestable/jquery.nestable.min
//= require jquery-nouislider/jquery.nouislider.min
//= require jquery-scrollto/jquery-scrollto
//= require jquery-slider/jquery.sidr.min
//= require jquery-sparkline/jquery.sparkline.min
//= require jquery-ui-touch/jquery.ui.touch-punch.min
//= require jquery-unevent/jquery.unevent
//= require lodash/lodash.min
//= require mapplic/js/jquery.mousewheel
//= require noui-slider/jquery.nouislider.min
//= require nvd3/nv.d3.min
//= require owl-carousel/owl.carousel.min
//= require responsive-tabs/responsive-tabs
//= require rickshaw/rickshaw.min
//= require select2/js/select2.full.min
//= require skycons/skycons
//= require sly/sly.min
//= require summernote/js/summernote.min
//= require switchery/js/switchery.min
//= require velocity/velocity.min
//= require interactjs/interact.min
//= require hammer.min
//= require jquery.sieve.min
//= require sly.min
//= require bootstrap-datepicker/js/bootstrap-datepicker
//= require bootstrap-timepicker/bootstrap-timepicker


//= require pages.calendar.min
//= require calendar_month
//= require fullcalendar
//= require fullcalendar/locale-all

//= require pages.js
//= require scripts
//= require jquery_ujs

$(document).ready(function () {
  $('#myDatepicker').datepicker();
  $('.select2').select2();
  $('#payer_best_partner').on('select2:selecting', function(evt){
    var element = evt.params.args.data.element;
    var $element = $(element);
    $element.detach();
    $(this).append($element);
    $(this).trigger("change");
  })
});
function copyText(){
  var copyText = document.getElementById("api_key").innerHTML;
  var $temp = $("<input>");
  $("body").append($temp);
  $temp.val(copyText).select();
  document.execCommand("copy");
}

function convertCurrency(){
  var amount = document.getElementById('payment_amount').value
  var new_amount = Number(amount.replace(/,/g, ""))
  document.getElementById('payment_amount_val').value = new_amount
}

function bestPartnerSelection(){
  let result = []
  let bestPartner = document.getElementById('payer_best_partner').value
}

function changeTag(form_id){
  if (form_id.checked){
    form_id.parentElement.parentElement.className = "table-success"
  } else{
    form_id.parentElement.parentElement.className = ""
  }
}

function checkAllTag(form_id){
  let checkboxes = Array.from(document.querySelectorAll('input[type="checkbox"]'))
  checkboxes.shift()
  if (form_id.checked){
    checkboxes.forEach((el) => {el.checked = true; el.parentElement.parentElement.className = "table-success"})
  } else{
    checkboxes.forEach((el) => {el.checked = false;el.parentElement.parentElement.className = ""})
  }
}