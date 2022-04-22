Reduce Storage Costs with EFS
Introduction

Amazon Elastic File System (Amazon EFS) provides a simple, serverless elastic file system that lets you share file data without provisioning or managing storage. In this lab, we modify 3 existing EC2 instances to use a shared EFS storage volume instead of duplicated Elastic Block Store volumes. This reduces costs significantly, as we only need to store data in 1 location instead of 3. By the end of this lab, you will understand how to create EFS volumes and attach them to an EC2 instance.
Solution

Log in to the AWS Management Console using the credentials provided on the lab instructions page. Make sure you're using the us-east-1 region.
Create EFS Filesystem
Create an EFS Volume

    Navigate to EC2 > Instances (running).
    Click the checkmark next to webserver-01.
    Click the Storage tab and note the 10 GiB volume attached.
    In a new browser tab, navigate to EFS.
    Click Create file system, and set the following values:
        Name: SharedWeb
        Availability and Durability: One Zone
    Click Create.
    In the top right corner, click View file system.
    Click the Network tab and wait for the created network to become available.
    Click Manage.
    Under Security groups, remove the currently attached default security group and open the dropdown menu to select the provided EC2 security group (not the default).
    Click Save.
    Return to the EC2 browser tab.
    Click Security Groups in the left-hand menu.
    Click the checkmark next to that same security group (the one that is not default).
    Click the Inbound rules tab.
    Click Edit inbound rules.
    Click Add rule.
    In the Type column, find and select the NFS option to enable network file sharing (NFS).
    In the dropdown menu with the magnifying glass icon, find and select 0.0.0.0/0.
    Click Save rules.
    Click EC2 Dashboard in the left-hand menu.
    Click Instances (running).
    Click the checkmark next to webserver-01.
    In the top right corner, click Connect.
    Click Connect. This should take you to a new terminal showing your EC2 instance in a new browser tab or window.

Mount the EFS Filesystem and Test It

    In the terminal, list your block devices:
    lsblk

    View the data inside the 10-gig disk mounted to /data:
    ls /data

    Create a mount point or directory to attach our EFS volume:
    sudo mkdir /efs

    Return to the AWS EFS console showing the SharedWeb filesystem.

    Click Attach.

    Select Mount via IP.

    Copy the command under Using the NFS client: to your clipboard.

    Return to the terminal and paste in the command.

    Add a slash right before efs and press Enter.

    View the newly mounted EFS volume:
    ls /efs

    List the block devices again:
    lsblk

    View the mounts specifically and verify that the IP of your NFS mount is mounted on /efs:
    mount

    View filesystem mounts:
    df -h

    Move all files from /data to the /efs filesystem:
    sudo rsync -rav /data/* /efs

    View the files now in the /efs filesystem:
    ls /efs

Remove Old Data
Remove Data from Webserver-01

    Unmount the partition:
    sudo umount /data

    Edit the /etc/fstab file, which is the filesystem tab:
    sudo nano /etc/fstab

    Remove the line starting with "UUID=" by placing the cursor at the beginning of the line and hitting the Delete key until the line is gone.

    Paste in the filesystem ID into the now-empty line:
    [IP of NFS mount]:/

    Hit the Tab key twice.

    Add the mount point and filesystem type (nfs4), so that the line now looks like this:
    [IP of NFS mount]:/ 		/data 	nfs4

    Return to the AWS EFS console, which should still have the Attach window open, and copy the options (the part of the command starting with nfsvers and ending with noresvport) to your clipboard.

    Return to your terminal and add the copied options to the line and add two zeroes at the end, so that it now looks like this:
    [IP of NFS mount]:/ 		/data 	nfs4 <INSERT OPTIONS HERE> 0 0

    Save and exit by pressing Control+X, followed by Y and Enter.

    Unmount the /efs to test if this worked:
    sudo umount /efs

    View the filesystems:
    df -h

    Try and mount everything that is not already mounted:
    sudo mount -a

    View the filesystems again and check if 10.0.0.180:/ is mounted:
    df -h

    View the contents of /data:
    ls /data

    To delete the volume we're no longer using, return to the browser window or tab with the Connect to instance EC2 page open.

    Click the EC2 link in the top left corner to return to the EC2 console.

    Click Volumes in the left-hand menu.

    Scroll to the right and expand the Attachment Information column to find out which volume is attached to webserver-01.

    Click the checkbox next to the volume attached to webserver-01.

    Click Actions > Detach Volume.

    Click Yes, Detach.

    Click Actions > Delete Volume.

    Click Yes, Delete.

Remove Data from Webserver-02 and Webserver-03

    Navigate to EC2 > Instances (running).

    Click the checkbox next to webserver-02.

    Click Connect.

    Click Connect. This should launch a terminal in a new browser window or tab.

    Return to the window with the Connect to instance EC2 page open.

    Navigate to EC2 > Instances (running).

    Click the checkbox next to webserver-01.

    Click Connect.

    Click Connect. This should launch a terminal in a new browser window or tab.

    View the contents of /etc/fstab, also known as the filesystem tab:
    cat /etc/fstab

    Copy the second line starting with "10.0.0.180" to your clipboard.

    Return to the terminal you launched for webserver-02.

    Unmount the /data partition:
    sudo umount /data

    Edit the /etc/fstab file:
    sudo nano /etc/fstab

    Delete the second line using Control+K.

    Paste in the line from our clipboard using Control+V.

    Save and exit by pressing Control+X and then Y and then pressing Enter.

    Mount it:
    sudo mount -a

    Check the disk status:
    df -h

    Check the contents of /data:
    ls /data

    Return to the window with the Connect to instance EC2 page open.

    Navigate to EC2 > Instances (running).

    Click the checkbox next to webserver-03.

    Click Connect.

    Click Connect. This should launch a terminal in a new browser window or tab.

    Unmount the /data partition:
    sudo umount /data

    Edit the /etc/fstab file:
    sudo nano /etc/fstab

    Delete the second line using Control+K.

    Paste in the line from our clipboard using Control+V.

    Save and exit by pressing Control+X and then Y and then pressing Enter.

    Mount everything that is not already mounted:
    sudo mount -a

    Check the disk status:
    df -h

    Check the contents of /data:
    ls /data

    Return to the window with the Connect to instance EC2 page open.

    Navigate to EC2 > Volumes.

    Check both of the 10-GiB volumes.

    Click Actions > Detach Volumes.

    Click Yes, Detach.

    Click Actions > Delete Volumes.

    Click Yes, Delete.

Conclusion

Congratulations — you've completed this hands-on lab!
