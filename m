Return-Path: <linux-ext4+bounces-12613-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C72CFE679
	for <lists+linux-ext4@lfdr.de>; Wed, 07 Jan 2026 15:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64281303928B
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jan 2026 14:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD833559F3;
	Wed,  7 Jan 2026 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="gXe9vL29"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACEF35580A;
	Wed,  7 Jan 2026 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797398; cv=pass; b=lby1nhqZdstAZ/phwJ3gzqTUeYkuWG/ZI4FVR4nyeBMQr0oi26CPe5joY82RsUXLwOsOCAelqCqS91pO9dpRZ7qWzmY0BacJB2XtiGmAL84LzigzaRwQl1cqRQZVOZb15TYiV4UoeNezRUSrVatMiyi42whra0qYjH6kYIOZFaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797398; c=relaxed/simple;
	bh=kxf6RgPUDEzyLHExuLuWh395GVrp8PSxUatRtPeZDq0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=OAC1VlUZXPiezmCywxXCgeSBsgDdMKD5lp3X1SC9iIw9+/G//mVV+3w/4y1RwIkvDif8fNZ1KGUaDQtORILJg8cDG9h6xleLctfKIcYVPjI2Z8IF7gQZwl8NdfCaR83Lg0M5vSU0G7i7ngEw06llwtTVoe8oolWNhWRNrfFfe0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=gXe9vL29; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1767797390; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XsM0WW2X9r6AuOvFtqKwapjuk0MUzsUnXLB4Fi+BQHS7JNRs0Tk2zMBktX8Y8Vwn9UTR9lQx/nqnbId2Svp9ZORdAj6kSkACPeiOp/5sid1YV0qrd0ZKb4BdRmtoMqTTWt3gJe5M9Oc/cBfJNXQS+cCrH/6v+qQgOR9l1GS1BBA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767797390; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RV2C6zZkYlRB7AZkGl5bnLNBi4MBqqbt8Yb/4nAYTsg=; 
	b=ItxsXZ+s+rAuLMXDfT70O1iAvhsNY+fhwwRT7yNmdbGSZP29izwf5IwJ1S66YInjm2x2QtK3Pwf1Dmf6k2mwXfW9NAEyvE99byRCHtdPVCIH5ZU8+Alod8ARJYg0sBGyz1z4P9u2tdi67CZ13/NTEmpTEHEBEtIt6D56fWxH5wA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767797390;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=RV2C6zZkYlRB7AZkGl5bnLNBi4MBqqbt8Yb/4nAYTsg=;
	b=gXe9vL29V3reSg4p3Tde3exeCRrfgs1qj5VtQoIGQLS8U+f0tesZSfQxR7uegRM3
	+GXhhMT1GAWuBMHU9niFMb4GFcJDU5d+o0VSLVuinr/XdFaodjie9dxyOBJ0n40tst5
	XgItiUSEqErA8UEUdQn4UHFLAEN3JFyEzh5Oejs8=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1767797388375333.89263016081657; Wed, 7 Jan 2026 06:49:48 -0800 (PST)
Date: Wed, 07 Jan 2026 22:49:48 +0800
From: Li Chen <me@linux.beauty>
To: "Jan Kara" <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	"Andreas Dilger" <adilger.kernel@dilger.ca>,
	"linux-ext4" <linux-ext4@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"stable" <stable@vger.kernel.org>
Message-ID: <19b98ef7441.2e449c605279413.2845425093226852052@linux.beauty>
In-Reply-To: <4jxwogttddiaoqbstlgou5ox6zs27ngjjz5ukrxafm2z5ijxod@so4eqnykiegj>
References: <20251226050220.138194-1-me@linux.beauty> <4jxwogttddiaoqbstlgou5ox6zs27ngjjz5ukrxafm2z5ijxod@so4eqnykiegj>
Subject: Re: [PATCH] ext4: publish jinode after initialization
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Jan

Thanks a lot for your detailed review!

 ---- On Wed, 07 Jan 2026 02:06:53 +0800  Jan Kara <jack@suse.cz> wrote ---=
=20
 > On Fri 26-12-25 13:02:20, Li Chen wrote:
 > > ext4_inode_attach_jinode() publishes ei->jinode to concurrent users.
 > > It assigned ei->jinode before calling jbd2_journal_init_jbd_inode().
 > >=20
 > > This allows another thread to observe a non-NULL jinode with i_vfs_ino=
de
 > > still unset. The fast commit flush path can then pass this jinode to
 > > jbd2_wait_inode_data(), which dereferences i_vfs_inode->i_mapping and =
