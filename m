Return-Path: <linux-ext4+bounces-3935-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F277E96235A
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 11:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3247AB21DEE
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 09:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82CA15E5B7;
	Wed, 28 Aug 2024 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HI3asXJc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AzuDJLLn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HI3asXJc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AzuDJLLn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8D015B125
	for <linux-ext4@vger.kernel.org>; Wed, 28 Aug 2024 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837275; cv=none; b=RrEVyorDrXOPeOWKMyTyWPKdaApNm/LQgj21ltrd18ZyZ1YJWBXjpyteyq6dmbyKLdQck1yxfoNLkIMQh0b3CidybR2PIe/ll0kMs3tX8DxkwJ3EpPXqSe5mNbinWvE/Ca1N/BvW0xPqTp2HUc2lSYcUFQbW2td9LqSza7g4w5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837275; c=relaxed/simple;
	bh=pC079pqOMBCffZ8Lk4nl2Eom7mmItggXlQHUZPOPqy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYcz7UmOGzNBV4XwVlTlPpofL4FeNdBV+RV2p/RRb0u6PW1G4LHPYr8Eli2Vkxb00Z9f2LhEyxhw2RUNnhS8VQPTEakr35SF3qbLkEFYRh3kuta3tO/N+F0BLz26ZFKGltaJlmQlRGWn6dDq1pTmuuTbUzDUoR8ov8j9mqaw9+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HI3asXJc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AzuDJLLn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HI3asXJc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AzuDJLLn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 605541FBED;
	Wed, 28 Aug 2024 09:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724837271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wwo8PwnO39I3CzRxpNr/rAE5P7/ajPsu6B6/it27C0Y=;
	b=HI3asXJcRBzEWxzKafSWjZeb1MNoA61VmWIK7s1nyqTjEvGClYXsl4GnzHCfWBmXoAEjQi
	ImuuFnuGUXS5E1KvHaQN2Ak6GtCNRogPFJmxReLaNs72hyYkweFS19q97FyY1ZaErtry0T
	l9VBliv2v0O6KUXDNC0xRprQRzZJHyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724837271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wwo8PwnO39I3CzRxpNr/rAE5P7/ajPsu6B6/it27C0Y=;
	b=AzuDJLLnY1AJKbFFPmFVjkUChoo4WvsgnYg0L1dtsNRLEXCCgKor5PXeLXBUWY3au3WHXp
	bBMfRBadjdji36BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HI3asXJc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AzuDJLLn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724837271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wwo8PwnO39I3CzRxpNr/rAE5P7/ajPsu6B6/it27C0Y=;
	b=HI3asXJcRBzEWxzKafSWjZeb1MNoA61VmWIK7s1nyqTjEvGClYXsl4GnzHCfWBmXoAEjQi
	ImuuFnuGUXS5E1KvHaQN2Ak6GtCNRogPFJmxReLaNs72hyYkweFS19q97FyY1ZaErtry0T
	l9VBliv2v0O6KUXDNC0xRprQRzZJHyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724837271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wwo8PwnO39I3CzRxpNr/rAE5P7/ajPsu6B6/it27C0Y=;
	b=AzuDJLLnY1AJKbFFPmFVjkUChoo4WvsgnYg0L1dtsNRLEXCCgKor5PXeLXBUWY3au3WHXp
	bBMfRBadjdji36BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52F1A1398F;
	Wed, 28 Aug 2024 09:27:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UNL2E5ftzmYNVgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Aug 2024 09:27:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F3813A0968; Wed, 28 Aug 2024 11:27:42 +0200 (CEST)
Date: Wed, 28 Aug 2024 11:27:42 +0200
From: Jan Kara <jack@suse.cz>
To: yangerkun <yangerkun@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, yangerkun@huawei.com,
	chengzhihao1@huawei.com
Subject: Re: [PATCH 2/2] ext4: dax: keep orphan list before truncate overflow
 allocated blocks
Message-ID: <20240828092742.t6kbk7sky5ime7iq@quack3>
References: <20240820140657.3685287-1-yangerkun@huaweicloud.com>
 <20240820140657.3685287-2-yangerkun@huaweicloud.com>
 <20240827170813.twxnsgkqp2vraavz@quack3>
 <3e7c14a1-3d9d-ab58-22a4-efc7eb525f23@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e7c14a1-3d9d-ab58-22a4-efc7eb525f23@huaweicloud.com>
