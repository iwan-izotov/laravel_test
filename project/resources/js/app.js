import './bootstrap';
import Alpine from 'alpinejs';
import flatpickr from "flatpickr";
import TomSelect from "tom-select";

window.Alpine = Alpine;
window.flatpickr = flatpickr;
window.TomSelect = TomSelect;

import './../../node_modules/flatpickr/dist/flatpickr.min.css';
import './../../vendor/power-components/livewire-powergrid/dist/tom-select.css';
import './../../vendor/power-components/livewire-powergrid/dist/powergrid.css';

import './../../vendor/power-components/livewire-powergrid/dist/powergrid';

Alpine.start();
