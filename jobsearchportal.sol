// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract JobSearchPortal {

    struct JobPosting {
        uint jobId;
        address employer;
        string jobName;
        string jobDescription;
        string salary;
        string employerContactNumber;
    }
    uint private jobCount = 0;

    mapping(uint => JobPosting) jobs;



    event JobPosted(
        uint jobId,
        address employer,
        string jobName,
        string jobDescription,
        string salary,
        string employerContactNumber
    );


    // Post a job
    function postJob(
        string memory _jobName,
        string memory _jobDescription,
        string memory _salary,
        string memory _employerContactNumber
    ) public {
        // Create a new job
        JobPosting memory job = JobPosting(
              jobCount,
            msg.sender,
            _jobName,
            _jobDescription,
            _salary,
            _employerContactNumber
        );
        jobs[jobCount] = job;

        jobCount++;

        emit JobPosted(
            job.jobId,
            job.employer,
            job.jobName,
            job.jobDescription,
            job.salary,
            job.employerContactNumber
        );
    }

 function getJobposts(uint256 _jobId)
        public
        view
        returns (
            uint,
            address,
            string memory,
            string memory,
            string memory,
            string memory
        )
    {
         JobPosting storage job = jobs[_jobId];
        return (
            job.jobId,
            job.employer,
            job.jobName,
            job.jobDescription,
            job.salary,
            job.employerContactNumber
        );
    }

     function removeJobPost(uint _jobId) external {
	        require(msg.sender == jobs[_jobId].employer, "not permmited");
            jobs[_jobId] = jobs[jobCount - 1];
            delete jobs[jobCount - 1];
            jobCount--;
	 }


    //add users
struct User {
        string firstName;
        string lastName;
        string email;
        string password;
        address add;
        string usertype;
    }

    mapping (uint => User) public users;

    uint public usersCount;

    function addUser (string memory _firstName, 
                      string memory _lastName, 
                      string memory _email, 
                      string memory _password,
                      string memory _usertype) public{
        users[usersCount] = User(_firstName,
                                 _lastName, 
                                 _email, 
                                 _password, 
                                 msg.sender,
                                 _usertype);
        usersCount++;

    }


// Job applied
struct applied {
        uint256 primarykey;
        uint256 jobid;
        uint256 userid;
        bytes32 jname;
    }

    
    uint256 applied_count = 0;
    mapping(uint256 => applied) m_applied;


    function jobApplied (uint256 _jobid,
                         uint256 _userid,
                         bytes32 _jname) public {
        applied_count++;
        m_applied[applied_count] = applied(applied_count,
                                           _jobid,
                                           _userid,
                                           _jname);
    }
 




//rating
    struct ApplicantRating {
        uint uid;
        string rating;
        string comment;
    }

    mapping (uint => ApplicantRating) public applicantrating;

    uint public applicantsRating;

    function applicantRating (uint _uid, 
                              string memory _rating, 
                              string memory _comment) public{
        applicantrating[applicantsRating] = ApplicantRating(_uid, 
                                                            _rating, 
                                                            _comment);
    }

}