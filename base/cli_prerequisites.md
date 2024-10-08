<script>
function buildQuiz(myq, qc){
  // variable to store the HTML output
  const output = [];

  // for each question...
  myq.forEach(
    (currentQuestion, questionNumber) => {

      // variable to store the list of possible answers
      const answers = [];

      // and for each available answer...
      for(letter in currentQuestion.answers){

        // ...add an HTML radio button
        answers.push(
          `<label>
            <input type="radio" name="question${questionNumber}" value="${letter}">
            ${letter} :
            ${currentQuestion.answers[letter]}
          </label><br/>`
        );
      }

      // add this question and its answers to the output
      output.push(
        `<div class="question"> ${currentQuestion.question} </div>
        <div class="answers"> ${answers.join('')} </div><br/>`
      );
    }
  );

  // finally combine our output list into one string of HTML and put it on the page
  qc.innerHTML = output.join('');
}

function showResults(myq, qc, rc){

  // gather answer containers from our quiz
  const answerContainers = qc.querySelectorAll('.answers');

  // keep track of user's answers
  let numCorrect = 0;

  // for each question...
  myq.forEach( (currentQuestion, questionNumber) => {

    // find selected answer
    const answerContainer = answerContainers[questionNumber];
    const selector = `input[name=question${questionNumber}]:checked`;
    const userAnswer = (answerContainer.querySelector(selector) || {}).value;

    // if answer is correct
    if(userAnswer === currentQuestion.correctAnswer){
      // add to the number of correct answers
      numCorrect++;

      // color the answers green
      answerContainers[questionNumber].style.color = 'lightgreen';
    }
    // if answer is wrong or blank
    else{
      // color the answers red
      answerContainers[questionNumber].style.color = 'red';
    }
  });

  // show number of correct answers out of total
  rc.innerHTML = `${numCorrect} out of ${myq.length}`;
}
</script>

# Command Line Interface

A basic understanding of the command line interface (CLI) is highly recommended for success in this course. We will briefly review the commands necessary for this course on the first morning, but there will not be enough time to provide full instruction in CLI basics. Beginners without any previous knowledge will be able to complete this course, and achieve a more thorough understanding of the techniques and analyses covered, but will probably not be able to conduct an experiment on their own.

The more confident you are in your command line skills, the more you will be able to explore the content in this course.

**Super Brief Introduction to the Command Line**
## Outline:
1. What is the command line?
2. Logging into a remote server with ssh
3. Directory Structure
4. Syntax of a Command
5. Options of a Command
5. Command Line Basics (ls, pwd, Ctrl-C, man, alias, ls -lthra)
6. Getting Around (cd)
7. Absolute and Relative Paths
8. Create and Destroy (echo, cat, rm, rmdir)
9. Symbolic Links (ln -s)
10. Forced Removal (rm -r)
11. Shell Scripts and File Permissions (chmod, nano, ./)

* The CLI is a tool into which one can type commands to perform tasks on your cmoputer.
* The user interface that accepts the typed responses and displays the data on the screen is called a shell: bash, tcsh…
* An all-text display and keyboard interactions, most of the time your mouse doesn't work.

