Return-Path: <linux-ext4+bounces-13426-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN+dGgQpe2nRBwIAu9opvQ
	(envelope-from <linux-ext4+bounces-13426-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jan 2026 10:31:48 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAD8AE2B4
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jan 2026 10:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8D0B300FF90
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jan 2026 09:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E17374192;
	Thu, 29 Jan 2026 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CyQvw0P+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XrUenqow";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CyQvw0P+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XrUenqow"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6287237FF61
	for <linux-ext4@vger.kernel.org>; Thu, 29 Jan 2026 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769679095; cv=none; b=B/T6krLxWlxa2woFjELRVjpF48rmwIxC4lMzdcUsBOLCFUtFt5qtKCq8dW5jYXRbHe81aCM6Fh1Furq0Gw2hIZlZKWysjzMk5+tjcqlDEFhL9ZVs2V1iygu+7jZT05q6qUTBi+EM36uJk2wGaEXdaCenqtk2yKeWK6J0vDa5A9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769679095; c=relaxed/simple;
	bh=Vq5bmpmYeM4b/wU4rp0E/FdHujnX2uBVWmJRMa3PIxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqW4n/yXBPSfnr+vhPraRLlMgDIV/8i6E9PM3EGtBMUTUoXl6C4V6uF1yK5U3wfzhBnMaAlY9HGVJDX7buKr1+2he2CJX6xHPmLEnurupE1BqotgQEll0wbCel+t4CsL7pWADX/fmv3KK+xnX1f1HASfK/xuix43JjCLHPlSUUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CyQvw0P+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XrUenqow; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CyQvw0P+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XrUenqow; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6057E34175;
	Thu, 29 Jan 2026 09:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769679091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sDheb6o6nimVg7DZzM6FtbiwMvbTBoOljlnWq9sOot4=;
	b=CyQvw0P+Ntnla8GaT8NV9oZQx7ZUWwAfMhUze+4dNMtndlsMS4X9msAnn4xroNR6ko7qRE
	EpkQUE0EhGJBGPAsvNoxzB1vLexZJhy9XaBNmR7/Z8HG2dwt9ZvB6S6ytZuu/Ju87VGMZh
	dToB6DvTdCrF1aubIx1gOCAA/9RU5Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769679091;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sDheb6o6nimVg7DZzM6FtbiwMvbTBoOljlnWq9sOot4=;
	b=XrUenqowoXuJdcRgwJSozZlhfraz0pqCB9Qc0IUEdkz8ZVb6u2pY8jKJ8bFi5MUswtoex2
	zLjnX6+q56gmeUCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769679091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sDheb6o6nimVg7DZzM6FtbiwMvbTBoOljlnWq9sOot4=;
	b=CyQvw0P+Ntnla8GaT8NV9oZQx7ZUWwAfMhUze+4dNMtndlsMS4X9msAnn4xroNR6ko7qRE
	EpkQUE0EhGJBGPAsvNoxzB1vLexZJhy9XaBNmR7/Z8HG2dwt9ZvB6S6ytZuu/Ju87VGMZh
	dToB6DvTdCrF1aubIx1gOCAA/9RU5Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769679091;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sDheb6o6nimVg7DZzM6FtbiwMvbTBoOljlnWq9sOot4=;
	b=XrUenqowoXuJdcRgwJSozZlhfraz0pqCB9Qc0IUEdkz8ZVb6u2pY8jKJ8bFi5MUswtoex2
	zLjnX6+q56gmeUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 475FC3EA61;
	Thu, 29 Jan 2026 09:31:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xrZkEfMoe2mQJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 Jan 2026 09:31:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DB094A084A; Thu, 29 Jan 2026 10:31:30 +0100 (CET)
Date: Thu, 29 Jan 2026 10:31:30 +0100
From: Jan Kara <jack@suse.cz>
To: Gerald Yang <gerald.yang@canonical.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, gerald.yang.tw@gmail.com
Subject: Re: [PATCH] ext4: Fix call trace when remounting to read only in
 data=journal mode
Message-ID: <bycdopvwzfaskilhk3nsljuk3gkztvoa3is466a6utuj2lozmj@pxf44ulcnqup>
References: <20260128074515.2028982-1-gerald.yang@canonical.com>
 <4u2l4huoj7zsfy2u37lgdzlmwwdntgqaer7wta7ud3kat7ox2n@oxhbcqryre3r>
 <CAMsNC+s1R-AUzhe80vjxYCSRu0X9Ybp33sSMHGHKpBL6=dG2_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMsNC+s1R-AUzhe80vjxYCSRu0X9Ybp33sSMHGHKpBL6=dG2_w@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13426-lists,linux-ext4=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,suse.cz:email,suse.cz:dkim,canonical.com:email];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,mit.edu,dilger.ca,vger.kernel.org,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0EAD8AE2B4
