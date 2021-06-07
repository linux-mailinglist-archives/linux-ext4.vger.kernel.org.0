Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708EE39E170
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jun 2021 18:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhFGQFt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Jun 2021 12:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230220AbhFGQFs (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 7 Jun 2021 12:05:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A7BE2611AD
        for <linux-ext4@vger.kernel.org>; Mon,  7 Jun 2021 16:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623081837;
        bh=Lnq/kheCP0MOiN9u+G6HIyCpLMohbJI5gXFT26w8Dy4=;
        h=From:To:Subject:Date:From;
        b=EtTCqLwvoadnEYtiK1TvHK9wcNzOJnQLsWwnEkM1QM97QPxqpEscDWCbl2rzmrfoN
         UrYzaNQU7Ni+xTT4suGKaUxEuueI2JhXguqIGsp6fLqO5rXY9qF7Hp3JUTBsHL7QCQ
         R6WhcxbbvTbnntnNiIRDRLJ5j7qXkgOKV3jDuPkJhA9CyBRnwVvvmUXSiv6nD5GjTR
         ONprwfX4Kvpu+VnrcAe3pUzktBKb+SfCcfV/FIQNyIXw/AEZjGwOm+nu570m1wLHQ6
         LwykYPC8kBJ6uwzxzL9ViYn12+oJmWBi7xHFKJlnsE2GGyPa2bGD/JJfvcBXHuTXjP
         AD3QHZufTOJ6w==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 9CE4461175; Mon,  7 Jun 2021 16:03:57 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 213357] New: chattr +e writes invalid checksum to extent block
Date:   Mon, 07 Jun 2021 16:03:57 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jeroen@wolffelaar.nl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-213357-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213357

            Bug ID: 213357
           Summary: chattr +e writes invalid checksum to extent block
           Product: File System
           Version: 2.5
    Kernel Version: 5.13.0-rc4
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: jeroen@wolffelaar.nl
        Regression: No

Created attachment 297207
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D297207&action=3Dedit
Reproduction script

Overview:

Converting a file previously using (ext2/3) blocklists to ext4 extents using
chattr +e makes the kernel write an invalid checksum to the extent block (if
one needs to be written because of the metadata_csum feature & there being =
more
than 4 extents). Because of inode caching, this won't be obvious until the
inode has has been evicted from the cache, or the filesystem is remounted. =
The
checksum errors are trivially correctable using e2fsck.

Reproduction:

In short:

* Create a large enough file on an ext3 filesystem to have it 5+ discontinu=
ous
ranges of blocks
* Add 'extent' and 'metadata_csum' feature to the filesystem
* chattr +e the file
* Reload the filesystem/clear inode cache

See repro.sh for full steps.

Observe:

* Reading the file gives I/O errors (EXT4-fs error: ext4_find_extent:885: i=
node
#12: comm cat: pblk 17591 bad header/extent: extent tree corrupted - magic
f30a, entries 6, max 340(340), depth 0(0))
* e2fsck reports checksum mismatch (ext2fs_block_iterate3: Extent block
checksum does not match extent block)

Reproduction:

Besides the system where I originally found the bug, I reproduced it with 3
Debian versions (Stretch, Buster, Bullseye rc1), and additionally Bullseye =
with
vanilla 5.13.0-rc4 kernel built from kernel.org source tarball: so, kernel
versions spanning 4.9 to 5.13.

The reproduction script is destructive to the provided device.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
