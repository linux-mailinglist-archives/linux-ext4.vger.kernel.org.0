Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEF121A712
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jul 2020 20:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgGISbc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 9 Jul 2020 14:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgGISbb (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 9 Jul 2020 14:31:31 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 207165] Persistent ext4_search_dir: bad entry in directory:
 directory entry too close to block end
Date:   Thu, 09 Jul 2020 18:31:30 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-207165-13602-Rvu9FeLFM8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207165-13602@https.bugzilla.kernel.org/>
References: <bug-207165-13602@https.bugzilla.kernel.org/>
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

--- Comment #2 from Elvis Pranskevichus (el@prans.net) ---
dumpe2fs 1.45.6 (20-Mar-2020)
Filesystem volume name:   root
Last mounted on:          /
Filesystem UUID:          1ca09d01-202a-4a0c-a150-8d078c57d751
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index filetype
needs_recovery extent 64bit flex_bg inline_data sparse_super large_file
huge_file dir_nlink extra_isize metadata_csum
Filesystem flags:         signed_directory_hash 
Default mount options:    user_xattr acl
Filesystem state:         clean with errors
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              31031296
Block count:              124111616
Reserved block count:     6205580
Free blocks:              37127036
Free inodes:              26630302
First block:              0
Block size:               4096
Fragment size:            4096
Group descriptor size:    64
Reserved GDT blocks:      1024
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8192
Inode blocks per group:   512
Flex block group size:    16
Filesystem created:       Tue Apr  7 23:31:35 2020
Last mount time:          Thu Jul  9 09:47:02 2020
Last write time:          Thu Jul  9 11:30:13 2020
Mount count:              6
Maximum mount count:      38
Last checked:             Fri May 22 14:10:16 2020
Check interval:           15552000 (6 months)
Next check after:         Wed Nov 18 13:10:16 2020
Lifetime writes:          2756 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               256
Required extra isize:     32
Desired extra isize:      32
Journal inode:            8
First orphan inode:       7122511
Default directory hash:   half_md4
Directory Hash Seed:      7fd796d0-3b05-456b-8550-2734924aa361
Journal backup:           inode blocks
FS Error count:           2
First error time:         Thu Jul  9 11:30:13 2020
First error function:     ext4_search_dir
First error line #:       1399
First error inode #:      28320400
First error block #:      113246792
Last error time:          Thu Jul  9 11:30:13 2020
Last error function:      ext4_search_dir
Last error line #:        1399
Last error inode #:       28328032
Last error block #:       113247269
Checksum type:            crc32c
Checksum:                 0x69cb04e1
Journal features:         journal_incompat_revoke journal_64bit
journal_checksum_v3
Journal size:             1024M
Journal length:           262144
Journal sequence:         0x0052bb7e
Journal start:            66275
Journal checksum type:    crc32c
Journal checksum:         0x17d02966

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
