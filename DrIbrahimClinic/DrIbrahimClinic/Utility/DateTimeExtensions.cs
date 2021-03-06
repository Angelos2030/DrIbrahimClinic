﻿using System;
using static System.Globalization.CultureInfo;

namespace DrIbrahimClinic.Utility
{
    public static class DateTimeExtensions
    {
        public static string ToMonthName(this DateTime dateTime)
        {
            return CurrentCulture.DateTimeFormat.GetMonthName(dateTime.Month);
        }

        public static string ToShortMonthName(this DateTime dateTime)
        {
            return CurrentCulture.DateTimeFormat.GetAbbreviatedMonthName(dateTime.Month);
        }

        public static string ToDayName(this DateTime dateTime)
        {
            return CurrentCulture.DateTimeFormat.GetDayName(dateTime.DayOfWeek);
        }

        public static string ToDayNumber(this DateTime dateTime)
        {
            return dateTime.Day.ToString();
        }

        public static string ToHour(this DateTime dateTime)
        {
            return dateTime.Hour.ToString();
        }

        public static string ToMinute(this DateTime dateTime)
        {
            return dateTime.Minute.ToString();
        }

        public static string ToFormattedDate(this DateTime dateTime)
        {
            return $"{dateTime.ToShortMonthName()} {dateTime.Day}, {dateTime.Year}";
        }

        public static string ToFormattedArabicDate(this DateTime dateTime)
        {
            return dateTime.ToString("dd MMMM yyyy", GetCultureInfo("ar-AE"));
        }

        public static string ToAgeFromBirthdate(this DateTime? dateTime)
        {
            if (dateTime == null || dateTime == default(DateTime))
                return string.Empty;
            return (DateTime.Now.Year - dateTime.Value.Year).ToString();
        }
    }
}