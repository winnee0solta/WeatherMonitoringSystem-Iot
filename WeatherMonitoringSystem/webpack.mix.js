const mix = require('laravel-mix');

/*
 |--------------------------------------------------------------------------
 | Mix Asset Management
 |--------------------------------------------------------------------------
 |
 */

mix.js('resources/js/app.js', 'public/js')
    .sass('resources/sass/app.scss', 'public/css');



mix.browserSync({
    proxy: "http://localhost:8000",
    snippetOptions: {
        rule: {
            match: /<\/body>/i,
            fn: function(snippet, match) {
                return snippet + match;
            }
        }
    }
});

//for notification
mix.disableNotifications();
