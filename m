Return-Path: <linux-ext4+bounces-3063-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6A291EABB
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jul 2024 00:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0331F21B27
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Jul 2024 22:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3FE8120F;
	Mon,  1 Jul 2024 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="g5SujC8u"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40CD4F602
	for <linux-ext4@vger.kernel.org>; Mon,  1 Jul 2024 22:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719871984; cv=none; b=l15I4wdg6XgMdzwdFmqRov1LM6lYTMkeTwHDtnWW+sKXs6Ws92XOed/Im/4bBCMNbUguJfz4T0Ikywr8b8TbCRtxvzLT1DDreY3wruCo0tcRsQBG3tdTPfevoSrRETTr47xHMkqNY9VSGKpfCQQZYg2X+E/P9X7+mmk7hgxSQRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719871984; c=relaxed/simple;
	bh=q381FDqHt5nOkVTGzJnmEwa7fO2YngB05ooRZLlGP48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlejgWKf4ZWMgmtzRKxb46Sfoe/ZXio3uGBpSeWuJtPu+8pUhthJoZPwD1yrKryfc0KsXER/6nk3Pf+3X0x3s20g7AWMHxTtdhnC3VCj3VrV0czpi06CmSx3se/7oSRaXXdQHB44/GiOLtSug2dO2EjtCNWicaZDi+CO8+XWlcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=g5SujC8u; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-17.bstnma.fios.verizon.net [173.48.115.17])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 461M8b0a020819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 18:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1719871718; bh=e1aD09QeNlcHoNu4/jTwuyH61FI08y4yfqXcvNe4YHA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=g5SujC8uPDvWyTuF8Fd8svyV+egf0hTROnPD3FavU38xXRMvILfg85HDC70XLdrZE
	 PVCEXGja7s7Xv3eiK+77hMDtICsO/wJDLK4p1hDr0GEjmhKx9Oq+tfMNtAA5nR/j9E
	 HWiCMi3IIro6x0+4FxUXkhzlFDKAxBXUCYjIyGoCtd3s22f9cGowqKNnD6uZQRuYD9
	 +rwdDw40WXSMD+wWKbddq7mLGBoNdxRMl9dFHTI0zL1U9ox79+NYHTb0EiTTJ+yM5D
	 NT1wYGYnwW7NPQyCrSnK46Yk9YslFMarCUqOOXQfGhcsbn3IDARJb8Oy+lcolfqvCm
	 iKEIp4rkmMfLA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 0F15115C0269; Mon, 01 Jul 2024 18:08:37 -0400 (EDT)
Date: Mon, 1 Jul 2024 18:08:37 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, saukad@google.com, harshads@google.com
Subject: Re: [PATCH v6 02/10] ext4: for committing inode, make
 ext4_fc_track_inode wait
Message-ID: <20240701220837.GD419129@mit.edu>
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
 <20240529012003.4006535-3-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529012003.4006535-3-harshadshirwadkar@gmail.com>

On Wed, May 29, 2024 at 01:19:55AM +0000, Harshad Shirwadkar wrote:
> If the inode that's being requested to track using ext4_fc_track_inode
> is being committed, then wait until the inode finishes the
> commit. Also, add calls to ext4_fc_track_inode at the right places.
> 
> With this patch, now calling ext4_reserve_inode_write() results in
> inode being tracked for next fast commit. A subtle lock ordering
> requirement with i_data_sem (which is documented in the code) requires
> that ext4_fc_track_inode() be called before grabbing i_data_sem. So,
> this patch also adds explicit ext4_fc_track_inode() calls in places
> where i_data_sem grabbed.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

I tried applying this patchset to both the current ext4/dev branch as
well as on to 6.10-rc5, and generic/241 is triggering large series of
WARNINGS followed by a BUG (or in some cases, a soft lockup).  A
bisection leads me to this patch.

The WARN stack trace:

