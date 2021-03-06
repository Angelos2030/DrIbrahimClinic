﻿using System;
using System.Windows.Forms;
using DrIbrahimClinic.BLL;
using DrIbrahimClinic.DAL.Model;
using DrIbrahimClinic.Utility;
using static DrIbrahimClinic.Utility.Constants;
using static DrIbrahimClinic.Utility.InputLanguageUtility;
using static DrIbrahimClinic.Utility.MessageBoxUtility;

namespace DrIbrahimClinic.PL
{
    public partial class FrmAddTreatment : FrmMaster
    {
        public FrmAddTreatment()
        {
            InitializeComponent();
        }

        #region Properties

        private TreatmentManager _treatmentManager;
        public TreatmentManager TreatmentManager => _treatmentManager ?? (_treatmentManager = new TreatmentManager());

        #endregion

        #region Events

        private void FrmAddTreatment_Load(object sender, EventArgs e)
        {
            SetTextBoxesInputLanguages();
            SetTextBoxesPlaceholders();
        }

        private void btnSaveAndNew_Click(object sender, EventArgs e)
        {
            Cursor = Cursors.WaitCursor;
            AddNewTreatment(true);
            Cursor = Cursors.Default;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            Cursor = Cursors.WaitCursor;
            AddNewTreatment();
            Cursor = Cursors.Default;
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            Close();
        }

        #endregion

        #region Methods

        private void AddNewTreatment(bool addAnother = false)
        {
            if (string.IsNullOrEmpty(txtTreatmentName.Text.FullTrim()))
            {
                txtTreatmentName.BackColor = ErrorColor;
                txtTreatmentName.Focus();
                return;
            }
            if (TreatmentManager.IsTreatmentFoundByName(txtTreatmentName.Text.FullTrim()))
            {
                ShowErrorMsg("يوجد علاج آخر بنفس الاسم");
                return;
            }
            TreatmentManager.AddTreatment(new Treatment
            {
                Name = txtTreatmentName.Text.FullTrim()
            });
            if (addAnother)
            {
                txtTreatmentName.Text = string.Empty;
                txtTreatmentName.Focus();
            }
            else
                Close();
        }

        private void SetTextBoxesInputLanguages()
        {
            txtTreatmentName.GotFocus += SetEnglishInputLanguage;
        }

        private void SetTextBoxesPlaceholders()
        {
            //txtTreatmentName.SetPlaceholderText("Enter treatment name here ...");
        }

        #endregion
    }
}