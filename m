Return-Path: <linux-ext4+bounces-2567-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20878C8F5D
	for <lists+linux-ext4@lfdr.de>; Sat, 18 May 2024 04:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9629E282CA1
	for <lists+linux-ext4@lfdr.de>; Sat, 18 May 2024 02:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6032A523A;
	Sat, 18 May 2024 02:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="O8+CIgmL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D7F29AF
	for <linux-ext4@vger.kernel.org>; Sat, 18 May 2024 02:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715999237; cv=none; b=gG0MzgruJYnjTUV4kzZ9aqXm5u/nBtqZPmUcXtBo7AInJq55ZBsuKbYDoKaTptOjEoFrpxFZseAlTBt/6shp9ZV0E4QxxVqse3usdrIJSi258tGW+blA6w0XOETMvFvLs44rxXeoT50FzkwcEvPN+WJeSbcsAA9gGgJmZSdjCr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715999237; c=relaxed/simple;
	bh=QZn3hh/vWFRGq9PVcMq3WbkOsCjPcnQpcs8NOTSohQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XK0kBQOfZk7288EkCxnCYpDErCHfJxroZD8eFKbdn+nSb1OKAbeDWeONmR4SYzTJx+jcgHiwaOC2wfyhr56BNoJ8xOqyFDaP4Ahxury/78ZCz6pUTK4mXu6xeBW5kjKAJSTJlyMjsJdHM3jnGDt+FUfIJJNnHJQaMAz5mQ/jBJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=O8+CIgmL; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44I2QkTg008925
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 22:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715999209; bh=fBNuPesawIQnGyWuvipMnxxc+s1aABzzD9p+pZBeJ/Y=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=O8+CIgmL7yBfXQnXrnpjhdSyeL/lCeyRymgH9AhtYAdfEwXKyNaGtKQ8otOHcrkXN
	 W3xPCPNce46RGFCSbK71snrXZSDJTon9WqJwJ7egwBx3OGtYvMlKZutRMRGqAdAEUx
	 arENHKNliBtUU6eeSV6pQT1OJWHD9ElQEX1OFMFm8fd9dqEbGnYgDK7tiX2i9F87h1
	 fEufGkY/RG7OPgHofHN+5jeaSvE+K+CmEbeTxrMWy+xSNb+9BPpx75SNp52U07NcZS
	 UjPB/e8T9YAIiM4RuDZfyZSTQAkY9C1bAY5L20JPJfj1DywTozIavY9wlk6LLCcrX1
	 3729+ZvrQcJMQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 5248015C00DC; Fri, 17 May 2024 22:26:46 -0400 (EDT)
Date: Fri, 17 May 2024 22:26:46 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: dm-devel@lists.linux.dev, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org, regressions@lists.linux.dev
Cc: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@kernel.org>
Subject: [REGRESSION] dm: use queue_limits_set
Message-ID: <20240518022646.GA450709@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

#regzbot introduced: 1c0e720228ad

While doing final regression testing before sending a pull request for
the ext4 tree, I found a regression which was triggered by generic/347
and generic/405 on on multiple fstests configurations, including
both ext4/4k and xfs/4k.

