
[https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally]	(https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally)

1.  Back up your computer.
2.  On the command line, in your home directory, create a directory for global installations:
	    ```
		    
	    ```
3.  Configure npm to use the new directory path:
    
4.  In your preferred text editor, open or create a  `~/.profile`  file and add this line:
    
5.  On the command line, update your system variables:
    
6.  To test your new configuration, install a package globally without using  `sudo`:
    

Instead of steps 2-4, you can use the corresponding ENV variable (e.g. if you don’t want to modify  `~/.profile`):
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTM3NTI1NTk5NV19
-->