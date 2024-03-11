using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class Blackboard : MonoBehaviour, IInteractable
{
    public bool startGame, BlackboardShowUI = false;
    private bool BlackboardColliding = false;

    public GameObject PlayerObj;
    private Interactor _interactor;

    public bool Interact(Interactor interactor)
    {
        BlackboardColliding = true;
        
        if (Keyboard.current.eKey.wasPressedThisFrame)
        {
            //Debug.Log("Blackboard!");
            startGame = true;
            return true;
        }

        return true;
    }

    private void Start()
    {
        _interactor = PlayerObj.GetComponent<Interactor>();
    }

    private void Update()
    {
        if (BlackboardColliding == true && _interactor.colliding && !startGame)
        {
            BlackboardShowUI = true;
        } else
        {
            BlackboardColliding = false;
            BlackboardShowUI = false;
        }
    }
}