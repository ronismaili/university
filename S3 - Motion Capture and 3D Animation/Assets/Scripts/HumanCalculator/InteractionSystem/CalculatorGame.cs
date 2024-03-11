using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.InputSystem;

public class CalculatorGame : MonoBehaviour
{
    public GameObject BlackBoardObj, CounterStartObj, EndScreenObj, BlackboardOperationObj, BlackboardResultObj;
    public GameObject ScoreObj, LivesLeftObj, TimerObj;
    public bool GameUI;

    private Blackboard blackBoard;
    private TextMeshPro CounterText, EndScreenText, BlackboardOperationText, BlackboardResultText;
    private TextMeshProUGUI ScoreText, LivesText, TimerText;

    private bool START, StartGame, GameFinished, LastPass, KeyPressed;
    private int Score, Lives, Time;

    private int Num1, Num2, Operand, CorrectOption, CorrectSelector, PlayerInput;
    private int[] Option = { 1, 2, 3, 4};
    private System.Random _random = new System.Random();

    private void Timer()
    {
        StartCoroutine(PlayerCounter());
    }

    private void CheckIfFinished()
    {
        if (Lives == 0)
        {
            GameFinished = true;
        }

        if (Score == 5)
        {
            GameFinished = true;
        }
    }

    private void CheckUI()
    {
            ScoreText.text = Score + " / 5";
            LivesText.text = "Lives left: " + Lives;
            TimerText.text = Time + "";
    }

    private int RandomNumber()
    {
        return (int)Random.Range(0.0f, 100.0f);
    }

    private int SelectOperation()
    {
        int operand = (int)Random.Range(0.0f, 4.0f);
        return operand;
    }

    private void OutputInfo()
    {
        if (Operand == 0)
        {
            BlackboardOperationText.text = Num1 + " + " + Num2;
        }
        else if (Operand == 1)
        {
            BlackboardOperationText.text = Num1 + " - " + Num2;
        }
        else if (Operand == 2)
        {
            BlackboardOperationText.text = Num1 + " * " + Num2;
        }
        else if (Operand == 3)
        {
            BlackboardOperationText.text = Num1 + " + " + Num2;
        }
        BlackboardResultText.text = "1. " + Option[0] + "     " + "2. " + Option[1] + "\n" + "3. " + Option[2] + "     " + "4. " + Option[3];
    }

    private int MakeResult(int num1, int num2, int operand)
    {
        int result;
        switch (operand)
        {
            case 0:
                result = num1 + num2;
                break;

            case 1:
                result = num1 - num2;
                break;

            case 2:
                result = num1 * num2;
                break;

            case 3:
                result = num1 + num2;
                break;

            default:
                result = 0;
                Debug.Log("ERROR OCCURED IN THE MAKERESULT FUNCTION");
                break;
        }
        return result;
    }

    private void GenerateOptions()
    {
        Num1 = RandomNumber();
        Num2 = RandomNumber();
        Operand = SelectOperation();

        Option[0] = MakeResult(Num1, Num2, Operand);

        Option[1] = Option[0] + (int)Random.Range(5.0f, 55.0f);
        Option[2] = Option[0] - (int)Random.Range(5.0f, 55.0f);
        Option[3] = Option[0] + (int)Random.Range(5.0f, 55.0f);
    }

    private void UpdateBoard()
    {
        SelectorOptions();
        OutputInfo();
    }

    private void Shuffle(int[] array)
    {
        int p = array.Length;
        for (int n = p - 1; n > 0; n--)
        {
            int r = _random.Next((int)Random.Range(0.0f, 2.0f), n);
            int t = array[r];
            array[r] = array[n];
            array[n] = t;
        }
    }

    private void SelectorOptions()
    {
        GenerateOptions();

        CorrectOption = Option[0];
        
        Shuffle(Option);
        
        if (CorrectOption == Option[0])
        {
            CorrectSelector = 1;
        }
        else if (CorrectOption == Option[1])
        {
            CorrectSelector = 2;
        }
        else if (CorrectOption == Option[2])
        {
            CorrectSelector = 3;
        }
        else if (CorrectOption == Option[3])
        {
            CorrectSelector = 4;
        }
    }

