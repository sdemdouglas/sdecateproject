using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections;

/// <summary>
/// Summary description for WordCounter
/// </summary>
#region WordCounter
public class WordCounter
{
    string testString = null;
    SortedList wordCounter = new SortedList();

    public WordCounter(string str)
    {
        testString = str;
    }

    public int UniqueWords
    {
        get
        {
            return wordCounter.Count;
        }
    }

    public IDictionaryEnumerator GetWordsAlphabeticallyEnumerator()
    {
        return wordCounter.GetEnumerator();
    }

    public IDictionaryEnumerator GetWordsByOccurrenceEnumerator()
    {
        SortedList sl = new SortedList();
        IDictionaryEnumerator enumer = GetWordsAlphabeticallyEnumerator();
        while (enumer.MoveNext())
        {
            WordOccurrence wo = new WordOccurrence((int)enumer.Value, (string)enumer.Key);
            sl.Add(wo, null);
        }
        return sl.GetEnumerator();
    }

    public bool CountStats(out int numWords, out int numChars)
    {
        numWords = 0;
        numChars = testString.Length;
        string[] words = testString.Split(null);

        foreach (string str in words)
        {
            if (str.Length > 0)
            {
                // count space as one char 
                //numChars += str.Length + 1;
                //if (!wordCounter.ContainsKey(str))
                //{
                //    wordCounter.Add(str, 1);
                numWords++;
                //}
                //else
                //{
                //    int iWordCount = (int)wordCounter[str];
                //    wordCounter[str] = iWordCount + 1;
                //}

            }
        }

        return true;
    }

    public class WordOccurrence : IComparable
    {
        int occurences;
        string word;

        public WordOccurrence(int occurrences, string word)
        {
            this.occurences = occurences;
            this.word = word;
        }



        public int Occurrences
        {
            get { return occurences; }
        }

        public string Word
        {
            get { return word; }
        }
        #region IComparable Members

        public int CompareTo(object o)
        {
            return string.Compare(word, ((WordOccurrence)o).word);
        }

        #endregion
    }
}
#endregion

