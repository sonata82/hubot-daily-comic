'use strict';

module.exports = function (grunt) {
    grunt.initConfig({
        mochacov: {
            unit: {
                options: {
                    reporter: 'spec'
                }
            },
            coverage: {
                options: {
                    reporter: 'mocha-term-cov-reporter',
                    instrument: true
                }
            },
            coveralls: {
                options: {
                    coveralls: {
                        serviceName: 'travis-ci'
                    }
                }
            },
            options: {
                files: 'test/*.coffee',
                colors: true,
                compilers: ['coffee:coffee-script/register']
            }
        }
    });


    grunt.loadNpmTasks('grunt-mocha-cov');

    grunt.registerTask('test', ['mochacov:unit', 'mochacov:coverage']);
    grunt.registerTask('travis', ['mochacov:unit', 'mochacov:coverage', 'mochacov:coveralls']);
    grunt.registerTask('default', 'test');
};
