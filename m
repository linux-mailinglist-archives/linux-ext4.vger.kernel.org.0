Return-Path: <linux-ext4+bounces-9824-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34761B45855
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 14:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41DA16ECF3
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 12:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DC9350845;
	Fri,  5 Sep 2025 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f6dN70MA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hOXSXKtr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f6dN70MA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hOXSXKtr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A3B342CB7
	for <linux-ext4@vger.kernel.org>; Fri,  5 Sep 2025 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077104; cv=none; b=DtoYNZdxDmyMYJuQapPGE7/LI2kNMvqBiW2x9u9XTx1xhh5OstmsEg1ntIFcC6xE/gijhSK1vY86/5OmBD2Bd/6rOtCv/8OCgQnqXo1x8ExP46Qt4hMd0UQT2B8MFMo01feSJBhk6HMkKwXooqEn6crX30JyJI97rIWfVl4lJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077104; c=relaxed/simple;
	bh=gzsKvUJatxnmF3elZ5sLv7xh9yhk0CkSwkIbCn+YgVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tooPDfVj0gSoNrKyQKeEwlW6nAwy4kWhCTHnI/BoLEy1BMWN9LQtuVJgQlrX0oot4QevBH+PujrPGqk0A/AGlJsva6ptVrWECYjSEPsQnzhPjt8RL0wNUV9iDs9YvfRpw4Yd7vINnkAldZlwvSkWCKczpA7knKNFXDHhOrn75R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f6dN70MA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hOXSXKtr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f6dN70MA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hOXSXKtr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7EE2A53F3;
	Fri,  5 Sep 2025 12:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757077100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53FoOwm7PjkejcllIw5kfq1WJWLt+e7owCN8XwXKkoY=;
	b=f6dN70MAcdsOmhqYA4A8Vj9tSgNaaLL6v+zfXnK18OUJJEvgCRnwxe3riTGVCFfyJAneXB
	Nin7mpUAvulH5o5niiMCD3d0ltuEGRryu6Ar38cRQIUpNxILufxdvNUBXfygeausdqY4Z8
	LLbkQz7x9qabxYkCp1uIYFjis3hD7Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757077100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53FoOwm7PjkejcllIw5kfq1WJWLt+e7owCN8XwXKkoY=;
	b=hOXSXKtrRQ3qm+XLvBbwbmaI6tqqSMKmlZGSLbKiT4YFMxVd2epEqh8pPfdN1qnRGvA/dT
	QnsXt098SNGnQ4Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757077100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53FoOwm7PjkejcllIw5kfq1WJWLt+e7owCN8XwXKkoY=;
	b=f6dN70MAcdsOmhqYA4A8Vj9tSgNaaLL6v+zfXnK18OUJJEvgCRnwxe3riTGVCFfyJAneXB
	Nin7mpUAvulH5o5niiMCD3d0ltuEGRryu6Ar38cRQIUpNxILufxdvNUBXfygeausdqY4Z8
	LLbkQz7x9qabxYkCp1uIYFjis3hD7Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757077100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53FoOwm7PjkejcllIw5kfq1WJWLt+e7owCN8XwXKkoY=;
	b=hOXSXKtrRQ3qm+XLvBbwbmaI6tqqSMKmlZGSLbKiT4YFMxVd2epEqh8pPfdN1qnRGvA/dT
	QnsXt098SNGnQ4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DC0E139B9;
	Fri,  5 Sep 2025 12:58:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sLbCGmzeumirawAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 05 Sep 2025 12:58:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 265A4A0A48; Fri,  5 Sep 2025 14:58:16 +0200 (CEST)
Date: Fri, 5 Sep 2025 14:58:16 +0200
From: Jan Kara <jack@suse.cz>
To: Sun Yongjian <sunyongjian1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	yangerkun@huawei.com, yi.zhang@huawei.com, libaokun1@huawei.com, tytso@mit.edu
Subject: Re: [PATCH -next] ext4: add an update to i_disksize in
 ext4_block_page_mkwrite
Message-ID: <jzghqbrik56z5z5vx6a2oxcanconkzdygwnaw2jdmpbjuwmxsz@kzzhtouxxjps>
References: <20250731140528.1554917-1-sunyongjian@huaweicloud.com>
 <f78e3cf5-41b1-4b84-bb25-dc0de03fd30f@huawei.com>
 <uxqef2v6p6mjmkm7t3vjbqf7bpr7fcgz5ryktu27hds3cdoruv@wm7giw7hi3kx>
 <634dec5f-af5f-41c6-b0cf-0da740625240@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <634dec5f-af5f-41c6-b0cf-0da740625240@huawei.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Fri 05-09-25 11:25:49, Sun Yongjian wrote:
