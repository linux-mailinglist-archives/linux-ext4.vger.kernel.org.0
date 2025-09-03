Return-Path: <linux-ext4+bounces-9808-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BF6B42455
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Sep 2025 17:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A081C480564
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Sep 2025 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8433112C0;
	Wed,  3 Sep 2025 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1+VTdxuj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F8bYSjF0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1+VTdxuj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F8bYSjF0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE12F99A8
	for <linux-ext4@vger.kernel.org>; Wed,  3 Sep 2025 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911826; cv=none; b=HoKT3p18vKDdLUIRkMGkHJM93PwzbPt/YnpsxSH2eqmswvg64RVfj1L5rvwBTBev+P9nx5uWYjTNiimbOo4JDxassUlc720ZzvQ9n5BJwNRPvaLKJ68vGblwpqJXoYjLDA/QBsoRgjeae2sNv0chz97zsWY6loF/cw0I6l4PDQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911826; c=relaxed/simple;
	bh=QMS3L5iyvt62DBQJ+l5vUpJeXw0qCTVCGzfLFkIIg3I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FWAYo1TcPrpe1dOz5t9bWJ/LzN1kXBPXdC7ul61w4pC5PRQEkCvwlemzUKRw/oz/JdakNfZF7aoo0Uv79orEPkQBk84sFiOCWwLQJDU7PZpzaZrISOrUCSsCxbrYwlMoxJCzp6yoRqpvxq7ilCmdgk7enoPYMwfJTpH38njwwdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1+VTdxuj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F8bYSjF0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1+VTdxuj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F8bYSjF0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 131C91F453;
	Wed,  3 Sep 2025 15:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756911822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=jk2M8TJfasQCadc0Uz3Q1t+T+Q7qvbBMT3QBKo7Aroo=;
	b=1+VTdxuj6xml9cb+m/d+tVAEk7lhr3LKG3VsMQNYH3ZBZGsJwfnx2W+63hPEGWVtU+kL26
	QZ0Omp3Vg/HJs/TFFZ8agSSxDjRjkYQk4NtIbLqTiK4o8KRA5ihYT/AjDOuvCxID0OTH5K
	bR0KVnASrxToA4OUHha39+AcB2isviY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756911822;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=jk2M8TJfasQCadc0Uz3Q1t+T+Q7qvbBMT3QBKo7Aroo=;
	b=F8bYSjF0q1a3cjRdtsp9Fp8JZqK7WYYS2oJSrh9uPYP669zIESFthoYbu+cD9rpEpZgK5W
	HqPaBDPPXJobKbDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1+VTdxuj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=F8bYSjF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756911822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=jk2M8TJfasQCadc0Uz3Q1t+T+Q7qvbBMT3QBKo7Aroo=;
	b=1+VTdxuj6xml9cb+m/d+tVAEk7lhr3LKG3VsMQNYH3ZBZGsJwfnx2W+63hPEGWVtU+kL26
	QZ0Omp3Vg/HJs/TFFZ8agSSxDjRjkYQk4NtIbLqTiK4o8KRA5ihYT/AjDOuvCxID0OTH5K
	bR0KVnASrxToA4OUHha39+AcB2isviY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756911822;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=jk2M8TJfasQCadc0Uz3Q1t+T+Q7qvbBMT3QBKo7Aroo=;
	b=F8bYSjF0q1a3cjRdtsp9Fp8JZqK7WYYS2oJSrh9uPYP669zIESFthoYbu+cD9rpEpZgK5W
	HqPaBDPPXJobKbDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31D0313888;
	Wed,  3 Sep 2025 15:03:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QOQfDM1YuGgkYQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Sep 2025 15:03:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5DC00A0734; Wed,  3 Sep 2025 17:03:33 +0200 (CEST)
Date: Wed, 3 Sep 2025 17:03:33 +0200
From: Jan Kara <jack@suse.cz>
To: Sun Yongjian <sunyongjian1@huawei.com>
Cc: linux-ext4@vger.kernel.org, yangerkun@huawei.com, yi.zhang@huawei.com, 
	libaokun1@huawei.com, tytso@mit.edu, jack@suse.cz, 
	Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH -next] ext4: add an update to i_disksize in
 ext4_block_page_mkwrite