    private void CheckInput()
    {
        if (Keyboard.current.digit1Key.wasPressedThisFrame)
        {
            PlayerInput = 1;
            KeyPressed = true;
        }

        if (Keyboard.current.digit2Key.wasPressedThisFrame)
        {
            PlayerInput = 2;
            KeyPressed = true;
        }

        if (Keyboard.current.digit3Key.wasPressedThisFrame)
        {
            PlayerInput = 3;
            KeyPressed = true;
        }

        if (Keyboard.current.digit4Key.wasPressedThisFrame)
        {
            PlayerInput = 4;
            KeyPressed = true;
        }
    }

    private void CheckResult()
    {
        CheckInput();

        if (PlayerInput == CorrectSelector && KeyPressed)
        {
            KeyPressed = false;
            Score++;
            Time = 10;
            UpdateBoard();
        }
        
        if (PlayerInput != CorrectSelector && KeyPressed)
        {
            KeyPressed = false;
            Lives--;
            Time = 10;
            UpdateBoard();
        }
    }

    private void PostCountdown()
    {
        Score = 0;
        Lives = 3;
        Time = 10;

        GameUI = true;
        LastPass = true;

        Timer();
        UpdateBoard();

        BlackboardOperationObj.SetActive(true);
        BlackboardResultObj.SetActive(true);
    }

    private IEnumerator WaiterCounter()
    {
        CounterStartObj.SetActive(true);
        CounterText.text = "READY";
        yield return new WaitForSeconds((float)1.5);
        CounterText.text = "SET";
        yield return new WaitForSeconds((float)1.5);
        CounterText.text = "GO";
        yield return new WaitForSeconds((float)1.5);
        CounterText.text = "";
        CounterStartObj.SetActive(false);

        PostCountdown();
    }

    private IEnumerator PlayerCounter()
    {
        while (Time > 0)
        {
            yield return new WaitForSeconds(1);
            Time--;
            if (Time == 0 && Lives != 0)
            {
                Lives--;
                Time = 10;

                //REMOVE IF NECESSARY
                UpdateBoard();
            }
        }
    }

    private void Start()
    {
        blackBoard = BlackBoardObj.GetComponent<Blackboard>();

        CounterText = CounterStartObj.GetComponent<TextMeshPro>();
        EndScreenText = EndScreenObj.GetComponent<TextMeshPro>();
        BlackboardOperationText = BlackboardOperationObj.GetComponent<TextMeshPro>();
        BlackboardResultText = BlackboardResultObj.GetComponent<TextMeshPro>();

        ScoreText = ScoreObj.GetComponent<TextMeshProUGUI>();
        LivesText = LivesLeftObj.GetComponent<TextMeshProUGUI>();
        TimerText = TimerObj.GetComponent<TextMeshProUGUI>();

        CounterText.text = "";
        EndScreenText.text = "";
        BlackboardOperationText.text = "";
        BlackboardResultText.text = "";

        ScoreText.text = "";
        LivesText.text = "";
        TimerText.text = "";

        GameFinished = false;
    }

    private void Update()
    {
        StartGame = blackBoard.startGame;

        if (Keyboard.current.escapeKey.wasPressedThisFrame)
        {
            Application.Quit();
        }

        if (StartGame == true && START == false) //A bit scuffed, I know. 
        {
            START = true;
            StartCoroutine(WaiterCounter());
        }

        if (GameUI && !GameFinished)
        {
            CheckIfFinished();
            CheckUI();
            CheckResult();
        }

        if (GameFinished && LastPass)
        {
            LastPass = false;

            ScoreText.text = "";
            LivesText.text = "";
            TimerText.text = "";

            BlackboardOperationText.text = "";
            BlackboardResultText.text = "";

            if (Score == 5)
            {
                EndScreenText.text = "YOU WON!";
            }
            else
            {
                EndScreenText.text = "YOU LOST!";
            }
        }
    }
}