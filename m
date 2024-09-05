Return-Path: <linux-ext4+bounces-4056-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4971996D360
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 11:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06E11F29F98
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 09:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88035197A68;
	Thu,  5 Sep 2024 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8FWTr4q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B401196D8F
	for <linux-ext4@vger.kernel.org>; Thu,  5 Sep 2024 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528772; cv=none; b=IkRlwR+CReaArnZXHhPXLgOiD2GSI0PyGurf4mfNOkQf7pWL+2Ne7rb59cY9lOnxGegRm9sV1lM/IrPskCPYGy7Tufm0tHtOoQDMPRmyZf14L2AsujoFOFYnbRBTJ/8Cd3+3QmBLfBYhq85oAbrrUMPM0a2/4HTNsawUUVOUaQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528772; c=relaxed/simple;
	bh=eag3z5buF79/z0D2T9XkK/vTuPXG5QF1j/YOk+tTtA8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XXCOuczYc16QzDHbLptIbefcXDvlnX1drD9S7xcSjOaUSSxwqdj6s08FeFQpz6PD9pL6koP1OKyASCQns3/Njpt+FLZOjSVI/F5bRRUGEhjP/4bZ6irIOm7G3Ea5rB2palSyYxBpkWwPX8QZoY7nNarZOrZ7NlHTaWL0/hrqXrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8FWTr4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C860C4CEC3
	for <linux-ext4@vger.kernel.org>; Thu,  5 Sep 2024 09:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725528771;
	bh=eag3z5buF79/z0D2T9XkK/vTuPXG5QF1j/YOk+tTtA8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=F8FWTr4qScdsyS+djdkptnPGw4qjzbgapHJEOyGiDfO2e+McfvP1Hc4D1bq3h1EtS
	 623CluhPQpQfK7gaQmHYk4X9frmrSe7VvdXzR3JOvg7PHtQ1seACeLxRHV1rHd4IMj
	 BlETpmWxHIUqbCy5Zoh/jK4ltRdOqxPbb37r5TalKewOJP0yBG2VIaW8jLu/VFxDIG
	 b/0iaVo3AkjtwyDofPsbISXFmwR6HSy4k+fmMDckSmomHlFp86+CfzRi+efAKfCTg2
	 mKFkKzkBfDSMlm3EUeSXkq4RZ0RAWZSNPLw14kZCj+HgdlO01N4MfbmkVYtvhdt8MA
	 XSx/6ClMvXZcQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8A63FC53BC4; Thu,  5 Sep 2024 09:32:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] occasional block layer hang when setting 'echo noop >
 /sys/block/sda/queue/scheduler'
Date: Thu, 05 Sep 2024 09:32:51 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219166-13602-CwLQ6nAqGv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219166-13602@https.bugzilla.kernel.org/>
References: <bug-219166-13602@https.bugzilla.kernel.org/>
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

--- Comment #13 from Richard W.M. Jones (rjones@redhat.com) ---
To document for myself and others what I did to reproduce the bug and get t=
he
kernel stack trace ...

(1) libguestfs from git with this patch reverted:
https://github.com/libguestfs/libguestfs/commit/b2d682a4730ead8b4ae07e5aaf6=
fa230c5eec305

(2) Run guestfish in a loop until it hangs:

$ while LIBGUESTFS_BACKEND_SETTINGS=3Dforce_tcg ./run guestfish -a /dev/nul=
l run
-vx >& /tmp/log ; do echo -n . ; done


(3) Looking /tmp/log we can see it hung just after trying to set noop
scheduler:

$ tail -5 /tmp/log
+ echo 300
+ for f in /sys/block/sd*/device/timeout
+ echo 300
+ for f in /sys/block/{h,s,ub,v}d*/queue/scheduler
+ echo noop

(4) Check the log for the kernel version, install the corresponding kernel
debuginfo.

(5) Get virsh to produce a core dump of the VM:

$ virsh list=20
 Id     Name                       State
--------------------------------------------
 1950   guestfs-lsdbxy71u4jg1w6x   running

$ virsh dump 1950 /var/tmp/core --memory-only

Domain '1950' dumped to /var/tmp/core

(6) Open in 'crash':

$ crash
/usr/lib/debug/lib/modules/6.11.0-0.rc5.20240830git20371ba12063.47.fc42.x86=
_64/vmlinux
/var/tmp/core

(7) List processes and find the one which hung:

crash> ps=20
...
      230      73   0  ffffa01f83c58000  UN   0.3    11608     3340  modpro=
be

(8) Get stack trace from the hung process:

crash> set 230
    PID: 230
COMMAND: "modprobe"
   TASK: ffffa01f83c58000  [THREAD_INFO: ffffa01f83c58000]
    CPU: 0
  STATE: TASK_UNINTERRUPTIBLE=20
crash> bt
PID: 230      TASK: ffffa01f83c58000  CPU: 0    COMMAND: "modprobe"
 #0 [ffffc1db0030f840] __schedule at ffffffff921906d0
 #1 [ffffc1db0030f8f8] schedule at ffffffff92191a27
 #2 [ffffc1db0030f908] __bio_queue_enter at ffffffff917e17dc
 #3 [ffffc1db0030f968] blk_mq_submit_bio at ffffffff917f3b4c
 #4 [ffffc1db0030f9f0] __submit_bio at ffffffff917e23fc
 #5 [ffffc1db0030fa58] submit_bio_noacct_nocheck at ffffffff917e28e6
 #6 [ffffc1db0030fac0] ext4_mpage_readpages at ffffffff915cef7c
 #7 [ffffc1db0030fbe0] read_pages at ffffffff91381cda
 #8 [ffffc1db0030fc40] page_cache_ra_unbounded at ffffffff91381fb5
 #9 [ffffc1db0030fca8] filemap_fault at ffffffff91376175
#10 [ffffc1db0030fd48] __do_fault at ffffffff913d1755
#11 [ffffc1db0030fd70] do_fault at ffffffff913d22e5
#12 [ffffc1db0030fda0] __handle_mm_fault at ffffffff913d8b2b
#13 [ffffc1db0030fe88] handle_mm_fault at ffffffff913d9472
#14 [ffffc1db0030fec8] do_user_addr_fault at ffffffff910b34ea
#15 [ffffc1db0030ff28] exc_page_fault at ffffffff92187e4e
#16 [ffffc1db0030ff50] asm_exc_page_fault at ffffffff922012a6
    RIP: 000055bb085508d8  RSP: 00007ffc3e731900  RFLAGS: 00010206
    RAX: 00000000000becd6  RBX: 00007f39925d1cd6  RCX: 000055bb0856592a
    RDX: 00007ffc3e733c70  RSI: 00000000200becd6  RDI: 000055bb1a712970
    RBP: 00007ffc3e731b60   R8: 0000000000000000   R9: 0000000000000000
    R10: 0000000000000000  R11: 0000000000000202  R12: 00000000200becd6
    R13: 000055bb1a712970  R14: 00007ffc3e733c70  R15: 000055bb0856a708
    ORIG_RAX: ffffffffffffffff  CS: 0033  SS: 002b

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