X-Rspamd-Action: no action

On Thu 29-01-26 11:31:43, Gerald Yang wrote:
> Thanks Jan for the review, originally this issue was observed during reboot
> because the root filesystem is remounted to read only before shutdown to
> make sure all data is flushed to disk.
> We don't see any issue on the machine because the data is persisted to
> journal. But I think your suggestion is the correct way to fix it, I
> will look into
> why ext4_writepages doesn't flush data to real file location after calling
> sync_filesystem and re-submit the patch for review, thanks again.

FWIW yesterday I did some investigation and it is always the tail (last
written) folio that is somehow kept dirty. In particular at the beginning
for ext4_do_writepages() we commit the running transaction and the bh
attached to the folio is just dirty but by the time we get to
ext4_bio_write_folio() to write it, the bh attached to the tail folio is
already part of the running transaction again and so ext4_bio_write_folio()
fails to write it. I didn't figure out how the bh gets reattached to the
transaction yet. Now I likely won't be able to dig more into this for a few
days so I'm just sharing my findings until now.

								Honza

> On Wed, Jan 28, 2026 at 6:22 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 28-01-26 15:45:15, Gerald Yang wrote:
> > > When remounting the filesystem to read only in data=journal mode
> > > it may dump the following call trace:
> > >
> > > [   71.629350] CPU: 0 UID: 0 PID: 177 Comm: kworker/u96:5 Tainted: G            E       6.19.0-rc7 #1 PREEMPT(voluntary)
> > > [   71.629352] Tainted: [E]=UNSIGNED_MODULE
> > > [   71.629353] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)/LXD, BIOS unknown 2/2/2022
> > > [   71.629354] Workqueue: writeback wb_workfn (flush-7:4)
> > > [   71.629359] RIP: 0010:ext4_journal_check_start+0x8b/0xd0
> > > [   71.629360] Code: 31 ff 45 31 c0 45 31 c9 e9 42 ad c4 00 48 8b 5d f8 b8 fb ff ff ff c9 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 c3 cc cc cc cc <0f> 0b b8 e2 ff ff ff eb c2 0f 0b eb
> > >  a9 44 8b 42 08 68 c7 53 ce b8
> > > [   71.629361] RSP: 0018:ffffcf32c0fdf6a8 EFLAGS: 00010202
> > > [   71.629364] RAX: ffff8f08c8505000 RBX: ffff8f08c67ee800 RCX: 0000000000000000
> > > [   71.629366] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > [   71.629367] RBP: ffffcf32c0fdf6b0 R08: 0000000000000001 R09: 0000000000000000
> > > [   71.629368] R10: ffff8f08db18b3a8 R11: 0000000000000000 R12: 0000000000000000
> > > [   71.629368] R13: 0000000000000002 R14: 0000000000000a48 R15: ffff8f08c67ee800
> > > [   71.629369] FS:  0000000000000000(0000) GS:ffff8f0a7d273000(0000) knlGS:0000000000000000
> > > [   71.629370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [   71.629371] CR2: 00007b66825905cc CR3: 000000011053d004 CR4: 0000000000772ef0
> > > [   71.629374] PKRU: 55555554
> > > [   71.629374] Call Trace:
> > > [   71.629378]  <TASK>
> > > [   71.629382]  __ext4_journal_start_sb+0x38/0x1c0
> > > [   71.629383]  mpage_prepare_extent_to_map+0x4af/0x580
> > > [   71.629389]  ? sbitmap_get+0x73/0x180
> > > [   71.629399]  ext4_do_writepages+0x3cc/0x10a0
> > > [   71.629400]  ? kvm_sched_clock_read+0x11/0x20
> > > [   71.629409]  ext4_writepages+0xc8/0x1b0
> > > [   71.629410]  ? ext4_writepages+0xc8/0x1b0
> > > [   71.629411]  do_writepages+0xc4/0x180
> > > [   71.629416]  __writeback_single_inode+0x45/0x350
> > > [   71.629419]  ? _raw_spin_unlock+0xe/0x40
> > > [   71.629423]  writeback_sb_inodes+0x260/0x5c0
> > > [   71.629425]  ? __schedule+0x4d1/0x1870
> > > [   71.629429]  __writeback_inodes_wb+0x54/0x100
> > > [   71.629431]  ? queue_io+0x82/0x140
> > > [   71.629433]  wb_writeback+0x1ab/0x330
> > > [   71.629448]  wb_workfn+0x31d/0x410
> > > [   71.629450]  process_one_work+0x191/0x3e0
> > > [   71.629455]  worker_thread+0x2e3/0x420
> > >
> > > This issue can be easily reproduced by:
> > > mkdir -p mnt
> > > dd if=/dev/zero of=ext4disk bs=1G count=2 oflag=direct
> > > mkfs.ext4 ext4disk
> > > tune2fs -o journal_data ext4disk
> > > mount ext4disk mnt
> > > fio --name=fiotest --rw=randwrite --bs=4k --runtime=3 --ioengine=libaio --iodepth=128 --numjobs=4 --filename=mnt/fiotest --filesize=1G --group_reporting
> > > mount -o remount,ro ext4disk mnt
> > > sync
> > >
> > > In data=journal mode, metadata and data are both written to the journal
> > > first, but for the second write, ext4 relies on the writeback thread to
> > > flush the data to the real file location.
> > >
> > > After the filesystem is remounted to read only, writeback thread still
> > > writes data to it and causes the issue. Return early to avoid starting
> > > a journal transaction on a read only filesystem, once the filesystem
> > > becomes writable again, the write thread will continue writing data.
> > >
> > > Signed-off-by: Gerald Yang <gerald.yang@canonical.com>
> >
> > Thanks for the report and the patch! I can indeed reproduce this warning.
> > But the patch itself is certainly not the right fix for this problem.
> > ext4_remount() must make sure there are no dirty pages on the filesystem
> > anymore when remounting filesystem read only and it apparently fails to do
> > so. In particular it calls sync_filesystem() which should make sure all
> > data is written. So this bug needs more investigation why there are some
> > dirty pages left in the inode in data=journal mode because
> > ext4_writepages() should have written them all...
> >
> >                                                                 Honza
> >
> > > ---
> > >  fs/ext4/inode.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > index 15ba4d42982f..4e3bbf17995e 100644
> > > --- a/fs/ext4/inode.c
> > > +++ b/fs/ext4/inode.c
> > > @@ -2787,6 +2787,17 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
> > >       if (unlikely(ret))
> > >               goto out_writepages;
> > >
> > > +     /*
> > > +      * For data=journal, if the filesystem was remounted read-only,
> > > +      * the writeback thread may still write dirty pages to it.
> > > +      * Return early to avoid starting a journal transaction on a
> > > +      * read-only filesystem.
> > > +      */
> > > +     if (ext4_should_journal_data(inode) && sb_rdonly(inode->i_sb)) {
> > > +             ret = -EROFS;
> > > +             goto out_writepages;
> > > +     }
> > > +
> > >       /*
> > >        * If we have inline data and arrive here, it means that
> > >        * we will soon create the block for the 1st page, so
> > > --
> > > 2.43.0
> > >
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

