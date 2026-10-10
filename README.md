# Advanced RWE Analytics & Semantic Knowledge Graphs for Neuroscience Progression Stratification

**Author:** Alex Mychlo, PhD  
**Domain:** Principal Clinical Data Science, Advanced RWE, Multi-Omics Integration & Graph Neural Networks (GNN)  
**Core Ecosystem:** R (limma, CDISC), Python (PyTorch Geometric, Transformers, rdflib, Neo4j, Pandas), SAS (GxP Production, PROC SQL)

This repository contains a production-grade, multi-modal research suite demonstrating the integration of Real-World Evidence (RWD/RWE), high-dimensional proteomics (3,000+ Olink protein markers), semantic Knowledge Graphs (RDF/SPARQL), and Graph Machine Learning to predict slow vs. fast disease progression in neurodegenerative disorders (Alzheimer's Disease / MADRS / ADAS-Cog endpoints). 

The architecture bridges modern AI representation learning with strict GxP regulatory compliance, compiling deep graph-derived insights directly into FDA-ready CDISC (SDTM/ADaM) data pipelines.

---

## 📂 Repository Architecture & End-to-End Pipeline

The project is organized into clean functional engineering layers, ensuring full computational isolation and focusing strictly on the production-grade source code:

```text
rwe_knowledge_graphs_neuroscience/
├── README.md                              # Enterprise-grade project documentation suite
│
├── layer_1_biomarker_qc/
│   └── 01_olink_limma_validation.R       # Differential expression noise-filtering via {limma}
│
├── layer_2_semantic_core/
│   └── build_rdf_triples.py               # Flat CDISC ADaM to RDF Semantic Triples & SPARQL Querying
│
├── layer_3_intelligence_embeddings/
│   └── ehr_pubmedbert_encoder.py          # Hugging Face PubMedBERT text embedding & Temporal Leakage filter
│
├── layer_4_graph_transformers/
│   └── pytorch_geometric_hgt.py           # Heterogeneous Graph Transformer (HGT) message passing via PyG
│
└── layer_5_gxp_sas_production/
    └── synthetic_control_arm_prep.sas     # GxP SAS production module: Inner joins and protocol updates
```

---

## 🛠️ Program-Level Deep Dive & Core Methodology

### Layer 1: Multi-Modal Data Foundation & Proteomic QC (`layer_1_biomarker_qc/`)
* **`01_olink_limma_validation.R`**: Deploys a rigorous statistical framework using the high-performance `{limma}` package to isolate true neurological pathology from systemic baseline variation and batch effects.
  * **Contrast Matrix Design**: Builds a deterministic linear model contrasting patients against age- and sex-matched Healthy Volunteers to systematically subtract Olink proteomic noise.
  * **Confounding Control**: Embeds critical clinical covariates (Age, Sex, BMI) into the design matrix and adjusts p-values via the Benjamini-Hochberg (BH) False Discovery Rate (FDR) procedure.

### Layer 2: The Semantic Core & RDF Knowledge Graph (`layer_2_semantic_core/`)
* **`build_rdf_triples.py`**: Converts standardized flat CDISC ADaM datasets into machine-readable RDF graphs based on the Subject-Predicate-Object semantic architecture and loads them into a Neo4j database.
  * **Ontological Normalization**: Maps raw fields from electronic health records (EHR) into unified industry vocabularies—utilizing **MedDRA** for Adverse Events and **SNOMED-CT** for clinical phenotypes.
  * **SPARQL Cohort Discovery**: Implements a native, high-performance SPARQL query pipeline for instant patient pattern matching, completely bypassing traditional relational JOIN performance bottlenecks.

### Layer 3: Intelligence Layer & Temporal Leakage Guardrails (`layer_3_intelligence_embeddings/`)
* **`ehr_pubmedbert_encoder.py`**: Utilizes pre-trained biomedical Foundation Models (Transformers) via Hugging Face to ingest free-text clinician notes.
  * **Timeline Security (Temporal Leakage Guardrail)**: Implements a strict algorithmic calendar filter via Python to programmatically drop any unstructured clinical note dated after the index study baseline, ensuring zero data contamination from the future.
  * **Representation Learning**: Extracts dense semantic vectors from the encoder layer (`[CLS]` token via `PubMedBERT`), outputting 768-dimensional mathematical embeddings to enrich graph nodes.

### Layer 4: PyTorch Geometric Learning Architecture (`layer_4_graph_transformers/`)
* **`pytorch_geometric_hgt.py`**: Constructs a deep learning heterogeneous graph topology utilizing `torch_geometric.nn` abstractions.
  * **Relational Message Passing**: Deploys a **Heterogeneous Graph Transformer (HGT)** wrapped inside `HeteroConv` and `SAGEConv` operators. Patient nodes dynamically exchange topological features across multi-omics and drug exposure nodes using mean neighborhood aggregation.
  * **Latent Space Stratification**: Executes a forward-pass evaluation (`model.eval()`) under zero-gradient memory environments (`torch.no_grad()`) to derive highly precise baseline vectors for fast vs. slow progression classification.

### Layer 5: Regulated SAS GxP Production Pipeline (`layer_5_gxp_sas_production/`)
* **`synthetic_control_arm_prep.sas`**: Bridges deep learning graph outputs with the traditional, audit-ready clinical trial environment under strict **21 CFR Part 11 and GxP standards**.
  * **High-Performance Ingestion**: Utilizes `PROC SQL` inner joins to isolate exactly 50 graph-matched historical digital twins from massive multi-million record real-world data (RWD) pools.
  * **SDTM Database Population**: Appends synthetic control cohorts into live active clinical study databases, enforcing explicit protocol designators (`ARMCD = "SYNPLCB"`) inside the Demographics (`DM`) domain.
  * **Audit-Ready Lineage Verification**: Hardcodes absolute metadata tracking keys (`SRCSEQ = "RWE_GRAPH_V1_MATCH"`) directly into the data matrix, ensuring 100% data provenance verification during regulatory inspections.

---

## 🔒 Regulatory Governance, Reproducibility & Compliance
To ensure complete algorithmic reproducibility across diverse execution platforms, deterministic anchors are hardcoded across all code bases:
1. **Python**: `torch.manual_seed(12345)` locks the graph message-passing initialization and text encoding splits.
2. **SAS**: `proc surveyselect ... seed=12345` guarantees reproducible simple random matching from the massive historical master registry.
3. **R**: Linear model contrasts are locked under strict statistical seeds to ensure zero stochastic volatility during regulatory submission reviews.
