using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerUI : MonoBehaviour
{
    public GameObject ScoreUI, LivesLeftUI, TimerUI, ProfessorUI, BlackboardUI;
    public GameObject ProfessorObj, BlackboardObj;

    private Professor _professor;
    private Blackboard _blackboard;
    private CalculatorGame _calculatorGame;

    private bool GameShowUI, ProfessorShowUI, BlackboardShowUI = false;

    private void OpenGameUI()
    {
        ScoreUI.SetActive(true);
        LivesLeftUI.SetActive(true);
        TimerUI.SetActive(true);
    }
    private void CloseGameUI()
    {
        ScoreUI.SetActive(false);
        LivesLeftUI.SetActive(false);
        TimerUI.SetActive(false);
    }

    private void OpenProfessorUI()
    {
        ProfessorUI.SetActive(true);
    }
    private void CloseProfessorUI()
    {
        ProfessorUI.SetActive(false);
    }

    private void OpenBlackboardUI()
    {
        BlackboardUI.SetActive(true);
    }
    private void CloseBlackboardUI()
    {
        BlackboardUI.SetActive(false);
    }

    void Start()
    {
        _professor = ProfessorObj.GetComponent<Professor>();
        _blackboard = BlackboardObj.GetComponent<Blackboard>();
        _calculatorGame = BlackboardObj.GetComponent<CalculatorGame>();

        CloseGameUI();
        CloseProfessorUI();
        CloseBlackboardUI();
    }

    private void Update()
    {
        ProfessorShowUI = _professor.ProfessorShowUI;
        BlackboardShowUI = _blackboard.BlackboardShowUI;
        GameShowUI = _calculatorGame.GameUI;

        if (GameShowUI)
        {
            OpenGameUI();
        }
        else
        {
            CloseGameUI();
        }

        if (ProfessorShowUI)
        {
            OpenProfessorUI();
        }
        else
        {
            CloseProfessorUI();
        }

        if (BlackboardShowUI)
        {
            OpenBlackboardUI();
        }
        else
        {
            CloseBlackboardUI();
        }
    }
}