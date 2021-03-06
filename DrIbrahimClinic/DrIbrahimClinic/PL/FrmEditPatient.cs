﻿using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;
using DrIbrahimClinic.BLL;
using DrIbrahimClinic.DAL.Model;
using DrIbrahimClinic.Utility;
using static DrIbrahimClinic.Utility.MessageBoxUtility;
using static DrIbrahimClinic.Utility.Utility;
using static DrIbrahimClinic.Utility.InputLanguageUtility;
using static DrIbrahimClinic.Utility.Constants;

namespace DrIbrahimClinic.PL
{
    public partial class FrmEditPatient : FrmMaster
    {
        public FrmEditPatient()
        {
            InitializeComponent();
        }

        #region Properties

        private PatientManager _patientManager;
        private PatientManager PatientManager => _patientManager ?? (_patientManager = new PatientManager());

        private IEnumerable<Patient> _patients;
        private IEnumerable<Patient> Patients => _patients ?? (_patients = PatientManager.GetAllPatients());

        public Patient Patient { get; set; }

        #endregion

        #region Events

        private void FrmEditPatient_Load(object sender, EventArgs e)
        {
            ResetForm();
            SetAutoCompletion();
            SetTextBoxesInputLanguages();
        }

        private void btnFindPatient_Click(object sender, EventArgs e)
        {
            Cursor = Cursors.WaitCursor;
            if (intInputId.Value == 0 && string.IsNullOrEmpty(txtName.Text))
            {
                ShowInfoMsg("يجب إدخال رقم المريض او اسم المريض");
                Cursor = Cursors.Default;
                return;
            }
            Patient = intInputId.Value != 0
                ? Patients.FirstOrDefault(patient => patient.Id == intInputId.Value)
                : Patients.FirstOrDefault(patient => patient.Name == txtName.Text);
            if (Patient != null)
                ShowPatient(Patient);
            else
                ShowErrorMsg("لا يوجد مريض بهذا الرقم او الاسم");
            Cursor = Cursors.Default;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            Cursor = Cursors.WaitCursor;
            if (string.IsNullOrEmpty(txtName.Text.FullTrim()))
            {
                txtName.BackColor = ErrorColor;
                Cursor = Cursors.Default;
                return;
            }
            if (txtName.Text.FullTrim() != Patient.Name && PatientManager.IsPatientFoundByName(txtName.Text.FullTrim()))
            {
                ShowErrorMsg("يوجد مريض آخر بنفس الاسم");
                Cursor = Cursors.Default;
                return;
            }
            Patient.Name = txtName.Text.FullTrim();
            Patient.Birthdate = dtBirthdate.Value != default(DateTime) ? dtBirthdate.Value : (DateTime?) null;
            Patient.Gender = switchBtnGender.Value ? "M" : "F";
            Patient.Phone = txtPhone.Text.FullTrim();
            Patient.Address = txtAddress.Text.FullTrim();
            Patient.BirthType = switchBtnBirthType.Value ? (byte) 1 : (byte) 2;
            Patient.SucklingType = switchBtnSucklingType.Value ? (byte) 1 : (byte) 2;
            PatientManager.UpdatePatient(Patient);
            Cursor = Cursors.Default;
            Close();
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            Cursor = Cursors.WaitCursor;
            ResetForm();
            Cursor = Cursors.Default;
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            Close();
        }

        #endregion

        #region Methods

        private void ResetForm()
        {
            ShowOrHideControls(false);
            intInputId.Value = 0;
            txtName.Text = string.Empty;
            dtBirthdate.Value = default(DateTime);
            switchBtnGender.Value = true;
            txtPhone.Text = string.Empty;
            txtAddress.Text = string.Empty;
            switchBtnBirthType.Value = true;
            switchBtnSucklingType.Value = true;
            txtName.BackColor = Color.Empty;
        }

        private void SetAutoCompletion()
        {
            var namesCollection = new AutoCompleteStringCollection();
            namesCollection.AddRange(Patients.Select(p => p.Name).ToArray());
            SetAutoCompleteSourceForTextBox(txtName, namesCollection);
        }

        private void ShowPatient(Patient patient)
        {
            ShowOrHideControls(true);
            intInputId.Value = patient.Id;
            txtName.Text = patient.Name;
            dtBirthdate.Value = patient.Birthdate ?? default(DateTime);
            switchBtnGender.Value = patient.Gender == "M";
            txtPhone.Text = patient.Phone ?? string.Empty;
            txtAddress.Text = patient.Address ?? string.Empty;
            switchBtnBirthType.Value = patient.BirthType == 1;
            switchBtnSucklingType.Value = patient.SucklingType == 1;
        }

        private void ShowOrHideControls(bool isEnabled)
        {
            intInputId.Enabled = !isEnabled;
            dtBirthdate.Enabled = isEnabled;
            switchBtnGender.Enabled = isEnabled;
            txtPhone.Enabled = isEnabled;
            txtAddress.Enabled = isEnabled;
            switchBtnBirthType.Enabled = isEnabled;
            switchBtnSucklingType.Enabled = isEnabled;
            btnSave.Enabled = isEnabled;
            btnFindPatient.Enabled = !isEnabled;
        }

        private void SetTextBoxesInputLanguages()
        {
            txtName.GotFocus += SetArabicInputLanguage;
            txtAddress.GotFocus += SetArabicInputLanguage;
            txtPhone.GotFocus += SetArabicInputLanguage;
        }

        #endregion
    }
}