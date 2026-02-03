Return-Path: <linux-ext4+bounces-13477-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCaAFbxQgWmLFgMAu9opvQ
	(envelope-from <linux-ext4+bounces-13477-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Feb 2026 02:34:52 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4D1D367E
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Feb 2026 02:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B1483005AB3
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Feb 2026 01:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D8226A0D5;
	Tue,  3 Feb 2026 01:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="kX5Z9Bpu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-e105.zoho.com (sender4-pp-e105.zoho.com [136.143.188.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF981C6FF5;
	Tue,  3 Feb 2026 01:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770082486; cv=pass; b=qdMy0/990VLGj1Xp0V/y/+We/+1gE/DwT2GqQtOY6XXNKZ4gMre6se30GkqvdsX/d6cOxRAD0z3B3QkVv/iXbcQVNxNqOWc78cTVhoq0FXD7EocdMubR7CFfUwhUPBItu1OpKiR7nhBTKvST9J1UDKqG5LUbxAIFgYx/G3qloTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770082486; c=relaxed/simple;
	bh=99GS9KIOxLr1CkshOScx7d1Zv9gxnNPZWMcbl7CHMO8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZMWveEGGYPBTe2KnLS/NUqWd0W9KN5WMmanBKIBy2nTKgJkIY/Z/1m4uimo15hASgd2gwmxqlAB4PFz41FWX9/m1rBCbojzbI5Fp7FY4jOMN6OAJhdL4ti9PlDNbWU86kjc0Jxb1aWg8IfFO7UNodI0klrjbWRHodzIfxlF3iAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=kX5Z9Bpu; arc=pass smtp.client-ip=136.143.188.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1770082479; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IeWd7K4O4tVZ8NEpN2Lj24lft0596jSA8Tb8Kg0m79MhUEK5/G/vs4mgGF5gzsacvA3XH5FrYGG3T+65jH/V6TJrf2C3XGMdDnMpUGf5kdJLrWW//GbpPt6cmxuyhkoMFipW6WWKSSKT29RsOxWjNfwUxKmmRhlrrhP+L4vaEMk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770082479; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7zUDXADVVn4xXHCYi00Bhj/tvJi8O6xIEQAk2OgUBJo=; 
	b=Aoc0Ly9RSk5Q1YHwv6r7l4xeuF3TcsLiHPj1UozdXgybL58H7aWVQl+o6T10TPJw3KEkqIujdjRdd6H6ZIJTdHCcRF8cgnke5TcXyawR5q/nhN66yKvlIOvglew2thErlX9/eSiPdNrbVkFPXGFdjNd9zSS8bADxUACkYOOG5oY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770082479;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7zUDXADVVn4xXHCYi00Bhj/tvJi8O6xIEQAk2OgUBJo=;
	b=kX5Z9BpuEI0qiayi0t1Pb2pk7ecAQcC3Ftr4ASOf+WuNgGQqrIGhGpx50B2//LPD
	DD2TL2mvOQuYUbTJhlnHBwi06biRax2bxEWUrNMCZdgD7DPQ60ApsUI403CzVMluI8K
	ZdVzIXigtGv3r7IsnuSBobLbO8JwZNcpZmTrVNkE=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1770082477725608.9422667049597; Mon, 2 Feb 2026 17:34:37 -0800 (PST)
Date: Tue, 03 Feb 2026 09:34:37 +0800
From: Li Chen <me@linux.beauty>
To: "Jan Kara" <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	"Andreas Dilger" <adilger.kernel@dilger.ca>,
	"linux-ext4" <linux-ext4@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"stable" <stable@vger.kernel.org>
Message-ID: <19c2123268d.3b4188282405127.5032751387094575276@linux.beauty>
In-Reply-To: <vrtwp467z7npa2uppdntauxfzexgaa4vja3nueqdcn7z6e7zll@hj3tjryw2dst>
References: <20260130025339.51519-1-me@linux.beauty> <vrtwp467z7npa2uppdntauxfzexgaa4vja3nueqdcn7z6e7zll@hj3tjryw2dst>
Subject: Re: [PATCH v2] ext4: publish jinode after initialization
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.65 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux.beauty];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13477-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.beauty:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF4D1D367E
X-Rspamd-Action: no action

Hi Jan

 ---- On Tue, 03 Feb 2026 00:37:48 +0800  Jan Kara <jack@suse.cz> wrote ---=
=20
 > On Fri 30-01-26 10:53:38, Li Chen wrote:
 > > ext4_inode_attach_jinode() publishes ei->jinode to concurrent users.
 > > It used to set ei->jinode before jbd2_journal_init_jbd_inode(),
 > > allowing a reader to observe a non-NULL jinode with i_vfs_inode
 > > still unset.
 > >=20
 > > The fast commit flush path can then pass this jinode to
 > > jbd2_wait_inode_data(), which dereferences i_vfs_inode->i_mapping and
 > > may crash.
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
 > > FS: 00007fc2f9e3e6c0(0000) GS:ffff9ea6b1444000(0000) knlGS:00000000000=
