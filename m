Return-Path: <linux-ext4+bounces-17-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0CD7ED766
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Nov 2023 23:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3187BB20BC4
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Nov 2023 22:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA10D41E4E;
	Wed, 15 Nov 2023 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7ZwYF4H"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C043AA1
	for <linux-ext4@vger.kernel.org>; Wed, 15 Nov 2023 22:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEB4FC433CC
	for <linux-ext4@vger.kernel.org>; Wed, 15 Nov 2023 22:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700087979;
	bh=X8IT44gkZghiclCsG43Yvw+G2sSy5rcgHaYLnZ4IvBc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=A7ZwYF4HIvwjq/M7gAWjdUdzBaRQG5AMK5vqWXpPF14JeT16lwWFfNFU5u6LidRej
	 I4YD6f1U7OQfHcRyVaupbDRdM5BGUY9aFfdeUhxb2jR17srojXZjSmy0mWDY+IqV4o
	 fSl7VmBDSck0QfbldQCynkEX44+/zK+wIl1qM3w1ocOYOZ0O1zGgsFJ6nw2JdXZMyd
	 Fx2V+kRm1Z8OMVqrWqVuFiUXqIhD2UqlsyAoAm9D2XlhEa2wOHU6j37SobtTVpBxyn
	 gAZIuwvUk1GyWPvm61fBAljsFH3JPGtnc1NLk+7n4mhjjKRrZ2y8niXuKq+iJUE7xa
	 wC1nnYnQVSIDg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CE412C4332E; Wed, 15 Nov 2023 22:39:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Wed, 15 Nov 2023 22:39:39 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@eyal.emu.id.au
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-tWzo0214Oi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #26 from Eyal Lebedinsky (bugzilla@eyal.emu.id.au) ---
Ojaswin,

For my understanding: the (dirty) buffers hold data blocks that need to be
written. Clearing dirty buffers does not include fs activity,
which was already performed during the copy. Is this correct? If so then why
are we talking about ext4?
    I expect that my understanding is incorrect.
The copy itself is very fast, completing in a few seconds.

I assume that the requested mount option is safe. Is it safe to use this way
   $ sudo mount -o remount,nodelalloc /data1
or should I also add the other current options, 'noatime' (from fstab) and
'stripe=3D640' (automatic)?
or should I reboot with this option in fstab?

Below is what I did now, is this what you need?

$ sudo perf record -p 1366946 sleep 60
[ perf record: Woken up 37 times to write data ]
[ perf record: Captured and wrote 9.079 MB perf.data (237339 samples) ]

$ sudo perf report --no-children --stdio -i perf.data
# To display the perf.data header info, please use --header/--header-only
options.
#
#
# Total Lost Samples: 0
#
# Samples: 237K of event 'cycles:P'
# Event count (approx.): 258097341907
#
# Overhead  Command          Shared Object      Symbol=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
# ........  ...............  .................=20
..........................................
#
    53.90%  kworker/u16:4+f  [kernel.kallsyms]  [k] ext4_mb_good_group
    13.71%  kworker/u16:4+f  [kernel.kallsyms]  [k] ext4_get_group_info
     7.39%  kworker/u16:4+f  [kernel.kallsyms]  [k]
ext4_mb_find_good_group_avg_frag_lists
     6.96%  kworker/u16:4+f  [kernel.kallsyms]  [k] __rcu_read_unlock
     5.01%  kworker/u16:4+f  [kernel.kallsyms]  [k] ext4_mb_scan_aligned
     4.51%  kworker/u16:4+f  [kernel.kallsyms]  [k] __rcu_read_lock
     1.70%  kworker/u16:4+f  [kernel.kallsyms]  [k] mb_find_order_for_block
     0.89%  kworker/u16:4+f  [kernel.kallsyms]  [k] xas_descend
     0.85%  kworker/u16:4+f  [kernel.kallsyms]  [k] filemap_get_entry
     0.81%  kworker/u16:4+f  [kernel.kallsyms]  [k] ext4_mb_regular_allocat=
or
     0.77%  kworker/u16:4+f  [kernel.kallsyms]  [k] ext4_mb_load_buddy_gfp
     0.54%  kworker/u16:4+f  [kernel.kallsyms]  [k] xas_load
     0.50%  kworker/u16:4+f  [kernel.kallsyms]  [k] ext4_mb_unload_buddy
     0.42%  kworker/u16:4+f  [kernel.kallsyms]  [k] _raw_read_unlock
     0.40%  kworker/u16:4+f  [kernel.kallsyms]  [k] mb_find_extent
     0.40%  kworker/u16:4+f  [kernel.kallsyms]  [k] _raw_spin_trylock
     0.25%  kworker/u16:4+f  [kernel.kallsyms]  [k] __filemap_get_folio
     0.24%  kworker/u16:4+f  [kernel.kallsyms]  [k] _raw_read_lock
     0.13%  kworker/u16:4+f  [kernel.kallsyms]  [k] xas_start
     0.12%  kworker/u16:4+f  [kernel.kallsyms]  [k] mb_find_buddy
     0.10%  kworker/u16:4+f  [kernel.kallsyms]  [k] pagecache_get_page
     0.08%  kworker/u16:4+f  [kernel.kallsyms]  [k] folio_mark_accessed
     0.05%  kworker/u16:4+f  [kernel.kallsyms]  [k] folio_test_hugetlb
     0.04%  kworker/u16:4+f  [kernel.kallsyms]  [k] _raw_spin_unlock
     0.02%  kworker/u16:4+f  [kernel.kallsyms]  [k] __cond_resched
     0.02%  kworker/u16:4+f  [kernel.kallsyms]  [k]
perf_adjust_freq_unthr_context
     0.01%  kworker/u16:4+f  [kernel.kallsyms]  [k] gen8_irq_handler
     0.01%  kworker/u16:4+f  [kernel.kallsyms]  [k] _raw_spin_lock
     0.01%  kworker/u16:4+f  [kernel.kallsyms]  [k] native_irq_return_iret
     0.01%  kworker/u16:4+f  [kernel.kallsyms]  [k] native_write_msr
     0.01%  kworker/u16:4+f  [kernel.kallsyms]  [k] timekeeping_advance
     0.01%  kworker/u16:4+f  [kernel.kallsyms]  [k] _raw_spin_lock_irqsave
     0.01%  kworker/u16:4+f  [kernel.kallsyms]  [k] native_read_msr
<then many zero% items>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