Message-ID: <ksmu3jz7ll2kp3xwemvil56ntzljrdaamv5hmdj7dbjniqsprv@25ypuymdslac>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f78e3cf5-41b1-4b84-bb25-dc0de03fd30f@huawei.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,huawei.com,mit.edu,suse.cz,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 131C91F453
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Mon 01-09-25 15:01:45, Sun Yongjian wrote:
> 在 2025/7/31 22:05, sunyongjian@huaweicloud.com 写道:
> Gentle ping.
> > From: Yongjian Sun <sunyongjian1@huawei.com>
> > 
> > After running a stress test combined with fault injection,
> > we performed fsck -a followed by fsck -fn on the filesystem
> > image. During the second pass, fsck -fn reported:
> > 
> > Inode 131512, end of extent exceeds allowed value
> > 	(logical block 405, physical block 1180540, len 2)
> > 
> > This inode was not in the orphan list.

Thanks for report! Interesting... Which kernel were you using?

> > Analysis revealed the
> > following call chain that leads to the inconsistency:
> > 
> >                               ext4_da_write_end()
> >                                //does not update i_disksize

Right, for any write beyond i_disksize to unallocated blocks we update
i_disksize only during page writeback.

> >                               ext4_punch_hole()
> >                                //truncate folio, keep size

So here offset + len passed to ext4_punch_hole() is important. Because
there's ext4_update_disksize_before_punch() call which updates i_disksize
to i_size if the punched hole reaches EOF. So did you punch hole in the
middle of the file?

> > ext4_page_mkwrite()
> >   ext4_block_page_mkwrite()
> >    ext4_block_write_begin()
> >      ext4_get_block()
> >       //insert written extent without update i_disksize

We should insert unwritten extent here, shouldn't we? We use
ext4_get_block_unwritten() when we are inside i_size. Ah, you mention below
you use nodioread_nolock. Nasty :)

> > journal commit
> > echo 1 > /sys/block/xxx/device/delete
> > 
> > da-write path updates i_size but does not update i_disksize. Then
> > ext4_punch_hole truncates the da-folio yet still leaves i_disksize
> > unchanged. Then ext4_page_mkwrite sees ext4_nonda_switch return 1
> > and takes the nodioread_nolock path, the folio about to be written
> > has just been punched out, and it’s offset sits beyond the current
> > i_disksize. This may result in a written extent being inserted, but
> > again does not update i_disksize. If the journal gets committed and
> > then the block device is yanked, we might run into this.
> > 
> > To fix this, we now check in ext4_block_page_mkwrite whether
> > i_disksize needs to be updated to cover the newly allocated blocks.
> > 
> > Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>

Hum, rather than complicating this niche code what if we just
unconditionally used ext4_get_block_unwritten() in
ext4_block_page_mkwrite() when delalloc gets disabled? It is far from any
performance critical path. What do people think? The code would actually
have to be something like:

	if (ext4_should_journal_data(inode))
		get_block = ext4_get_block;
	else
		get_block = ext4_get_block_unwritten;

to properly handle data journalling. I'm adding Ritesh to CC because I do
remember there used to be some issues with dioread_nolock with blocksize <
pagesize which he was able to trigger. But I think they were fixed.

								Honza

> > ---
> >   fs/ext4/inode.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index ed54c4d0f2f9..050270b265ae 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -6666,8 +6666,18 @@ static int ext4_block_page_mkwrite(struct inode *inode, struct folio *folio,
> >   		goto out_error;
> >   	if (!ext4_should_journal_data(inode)) {
> > +		loff_t disksize = folio_pos(folio) + len;
> >   		block_commit_write(folio, 0, len);
> >   		folio_mark_dirty(folio);
> > +		if (disksize > READ_ONCE(EXT4_I(inode)->i_disksize)) {
> > +			down_write(&EXT4_I(inode)->i_data_sem);
> > +			if (disksize > EXT4_I(inode)->i_disksize)
> > +				EXT4_I(inode)->i_disksize = disksize;
> > +			up_write(&EXT4_I(inode)->i_data_sem);
> > +			ret = ext4_mark_inode_dirty(handle, inode);
> > +			if (ret)
> > +				goto out_error;
> > +		}
> >   	} else {
> >   		ret = ext4_journal_folio_buffers(handle, folio, len);
> >   		if (ret)
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