X-Rspamd-Queue-Id: 605541FBED
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 28-08-24 10:06:46, yangerkun wrote:
> 
> 
> 在 2024/8/28 1:08, Jan Kara 写道:
> > On Tue 20-08-24 22:06:57, yangerkun wrote:
> > > From: yangerkun <yangerkun@huawei.com>
> > 
> > Thanks for debugging this. Couple of spelling fixes first:
> 
> Hi,
> 
> Thank you for your patient review!
> 
> > > Any extended write for ext4 requires the inode to be placed on the
> >        ^^^ extending
> > 
> > > orphan list before the actual write. In addition, the inode can be
> > > actually removed from the orphan list only after all writes are
> > > completed. Otherwise, those overcommitted blocks (If the allocated
> > 	     ^^ I'd phrase this: Otherwise we'd leave allocated blocks
> > beyond i_disksize if we could not copy all the data into allocated block
> > and e2fsck would complain.
> > 
> > > blocks are not written due to certain reasons, the inode size does not
> > > exceed the offset of these blocks) The leak status is always retained,
> > > and fsck reports an alarm for this scenario.
> > > 
> > > Currently, the dio and buffer IO comply with this logic. However, the
> > 			 ^^ buffered
> > 
> > BTW: The only reason why direct IO doesn't have this problem is because
> > we don't do short writes for direct IO. We either submit all or we return
> > error.
> 
> Yeah. In fact, the first version in my mind is same as this, don't do
> short write for dax too. But thinking deeper, it seems better to keep
> the blocks that has been successfully written...
> 
> 
> > 
> > > dax write will removed the inode from orphan list since
> > 		  ^^^ remove           ^ the orphan ...
> > 
> > > ext4_handle_inode_extension is unconditionally called during extend
> > 								^^ extending
> > 
> > > write. Fix it with this patch. We open the code from
> > > ext4_handle_inode_extension since we want to keep the blocks valid
> > > has been allocated and write success.
> > > 
> > > Signed-off-by: yangerkun <yangerkun@huawei.com>
> > > ---
> > >   fs/ext4/file.c | 35 +++++++++++++++++++++++++++++++----
> > >   1 file changed, 31 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> > > index be061bb64067..fd8597eef75e 100644
> > > --- a/fs/ext4/file.c
> > > +++ b/fs/ext4/file.c
> > > @@ -628,11 +628,12 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
> > >   static ssize_t
> > >   ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
> > >   {
> > > -	ssize_t ret;
> > > +	ssize_t ret, written;
> > >   	size_t count;
> > >   	loff_t offset;
> > >   	handle_t *handle;
> > >   	bool extend = false;
> > > +	bool need_trunc = true;
> > >   	struct inode *inode = file_inode(iocb->ki_filp);
> > >   	if (iocb->ki_flags & IOCB_NOWAIT) {
> > > @@ -668,10 +669,36 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
> > >   	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
> > > -	if (extend) {
> > > -		ret = ext4_handle_inode_extension(inode, offset, ret);
> > > -		ext4_inode_extension_cleanup(inode, ret < (ssize_t)count);
> > > +	if (!extend)
> > > +		goto out;
> > > +
> > > +	if (ret <= 0)
> > > +		goto err_trunc;
> > > +
> > > +	written = ret;
> > > +	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> > > +	if (IS_ERR(handle)) {
> > > +		ret = PTR_ERR(handle);
> > > +		goto err_trunc;
> > >   	}
> > > +
> > > +	if (ext4_update_inode_size(inode, offset + written)) {
> > > +		ret = ext4_mark_inode_dirty(handle, inode);
> > > +		if (unlikely(ret)) {
> > > +			ext4_journal_stop(handle);
> > > +			goto err_trunc;
> > > +		}
> > > +	}
> > > +
> > > +	if (written == count)
> > > +		need_trunc = false;
> > > +
> > > +	if (inode->i_nlink)
> > > +		ext4_orphan_del(handle, inode);
> > 
> > Why did you keep ext4_orphan_del() here? I thought the whole point of this
> 
> Sorry, I make a mistake here, there should be a truncate before. Thanks
> for point out this!
> 
> > patch is to avoid it? In fact, rather then opencoding
> > ext4_handle_inode_extension() I'd add argument to
> > ext4_handle_inode_extension() like:
> > 
> > ext4_handle_inode_extension(inode, pos, written, allocated)
> > 
> > and remove inode from the orphan list only if written == allocated. The
> > call site in ext4_dio_write_end_io() would call:
> > 
> > 	/*
> > 	 * For DIO we don't do partial writes so we must have submitted all
> > 	 * that was allocated.
> > 	 */
> > 	return ext4_handle_inode_extension(inode, pos, size, size);
> > 
> > and the call site in ext4_dax_write_iter() would call:
> > 
> > 	ret = ext4_handle_inode_extension(inode, offset, ret, count);
> > 
> > What do you think?
> 
> Great! This seems more clearly and I think it should works too. Whould I
> send a v2 patch for this?

Yes, please! If you could send a fix, that would be great.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