It bisects cleanly to commit 1c0e720228ad ("dm: use
queue_limits_set"), and the resulting WARNING is attached below.  This
stack trace can be seen for both generic/347 and generic/405.  And if
I revert this commit on top of linux-next, the failure goes away, so
it pretty clearly root causes to 1c0e720228ad.

For now, I'll add generic/347 and generic/405 to my global exclude
file, but maybe we should consider reverting the commit if it can't be
fixed quickly?

Thanks,

      	  	   	  	   	     - Ted

% git show 1c0e720228ad
commit 1c0e720228ad1c63bb487cdcead2558353b5a067
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Feb 28 14:56:42 2024 -0800

    dm: use queue_limits_set
    
    Use queue_limits_set which validates the limits and takes care of
    updating the readahead settings instead of directly assigning them to
    the queue.  For that make sure all limits are actually updated before
    the assignment.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Mike Snitzer <snitzer@kernel.org>
  ...    

% git checkout 1c0e720228ad
% install-kconfig ; kbuild
% kvm-xfstests -c xfs/4k generic/347

BEGIN TEST 4k (1 test): XFS 4k block Fri May 17 22:03:06 EDT 2024
DEVICE: /dev/vdd
XFS_MKFS_OPTIONS: -bsize=4096
XFS_MOUNT_OPTIONS: 
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 kvm-xfstests 6.9.0-rc2-xfstests-00006-g1c0e720228ad #335 SMP PREEMPT_DYNAMIC Fri May 17 22:02:37 EDT 2024
MKFS_OPTIONS  -- -f -bsize=4096 /dev/vdc
MOUNT_OPTIONS -- /dev/vdc /vdc

[    3.179146] XFS (vdd): EXPERIMENTAL online scrub feature in use. Use at your own risk!
generic/347 65s ...  [22:03:06][    3.389241] run fstests generic/347 at 2024-05-17 22:03:06
[    4.032221] ------------[ cut here ]------------
[    4.033087] WARNING: CPU: 1 PID: 30 at drivers/md/dm-bio-prison-v1.c:128 dm_cell_key_has_valid_range+0x3d/0x50
[    4.034871] CPU: 1 PID: 30 Comm: kworker/u8:1 Not tainted 6.9.0-rc2-xfstests-00006-g1c0e720228ad #335
[    4.035440] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    4.035829] Workqueue: dm-thin do_worker
[    4.035998] RIP: 0010:dm_cell_key_has_valid_range+0x3d/0x50
[    4.036236] Code: c1 48 29 d1 48 81 f9 00 04 00 00 77 1d 48 83 e8 01 48 c1 ea 0a b9 01 00 00 00 48 c1 e8 0a 48 39 c2 75 12 89 c8 c3 cc cc cc cc <0f> 0b 31 c9 89 c8 c3 cc cc cc cc 0f 0b 31 c9 eb e8 66 90 90 90 90
[    4.037024] RSP: 0018:ffffc90000107d18 EFLAGS: 00010206
[    4.037249] RAX: 0000000000000fff RBX: 0000000000000000 RCX: 0000000000000fff
[    4.037556] RDX: 0000000000000000 RSI: 0000000000000fff RDI: ffffc90000107d28
[    4.037923] RBP: ffff888009aa7b40 R08: ffff888009aa7bc0 R09: ffff888003e7b980
[    4.038247] R10: 0000000000000008 R11: fefefefefefefeff R12: ffff8880097ca5b8
[    4.038545] R13: 0000000000000fff R14: ffff8880097ca5b8 R15: ffff88800f4fc400
[    4.038843] FS:  0000000000000000(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[    4.039228] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.039472] CR2: 0000564ad92d7c00 CR3: 000000000f73e006 CR4: 0000000000770ef0
[    4.039774] PKRU: 55555554
[    4.039892] Call Trace:
[    4.040000]  <TASK>
`[    4.040094]  ? __warn+0x7b/0x120
[    4.040235]  ? dm_cell_key_has_valid_range+0x3d/0x50
[    4.040473]  ? report_bug+0x174/0x1c0
[    4.040635]  ? handle_bug+0x3a/0x70
[    4.040789]  ? exc_invalid_op+0x17/0x70
[    4.040958]  ? asm_exc_invalid_op+0x1a/0x20
[    4.041163]  ? dm_cell_key_has_valid_range+0x3d/0x50
[    4.041397]  process_discard_bio+0xba/0x190
[    4.041597]  process_thin_deferred_bios+0x290/0x3e0
[    4.041806]  process_deferred_bios+0xba/0x2e0
[    4.041994]  do_worker+0xf5/0x160
[    4.042139]  process_one_work+0x18a/0x3d0
[    4.042311]  worker_thread+0x285/0x3a0
[    4.042470]  ? __pfx_worker_thread+0x10/0x10
[    4.042655]  kthread+0xdd/0x110
[    4.042795]  ? __pfx_kthread+0x10/0x10
[    4.042979]  ret_from_fork+0x31/0x50
[    4.043153]  ? __pfx_kthread+0x10/0x10
[    4.043317]  ret_from_fork_asm+0x1a/0x30
[    4.043490]  </TASK>
[    4.043586] ---[ end trace 0000000000000000 ]---
[    4.043784] device-mapper: thin: Discard doesn't respect bio prison limits
[    4.044142] device-mapper: thin: Discard doesn't respect bio prison limits
[    4.044585] device-mapper: thin: Discard doesn't respect bio prison limits
[    6.410678] device-mapper: thin: 253:2: reached low water mark for data device: sending event.

