;(function (global) {
    'use strict';

    var $ = global.jQuery;
    var GOVUK = global.GOVUK || {};
    var Calculator = global.Calculator || {};

    function BenefitsReceivedPage () {
        var self = this;

        self.init = function() {
            initListenersForCheckboxes();
            setInitialState();
        };

        function initListenersForCheckboxes() {
            benefitsCheckboxesEl().on('click change', onBenefitsChange);
            noneCheckboxEl().on('click change', onNoneChange);
            dontKnowCheckboxEl().on('click change', onDontKnowChange);
        }

        function setInitialState() {
            if(checkedBenefits().length > 0) {
                deSelectNoneCheckbox();
                deSelectDontKnowCheckbox();
            }
            if(checkedSpecialValues().length > 0) {
                deSelectBenefitsCheckboxes();
            }
        }

        function checkedBenefits() {
            return checkedValues().filter(function(t) { return t != 'none' && t != 'dont_know' });
        }

        function checkedSpecialValues() {
            return checkedValues().filter(function(t) { return t == 'none' || t == 'dont_know' });
        }

        function checkedValues() {
            return $('.multiple-choice input[type=checkbox]:checked').toArray().map(function(n){ return n.value; });

        }

        function deSelectBenefitsCheckboxes() {
            benefitsCheckboxesEl().prop('checked', false);
        }

        function deSelectNoneCheckbox() {
            noneCheckboxEl().prop('checked', false);
        }

        function deSelectDontKnowCheckbox() {
            dontKnowCheckboxEl().prop('checked', false);
        }

        function benefitsCheckboxesEl() {
            return $('input[type=checkbox][value!=none][value!=dont_know]');
        }

        function noneCheckboxEl() {
            return $('input[type=checkbox][value=none]');
        }

        function dontKnowCheckboxEl() {
            return $('input[type=checkbox][value=dont_know]');
        }

        function onBenefitsChange(event) {
            if($(event.target).prop('checked')) {
                deSelectDontKnowCheckbox();
                deSelectNoneCheckbox();
            }
        }

        function onNoneChange(event) {
            if($(event.target).prop('checked')) {
                deSelectBenefitsCheckboxes();
                deSelectDontKnowCheckbox();
            }
        }

        function onDontKnowChange(event) {
            if($(event.target).prop('checked')) {
                deSelectBenefitsCheckboxes();
                deSelectNoneCheckbox();
            }
        }
    }


    BenefitsReceivedPage.prototype.init = function () {
      this.init();
    };


    Calculator.BenefitsReceivedPage = BenefitsReceivedPage;
    global.Calculator = Calculator;
})(window);
