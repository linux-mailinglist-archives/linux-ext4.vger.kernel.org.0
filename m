Return-Path: <linux-ext4+bounces-9814-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6596CB436B5
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Sep 2025 11:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B31767B2482
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Sep 2025 09:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9A32E0407;
	Thu,  4 Sep 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iyLAMvxU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uovmwDA8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iyLAMvxU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uovmwDA8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F2926E70C
	for <linux-ext4@vger.kernel.org>; Thu,  4 Sep 2025 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977087; cv=none; b=KOZuEXy1O+YiTb9UEWhfBL07q1zn4ybdHWYMbAyo/Iq1YCixXpm6eg6cOXPcMZDu+Xlb56TLAdWRNC/oT6LDVY1RwbGYs9P9GG7GTJ8fEYQQeeqzzLctRoKuAuqpct08MIav+007qg27Vf2SphG8hxxPJniiWqhYgDs4VBZfDHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977087; c=relaxed/simple;
	bh=7aGviJggifN8XtvPsy7t7L3t0HtXhvk0ncJrBDXtWBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9GztNNGZ5MNRC5PYIfOk6SRyh9BuAOAMBzq61M0Ud5V8ArfKym6UvBr5X64GB3/ndSzaY31UbcFTAsbGtG0ipQWqhKX08qQN+b5dXvArkwWhgmoLOkbwR95bsC0i/MSb/bTash7NTUBfZSqRYRXAe5yUC0YDp53ZoRd60yNzEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iyLAMvxU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uovmwDA8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iyLAMvxU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uovmwDA8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8FA4A3406D;
	Thu,  4 Sep 2025 09:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756977077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdDJaZh6zncPGvr9IUP6+a5RMJExv5RRhFsyzPg78HA=;
	b=iyLAMvxUi/LPp0RvSBXekkfgeAYf1j7P8LeMhVuLXzwqXFtyXMaeC6XstAue+1O366U7lD
	0ZwscoeVPnBS67A7WRs+hjm2HdUf+8bCZMniqg2RAZX9lTGGCHKHSA70vcBfmjnjc4QNC6
	cksVSHPBBGiD/xra5Xi/HP68knJ7B5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756977077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdDJaZh6zncPGvr9IUP6+a5RMJExv5RRhFsyzPg78HA=;
	b=uovmwDA8lCaplOyyKufBNx6DBubEhP3Vmj0XmIrOWhxM9Y+aeyWyv80EWE6HpPzVu7avAk
	84zTjr1W4XA4xvDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iyLAMvxU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uovmwDA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756977077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdDJaZh6zncPGvr9IUP6+a5RMJExv5RRhFsyzPg78HA=;
	b=iyLAMvxUi/LPp0RvSBXekkfgeAYf1j7P8LeMhVuLXzwqXFtyXMaeC6XstAue+1O366U7lD
	0ZwscoeVPnBS67A7WRs+hjm2HdUf+8bCZMniqg2RAZX9lTGGCHKHSA70vcBfmjnjc4QNC6
	cksVSHPBBGiD/xra5Xi/HP68knJ7B5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756977077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdDJaZh6zncPGvr9IUP6+a5RMJExv5RRhFsyzPg78HA=;
	b=uovmwDA8lCaplOyyKufBNx6DBubEhP3Vmj0XmIrOWhxM9Y+aeyWyv80EWE6HpPzVu7avAk
	84zTjr1W4XA4xvDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 856C713675;
	Thu,  4 Sep 2025 09:11:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FauPILVXuWhqFgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Sep 2025 09:11:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 47B0AA0A2D; Thu,  4 Sep 2025 11:11:17 +0200 (CEST)
Date: Thu, 4 Sep 2025 11:11:17 +0200
From: Jan Kara <jack@suse.cz>
To: Sun Yongjian <sunyongjian1@huawei.com>
Cc: linux-ext4@vger.kernel.org, yangerkun@huawei.com, yi.zhang@huawei.com, 
	libaokun1@huawei.com, tytso@mit.edu, jack@suse.cz
Subject: Re: [PATCH -next] ext4: add an update to i_disksize in
 ext4_block_page_mkwrite
Message-ID: <uxqef2v6p6mjmkm7t3vjbqf7bpr7fcgz5ryktu27hds3cdoruv@wm7giw7hi3kx>
References: <20250731140528.1554917-1-sunyongjian@huaweicloud.com>
 <f78e3cf5-41b1-4b84-bb25-dc0de03fd30f@huawei.com>
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8FA4A3406D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.01

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
> > This inode was not in the orphan list. Analysis revealed the
> > following call chain that leads to the inconsistency:
> > 
> >                               ext4_da_write_end()
> >                                //does not update i_disksize
> >                               ext4_punch_hole()
> >                                //truncate folio, keep size
> > ext4_page_mkwrite()
> >   ext4_block_page_mkwrite()
> >    ext4_block_write_begin()
> >      ext4_get_block()
> >       //insert written extent without update i_disksize
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

OK, after the discussion with Ritesh your solution looks like the best one.
Just two nits below:

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

Use an empty line between declarations and the code please.

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

Since we don't support delalloc with data journalling, your code is correct
but I think it would be more understandable if you just moved the
i_disksize update outside of the "if (!ext4_should_journal_data(inode))"
condition.

> >   	} else {
> >   		ret = ext4_journal_folio_buffers(handle, folio, len);
> >   		if (ret)
> 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

