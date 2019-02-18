
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ThirdPersonCameraController : MonoBehaviour
{

    #region Internal References
    private Transform _app;
    private Transform _view;
    private Transform _cameraBaseTransform;
    private Transform cameraTransform;
    private Transform cameraLookTarget;
    private Transform avatarTransform;
    private Rigidbody _avatarRigidbody;
    private bool currentlyShaking = false;
    private Vector3 originalPos;
    private Vector3 initOffset;
    private float initfOV;
    private float maxfOV = 70f;
    private float t = 0f;
    private float curfOV;
    private bool isHitCliff = false;
    #endregion

    #region Public Tuning Variables
    public Vector3 avatarObservationOffset_Base;
    public float followDistance_Base;
    public float verticalOffset_Base;
    public float pitchGreaterLimit;
    public float pitchLowerLimit;
    public float fovAtUp;
    public float fovAtDown;
    public float shakeAmount;
    public float shakeDur;
    public float decreaseFactor = 1f;
    public float radiusToImportantObj;
    public float playerHeight;
    #endregion

    private Transform importantObj;
    Vector3 curTarget = Vector3.zero;
     float distanceToImportantObj;

    enum GameState { Auto, Manual };

    #region Persistent Outputs
    //Positions
    private Vector3 _camRelativePostion_Auto;

    //Directions
    private Vector3 _avatarLookForward;

    //Scalars
    private float _followDistance_Applied;
    private float _verticalOffset_Applied;
    #endregion


    //to do for the assignment
    // make camera see ooj and hover on top of it
    // make camera react to traps (shake) done
    //Looking straight ahead as the avatar approaches a cliff - nesky mistake1
    // Using the same camera distance for all angles. 
    //  Using the same field-of-view for worm's eye angles and standard angles. 
    // Focusing only on the avatar.
    //Translating or rotating up and down when the avatar jumps.
    //use raycast spherecast physics 
    // make all of this states


    private void Awake()
    {
        _app = GameObject.Find("Application").transform;
        _view = _app.Find("View");
        _cameraBaseTransform = _view.Find("CameraBase");
        cameraTransform = _cameraBaseTransform.Find("Camera");
        cameraLookTarget = _cameraBaseTransform.Find("CameraLookTarget");

        avatarTransform = _view.Find("AIThirdPersonController");
        _avatarRigidbody = avatarTransform.GetComponent<Rigidbody>();
        initfOV = Camera.main.fieldOfView;
        
       
    }

    private void Update()
    {
        
        ProcessImportantObj();

        if (Input.GetKeyDown(KeyCode.Space)||CheckCol.isHitTrap)
        {
            StopAllCoroutines();
            StartCoroutine(ShakeCamera());
        }

        if (Input.GetMouseButton(1))
            _ManualUpdate();
        else
            _AutoUpdate();
    }



    #region States
    private void _AutoUpdate()
    {
        _ComputeData();
        _FollowAvatar();
        _LookAtAvatar();
        ProcessCliff();
    }
    private void _ManualUpdate()
    {
        _FollowAvatar();
        _ManualControl();
    }
    #endregion

    #region Internal Logic

    float _standingToWalkingSlider = 0;

    private void _ComputeData()
    {
        _avatarLookForward = Vector3.Normalize(Vector3.Scale(avatarTransform.forward, new Vector3(1, 0, 1)));

        if (_Helper_IsWalking())
        {
            _standingToWalkingSlider = Mathf.MoveTowards(_standingToWalkingSlider, 1, Time.deltaTime * 3);
        }
        else
        {
            _standingToWalkingSlider = Mathf.MoveTowards(_standingToWalkingSlider, 0, Time.deltaTime);
        }

        float _followDistance_Walking = followDistance_Base;
        float _followDistance_Standing = followDistance_Base * 2;

        float _verticalOffset_Walking = verticalOffset_Base;
        float _verticalOffset_Standing = verticalOffset_Base * 4;

        _followDistance_Applied = Mathf.Lerp(_followDistance_Standing, _followDistance_Walking, _standingToWalkingSlider);
        _verticalOffset_Applied = Mathf.Lerp(_verticalOffset_Standing, _verticalOffset_Walking, _standingToWalkingSlider);
    }

    private void _FollowAvatar()
    {
        _camRelativePostion_Auto = avatarTransform.position;

       
        if(importantObj!=null && distanceToImportantObj < radiusToImportantObj)
        {
            float lerpPct = 1;

            curTarget = importantObj.position + avatarObservationOffset_Base;

            lerpPct = distanceToImportantObj.Map(0, radiusToImportantObj, 0, 1);
            cameraLookTarget.position = Vector3.Lerp(curTarget, avatarTransform.position, lerpPct) + avatarObservationOffset_Base;
        }
        else
        {
            cameraLookTarget.position = avatarTransform.position + avatarObservationOffset_Base;
        }

       

        cameraTransform.position = avatarTransform.position - _avatarLookForward * _followDistance_Applied + Vector3.up * _verticalOffset_Applied;
    }

    private void _LookAtAvatar()
    {
        cameraTransform.LookAt(cameraLookTarget);
    }

    private void _ManualControl()
    {
        Vector3 _camEulerHold = cameraTransform.localEulerAngles;

        if (Input.GetAxis("Mouse X") != 0)
            _camEulerHold.y += Input.GetAxis("Mouse X");

        if (Input.GetAxis("Mouse Y") != 0)
        {
            float temp = _camEulerHold.x - Input.GetAxis("Mouse Y");
            temp = (temp + 360) % 360;

            if (temp < 180)
                temp = Mathf.Clamp(temp, 0, 80);
            else
                temp = Mathf.Clamp(temp, 360 - 80, 360);

            _camEulerHold.x = temp;
        }

        Debug.Log("The V3 to be applied is " + _camEulerHold);
        cameraTransform.localRotation = Quaternion.Euler(_camEulerHold);
    }

    private  Vector3 _CalculateShake()
    {
  
            shakeAmount += Time.deltaTime;
            return new Vector3(0, 2f, Easing.BounceEaseIn(shakeAmount / shakeDur));
          }

    private void ShakeCam()
    {
        if (shakeDur > 0)
        {
            avatarObservationOffset_Base =  Random.insideUnitSphere * shakeAmount;

            shakeDur -= Time.deltaTime * decreaseFactor;
        }
        else
        {
            shakeDur = 0f;
            avatarObservationOffset_Base = Vector3.zero;
        }
    }

    IEnumerator ShakeCamera()
    {

        initOffset = avatarObservationOffset_Base;

       for (float i = 0; i<1; i += Time.deltaTime / 2f)
        {
            avatarObservationOffset_Base = Random.insideUnitSphere * shakeAmount;

            yield return null;

        }

        avatarObservationOffset_Base = initOffset;


    }

    private void ProcessImportantObj()
    {
        Collider[] hitColliders = Physics.OverlapSphere(avatarTransform.position, radiusToImportantObj);

        foreach (var c in hitColliders)
        {
            if(c.tag == "OOI")
            {
                importantObj = c.transform;
                Vector3 diff = importantObj.transform.position - avatarTransform.position;
                distanceToImportantObj = diff.magnitude;
            }
        }
    }

    private void ProcessCliff()
    {
        RaycastHit hit;
        int layerMask = 1 << 9;
        if (Physics.Raycast(cameraTransform.position, cameraTransform.TransformDirection(Vector3.forward), out hit, Mathf.Infinity, layerMask))
        {
            Debug.DrawRay(cameraTransform.position, cameraTransform.TransformDirection(Vector3.forward) * hit.distance, Color.yellow);
            isHitCliff = true;

            Camera.main.fieldOfView = Mathf.Lerp(initfOV,maxfOV, t);
            t += 0.5f * Time.deltaTime;
           
        }
        else
        {
            Debug.DrawRay(cameraTransform.position, cameraTransform.TransformDirection(Vector3.forward) * 1000, Color.white);
            Debug.Log("Did not Hit");
            if (t > 1.0f)
            {
                isHitCliff = false;
                Camera.main.fieldOfView = Mathf.Lerp(maxfOV, initfOV, t);
                t += 0.5f * Time.deltaTime;
            }

        }
    }

    private void OnDrawGizmos()
    {
        if (avatarTransform == null) return;

        Vector3 pos = avatarTransform.position;
        Gizmos.color = Color.cyan;
        Gizmos.DrawWireSphere(pos, radiusToImportantObj);
    }

    #endregion

    #region Helper Functions

    private Vector3 _lastPos;
    private Vector3 _currentPos;
    private bool _Helper_IsWalking()
    {
        _lastPos = _currentPos;
        _currentPos = avatarTransform.position;
        float velInst = Vector3.Distance(_lastPos, _currentPos) / Time.deltaTime;

        if (velInst > .15f)
            return true;
        else return false;
    }

    #endregion
}
