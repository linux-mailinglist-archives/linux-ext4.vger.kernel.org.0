Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D54A1A2910
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 21:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgDHTF4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Wed, 8 Apr 2020 15:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbgDHTFz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 8 Apr 2020 15:05:55 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 207165] New: Persistent ext4_search_dir: bad entry in
 directory: directory entry too close to block end
Date:   Wed, 08 Apr 2020 19:05:55 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: el@prans.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-207165-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207165

            Bug ID: 207165
           Summary: Persistent ext4_search_dir: bad entry in directory:
                    directory entry too close to block end
           Product: File System
           Version: 2.5
    Kernel Version: 5.5.16
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: el@prans.net
        Regression: No

Since 5.5 I started getting persistent hits at the check added in 109ba779d6cca
(ext4: check for directory entries too close to block end).  It is 100%
reproducible when running docker containers on overlayfs2.  Here's an example
log entry:

kernel: EXT4-fs error (device dm-0): ext4_search_dir:1395: inode #28320400:
block 113246792: comm dockerd: bad entry in directory: directory entry too
close to block end - offset=0, inode=28320403, rec_len=32, name_len=8,
size=4096
dockerd[5315]: time="2020-04-08T11:03:35.148433258-07:00" level=error
msg="Error removing mounted layer
c520f6ce1d0b493e51aa9cdaea2240c6f65f104c3da8fb9767999dc526086f85: unlinkat
/var/lib/docker/overlay2/01c0c02ee4841227fefe595eeef8912fee32bc2b63a2264cb513f924e6366950/diff/tmp/apt-key-gpghome.TauCtRwzyD:
directory not empty"

To clarify, this error happened elsewhere as well, so this doesn't seem to be
overlayfs2-specific.

At first I thought that my filesystem was borked somehow, so I went so far as
to reformat the partition, but that didn't help.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