00000
 > > CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 > > CR2: 000000010beb47f4 CR3: 0000000119ac5000 CR4: 0000000000750ef0
 > > PKRU: 55555554
 > > Call Trace:
 > > <TASK>
 > > filemap_get_folios_tag+0x87/0x2a0
 > > __filemap_fdatawait_range+0x5f/0xd0
 > > ? srso_alias_return_thunk+0x5/0xfbef5
 > > ? __schedule+0x3e7/0x10c0
 > > ? srso_alias_return_thunk+0x5/0xfbef5
 > > ? srso_alias_return_thunk+0x5/0xfbef5
 > > ? srso_alias_return_thunk+0x5/0xfbef5
 > > ? preempt_count_sub+0x5f/0x80
 > > ? srso_alias_return_thunk+0x5/0xfbef5
 > > ? cap_safe_nice+0x37/0x70
 > > ? srso_alias_return_thunk+0x5/0xfbef5
 > > ? preempt_count_sub+0x5f/0x80
 > > ? srso_alias_return_thunk+0x5/0xfbef5
 > > filemap_fdatawait_range_keep_errors+0x12/0x40
 > > ext4_fc_commit+0x697/0x8b0
 > > ? ext4_file_write_iter+0x64b/0x950
 > > ? srso_alias_return_thunk+0x5/0xfbef5
 > > ? preempt_count_sub+0x5f/0x80
 > > ? srso_alias_return_thunk+0x5/0xfbef5
 > > ? vfs_write+0x356/0x480
 > > ? srso_alias_return_thunk+0x5/0xfbef5
 > > ? preempt_count_sub+0x5f/0x80
 > > ext4_sync_file+0xf7/0x370
 > > do_fsync+0x3b/0x80
 > > ? syscall_trace_enter+0x108/0x1d0
 > > __x64_sys_fdatasync+0x16/0x20
 > > do_syscall_64+0x62/0x2c0
 > > entry_SYSCALL_64_after_hwframe+0x76/0x7e
 > > ...
 > > ```
 > >=20
 > > Fix this by initializing the jbd2_inode first.
 > > Use smp_wmb() and WRITE_ONCE() to publish ei->jinode after
 > > initialization. Readers use READ_ONCE() to fetch the pointer.
 > >=20
 > > Fixes: a361293f5fede ("jbd2: Fix oops in jbd2_journal_file_inode()")
 > > Cc: stable@vger.kernel.org
 > > Signed-off-by: Li Chen <me@linux.beauty>
 >=20
 > Looks pretty good. Some small comments below.
 >=20
 > > ---
 > >=20
 > > Changes since v1:
 > > - Publish EXT4_I(inode)->jinode with smp_wmb() + WRITE_ONCE(), and fet=
ch it
 > >   with READ_ONCE() (instead of smp_store_release()/smp_load_acquire())=
, as
 > >   suggeted by Jan.
 >=20
 > ...=20
 >=20
 > > diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
 > > index 63d17c5201b5..2d5343441b71 100644
 > > --- a/fs/ext4/ext4_jbd2.h
 > > +++ b/fs/ext4/ext4_jbd2.h
 > > @@ -336,18 +336,26 @@ static inline int ext4_journal_force_commit(jour=
nal_t *journal)
 > >  static inline int ext4_jbd2_inode_add_write(handle_t *handle,
 > >          struct inode *inode, loff_t start_byte, loff_t length)
 > >  {
 > > -    if (ext4_handle_valid(handle))
 > > +    if (ext4_handle_valid(handle)) {
 > > +        struct jbd2_inode *jinode;
 > > +
 > > +        jinode =3D READ_ONCE(EXT4_I(inode)->jinode);
 > >          return jbd2_journal_inode_ranged_write(handle,
 > > -                EXT4_I(inode)->jinode, start_byte, length);
 > > +                jinode, start_byte, length);
 > > +    }
 > >      return 0;
 > >  }
 > > =20
 > >  static inline int ext4_jbd2_inode_add_wait(handle_t *handle,
 > >          struct inode *inode, loff_t start_byte, loff_t length)
 > >  {
 > > -    if (ext4_handle_valid(handle))
 > > +    if (ext4_handle_valid(handle)) {
 > > +        struct jbd2_inode *jinode;
 > > +
 > > +        jinode =3D READ_ONCE(EXT4_I(inode)->jinode);
 > >          return jbd2_journal_inode_ranged_wait(handle,
 > > -                EXT4_I(inode)->jinode, start_byte, length);
 > > +                jinode, start_byte, length);
 > > +    }
 > >      return 0;
 > >  }
 >=20
 > After some thought these two are guaranteed to be called about
 > EXT4_I(inode)->jinode is set and once set jinode never changes so I don'=
t
 > think we need to change anything here (and it's actually somewhat
 > confusing because if jinode could be changing
 > jbd2_journal_inode_ranged_wait() could crash...).
 >=20
 > > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
 > > index f575751f1cae..a80ed2d6df81 100644
 > > --- a/fs/ext4/fast_commit.c
 > > +++ b/fs/ext4/fast_commit.c
 > > @@ -972,16 +972,19 @@ static int ext4_fc_flush_data(journal_t *journal=
)
 > >      struct super_block *sb =3D journal->j_private;
 > >      struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 > >      struct ext4_inode_info *ei;
 > > +    struct jbd2_inode *jinode;
 > >      int ret =3D 0;
 > > =20
 > >      list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 > > -        ret =3D jbd2_submit_inode_data(journal, ei->jinode);
 > > +        jinode =3D READ_ONCE(ei->jinode);
 > > +        ret =3D jbd2_submit_inode_data(journal, jinode);
 > >          if (ret)
 > >              return ret;
 > >      }
 > > =20
 > >      list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 > > -        ret =3D jbd2_wait_inode_data(journal, ei->jinode);
 > > +        jinode =3D READ_ONCE(ei->jinode);
 > > +        ret =3D jbd2_wait_inode_data(journal, jinode);
 > >          if (ret)
 > >              return ret;
 > >      }
 >=20
 > Perhaps we don't need the intermediate variable here and can just write:
 >=20
 >         ret =3D jbd2_submit_inode_data(journal, READ_ONCE(ei->jinode));
 >=20
 > and similarly with jbd2_wait_inode_data().
 >=20
 > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
 > > index da96db5f2345..d99296d7315f 100644
 > > --- a/fs/ext4/inode.c
 > > +++ b/fs/ext4/inode.c
 > > @@ -128,6 +128,8 @@ void ext4_inode_csum_set(struct inode *inode, stru=
ct ext4_inode *raw,
 > >  static inline int ext4_begin_ordered_truncate(struct inode *inode,
 > >                            loff_t new_size)
 > >  {
 > > +    struct jbd2_inode *jinode =3D READ_ONCE(EXT4_I(inode)->jinode);
 > > +
 > >      trace_ext4_begin_ordered_truncate(inode, new_size);
 > >      /*
 > >       * If jinode is zero, then we never opened the file for
 > > @@ -135,10 +137,10 @@ static inline int ext4_begin_ordered_truncate(st=
ruct inode *inode,
 > >       * jbd2_journal_begin_ordered_truncate() since there's no
 > >       * outstanding writes we need to flush.
 > >       */
 > > -    if (!EXT4_I(inode)->jinode)
 > > +    if (!jinode)
 > >          return 0;
 > >      return jbd2_journal_begin_ordered_truncate(EXT4_JOURNAL(inode),
 > > -                           EXT4_I(inode)->jinode,
 > > +                           jinode,
 > >                             new_size);
 > >  }
 > > =20
 > > @@ -4478,8 +4480,13 @@ int ext4_inode_attach_jinode(struct inode *inod=
e)
 > >              spin_unlock(&inode->i_lock);
 > >              return -ENOMEM;
 > >          }
 > > -        ei->jinode =3D jinode;
 > > -        jbd2_journal_init_jbd_inode(ei->jinode, inode);
 > > +        jbd2_journal_init_jbd_inode(jinode, inode);
 > > +        /*
 > > +         * Publish ->jinode only after it is fully initialized so tha=
t
 > > +         * readers never observe a partially initialized jbd2_inode.
 >=20
 >=20
 > > +         */
 > > +        smp_wmb();
 > > +        WRITE_ONCE(ei->jinode, jinode);
 > >          jinode =3D NULL;
 > >      }
 > >      spin_unlock(&inode->i_lock);
 > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
 > > index 69eb63dde983..5cf6c2b54bbb 100644
 > > --- a/fs/ext4/super.c
 > > +++ b/fs/ext4/super.c
 > > @@ -1526,17 +1526,20 @@ static void destroy_inodecache(void)
 > > =20
 > >  void ext4_clear_inode(struct inode *inode)
 > >  {
 > > +    struct jbd2_inode *jinode;
 > > +
 > >      ext4_fc_del(inode);
 > >      invalidate_inode_buffers(inode);
 > >      clear_inode(inode);
 > >      ext4_discard_preallocations(inode);
 > >      ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
 > >      dquot_drop(inode);
 > > -    if (EXT4_I(inode)->jinode) {
 > > +    jinode =3D READ_ONCE(EXT4_I(inode)->jinode);
 > > +    if (jinode) {
 > >          jbd2_journal_release_jbd_inode(EXT4_JOURNAL(inode),
 > > -                           EXT4_I(inode)->jinode);
 > > -        jbd2_free_inode(EXT4_I(inode)->jinode);
 > > -        EXT4_I(inode)->jinode =3D NULL;
 > > +                           jinode);
 > > +        jbd2_free_inode(jinode);
 > > +        WRITE_ONCE(EXT4_I(inode)->jinode, NULL);
 > >      }
 > >      fscrypt_put_encryption_info(inode);
 > >      fsverity_cleanup_inode(inode);
 >=20
 > These cannot ever race with anybody as by the time ext4_clear_inode() we
 > are the exclusive owners of the inode. So there's no point in changing t=
his
 > code.
=20
Thanks a lot for the review :-)

Agreed. I'll drop the READ_ONCE() changes in ext4_jbd2_inode_add_*() and
ext4_clear_inode(), and inline READ_ONCE(ei->jinode) in ext4_fc_flush_data(=
)
as you suggested in v3.

Regards,
Li=E2=80=8B


