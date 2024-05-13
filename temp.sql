CREATE TABLE IF NOT EXISTS temp_search_results (
    item_code VARCHAR(255),
    item_name VARCHAR(255),
    organization_code VARCHAR(255),
    predicted_start_date DATE,
    predicted_end_date DATE,
    budget_start_date DATE,
    budget_end_date DATE
);