> 在 2025/9/4 17:11, Jan Kara 写道:
> > On Mon 01-09-25 15:01:45, Sun Yongjian wrote:
> > > 在 2025/7/31 22:05, sunyongjian@huaweicloud.com 写道:
> > > Gentle ping.
> > > > From: Yongjian Sun <sunyongjian1@huawei.com>
> > > > 
> > > > After running a stress test combined with fault injection,
> > > > we performed fsck -a followed by fsck -fn on the filesystem
> > > > image. During the second pass, fsck -fn reported:
> > > > 
> > > > Inode 131512, end of extent exceeds allowed value
> > > > 	(logical block 405, physical block 1180540, len 2)
> > > > 
> > > > This inode was not in the orphan list. Analysis revealed the
> > > > following call chain that leads to the inconsistency:
> > > > 
> > > >                                ext4_da_write_end()
> > > >                                 //does not update i_disksize
> > > >                                ext4_punch_hole()
> > > >                                 //truncate folio, keep size
> > > > ext4_page_mkwrite()
> > > >    ext4_block_page_mkwrite()
> > > >     ext4_block_write_begin()
> > > >       ext4_get_block()
> > > >        //insert written extent without update i_disksize
> > > > journal commit
> > > > echo 1 > /sys/block/xxx/device/delete
> > > > 
> > > > da-write path updates i_size but does not update i_disksize. Then
> > > > ext4_punch_hole truncates the da-folio yet still leaves i_disksize
> > > > unchanged. Then ext4_page_mkwrite sees ext4_nonda_switch return 1
> > > > and takes the nodioread_nolock path, the folio about to be written
> > > > has just been punched out, and it’s offset sits beyond the current
> > > > i_disksize. This may result in a written extent being inserted, but
> > > > again does not update i_disksize. If the journal gets committed and
> > > > then the block device is yanked, we might run into this.
> > > > 
> > > > To fix this, we now check in ext4_block_page_mkwrite whether
> > > > i_disksize needs to be updated to cover the newly allocated blocks.
> > > > 
> > > > Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
> > 
> > OK, after the discussion with Ritesh your solution looks like the best one.
> > Just two nits below:
> > 
> > > > ---
> > > >    fs/ext4/inode.c | 10 ++++++++++
> > > >    1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > > index ed54c4d0f2f9..050270b265ae 100644
> > > > --- a/fs/ext4/inode.c
> > > > +++ b/fs/ext4/inode.c
> > > > @@ -6666,8 +6666,18 @@ static int ext4_block_page_mkwrite(struct inode *inode, struct folio *folio,
> > > >    		goto out_error;
> > > >    	if (!ext4_should_journal_data(inode)) {
> > > > +		loff_t disksize = folio_pos(folio) + len;
> > 
> > Use an empty line between declarations and the code please.
> > 
> > > >    		block_commit_write(folio, 0, len);
> > > >    		folio_mark_dirty(folio);
> > > > +		if (disksize > READ_ONCE(EXT4_I(inode)->i_disksize)) {
> > > > +			down_write(&EXT4_I(inode)->i_data_sem);
> > > > +			if (disksize > EXT4_I(inode)->i_disksize)
> > > > +				EXT4_I(inode)->i_disksize = disksize;
> > > > +			up_write(&EXT4_I(inode)->i_data_sem);
> > > > +			ret = ext4_mark_inode_dirty(handle, inode);
> > > > +			if (ret)
> > > > +				goto out_error;
> > > > +		}
> > 
> > Since we don't support delalloc with data journalling, your code is correct
> > but I think it would be more understandable if you just moved the
> > i_disksize update outside of the "if (!ext4_should_journal_data(inode))"
> > condition.
> > 
> > > >    	} else {
> > > >    		ret = ext4_journal_folio_buffers(handle, folio, len);
> > > >    		if (ret)
> > > 
> > 
> > 								Honza
> Thanks for the review, I will send a patch to improve this!

Yesterday on ext4 developers call we were further discussing this and Ted
came up with a different way of addressing this issue which might be even
better. Instead of updating i_disksize in ext4_page_mkwrite() we can
instead update i_disksize already during the hole punch. I.e., we can modify
ext4_update_disksize_before_punch() to always increase i_disksize to offset
+ len. That should deal with the problem as well and we would avoid
updating i_disksize from page_mkwrite() which is a bit awkward special case.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

