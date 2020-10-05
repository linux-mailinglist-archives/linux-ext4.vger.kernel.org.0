Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFFF2841D2
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Oct 2020 22:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgJEU4T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 5 Oct 2020 16:56:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgJEU4T (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 5 Oct 2020 16:56:19 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 102621] Directory name or file name staring with '-' cannot be
 handled through command line,i.e.,terminal
Date:   Mon, 05 Oct 2020 20:56:18 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext2
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dmsfuddid@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-102621-13602-EbL468USN2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-102621-13602@https.bugzilla.kernel.org/>
References: <bug-102621-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=102621

--- Comment #3 from dmsfuddid@gmail.com ---
unsubscribe linux-ext4

2015년 8월 10일 (월) 오후 6:38, <bugzilla-daemon@bugzilla.kernel.org>님이 작성:

> https://bugzilla.kernel.org/show_bug.cgi?id=102621
>
>             Bug ID: 102621
>            Summary: Directory name or file name staring with '-' cannot be
>                     handled through command line,i.e.,terminal
>            Product: File System
>            Version: 2.5
>     Kernel Version: 3.16.7-21-desktop
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: ext2
>           Assignee: fs_ext2@kernel-bugs.osdl.org
>           Reporter: saptarshinag620@gmail.com
>         Regression: No
>
> Firstly,one cannot create a directory or a file through command-line with
> its
> name starting with '-'. That is one cannot give command like 'mkdir -test'
> or
> 'touch -test' where '-test' is the directory name and file name
> respectively.But in other way,one can easily create or work with such
> directory
> or file in GUI,but that file or directory cannot be accessed or handled
> through
> command-line.It has been tested in Suse Linux and Ubuntu,maybe it is
> universal
> bug for linux
>
> --
> You are receiving this mail because:
> You are watching the assignee of the bug.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ext4" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
