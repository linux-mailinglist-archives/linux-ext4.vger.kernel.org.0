Return-Path: <linux-ext4+bounces-14054-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANUrJ0pOoGnvhwQAu9opvQ
	(envelope-from <linux-ext4+bounces-14054-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 14:44:42 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B71A1A6DBE
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 14:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D714B314C136
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 13:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3167222173D;
	Thu, 26 Feb 2026 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e3IjUPcs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gaGc91Zy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O5E7h2c1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SvAWqU4F"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724DB24E4C3
	for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113168; cv=none; b=fzSBLjunSQMecM9+3AInq33L5mepohBbVWPe6Zk50kkv7cKu6y08LuZbc2kEBn5GIisKcuZyArljl32krRH5x+4bt26MIAaExrXB25b0OevQbO2hL25hP0Lmndx4Uwqlno7x4+2w/IiWhiqLH1yap+MIYE2rzKobm3hVn5JlCAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113168; c=relaxed/simple;
	bh=IIIAzBYvY1zIrRjAJ2Bq0qo6uLAb4Rc16WoUXokZA20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IH+G1yjGjCcTY7ui0ML1dV8YjL3ItYfT4lgpBonPkvkJTouTdZteYfWUHBtHSFJFSh1UzkWY5dJfDiGnj33Q93LPwB0PBkBECqfxDHQtDhZHLCFFBcFLyUpfJrCyOCPNJDUeuCDNjchVmwHhXeuZy0g4P5tTA7HQiaLDXQVMapg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e3IjUPcs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gaGc91Zy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O5E7h2c1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SvAWqU4F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B2E351FAA3;
	Thu, 26 Feb 2026 13:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772113165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/rXhoBzkdB7BsxszB1c7jbt2UMbPw0IOuoVqNzSFxk=;
	b=e3IjUPcscDOBmJvuRJfEFWt3rqtqjD+N7WtCHvANjk7quI9EoLNeQfqsPtsLL8bXLq/Qku
	aj7Jt/boK7ZgX4Ta8uOEbktgniXN4/8eZVwIe7rRpFDcNeUMhc43vDFFBeYxl8CBTqBhpW
	w28sM/U6wM7GzeE9q0gXtiFJzRCZRJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772113165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/rXhoBzkdB7BsxszB1c7jbt2UMbPw0IOuoVqNzSFxk=;
	b=gaGc91ZyXfsgQ5CFlRMgHRtZPHJogyDR+q/yHh7jnRGtRMHmN2UXyEXnwnP17rK0OVz5XS
	BY8dK+Ar1cbEAYAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=O5E7h2c1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SvAWqU4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772113164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/rXhoBzkdB7BsxszB1c7jbt2UMbPw0IOuoVqNzSFxk=;
	b=O5E7h2c1/MXNc0M4eaCFjg1NVCAsGhVCaWHrmc8Dyv6p58HNQ5/IycbNTSd7gfuNpqYNGk
	m/3DuNlexMbBFa4tUQ9wU05PcaMbfukWxy2pZ0yzwdLSVCoVlC3AkHqE97eAwlXtsKq78i
	pGdaVOa2AA59SZX27bj0r2fPFRb9SIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772113164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/rXhoBzkdB7BsxszB1c7jbt2UMbPw0IOuoVqNzSFxk=;
	b=SvAWqU4FdeoB8l0FDhxnW6hcYWeW+iPIZzTf4/SjdkFjLW1SFF3Ipb+S9jQvDNW/nHzfEW
	fW3UHIOUSjEbVYCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A89E63EA62;
	Thu, 26 Feb 2026 13:39:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FlYnKQxNoGk6ZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Feb 2026 13:39:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6DA5CA0A27; Thu, 26 Feb 2026 14:39:24 +0100 (CET)
Date: Thu, 26 Feb 2026 14:39:24 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, Free Ekanayaka <free.ekanayaka@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ext4: Fix fsync(2) for nojournal mode
Message-ID: <gzffe2p4gbxrkwolwk2lxpd72gzkbnvfgopz2z5g5z3ses5rdy@fyraeynvocf7>
References: <20260211140209.30337-1-jack@suse.cz>
 <20260216164848.3074-4-jack@suse.cz>
 <85f5a062-2cdb-48ef-8250-cdc022209634@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85f5a062-2cdb-48ef-8250-cdc022209634@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14054-lists,linux-ext4=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,suse.com:email,suse.cz:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,mit.edu,vger.kernel.org,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1B71A1A6DBE
X-Rspamd-Action: no action

On Thu 26-02-26 19:56:34, Zhang Yi wrote:
> On 2/17/2026 12:48 AM, Jan Kara wrote:
> > When inode metadata is changed, we sometimes just call
> > ext4_mark_inode_dirty() to track modified metadata. This copies inode
> > metadata into block buffer which is enough when we are journalling
> > metadata. However when we are running in nojournal mode we currently
> > fail to write the dirtied inode buffer during fsync(2) because the inode
> > is not marked as dirty.
> 
> Please let me understand this. You mean that because some places we
> directly call ext4_mark_inode_dirty() to mark the inode as dirty, instead
> of using the generic mark_inode_dirty(), this results in the inode missing
> the I_DIRTY_INODE flag. Consequently, generic_buffers_fsync_noflush()->
> sync_inode_metadata() does not write the inode, leading to the metadata
> not being updated on disk after fsync(2), right?

Correct.

> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Thanks for review!

								Honza

> > Use explicit ext4_write_inode() call to make
> > sure the inode table buffer is written to the disk. This is a band aid
> > solution but proper solution requires a much larger rewrite including
> > changes in metadata bh tracking infrastructure.
> > 
> > Reported-by: Free Ekanayaka <free.ekanayaka@gmail.com>
> > Link: https://lore.kernel.org/all/87il8nhxdm.fsf@x1.mail-host-address-is-not-set/
> > CC: stable@vger.kernel.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext4/fsync.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
> > index e476c6de3074..bd8f230fa507 100644
> > --- a/fs/ext4/fsync.c
> > +++ b/fs/ext4/fsync.c
> > @@ -83,11 +83,23 @@ static int ext4_fsync_nojournal(struct file *file, loff_t start, loff_t end,
> >  				int datasync, bool *needs_barrier)
> >  {
> >  	struct inode *inode = file->f_inode;
> > +	struct writeback_control wbc = {
> > +		.sync_mode = WB_SYNC_ALL,
> > +		.nr_to_write = 0,
> > +	};
> >  	int ret;
> >  
> >  	ret = generic_buffers_fsync_noflush(file, start, end, datasync);
> > -	if (!ret)
> > -		ret = ext4_sync_parent(inode);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Force writeout of inode table buffer to disk */
> > +	ret = ext4_write_inode(inode, &wbc);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ext4_sync_parent(inode);
> > +
> >  	if (test_opt(inode->i_sb, BARRIER))
> >  		*needs_barrier = true;
> >  
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

