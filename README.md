# MONSTER MIND — Smart Hospital Bed & Patient Deterioration Simulator

> **A Student Hackathon Project: Digital Twin for Hospital Operations, Explainable Patient Deterioration, and Bed Capacity Planning.**

---

## ⚠️ Important Educational Safety Disclaimer

> **DEMO ENVIRONMENT — All patients and readings are synthetic.**
> This educational simulator is inspired by clinical principles (such as NEWS2) but is **not clinically validated** and **does not make autonomous clinical decisions**. All alerts, scores, and bed recommendations are operational suggestions intended exclusively for human review.

---

## 🌟 Overview & Highlights

**MONSTER MIND** is a digital twin command centre dashboard designed for modern hospital operations. It addresses two critical healthcare operational bottlenecks:
1. **Late Detection of Patient Deterioration:** Demonstrates how continuous multi-parameter telemetry and transparent early warning scores (NEWS2) detect physiological decline before code events occur.
2. **Disconnected Bed Placement:** Demonstrates how real-time patient acuity changes automatically trigger constraint-satisfaction bed optimization (care-level hierarchy, isolation precautions, telemetry, and specialty alignment) with ranked recommendations and transparent rejection reasons.

---

## 🚀 Live Demo Quick Start

### Prerequisites
- **Python 3.10+** (FastAPI, Uvicorn, Pydantic, Pytest)
- **Node.js 18+** & **npm**

### Quick Launch Scripts (Windows)

We provide one-click `.bat` runners for instant evaluation:

1. **Start Backend (FastAPI + WebSocket on Port 8000):**
   ```bash
   run_backend.bat
   ```
   *Or manually:*
   ```bash
   cd backend
   python -m uvicorn main:app --host 127.0.0.1 --port 8000 --reload
   ```