A nice short read and description of terminals can be found [here](https://articles.geekiam.io/what-is-a-terminal-window/)

<img src="figures/cli_figure1.png" alt="cli_figure1" width="800px"/>


After opening a new terminal window, system messages are often displayed, followed by the "prompt".
A prompt is a short text message at the start of the command line and ends with '$' in bash shell, commands are typed after the prompt. The prompt typically follows the form **username@server:current_directory$**.

In the figure above, the user is "mattsettles," the machine is "biomsettles" (my apple mac), the current directory is "~" (short-hand for the home directory). and the "$" at the end tells us we are in the bash shell.

## Terminals

* Linux: every Linux distribution has its own terminal application as a stardard part of the installation.

* Apple Mac OS: apple also includes the 'terminal' application as a part of its standard installation. A more powerful and free tool 'iTerm2' is what I use and would recommend.

* Microsoft Windows: since Windows 10, there is now 'Windows Subsystem for Linux' and Later 'Windows Terminal'

## Command Line Basics

First some basics - how to look at your surroundings.

    pwd

present working directory ... where am I?

    ls

list files here ... you should see nothing since your homes are empty

    ls /tmp/

list files somewhere else, like /tmp/


Because one of the first things that's good to know is *how to escape once you've started something you don't want*.

    sleep 1000  # wait for 1000 seconds!

Use Ctrl-c (shows as '^C' in the terminal) to exit (kill) a command. In some cases, a different key sequence is required (Ctrl-d). Note that anything including and after a "#" symbol is ignored, i.e. a comment. **So in all the commands below, you do not have to type anything including and past a "#".**


#### Options

Each command can act as a basic tool, or you can add 'options' or 'flags' that modify the default behavior of the tool. These flags come in the form of '-v' ... or, when it's a more descriptive word, two dashes: '\-\-verbose' ... that's a common (but not universal) one that tells a tool that you want it to give you output with more detail. Sometimes, options require specifying amounts or strings, like '-o results.txt' or '\-\-output results.txt' ... or '-n 4' or '\-\-numCPUs 4'. Let's try some, and see what the man page for the 'list files' command 'ls' is like.

    ls -R /

Lists directories and files *recursively*. This will be a very long output, so use Ctrl-C to break out of it. Sometimes you have to press Ctrl-C many times to get the terminal to recognize it. In order to know which options do what, you can use the manual pages. To look up a command in the manual pages type "man" and then the command name. So to look up the options for "ls", type:

    man ls

Navigate this page using the up and down arrow keys, PageUp and PageDown, and then use q to quit out of the manual. In this manual page, find the following options, quit the page, and then try those commands. You could even open another terminal, log in again, and run manual commands in that terminal.

    ls -l /usr/bin/ # long format, gives permission values, owner, group, size, modification time, and name

<img src="figures/ls1.png" alt="ls1" width="800px"/>

    ls -a /usr/bin # shows ALL files, including hidden ones

<img src="figures/ls2.png" alt="ls2" width="800px"/>

    ls -l -a /usr/bin # does both of the above

<img src="figures/ls3.png" alt="ls3" width="800px"/>

    ls -la /usr/bin # option 'smushing' can be done with single letter options

<img src="figures/ls4.png" alt="ls4" width="800px"/>

    ls -ltrha /usr/bin # shows all files, long format, in last modified time reverse order, with human readable sizes

<img src="figures/ls5.png" alt="ls5" width="800px"/>

And finally adding color (white for regular files, blue for directories, turquoise for links):

    ls -ltrha --color /usr/bin # single letter (smushed) vs word options (Linux)

**OR**

    ls -ltrhaG /usr/bin # (MacOS)

<img src="figures/ls6.png" alt="ls6" width="800px"/>


**Quick aside:*** what if I want to use same options repeatedly? and be lazy? You can create a shortcut to another command using 'alias'.

    alias ll='ls -lah'
    ll


## Directory Structure

<img src="figures/cli_figure2.png" alt="cli_figure2" width="500px"/>

Usually, /home is where the user accounts reside, ie. users' 'home' directories.
For example, for a user that has a username of “msettles”: their home directory is /home/msettles
It is the directory that a user starts in after starting a new shell or logging into a remote server.

On Apple Mac OS, the home directories are under /Users

The tilde (~) is a short form of a user’s home directory.

## Syntax of a command

* A command plus the required parameters/arguments
* The separator used in issuing a command is space, number of spaces does not matter

<img src="figures/cli_figure3.png" alt="cli_figure3" width="800px"/>

## Quiz 1

<div id="quiz1" class="quiz"></div>
<button id="submit1">Submit Quiz</button>
<div id="results1" class="output"></div>
<script>
quizContainer1 = document.getElementById('quiz1');
resultsContainer1 = document.getElementById('results1');
submitButton1 = document.getElementById('submit1');

myQuestions1 = [
  {
    question: "What does the -h option for the ls command do?",
    answers: {
      a: "Creates a hard link to a file",
      b: "Shows the file sizes in a human readable format",
      c: "Shows the help page",
      d: "Recursively lists directories"
    },
    correctAnswer: "b"
  },
  {
    question: "What does the -l option for ls do?",
    answers: {
      a: "Produces a listing of all the links",
      b: "Produces a time stamp sorted list",
      c: "Produces a log file",
      d: "Produces a detailed format list"
    },
    correctAnswer: "d"
  },
  {
    question: "Which option turns off the default sort in the ls output?",
    answers: {
      a: "-U",
      b: "-t",
      c: "--hide",
      d: "-H"
    },
    correctAnswer: "a"
  }
];

buildQuiz(myQuestions1, quizContainer1);
submitButton1.addEventListener('click', function() {showResults(myQuestions1, quizContainer1, resultsContainer1);});
</script>


## Getting Around

The filesystem you're working on is like the branching root system of a tree. The top level, right at the root of the tree, is called the 'root' directory, specified by '/' ... which is the divider for directory addresses, or 'paths'. We move around using the 'change directory' command, 'cd'. The command pwd return the present working directory.

    cd  # no effect? that's because by itself it sends you home (to ~)
    cd /  # go to root of tree's root system
    cd home  # go to where everyone's homes are (on a Mac OS us /Users)
    pwd
    cd username  # use your actual home, not "username"
    pwd
    cd /
    pwd
    cd ~  # a shortcut to home, from anywhere
    pwd
    cd .  # '.' always means *this* directory
    pwd
    cd ..  # '..' always means *one directory up*
    pwd

<img src="figures/cli_figure5.png" alt="cli_figure5" width="800px"/>

**You should also notice the location changes in your prompt.**

## Absolute and Relative Paths

You can think of paths like addresses. You can tell your friend how to go to a particular store *from where they are currently* (a 'relative' path), or *from the main Interstate Highway that everyone uses* (in this case, the root of the filesystem, '/' ... this is an 'absolute' path). Both are valid. But absolute paths can't be confused, because they always start off from the same place, and are unique. Relative paths, on the other hand, could be totally wrong for your friend *if you assume they're somewhere they're not*. With this in mind, let's try a few more:

    cd /usr/bin  # let's start in /usr/bin

**relative** (start here, take one step up, then down through lib)

    cd ../lib/
    pwd

**absolute** (start at root, take steps)

    cd /usr/lib/
    pwd

Now, because it can be a real pain to type out, or remember these long paths, we need to discuss ...

## Quiz 2

<div id="quiz2" class="quiz"></div>
<button id="submit2">Submit Quiz</button>
<div id="results2" class="output"></div>
<script>
quizContainer2 = document.getElementById('quiz2');
resultsContainer2 = document.getElementById('results2');
submitButton2 = document.getElementById('submit2');

myQuestions2 = [
  {
    question: "What is the tilde short for?",
    answers: {
      a: "Your home directory",
      b: "Your user name",
      c: "Your current directory",
      d: "The root directory"
    },
    correctAnswer: "a"
  },
  {
    question: "From the /usr/bin directory, verify that the two following commands are equivalent:<br/><br/>cd ../../lib/<br/>cd ../../../../../../../lib<br/><br/>Why are these very different-looking commands equivalent?",
    answers: {
      a: "The cd command knows where your home directory resides",
      b: "The terminal ignores excess dots",
      c: "Because going one directory up from root just takes you back to root",
      d: "Home is the root directory"
    },
    correctAnswer: "c"
  }
];

buildQuiz(myQuestions2, quizContainer2);
submitButton2.addEventListener('click', function() {showResults(myQuestions2, quizContainer2, resultsContainer2);});
</script>

## Create and Destroy

Let's create a directory and a text file.

    cd  # home again
    echo $USER # echo to screen the contents of the variable $USER
    mkdir ~/tmp2
    cd ~/tmp2
    echo 'Hello, world!' > first.txt

echo text then redirect ('>') to a file.

    cat first.txt  # 'cat' means 'concatenate', or just spit the contents of the file to the screen

why 'concatenate'? try this:

    cat first.txt first.txt first.txt > second.txt
    cat second.txt

OK, let's destroy what we just created:

    cd ../
    rmdir tmp2  # 'rmdir' meands 'remove directory', but this shouldn't work!
    rm tmp2/first.txt
    rm tmp2/second.txt  # clear directory first
    rmdir tmp2  # should succeed now

So, 'mkdir' and 'rmdir' are used to create and destroy (empty) directories. 'rm' to remove files. To create a file can be as simple as using 'echo' and the '>' (redirection) character to put text into a file. Even simpler is the 'touch' command.

    mkdir ~/cli
    cd ~/cli
    touch newFile
    ls -ltra  # look at the time listed for the file you just created
    cat newFile  # it's empty!
    sleep 60  # go grab some coffee
    touch newFile
    ls -ltra  # same time?

So 'touch' creates empty files, or updates the 'last modified' time. Note that the options on the 'ls' command you used here give you a Long listing, of All files, in Reverse Time order (l, a, r, t).

## Symbolic Links

Since copying or even moving large files (like sequence data) around your filesystem may be impractical, we can use links to reference 'distant' files without duplicating the data in the files. Symbolic links are disposable pointers that refer to other files, but behave like the referenced files in commands. I.e., they are essentially 'Shortcuts' (to use a Windows term) to a file or directory.

The 'ln' command creates a link. **You should, by default, always create a symbolic link using the -s option.**

    ln -s ~/cli/newFile .
    ls -ltrhaF  # notice the symbolic link pointing at its target


## Forced Removal

When you're on the command line, there's no 'Recycle Bin'. Since we've expanded a whole directory tree, we need to be able to quickly remove a directory without clearing each subdirectory and using 'rmdir'.

    cd
    mkdir -p rmtest/dir1/dir2 # the -p option creates all the directories at once
    rmdir rmtest # gives an error since rmdir can only remove directories that are empty
    rm -rf rmtest # will remove the directory and EVERYTHING in it

Here -r = recursively remove sub-directories, -f means *force*. Obviously, be careful with 'rm -rf', there is no going back, if you delete something with rm, rmdir its gone! **There is no Recycle Bin on the Command-Line!**

## Quiz 3

<div id="quiz3" class="quiz"></div>
<button id="submit3">Submit Quiz</button>
<div id="results3" class="output"></div>
<script>
quizContainer3 = document.getElementById('quiz3');
resultsContainer3 = document.getElementById('results3');
submitButton3 = document.getElementById('submit3');

myQuestions3 = [
  {
    question: "In the command 'rm -rf rmtest', what is 'rmtest'?",
    answers: {
      a: "An option",
      b: "An argument",
      c: "A command",
      d: "A choice"
    },
    correctAnswer: "b"
  },
  {
    question: "Make a directory called test and then run 'rm test'. What happens?",
    answers: {
      a: "Nothing happens",
      b: "The directory is removed",
      c: "The terminal exits",
      d: "You get an error message"
    },
    correctAnswer: "d"
  }
];

buildQuiz(myQuestions3, quizContainer3);
submitButton3.addEventListener('click', function() {showResults(myQuestions3, quizContainer3, resultsContainer3);});
</script>



## Shell Scripts, File Permissions

Often it's useful to define a whole string of commands to run on some input, so that (1) you can be sure you're running the same commands on all data, and (2) so you don't have to type the same commands in over and over! Let's use the 'nano' text editor program that's pretty reliably installed on most linux systems.

    cd ~
    nano test.sh

<img src="figures/cli_figure7.png" alt="cli_figure7" width="800px"/>

nano now occupies the whole screen; see commands at the bottom. Let's type in a few commands. First we need to put the following line at the top of the file:

<div class="script">
#!/bin/bash
</div>

The "#!" at the beginning of a script tells the shell what language to use to interpret the rest of the script. In our case, we will be writing "bash" commands, so we specify the full path of the bash executable after the "#!". Then, add some commands:

<div class="script">
#!/bin/bash

echo "Start script..."
pwd
ls -l
sleep 10
echo "End script."
</div>

Hit Cntl-O and then enter to save the file, and then Cntl-X to exit nano.

Though there are ways to run the commands in test.sh right now, it's generally useful to give yourself (and others) 'execute' permissions for test.sh, really making it a shell script. Note the characters in the first (left-most) field of the file listing:

    ls -lh test.sh

<div class="output">-rw-rw-r-- 1 msettles biocore 79 Aug 19 15:05 test.sh
</div>


The first '-' becomes a 'd' if the 'file' is actually a directory. The next three characters represent **r**ead, **w**rite, and e**x**ecute permissions for the file owner (you), followed by three characters for users in the owner's group, followed by three characters for all other users. Run the 'chmod' command to change permissions for the 'test.sh' file, adding execute permissions ('+x') for the user (you) and your group ('ug'):

    chmod ug+x test.sh
    ls -lh test.sh

<div class="output">-rwxr-xr-- 1 msettles biocore 79 Aug 19 15:05 test.sh
</div>

The first 10 characters of the output represent the file and permissions.
The first character is the file type, the next three sets of three represent the file permissions for the user, group, and everyone respectively.
- r = read
- w = write
- x = execute

So let's run this script. We have to provide a relative reference to the script './' because its not our our "PATH".:

    ./test.sh

And you should see all the commands in the file run in sequential order in the terminal.

