#!/usr/bin/env nextflow

// This is the main Nextflow workflow definition

// Processes
process sayHello {
    input:
        val greeting

    output:
        path "${greeting}-output.txt"

    script:
    """
    echo '$greeting' > '$greeting-output.txt'
    """
}

// Workflow
workflow {
    // Create a channel with a single column from the input data
    greeting_channel = Channel.fromPath("data/hello.csv").splitCsv(header: true).map( line -> line.greeting)

    sayHello(greeting_channel)
}