[    4.061189] ------------[ cut here ]------------
[    4.061848] WARNING: CPU: 1 PID: 2627 at fs/ext4/fast_commit.c:259 ext4_fc_del+0x7d/0x190
[    4.062919] CPU: 1 PID: 2627 Comm: dbench Not tainted 6.10.0-rc5-xfstests-00033-gb6f5b0076b56 #350
[    4.064070] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    4.065077] RIP: 0010:ext4_fc_del+0x7d/0x190
[    4.065404] Code: 0f 84 f0 00 00 00 48 8b 83 48 ff ff ff 48 0f ba e0 2a 73 18 48 8b 43 28 48 8b 80 90 03 00 00 48 8b 80 80 00 00 00 a8 02 75 02 <0f> 0b 48 89 ef e8 09 ad 68 00 84 c0 74 0f 48 8b 53 98 48 8b 43 a0
[    4.066190] RSP: 0018:ffffc90003707d98 EFLAGS: 00010246
[    4.066415] RAX: 0000000000000001 RBX: ffff888013de5c08 RCX: 0000000000000000
[    4.066718] RDX: 0000000000000001 RSI: 00000000ffffffff RDI: ffff88800a22c7f0
[    4.067019] RBP: ffff888013de5ba0 R08: ffffffff827fc6fe R09: ffff888008bed000
[    4.067323] R10: 0000000000000008 R11: 000000000000001e R12: ffff88800a22c7f0
[    4.067629] R13: ffff88800a22c000 R14: ffff888013de5b90 R15: ffff88800ac0c000
[    4.067935] FS:  00007fec79a4e740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[    4.068281] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.068530] CR2: 000055d2f34b87e8 CR3: 000000000f492003 CR4: 0000000000770ef0
[    4.068834] PKRU: 55555554
[    4.068952] Call Trace:
[    4.069061]  <TASK>
[    4.069158]  ? __warn+0x7b/0x120
[    4.069338]  ? ext4_fc_del+0x7d/0x190
[    4.069497]  ? report_bug+0x174/0x1c0
[    4.069655]  ? handle_bug+0x3a/0x70
[    4.069809]  ? exc_invalid_op+0x17/0x70
[    4.069975]  ? asm_exc_invalid_op+0x1a/0x20
[    4.070156]  ? ext4_fc_del+0x7d/0x190
[    4.070309]  ? ext4_fc_del+0x44/0x190
[    4.070468]  ext4_clear_inode+0x12/0xb0
[    4.070636]  ext4_free_inode+0x86/0x5a0
[    4.070802]  ext4_evict_inode+0x457/0x6b0
[    4.070976]  evict+0xcd/0x1d0
[    4.071114]  do_unlinkat+0x2de/0x330
[    4.071271]  __x64_sys_unlink+0x23/0x30
[    4.071436]  do_syscall_64+0x4b/0x110
[    4.071596]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    4.071812] RIP: 0033:0x7fec79b4aa07
[    4.071969] Code: f0 ff ff 73 01 c3 48 8b 0d f6 83 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c9 83 0d 00 f7 d8 64 89 01 48
[    4.072760] RSP: 002b:00007ffed55de918 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
[    4.073081] RAX: ffffffffffffffda RBX: 00007ffed55dedb0 RCX: 00007fec79b4aa07
[    4.073429] RDX: 0000000000000000 RSI: 00007ffed55dedb0 RDI: 00007ffed55dedb0
[    4.073733] RBP: 000055d2f34a37f0 R08: 0fffffffffffffff R09: 0000000000000000
[    4.074033] R10: 0000000000000000 R11: 0000000000000206 R12: 000055d2f34a35d0
[    4.074338] R13: 00007fec79c35000 R14: 0000000000000004 R15: 00007fec79c35050
[    4.074650]  </TASK>
[    4.074747] ---[ end trace 0000000000000000 ]---

And here's the BUG:

[    5.121989] BUG: kernel NULL pointer dereference, address: 00000000000000b8
[    5.122281] #PF: supervisor read access in kernel mode
[    5.122500] #PF: error_code(0x0000) - not-present page
[    5.122717] PGD 0 P4D 0 
[    5.122828] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[    5.123036] CPU: 0 PID: 2629 Comm: dbench Tainted: G        W          6.10.0-rc5-xfstests-00033-gb6f5b0076b56 #350
[    5.123470] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    5.123857] RIP: 0010:ext4_fc_perform_commit+0x303/0x4b0
[    5.124082] Code: fd 48 2d a0 00 00 00 48 39 d3 75 af e9 ac fe ff ff 49 8b 4d 58 49 8d 45 58 48 39 c1 0f 84 9f 01 00 00 49 8b 45 58 49 63 4d 08 <48> 39 88 b8 00 00 00 4c 8d 78 78 0f 85 7f 01 00 00 48 89 ef e8 c4
[    5.124855] RSP: 0018:ffffc90003727df8 EFLAGS: 00010246
[    5.125072] RAX: 0000000000000000 RBX: ffff8880089e5f08 RCX: 00000000089e5f08
[    5.125416] RDX: 0000000000000001 RSI: 0000000000000003 RDI: ffff88800a22c7f0
[    5.125712] RBP: ffff88800a22c7f0 R08: ffff88807dc2fbc0 R09: 0000000000000000
[    5.126009] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88800a22c7c8
[    5.126310] R13: ffff8880089e5f08 R14: ffff88800a22c7a8 R15: ffff88800a22c708
[    5.126609] FS:  00007fec79a4e740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[    5.126943] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.127188] CR2: 00000000000000b8 CR3: 000000000f48e002 CR4: 0000000000770ef0
[    5.127483] PKRU: 55555554
[    5.127598] Call Trace:
[    5.127705]  <TASK>
[    5.127838]  ? __die+0x23/0x60
[    5.127973]  ? page_fault_oops+0xa3/0x160
[    5.128143]  ? exc_page_fault+0x6a/0x160
[    5.128351]  ? asm_exc_page_fault+0x26/0x30
[    5.128530]  ? ext4_fc_perform_commit+0x303/0x4b0
[    5.128728]  ? ext4_fc_perform_commit+0x36b/0x4b0
[    5.128948]  ext4_fc_commit+0x17f/0x300
[    5.129116]  ext4_sync_file+0x1ce/0x380
[    5.129310]  __x64_sys_fsync+0x3b/0x70
[    5.129470]  do_syscall_64+0x4b/0x110
[    5.129627]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    5.129840] RIP: 0033:0x7fec79b4fb10
[    5.129995] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d d1 ba 0d 00 00 74 17 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
[    5.130764] RSP: 002b:00007ffed55de948 EFLAGS: 00000202 ORIG_RAX: 000000000000004a
[    5.131079] RAX: ffffffffffffffda RBX: 00007fec79c35450 RCX: 00007fec79b4fb10
[    5.131381] RDX: 0000000000002b6f RSI: 0000000000002b6f RDI: 0000000000000005
[    5.131681] RBP: 000055d2f34a3660 R08: 1999999999999999 R09: 0000000000000000
[    5.131981] R10: 00007fec79bcdac0 R11: 0000000000000202 R12: 000055d2f34a35d0
[    5.132280] R13: 00007fec79c35450 R14: 0000000000000003 R15: 00007fec79c354a0
[    5.132575]  </TASK>
[    5.132670] CR2: 00000000000000b8
[    5.132812] ---[ end trace 0000000000000000 ]---

Harshad, can you take a look?   Thanks!

						- Ted


