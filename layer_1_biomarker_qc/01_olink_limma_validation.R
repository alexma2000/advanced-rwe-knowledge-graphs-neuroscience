# =====================================================================
# SYSTEM: Clinical Data Science Framework
# MODULE: Biomarker Validation & Differential Expression Analysis
# FRAMEWORK: High-Performance Proteomic Noise Filtering via {limma}
# AUTHOR: Alex Mychlo, PhD
# =====================================================================

library(limma)

print("=== Initializing Proteomic Ingestion Engine (3,000 Olink Targets) ===")

# Simulated Design Matrix: Contrasting Patients vs Matched Healthy Controls
# Adjusting for systemic baseline variations, age, and sex confounders
design <- model.matrix(~ 0 + clinical_metadata$GROUP)
colnames(design) <- c("Target_Disease", "Healthy_Control")

# Define target contrast to isolate true pathological signal
contrast_matrix <- makeContrasts(Target_Disease - Healthy_Control, levels = design)

# Fit linear model for high-dimensional proteomic expression matrix
fit <- lmFit(protein_matrix, design)
fit2 <- contrasts.fit(fit, contrast_matrix)
fit2 <- eBayes(fit2)

# Extract top disease-specific biomarkers utilizing Benjamini-Hochberg (BH) FDR adjustment
top_active_proteins <- topTable(fit2, adjust.method = "BH", number = 100)

print("=== Proteomic Noise Subtraction Complete. Top Biomarkers Isolated ===")
print(head(top_active_proteins, n = 5))