2. **Start Frontend (Vite + React on Port 5173):**
   ```bash
   run_frontend.bat
   ```
   *Or manually:*
   ```bash
   cd frontend
   npm run dev
   ```
   *Open browser at: [http://localhost:5173](http://localhost:5173)*

3. **Run Automated Test Suite (Pytest):**
   ```bash
   run_tests.bat
   ```
   *Or manually:*
   ```bash
   cd backend
   pytest -v
   ```

---

## 🧭 Judge & Presenter Walkthrough Demo Sequence

To demonstrate the full digital twin cause-and-effect cascade during the hackathon presentation, follow this 5-step workflow:

1. **Overview Dashboard:**
   - Review the **4 dynamic KPI summary cards** (24 Total Patients, High-Priority Cases, Available Beds, Active Simulation Alerts).
   - Inspect the **Risk Distribution** and **Bed Occupancy** interactive Recharts bar charts.
   - Use the **Search Bar** to find patient `SIM-104` (Bacterial Pneumonia in HDU).

2. **Inspect Patient Observations:**
   - Click **Details** on `SIM-104`.
   - Inspect the **7 core vital signs cards** with normal reference bounds and NEWS2 subscore contributions (+pts).
   - Review the multi-metric **Vital History Chart** showing historical trends for Heart Rate, Respiration, SpO2, and Risk Score.

3. **Drive Deterioration in the Simulation Lab:**
   - Click **Launch Simulation Lab** or select **Simulation Lab** in the left sidebar.
   - Select **Worsening** mode and set the **Intensity Slider** to **80%**.
   - Click **Run Simulation**.

4. **Observe Instant Cause-and-Effect Cascade:**
   - **Step 1:** Synthetic readings immediately derange (Tachycardia 120+ bpm, Tachypnea 26+ breaths/min, SpO2 drops below 91%).
   - **Step 2:** Risk Engine recalculates score into **High Priority (NEWS2 &ge; 7)** with a flashing red alert badge.
   - **Step 3:** The **Explainable Risk Card** generates plain-English clinical justifications highlighting extreme driving parameters.
   - **Step 4:** The **Bed Optimizer** automatically promotes target care level from `HDU` to `ICU`, immediately surfacing vacant ICU beds (e.g. `ICU-103` at 100% suitability) while rejecting general ward beds.
   - **Step 5:** The event is permanently logged into the **Alert History** audit timeline.

5. **Test Recovery:**
   - In the Simulation Lab, switch mode to **Recovery** at **15% intensity** and click **Run Simulation**.
   - Observe vitals improve toward baseline, risk score drop, and bed recommendations recalibrate back to Step-Down/General.

---

## 🏗️ System Architecture

```
                                  [ Browser Client ]
                             React 19 + TypeScript + Vite
                       Tailwind CSS + Lucide React + Recharts
                                       |      ^
                     REST API Requests |      | Bi-Directional WebSocket
                        (Port 8000)    |      | (/ws/ward telemetry)
                                       v      |
                       +-----------------------------------+
                       |         FastAPI Backend           |
                       |       (Python 3.12, Uvicorn)      |
                       +-----------------------------------+
                         |               |               |
                         v               v               v
                +----------------+ +------------+ +-----------------+
                |   Simulator    | | Risk Engine| |  Bed Optimizer  |
                |  24 Patients   | |   (NEWS2)  | |  32 Ward Beds   |
                |  Deterministic | | Explainable| |  Constraints    |
                +----------------+ +------------+ +-----------------+
```

### Directory Structure

```
Monster Mind/
├── backend/
│   ├── main.py                  # FastAPI server, REST routes, CORS & WebSocket (/ws/ward)
│   ├── schemas.py               # Pydantic data contracts (Patient, Bed, Risk, Simulation)
│   ├── simulator.py             # Deterministic patient deterioration engine & state manager
│   ├── risk_engine.py           # Transparent NEWS2-inspired clinical scoring engine
│   ├── bed_optimizer.py         # Constraint-satisfaction bed matcher & ranking algorithm
│   ├── websocket_manager.py     # Thread-safe WebSocket client manager
│   ├── pytest.ini               # Pytest configuration
│   └── tests/
│       ├── test_risk_engine.py  # Unit tests for scoring rules & threshold boundaries
│       ├── test_bed_optimizer.py# Unit tests for isolation, care level & bed constraints
│       └── test_simulator.py    # Unit tests for 24 patients, modes & demo reset
│
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   │   ├── SafetyBanner.tsx           # Persistent educational disclaimer banner
│   │   │   ├── Sidebar.tsx                # Collapsible navigation drawer
│   │   │   ├── TopNavbar.tsx              # Page headers, sync timestamp & reset trigger
│   │   │   ├── StatusBadge.tsx            # Risk band, trend, and care-level badges
│   │   │   ├── VitalCard.tsx              # Parameter metric card with subscore highlights
│   │   │   ├── VitalHistoryChart.tsx      # Multi-metric Recharts trend graph
│   │   │   ├── RiskExplanationCard.tsx    # Parameter table & narrative rationale
│   │   │   ├── BedRecommendationPanel.tsx # Ranked matches & rejected bed audit
│   │   │   ├── PatientTable.tsx           # Searchable census directory
│   │   │   ├── SimulationControls.tsx     # Tactile mode buttons & intensity slider
│   │   │   └── ConfirmModal.tsx           # Reset confirmation dialog
│   │   ├── views/
│   │   │   ├── OverviewView.tsx           # Main operations dashboard with 4 KPI cards
│   │   │   ├── PatientDetailView.tsx      # Comprehensive patient observation monitor
│   │   │   ├── SimulationLabView.tsx      # Main demo feature for scenario driving
│   │   │   ├── BedManagementView.tsx      # Hospital-wide bed inventory & matrix
│   │   │   ├── AlertHistoryView.tsx       # Chronological escalation audit log
│   │   │   └── AboutMethodologyView.tsx   # Problem, scoring matrix & methodology
│   │   ├── context/
│   │   │   └── HospitalContext.tsx        # Central React state & WebSocket synchronizer
│   │   ├── services/
│   │   │   ├── api.ts                     # Typed REST API client
│   │   │   └── websocket.ts               # Auto-reconnecting WebSocket client
│   │   └── types/
│   │       └── index.ts                   # Complete TypeScript data model definitions
│   ├── tailwind.config.js
│   ├── vite.config.ts
│   └── package.json
│
├── run_backend.bat              # Start FastAPI backend
├── run_frontend.bat             # Start Vite frontend
├── run_tests.bat                # Run Pytest suite
└── README.md                    # Project documentation
```

---

## 📊 Clinical Scoring Engine Rules (NEWS2 Inspired)

The engine transparently tracks 7 physiological vital signs:
- **Respiration Rate (breaths/min):** &le;8 (3 pts), 9–11 (1 pt), 12–20 (0 pts), 21–24 (2 pts), &ge;25 (3 pts)
- **Oxygen Saturation (%):** &le;91 (3 pts), 92–93 (2 pts), 94–95 (1 pt), &ge;96 (0 pts)
- **Supplemental Oxygen:** Room air (0 pts), Prescribed O2 (2 pts)
- **Systolic BP (mmHg):** &le;90 (3 pts), 91–100 (2 pts), 101–110 (1 pt), 111–219 (0 pts), &ge;220 (3 pts)
- **Heart Rate (bpm):** &le;40 (3 pts), 41–50 (1 pt), 51–90 (0 pts), 91–110 (1 pt), 111–130 (2 pts), &ge;131 (3 pts)
- **Consciousness (ACVPU):** Alert (0 pts), Voice/Confusion/Pain/Unresponsive (3 pts)
- **Temperature (°C):** &le;35.0 (3 pts), 35.1–36.0 (1 pt), 36.1–38.0 (0 pts), 38.1–39.0 (1 pt), &ge;39.1 (2 pts)

### Risk Bands
- **Low Risk (0–4 points):** Ward-based routine monitoring.
- **Medium Risk (5–6 points OR any single parameter of 3 points):** Urgent clinical review; HDU consideration.
- **High Priority (&ge;7 points):** Emergency critical care review; ICU transfer protocol.

---

## 🛏️ Bed Optimization Constraints & Ranking

- **Feasibility Filter:** Excludes occupied beds, excludes non-isolation rooms for airborne infections, excludes beds lacking continuous telemetry for deteriorating patients, and enforces care-level ceilings.
- **Suitability Ranking Index (0–100):**
  - Base: 100 points
  - Exact Specialty Match: +15 points
  - Same-Ward Placement: +10 points
  - ICU Over-Provisioning Penalty for HDU: -20 points (to preserve surge critical capacity)

---

## 🧪 Verified Automated Tests

Run the complete test suite:
```bash
run_tests.bat
```
Output:
```
tests/test_bed_optimizer.py::test_occupied_bed_rejection PASSED
tests/test_bed_optimizer.py::test_isolation_constraint_enforcement PASSED
tests/test_bed_optimizer.py::test_icu_patient_care_level_mismatch PASSED
tests/test_risk_engine.py::test_normal_vitals_score_zero PASSED
tests/test_risk_engine.py::test_single_extreme_triggers_medium_risk PASSED
tests/test_risk_engine.py::test_critical_derangement_high_risk PASSED
tests/test_risk_engine.py::test_missing_parameters_graceful_handling PASSED
tests/test_risk_engine.py::test_trend_calculation PASSED
tests/test_simulator.py::test_simulator_initial_counts PASSED
tests/test_simulator.py::test_simulator_worsening_mode PASSED
tests/test_simulator.py::test_simulator_recovery_mode PASSED
tests/test_simulator.py::test_reset_demo_data PASSED
============================= 12 passed in 1.09s ==============================
```

---

## ⚖️ Known Limitations

1. **Synthetic Data Only:** All patient identities, histories, and parameters are synthetic fixtures.
2. **Simplified Scoring Model:** While modeled after NEWS2, this is an educational implementation and is not an officially certified medical tool.
3. **In-Memory Event Persistence:** Simulation events and state changes are held in runtime memory for hackathon responsiveness and reset cleanly with the **Reset Demo** feature.
