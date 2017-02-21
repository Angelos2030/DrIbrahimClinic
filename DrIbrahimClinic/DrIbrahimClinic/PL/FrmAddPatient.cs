﻿using System;
using DrIbrahimClinic.BLL;
using DrIbrahimClinic.DAL.Model;
using static DrIbrahimClinic.Utility.MessageBoxUtility;
using static DrIbrahimClinic.Utility.StringExtensions;
using static DrIbrahimClinic.Utility.Constants;
using static DrIbrahimClinic.Utility.InputLanguageUtility;

namespace DrIbrahimClinic.PL
{
    public partial class FrmAddPatient : MasterForm
    {
        public FrmAddPatient()
        {
            InitializeComponent();
        }

        #region Properties

        private PatientManager _patientManager;
        public PatientManager PatientManager => _patientManager ?? (_patientManager = new PatientManager());

        #endregion

        #region Events

        private void FrmAddPatient_Load(object sender, EventArgs e)
        {
            SetTextBoxesInputLanguages();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtName.Text.FullTrim()))
            {
                txtName.BackColor = ErrorColor;
                return;
            }
            var patient = new Patient
            {
                Name = txtName.Text.FullTrim(),
                Birthdate = dtBirthdate.Value != default(DateTime) ? dtBirthdate.Value : (DateTime?) null,
                Gender = switchBtnGender.Value ? "M" : "F",
                Phone = txtPhone.Text.FullTrim(),
                Address = txtAddress.Text.FullTrim(),
                BirthType = switchBtnBirthType.Value ? (byte) 1 : (byte) 2,
                SucklingType = switchBtnSucklingType.Value ? (byte) 1 : (byte) 2
            };
            PatientManager.AddPatient(patient);
            ShowInfoMsg($"تم إضافة المريض بنجاح\nرقم المريض هو: {patient.Id}");
            Close();
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            ResetForm();
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            Close();
        }

        #endregion

        #region Methods
        
        private void ResetForm()
        {
            txtName.Text = string.Empty;
            dtBirthdate.Value = default(DateTime);
            switchBtnGender.Value = true;
            txtPhone.Text = string.Empty;
            txtAddress.Text = string.Empty;
            switchBtnBirthType.Value = true;
            switchBtnSucklingType.Value = true;
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
