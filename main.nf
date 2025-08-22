#!/usr/bin/env nextflow

// This is the main Nextflow workflow definition

// Input parameters
params.str = "Hello world!"

// Processes

process split {
    publishDir "results/lower"

    input:
    val x

    output:
    path "chunk_*"

    script:
    """
    printf '${x}' | split -b 6 - chunk_
    """
}

process convert_to_upper {
    publishDir "results/upper"
    tag "$y"

    input:
    path y

    output:
    path "upper_*"

    script:
    """
    cat $y | tr '[a-z]' '[A-Z]' > upper_${y}
    """
}

// Workflow
workflow {
    split(params.str)
    convert_to_upper(split.out.flatten())
}
