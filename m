Return-Path: <linux-ext4+bounces-3739-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E68CF954333
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 09:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409501F2562F
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 07:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAF35B69E;
	Fri, 16 Aug 2024 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sng0UQHR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C703D4F602
	for <linux-ext4@vger.kernel.org>; Fri, 16 Aug 2024 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723794189; cv=none; b=FEra86zQlbwx6UPZqY4j/sIZ7Kz4ORLdR7Wd/kAcRgM7CJf+0H1mWavhDZm59INarMQH9YYy8laI6sYjnTfuzuSbXphbtLjV6MycGVvqGgsnH7NPxV0Cro/l2GSPdQR/MEn146bRQTSuMO8eJpolGucFL+gMokALoMZDv3tER2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723794189; c=relaxed/simple;
	bh=l3JZvIn/HnfiPn+23+JJ+7h32og1cXxHlFtmiqQph+w=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nT54Sch4IdhwNOJgUNb7dva0ntqnv3ivOR49nDAYrR0KeV4irSBfqmTRLnYPVXKPpmLL8z6RWCrFmWIHAeSRODVKXagM+TOk0OnU34BK3Q4iyL9kAkgFsBHwX418OpT9T/7Xnqam+pq9wb9CbGsoB+lywdYQoiDyJBxP8dne7qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sng0UQHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FACEC4AF0B
	for <linux-ext4@vger.kernel.org>; Fri, 16 Aug 2024 07:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723794189;
	bh=l3JZvIn/HnfiPn+23+JJ+7h32og1cXxHlFtmiqQph+w=;
	h=From:To:Subject:Date:From;
	b=Sng0UQHRT4bXSAEwD+TOueoQEy3BEC45Euc7kRVMcAAiKG37975GMiJNjX/mt+53D
	 J4FYfQcJpb+OAxNrfkmodpULsyQqmcU6smUCCedbJx7IcBUvqg+1cc2bdD8KQGFgL1
	 sH49H0swMq1xeinru6INAebLqa5Hd7nHruu7Hmv1XxNoAbjSw5+2EUHyEJIx5MQDxg
	 1EOe3LqcGHqvn6ShQ8B0my5H0xU7qd4X1FCDat+nfYxjBuwdY3ToJqssAq5vK5xBVN
	 NvP2TatFbuc6Ac7I4DTfPK/sFn33Szd7dxqbbwzHId2wFammeZ9Or0+J0TVdMPVLT7
	 p9HFCNmGrJDkg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5244DC53B50; Fri, 16 Aug 2024 07:43:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] New: ext4 hang when setting echo noop >
 /sys/block/sda/queue/scheduler
Date: Fri, 16 Aug 2024 07:43:09 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rjones@redhat.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219166-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219166

            Bug ID: 219166
           Summary: ext4 hang when setting echo noop >
                    /sys/block/sda/queue/scheduler
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: rjones@redhat.com
        Regression: No

kernel-6.11.0-0.rc3.30.fc41.x86_64

This hang seems new in 6.11.0.

Downstream bug:
https://bugzilla.redhat.com/show_bug.cgi?id=3D2303267

Trying to change the queue/scheduler for a device containing an ext4 filesy=
stem
very rarely causes other processes which are using the filesystem to hang.

This is running inside qemu.  Using 'crash' I was able to get a stack trace
from a couple of hanging processes (from different VM instances):

crash> set 230
    PID: 230
COMMAND: "modprobe"
   TASK: ffff98ce03ca3040  [THREAD_INFO: ffff98ce03ca3040]
    CPU: 0
  STATE: TASK_UNINTERRUPTIBLE=20
crash> bt
PID: 230      TASK: ffff98ce03ca3040  CPU: 0    COMMAND: "modprobe"
 #0 [ffffaf9940307840] __schedule at ffffffff9618f6d0
 #1 [ffffaf99403078f8] schedule at ffffffff96190a27
 #2 [ffffaf9940307908] __bio_queue_enter at ffffffff957e121c
 #3 [ffffaf9940307968] blk_mq_submit_bio at ffffffff957f358c
 #4 [ffffaf99403079f0] __submit_bio at ffffffff957e1e3c
 #5 [ffffaf9940307a58] submit_bio_noacct_nocheck at ffffffff957e2326
 #6 [ffffaf9940307ac0] ext4_mpage_readpages at ffffffff955ceafc
 #7 [ffffaf9940307be0] read_pages at ffffffff95381d1a
 #8 [ffffaf9940307c40] page_cache_ra_unbounded at ffffffff95381ff5
 #9 [ffffaf9940307ca8] filemap_fault at ffffffff953761b5
