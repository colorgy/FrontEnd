/*!
Copyright (c) <2012> <Arieh Glazer>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

//Accessible outline removal
//can be used with delegation or on specific elements (by query)
//should work on all modern browsers + IE8+

//method inspired by:http://www.paciellogroup.com/blog/2012/04/how-to-remove-css-outlines-in-an-accessible-manner/

//example: http://jsfiddle.net/JzEyP/8/
(function() {
    function hasClass(el, name) {
        if ('classList' in el) return el.classList.contains(name);
        return el.className.explode(' ').indexOf(name) > -1;
    }

    this.Outliner = function Outliner(opts) {
        var key;
        for (key in opts) if (key in this.options) this.options[key] = opts[key];

        this.handleEvent = this.handleEvent.bind(this);

        if (this.options.useDelegation) this.className = this.options.selector.replace('.', '');

        this.generate();
        this.attach();
    };

    Outliner.prototype = {
        constructor: Outliner,
        options: {
            selector: 'a',
            useDelegation: false
        },
        generate: function() {
            this.element = document.createElement('style');
            document.head.appendChild(this.element);
        },
        handleEvent: function(e) {
            if (this.options.useDelegation && hasClass(e.target, this.className) == false) return;

            switch (e.type) {
            case 'mouseover':
                this.removeOutline();
                break;
            case 'keydown':
                this.restoreOutline();
                break;
            }
        },

        attach: function() {
            var compat = 'addEventListener' in document,
                attachee = compat ? this : this.handleEvent,
                key_ev = compat ? 'keydown' : 'onkeydown',
                mouse_ev = compat ? 'mouseover' : 'onmouseover',
                i, el;

            this.elements = this.options.useDelegation ?
                [document.body] :
                document.querySelectorAll(this.options.selector);

            for (i = 0; el = this.elements[i]; i++) {
                el[compat ? 'addEventListener' : 'attachEvent'](key_ev, attachee, false);
                el[compat ? 'addEventListener' : 'attachEvent'](mouse_ev, attachee, false);
            }
        },
        removeOutline: function() {
            this.element.innerHTML = this.options.selector + ' {outline:none}';
        },
        restoreOutline: function() {
            this.element.innerHTML = '';
        },
        detach: function() {
            var compat = 'addEventListener' in document,
                attachee = compat ? this : this.handleEvent,
                key_ev = compat ? 'keydown' : 'onkeydown',
                mouse_ev = compat ? 'mouseover' : 'onmouseover',
                i, el;

            for (i = 0; el = this.elements[i]; i++) {
                el[compat ? 'removeEventListener' : 'detatchEvent'](key_ev, attachee, false);
                el[compat ? 'removeEventListener' : 'detatchEvent'](mouse_ev, attachee, false);
            }

            this.elements = {};

            document.head.removeElement(this.element);
            this.element = null;
        }
    };

}).call(this);

new this.Outliner({
    useDelegation: 'true',
    selector: '.use'
});
