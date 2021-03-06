﻿using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;
using DrIbrahimClinic.BLL;
using DrIbrahimClinic.DAL.Model;
using DrIbrahimClinic.Utility;
using static DrIbrahimClinic.Utility.Constants;
using static DrIbrahimClinic.Utility.Utility;
using static DrIbrahimClinic.Utility.MessageBoxUtility;
using static DrIbrahimClinic.Utility.InputLanguageUtility;

namespace DrIbrahimClinic.PL
{
    public partial class FrmEditTreatment : FrmMaster
    {
        public FrmEditTreatment()
        {
            InitializeComponent();
        }

        #region Properties

        private TreatmentManager _treatmentManager;
        private TreatmentManager TreatmentManager => _treatmentManager ?? (_treatmentManager = new TreatmentManager());

        private IEnumerable<Treatment> _treatments;
        private IEnumerable<Treatment> Treatments => _treatments ?? (_treatments = TreatmentManager.GetAllTreatments());

        public Treatment Treatment { get; set; }

        #endregion

        #region Events

        private void FrmEditTreatment_Load(object sender, EventArgs e)
        {
            SetAutoCompletion();
            SetTextBoxesInputLanguages();
        }

        private void btnSaveAndNew_Click(object sender, EventArgs e)
        {
            Cursor = Cursors.WaitCursor;
            EditTreatment(true);
            Cursor = Cursors.Default;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            Cursor = Cursors.WaitCursor;
            EditTreatment();
            Cursor = Cursors.Default;
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

        private void EditTreatment(bool editAnother = false)
        {
            if (string.IsNullOrEmpty(txtTreatmentOldName.Text.FullTrim()))
            {
                txtTreatmentOldName.BackColor = ErrorColor;
                txtTreatmentOldName.Focus();
                return;
            }
            if (string.IsNullOrEmpty(txtTreatmentNewName.Text.FullTrim()))
            {
                txtTreatmentNewName.BackColor = ErrorColor;
                return;
            }
            Treatment = TreatmentManager.GeTreatmentByName(txtTreatmentOldName.Text);
            if (Treatment == null)
                ShowErrorMsg("لا يوجد علاج بهذا الاسم");
            else
            {
                if (txtTreatmentNewName.Text.FullTrim() == txtTreatmentOldName.Text.FullTrim())
                {
                    ShowErrorMsg("لا يمكن الحفظ بنفس الاسم");
                    return;
                }
                if (TreatmentManager.IsTreatmentFoundByName(txtTreatmentNewName.Text.FullTrim()))
                {
                    ShowErrorMsg("يوجد علاج آخر بنفس الاسم");
                    return;
                }
                Treatment.Name = txtTreatmentNewName.Text.FullTrim();
                TreatmentManager.UpdateTreatment(Treatment);
                if (!editAnother)
                    Close();
                ResetForm();
                txtTreatmentOldName.Focus();
                _treatments = null;
                SetAutoCompletion();
            }
        }

        private void ResetForm()
        {
            txtTreatmentOldName.Text = txtTreatmentNewName.Text = string.Empty;
            txtTreatmentOldName.BackColor = txtTreatmentNewName.BackColor = Color.Empty;
        }

        private void SetAutoCompletion()
        {
            var namesCollection = new AutoCompleteStringCollection();
            namesCollection.AddRange(Treatments.Select(t => t.Name).ToArray());
            SetAutoCompleteSourceForTextBox(txtTreatmentOldName, namesCollection);
        }

        private void SetTextBoxesInputLanguages()
        {
            txtTreatmentOldName.GotFocus += SetEnglishInputLanguage;
            txtTreatmentNewName.GotFocus += SetEnglishInputLanguage;
        }

        #endregion
    }
}