#10 [ffffaf9940307d48] __do_fault at ffffffff953d1895
#11 [ffffaf9940307d70] do_fault at ffffffff953d2425
#12 [ffffaf9940307da0] __handle_mm_fault at ffffffff953d8c6b
#13 [ffffaf9940307e88] handle_mm_fault at ffffffff953d95c2
#14 [ffffaf9940307ec8] do_user_addr_fault at ffffffff950b34ea
#15 [ffffaf9940307f28] exc_page_fault at ffffffff96186e4e
#16 [ffffaf9940307f50] asm_exc_page_fault at ffffffff962012a6
    RIP: 0000556b7a7468d8  RSP: 00007ffde2ffb560  RFLAGS: 00000206
    RAX: 00000000000bec82  RBX: 00007f5331a0dc82  RCX: 0000556b7a75b92a
    RDX: 00007ffde2ffd8d0  RSI: 00000000200bec82  RDI: 0000556ba8edf960
    RBP: 00007ffde2ffb7c0   R8: 0000000000000000   R9: 0000000000000000
    R10: 0000000000000000  R11: 0000000000000202  R12: 00000000200bec82
    R13: 0000556ba8edf960  R14: 00007ffde2ffd8d0  R15: 0000556b7a760708
    ORIG_RAX: ffffffffffffffff  CS: 0033  SS: 002b

crash> set 234
    PID: 234
COMMAND: "modprobe"
   TASK: ffff9f5ec3a22f40  [THREAD_INFO: ffff9f5ec3a22f40]
    CPU: 0
  STATE: TASK_UNINTERRUPTIBLE=20
crash> bt
PID: 234      TASK: ffff9f5ec3a22f40  CPU: 0    COMMAND: "modprobe"
 #0 [ffffb21e002e7840] __schedule at ffffffffa718f6d0
 #1 [ffffb21e002e78f8] schedule at ffffffffa7190a27
 #2 [ffffb21e002e7908] __bio_queue_enter at ffffffffa67e121c
 #3 [ffffb21e002e7968] blk_mq_submit_bio at ffffffffa67f358c
 #4 [ffffb21e002e79f0] __submit_bio at ffffffffa67e1e3c
 #5 [ffffb21e002e7a58] submit_bio_noacct_nocheck at ffffffffa67e2326
 #6 [ffffb21e002e7ac0] ext4_mpage_readpages at ffffffffa65ceafc
 #7 [ffffb21e002e7be0] read_pages at ffffffffa6381d17
 #8 [ffffb21e002e7c40] page_cache_ra_unbounded at ffffffffa6381ff5
 #9 [ffffb21e002e7ca8] filemap_fault at ffffffffa63761b5
#10 [ffffb21e002e7d48] __do_fault at ffffffffa63d1892
#11 [ffffb21e002e7d70] do_fault at ffffffffa63d2425
#12 [ffffb21e002e7da0] __handle_mm_fault at ffffffffa63d8c6b
#13 [ffffb21e002e7e88] handle_mm_fault at ffffffffa63d95c2
#14 [ffffb21e002e7ec8] do_user_addr_fault at ffffffffa60b34ea
#15 [ffffb21e002e7f28] exc_page_fault at ffffffffa7186e4e
#16 [ffffb21e002e7f50] asm_exc_page_fault at ffffffffa72012a6
    RIP: 000055d16159f8d8  RSP: 00007ffdd4c1f340  RFLAGS: 00010206
    RAX: 00000000000bec82  RBX: 00007ff2fd00dc82  RCX: 000055d1615b492a
    RDX: 00007ffdd4c216b0  RSI: 00000000200bec82  RDI: 000055d185725960
    RBP: 00007ffdd4c1f5a0   R8: 0000000000000000   R9: 0000000000000000
    R10: 0000000000000000  R11: 0000000000000202  R12: 00000000200bec82
    R13: 000055d185725960  R14: 00007ffdd4c216b0  R15: 000055d1615b9708
    ORIG_RAX: ffffffffffffffff  CS: 0033  SS: 002b

The hanging process was modprobe both times.  I don't know if that is
significant.

Note that "noop" is not actually a valid scheduler (for about 10 years)!  We
still observe this hang even when setting it to this impossible value.

# echo noop > /sys/block/sda/queue/scheduler
/init: line 108: echo: write error: Invalid argument

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

