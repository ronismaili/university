using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class Interactor : MonoBehaviour
{
    public bool colliding;

    private readonly Collider[] _colliders = new Collider[3];
    private IInteractable _interactable;
    private int _numFound;

    [SerializeField] private Transform _interactionPoint;
    [SerializeField] private float _interactionPointRadius = 0.5f;
    [SerializeField] private LayerMask _interactableMask;

    private void Update()
    {
        _numFound = Physics.OverlapSphereNonAlloc(_interactionPoint.position, _interactionPointRadius, _colliders, _interactableMask);

        if (_numFound > 0)
        {
            _interactable = _colliders[0].GetComponent<IInteractable>();

            if (_interactable != null)
            {
                _interactable.Interact(this);
                colliding = true;
            }
        }
        else
        {
            if(_interactable != null) _interactable = null;
            colliding = false;
        }
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(_interactionPoint.position, _interactionPointRadius);
    }
}