Return-Path: <linux-ext4+bounces-3659-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 402BC94A814
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Aug 2024 14:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA54828173A
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Aug 2024 12:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4151E6734;
	Wed,  7 Aug 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVjycEnH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D8D1E486D
	for <linux-ext4@vger.kernel.org>; Wed,  7 Aug 2024 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035144; cv=none; b=bOaYYIQsIn9ed2BPlQUCh1q8N3KIdQI6nicOvQRb/68w9RNf2IGDzzgvwWgxo7fYWH4Pw9tFJ8mI7WQ33dxwiuywBk0vSYntxA4rFnN3Dp0acEfhUDAHMWeLvkBlowYXaIGXV404M8aWplxaMNyCNrLvdqnaTTyHyjAor4ChtlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035144; c=relaxed/simple;
	bh=Wa3qGyH4LiklsLldqwfW8mkUdjCiwI9Tf1Bkw3IbxFs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dSxYEmwroyGJWscPJPTvhojXoPjbPxSfRMtypS/sm8CR5Pc6ICPhywC0FMHZcrWAC4Utnb37nKalOTHTVSqHWcaLSkJwdgApkIq8PhEQs8TsxhtzFRJBIPMxJBmKLNeUrtw9qL1MAMaS8KV+YaiTOfhdur4Td7biUsECY2zkGxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVjycEnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B2A9C4AF0B
	for <linux-ext4@vger.kernel.org>; Wed,  7 Aug 2024 12:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723035144;
	bh=Wa3qGyH4LiklsLldqwfW8mkUdjCiwI9Tf1Bkw3IbxFs=;
	h=From:To:Subject:Date:From;
	b=pVjycEnHO+IufDNe9XG8w77Hcg3IcOd27l6nrLRYEjab1OfZYYWmEDBl/MrNWiMBC
	 t06GtAzKcXvZSkyx4QcHWqyO6zuMT6KxvLH4siX40OfXwtxwHUS9rGGNp9w6D6SXnX
	 G/FuEz0Lr153bEE3B8FIkh4PlXiTV8cOfc4otsskzrAp8LvScyAFBfziIT21I1T7rE
	 JisnhzSjTd3WnFsUSDgAzHt7kPbveBp2jhmcbuT//UKru0bos6m24hiQyTHdonCLqq
	 lZQg3/N/K4DNRARdNKWhcz+1Be/Eo6dLcL1BOxjPz5HbnKMqTDfg3l16/Sb5Vojbgg
	 bZRxunQWAomvw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 650F4C53B73; Wed,  7 Aug 2024 12:52:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219136] New: ext4: dax: overflowing extents beyond inode size
 when partially writing
Date: Wed, 07 Aug 2024 12:52:24 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chengzhihao1@huawei.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219136-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D219136

            Bug ID: 219136
           Summary: ext4: dax: overflowing extents beyond inode size when
                    partially writing
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: chengzhihao1@huawei.com
        Regression: No

The dax_iomap_rw() does two things in each iteration: map written blocks
    and copy user data to blocks. If the process is killed by user(See sign=
al
    handling in dax_iomap_iter()), the copied data will be returned and add=
ed
    on inode size, which means that the length of written extents may exceed
    the inode size, then fsck will fail. An example is given as:

    dd if=3D/dev/urandom of=3Dfile bs=3D4M count=3D1
     dax_iomap_rw
      iomap_iter // round 1
       ext4_iomap_begin
        ext4_iomap_alloc // allocate 0~2M extents(written flag)
      dax_iomap_iter // copy 2M data
      iomap_iter // round 2
       iomap_iter_advance
        iter->pos +=3D iter->processed // iter->pos =3D 2M
       ext4_iomap_begin
        ext4_iomap_alloc // allocate 2~4M extents(written flag)
      dax_iomap_iter
       fatal_signal_pending
      done =3D iter->pos - iocb->ki_pos // done =3D 2M
     ext4_handle_inode_extension
      ext4_update_inode_size // inode size =3D 2M

    fsck reports: Inode 13, i_size is 2097152, should be 4194304.  Fix?

Reproducer:
1. Apply diff and compile kernel
2. ./test.sh
mke2fs 1.47.0 (5-Feb-2023)
Creating filesystem with 524288 4k blocks and 131072 inodes
Filesystem UUID: e2c71b4e-3315-4463-8613-ea3f40bf1efb
Superblock backups stored on blocks:=20
        32768, 98304, 163840, 229376, 294912

Allocating group tables: done=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
Writing inode tables: done=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done=20

./test.sh: line 18:  1559 Terminated              dd if=3D/dev/urandom
of=3D$MNT/file bs=3D4M count=3D1
e2fsck 1.47.0 (5-Feb-2023)
Pass 1: Checking inodes, blocks, and sizes
Inode 13, i_size is 2097152, should be 4194304.  Fix? no

Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information

/dev/pmem2: ********** WARNING: Filesystem still has errors **********

/dev/pmem2: 13/131072 files (0.0% non-contiguous), 27308/524288 blocks

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

