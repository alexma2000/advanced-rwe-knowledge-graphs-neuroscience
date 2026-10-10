
Advanced RWE Analytics & Semantic Knowledge Graphs for Neuroscience Progression Stratification

Author: Alex Mychlo, PhD
Domain: Principal Clinical Data Science, Advanced RWE, Multi-Omics Integration & Graph Neural Networks (GNN)
Core Ecosystem: R (limma, CDISC), Python (PyTorch Geometric, Transformers, LangChain, Pandas), SAS (GxP Production, PROC SQL)
This repository contains a production-grade, multi-modal research suite demonstrating the integration of Real-World Evidence (RWD/RWE), high-dimensional proteomics (3,000+ Olink protein markers), semantic Knowledge Graphs (RDF/SPARQL), and Graph Machine Learning to predict slow vs. fast disease progression in neurodegenerative disorders (Alzheimer's Disease / MDRS / ADAS-Cog endpoints).

The architecture bridges modern AI representation learning with strict GxP regulatory compliance, compiling deep graph-derived insights directly into FDA-ready CDISC (SDTM/ADaM) data pipelines.


📂 Repository Architecture & End-to-End Pipeline

The project is structured into functional engineering layers, ensuring full computational isolation and execution traceability:

rwe_knowledge_graphs_neuroscience/
├── README.md                              # Enterprise-grade project documentation suite
│
├── layer_1_biomarker_qc/
│   ├── 01_olink_limma_validation.R       # Differential expression noise-filtering via {limma}
│   └── biomarker_qc_execution.log         # Execution verification and statistical FDR outputs
│
├── layer_2_semantic_core/
│   ├── build_rdf_triples.py               # Standardized CDISC-to-RDF conversion layer
│   └── study_ontology_mapping.ttl         # MedDRA & SNOMED-CT ontological specifications
│
├── layer_3_intelligence_embeddings/
│   ├── ehr_pubmedbert_encoder.py          # Hugging Face PubMedBERT text embedding & Temporal Leakage filter
│   └── NLP_pipeline_execution.log         # Terminal log proving timeline-safe embedding extraction
│
├── layer_4_graph_transformers/
│   ├── pytorch_geometric_hgt.py           # Heterogeneous Graph Transformer (HGT) message passing via PyG
│   └── model_inference_latent.log         # Inference logs capturing patient latent space extraction
│
└── layer_5_gxp_sas_production/
    ├── synthetic_control_arm_prep.sas     # GxP SAS production module: Inner joins and protocol updates
    ├── sdtm_dm_synthetic_output.csv       # FDA-compliant live study database update
    └── sas_lineage_traceback.log          # SAS compilation log validating strict data lineage


🛠️ Program-Level Deep Dive & Core Methodology


Layer 1: Multi-Modal Data Foundation & Proteomic QC (layer_1_biomarker_qc/)

• 01_olink_limma_validation.R: Deploys a rigorous statistical framework using the high-performance {limma} package to isolate true neurological pathology from systemic baseline variation and batch effects.
	• Contrast Matrix Design: Builds a deterministic linear model contrasting Alzheimer's patients against age- and sex-matched Healthy Volunteers to systematically subtract Olink proteomic noise.
	• Confounding Control: Embeds critical clinical covariates (Age, Sex, BMI) into the design matrix. Adjusts p-values via the Benjamini-Hochberg (BH) False Discovery Rate (FDR) procedure to discover true disease-specific biomarkers.

Layer 2: The Semantic Core & RDF Knowledge Graph (layer_2_semantic_core/)

• build_rdf_triples.py: Converted standardized flat CDISC ADaM datasets into machine-readable RDF graphs based on the Subject-Predicate-Object semantic architecture.
	• Ontological Normalization: Maps raw, heterogeneous text fields from electronic health records (EHR) into unified industry vocabularies—utilizing MedDRA for Adverse Events and SNOMED-CT for clinical phenotypes.
	• Temporal Graph Architecture: Embeds longitudinal timestamps directly into the relational edges of the graph, preserving clinical timelines across multiple patient visits.

Layer 3: Intelligence Layer & Temporal Leakage Guardrails (layer_3_intelligence_embeddings/)

• ehr_pubmedbert_encoder.py: Utilizes pre-trained biomedical Foundation Models (Transformers) via Hugging Face to ingest free-text clinician notes.
	• Timeline Security (Temporal Leakage Guardrail): Implements a strict algorithmic calendar filter via Python. It programmatically drops any unstructured clinical note dated after the index randomization window (NOTE_DATE > INDEX_DATE), ensuring no features "from the future" contaminate the baseline models.
	• Representation Learning: Extracts the aggregate semantic vector from the dense encoder layer ([CLS] token via PubMedBERT), outputting fixed-dimension mathematical embeddings (768 features) to enrich the graph nodes.

Layer 4: PyTorch Geometric Learning Architecture (layer_4_graph_transformers/)

• pytorch_geometric_hgt.py: Constructs a deep learning heterogeneous graph topology utilizing torch_geometric.nn abstractions.
	• Relational Message Passing: Deploys a Heterogeneous Graph Transformer (HGT) wrapped inside HeteroConv and SAGEConv operators. Patient nodes dynamically exchange topological features across multi-omics, digital metrics, and drug exposure nodes using an explicit mean neighborhood aggregation strategy.
	• Latent Space Stratification: Executes a forward-pass evaluation (model.eval()) under tight zero-gradient memory environments (torch.no_grad()) to derive highly precise baseline patient embeddings for fast vs. slow progression classification.

Layer 5: Regulated SAS GxP Production Pipeline (layer_5_gxp_sas_production/)

• synthetic_control_arm_prep.sas: Bridges deep learning graph outputs with the traditional, audit-ready clinical trial environment under strict 21 CFR Part 11 and GxP standards.
	• High-Performance Ingestion: Utilizes PROC SQL inner joins to isolate exactly 50 graph-matched historical digital twins from massive multi-million record real-world data (RWD) pools.
	• SDTM Database Population: Appends synthetic control cohorts into live active clinical study databases, enforcing explicit protocol designators (ARMCD = "SYNPLCB") inside the Demographics (DM) domain.
	• Audit-Ready Lineage Verification: Hardcodes absolute metadata tracking keys (SRCSEQ = "JNJ_RWE_GRAPH_V1_MATCH") directly into the data matrix, ensuring 100% data provenance verification during regulatory inspections.


🔒 Regulatory Governance, Reproducibility & Compliance

To ensure complete algorithmic reproducibility across diverse execution platforms, deterministic anchors are hardcoded across all code bases:
1. Python: torch.manual_seed(12345) locks the graph message-passing initialization and text encoding splits.
2. SAS: proc surveyselect ... seed=12345 guarantees reproducible simple random matching from the massive historical master registry.
3. R: Linear model contrasts are locked under strict statistical seeds to ensure zero stochastic volatility during regulatory submission reviews.
   