may
 > > crash.
 > >=20
 > > Below is the crash I observe:
 > > ```
 > > BUG: unable to handle page fault for address: 000000010beb47f4
 > > PGD 110e51067 P4D 110e51067 PUD 0
 > > Oops: Oops: 0000 [#1] SMP NOPTI
 > > CPU: 1 UID: 0 PID: 4850 Comm: fc_fsync_bench_ Not tainted 6.18.0-00764=
-g795a690c06a5 #1 PREEMPT(voluntary)
 > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux=
 1.17.0-2-2 04/01/2014
 > > RIP: 0010:xas_find_marked+0x3d/0x2e0
 > > Code: e0 03 48 83 f8 02 0f 84 f0 01 00 00 48 8b 47 08 48 89 c3 48 39 c=
6 0f 82 fd 01 00 00 48 85 c9 74 3d 48 83 f9 03 77 63 4c 8b 0f <49> 8b 71 08=
 48 c7 47 18 00 00 00 00 48 89 f1 83 e1 03 48 83 f9 02
 > > RSP: 0018:ffffbbee806e7bf0 EFLAGS: 00010246
 > > RAX: 000000000010beb4 RBX: 000000000010beb4 RCX: 0000000000000003
 > > RDX: 0000000000000001 RSI: 0000002000300000 RDI: ffffbbee806e7c10
 > > RBP: 0000000000000001 R08: 0000002000300000 R09: 000000010beb47ec
 > > R10: ffff9ea494590090 R11: 0000000000000000 R12: 0000002000300000
 > > R13: ffffbbee806e7c90 R14: ffff9ea494513788 R15: ffffbbee806e7c88
 > > FS:  00007fc2f9e3e6c0(0000) GS:ffff9ea6b1444000(0000) knlGS:0000000000=
000000
 > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 > > CR2: 000000010beb47f4 CR3: 0000000119ac5000 CR4: 0000000000750ef0
 > > PKRU: 55555554
 > > Call Trace:
 > >  <TASK>
 > >  filemap_get_folios_tag+0x87/0x2a0
 > >  __filemap_fdatawait_range+0x5f/0xd0
 > >  ? srso_alias_return_thunk+0x5/0xfbef5
 > >  ? __schedule+0x3e7/0x10c0
 > >  ? srso_alias_return_thunk+0x5/0xfbef5
 > >  ? srso_alias_return_thunk+0x5/0xfbef5
 > >  ? srso_alias_return_thunk+0x5/0xfbef5
 > >  ? preempt_count_sub+0x5f/0x80
 > >  ? srso_alias_return_thunk+0x5/0xfbef5
 > >  ? cap_safe_nice+0x37/0x70
 > >  ? srso_alias_return_thunk+0x5/0xfbef5
 > >  ? preempt_count_sub+0x5f/0x80
 > >  ? srso_alias_return_thunk+0x5/0xfbef5
 > >  filemap_fdatawait_range_keep_errors+0x12/0x40
 > >  ext4_fc_commit+0x697/0x8b0
 > >  ? ext4_file_write_iter+0x64b/0x950
 > >  ? srso_alias_return_thunk+0x5/0xfbef5
 > >  ? preempt_count_sub+0x5f/0x80
 > >  ? srso_alias_return_thunk+0x5/0xfbef5
 > >  ? vfs_write+0x356/0x480
 > >  ? srso_alias_return_thunk+0x5/0xfbef5
 > >  ? preempt_count_sub+0x5f/0x80
 > >  ext4_sync_file+0xf7/0x370
 > >  do_fsync+0x3b/0x80
 > >  ? syscall_trace_enter+0x108/0x1d0
 > >  __x64_sys_fdatasync+0x16/0x20
 > >  do_syscall_64+0x62/0x2c0
 > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 > > ...
 > > ```
 > >=20
 > > To fix this issue, initialize the jbd2_inode first and only then publi=
sh
 > > the pointer with smp_store_release(). Use smp_load_acquire() at the re=
ad
 > > sites to pair with the release and ensure the initialized fields are v=
isible.
 > >=20
 > > On x86 (TSO), the crash should primarily be due to the logical early p=
ublish
 > > window (another CPU can run between the store and initialization). x86
 > > also relies on compiler ordering; the acquire/release helpers include
 > > the necessary compiler barriers while keeping the fast-path cheap.
 > >=20
 > > On weakly-ordered architectures (e.g. arm64/ppc), plain "init; store p=
tr"
 > > is not sufficient: without release/acquire, a reader may observe the
 > > pointer while still missing prior initialization stores. The explicit
 > > pairing makes this publish/consume relationship correct under LKMM.
 > >=20
 > > Fixes: a361293f5fede ("jbd2: Fix oops in jbd2_journal_file_inode()")
 > > Cc: stable@vger.kernel.org
 > > Signed-off-by: Li Chen <me@linux.beauty>
 >=20
 > Thanks for the analysis and the patch. I think using smp_load_acquire() =
for
 > reading EXT4_I(inode)->jinode is a bit of an overkill since all we care
 > about is that EXT4_I(inode)->jinode->foo loads see the initialized conte=
nt
 > of jinode. So it should be enough to just do smp_wmb() between inode
 > initialization and setting of EXT4_I(inode)->jinode and then use
 > READ_ONCE() to read EXT4_I(inode)->jinode, shouldn't it?

Agreed. I'll do it in this way in next version.
=20
 > Also I think the problem, in particular with fastcommit code, goes furth=
er
 > than just the initialization. Generally jbd2_inode is modified under
 > journal->j_list_lock however readers such as jbd2_submit_inode_data() or
 > jbd2_wait_inode_data() and respective filesystem implementations
 > ocfs2_journal_submit_inode_data_buffers() and
 > ext4_journal_submit_inode_data_buffers() don't hold j_list_lock when
 > reading fields from jbd2_inode. So we should be using READ_ONCE /
 > WRITE_ONCE for reading / updating jbd2_inode. But thinking about it that=
's
 > a separate problem so let's deal with the init issues first.
=20
Makes sense. For this patch I'd still focus only on the
publish-before-init window. And I would try to convert the lockless jbd2_in=
ode field reads
to READ_ONCE/WRITE_ONCE in another patchset.

Regards,
Li=E2=80=8B


