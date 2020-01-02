Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9DF12E6ED
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jan 2020 14:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgABNtZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 2 Jan 2020 08:49:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:37018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728342AbgABNtZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 2 Jan 2020 08:49:25 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 206061] New: Poor NVME SSD support, EXT4 re-mounted
Date:   Thu, 02 Jan 2020 13:49:23 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: greatestcombinator@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-206061-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206061

            Bug ID: 206061
           Summary: Poor NVME SSD support, EXT4 re-mounted
           Product: File System
           Version: 2.5
    Kernel Version: 4.18, 5.3
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: low
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: greatestcombinator@gmail.com
        Regression: No

Good time of day. After every time I turned on my computer on Xubuntu 18.04, I
saw that my disk's file system was being checked. In dmesg, I saw the
following: 
[    1.422390] EXT4-fs (nvme0n1p3): mounted filesystem with ordered data mode.
Opts: (null)
[    3.522543] EXT4-fs (nvme0n1p3): re-mounted. Opts: (null)

. On the Internet, I found out that this is an old SSD NVME problem that can't
be fixed for 2 years. Why are you not going to support new hardware and the
kernel displays such messages after each run? This problem affects many users.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
