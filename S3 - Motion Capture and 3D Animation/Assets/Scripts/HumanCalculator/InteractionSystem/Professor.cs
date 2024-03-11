using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class Professor : MonoBehaviour, IInteractable
{
    public bool ProfessorShowUI = false;
    private bool ProfessorTalk, ProfessorColliding = false;

    public GameObject PlayerObj;
    private Interactor _interactor;
    
    public bool Interact(Interactor interactor)
    {
        ProfessorColliding = true;

        if (Keyboard.current.eKey.wasPressedThisFrame)
        {
            if (!ProfessorTalk)
            {
                //Debug.Log("You just talked to the professor!");
                ProfessorTalk = true;
                return true;
            }
            else
            {
                //Debug.Log("Already talked to the Professor!");
                return false;
            }
        }

        return false;
    }

    private void Start()
    {
        _interactor = PlayerObj.GetComponent<Interactor>();
    }

    private void Update()
    {
        if (ProfessorColliding == true && _interactor.colliding && !ProfessorTalk)
        {
            ProfessorShowUI = true;
        }
        else
        {
            ProfessorColliding = false;
            ProfessorShowUI = false;
        }
    }
}