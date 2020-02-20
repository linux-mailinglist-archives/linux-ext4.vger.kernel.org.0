Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5130A16641E
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2020 18:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgBTRPz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 20 Feb 2020 12:15:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbgBTRPz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 20 Feb 2020 12:15:55 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 206613] New: On hitting tab key from terminal against a
 directory name ending with ':\' doesnot shows files/dir inside it rather
 shows dir name itself
Date:   Thu, 20 Feb 2020 17:15:53 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: cubonix@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-206613-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206613

            Bug ID: 206613
           Summary: On hitting tab key from terminal against a directory
                    name ending with ':\' doesnot shows files/dir inside
                    it rather shows dir name itself
           Product: File System
           Version: 2.5
    Kernel Version: 5.5.0-050500-generic
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: low
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: cubonix@gmail.com
        Regression: No

Hi All.
Recently I bought a new laptop for usability purpose of my wife I created some
folders by Name C:\ D:\ E:\ and mounted  3 partitions (as she is a win user),
lately I have observed if hit tab againt these 3 dir , it does not exposes
files/dir which is contained. Which generally doesnot happens.

Log Snippet
===========
root@jarvis:~# uname -a
Linux jarvis 5.5.0-050500-generic #202001262030 SMP Mon Jan 27 01:33:36 UTC
2020 x86_64 x86_64 x86_64 GNU/Linux
root@jarvis:~# 
root@jarvis:~# cat /etc/os-release 
NAME="Ubuntu"
VERSION="19.10 (Eoan Ermine)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 19.10"
VERSION_ID="19.10"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=eoan
UBUNTU_CODENAME=eoan

When I normally hit tab against any dir it exposes files/dir 
=============================================================
root@jarvis:~# cd /
bin/        cdrom/      etc/        lib/        lib64/      lost+found/ mnt/   
    proc/       run/        srv/        tmp/        var/
boot/       dev/        home/       lib32/      libx32/     media/      opt/   
    root/       sbin/       sys/        usr/        
root@jarvis:~# 

But when I try to hit tab against any dir ending with :\
==============================================================

root@jarvis:/home/abhishek/Desktop# ls
'C:\'  'D:\'  'E:\'

abhishek@jarvis:~/Desktop$ cd 'C:\'^C =========>does not recommends any thing
abhishek@jarvis:~/Desktop$ cd C:\\ =========>does not recommends any thing

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
