rule go_fetch:
    params:
        email=config["user_email"],
        api=config["user_api"],
        target=config["target"],
        db=config["database"],
        min=config["gf_min"],
        max=config["gf_max"]
    output:
        "results/go_fetch/{taxids}/gene.fasta",
        "results/go_fetch/{taxids}/seed.fasta",
    log:
        "logs/go_fetch/{taxids}.log",
    conda:
        "../envs/go_fetch.yaml"
    threads:
        workflow.cores * 0.2
    shell:
        """
        python3 workflow/scripts/go_fetch.py \
            --taxonomy {wildcards.taxids} \
            --target {params.target} \
            --db {params.db} \
            --min {params.min}  \
            --max {params.max} \
            --output results/go_fetch/{wildcards.taxids} \
            --getorganelle \
            --email {params.email} \
            --api {params.api} \
            --overwrite &> {log}
        """
