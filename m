Return-Path: <linux-ext4+bounces-13467-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEZRMc7XgGnMBwMAu9opvQ
	(envelope-from <linux-ext4+bounces-13467-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Feb 2026 17:58:54 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4BACF431
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Feb 2026 17:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE08E3013A7E
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Feb 2026 16:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAE23806D2;
	Mon,  2 Feb 2026 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1/CDKOvJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SjihoiF4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bI/nppYE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yx/TCFoJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8EE223705
	for <linux-ext4@vger.kernel.org>; Mon,  2 Feb 2026 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051159; cv=none; b=TdGKEqMdTvE1XeiL9LLWN96Jk8ZASruev8VBForSg2u8K6Qh2AwMuH5LwKzuuNmejqCL0qiXspNvx30OTNi+YEgRuZ8rlLEJ4RuBuhhnvsZCnXlLrN+ho1607gGkqSV6ZRd1uyYxM3qSRHZhatzLNx7wB80zW7/HR/MvFwlzWTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051159; c=relaxed/simple;
	bh=vGlMp69JRySKOEJPYHl/D6PgdPb64/n1QXCyToEvYw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kB2RjEcqNRUNXvR7ldePd4CbcA+Up9kl1Rq4SvT4rBIr4qrlrQeXidFT+Jw/Ym0Rkp2ycsUPLrO7qtn41j7EgJw48RwUmFse2R921U5Br+FBd0DbAAr6i9SOpnD18TVG1Cs+Y6gTBcXOHXGHWXENM8MEbleGSFFtWStH+k9n3ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1/CDKOvJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SjihoiF4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bI/nppYE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yx/TCFoJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D472E34FC0;
	Mon,  2 Feb 2026 16:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770051155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqehyBt96vpabiRX5hSgHUbnMMsVVtLcroHKHr7pcUo=;
	b=1/CDKOvJSPXaOSbTvMVA4Cftosl3iKXzUvjJyPovDhvutGkfVutIg1aNfEEmN17Im8+o7H
	aiMnUUWDFIXgbLCxZS1COePiJvd6VPMp+wp/1ZfXP78rTLMWqj9eRzAIPxCQIJVU510+4E
	1NJxmT0E7E+zwkk4E0VkWkCnn0D8Rd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770051155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqehyBt96vpabiRX5hSgHUbnMMsVVtLcroHKHr7pcUo=;
	b=SjihoiF4aPIbsm/pdEdyO9wiHLRmEANvABJWSRLwbY2NIunxNSi50ARkIc1FZ2NkBOCpAn
	A+3KImyAhyK8qBAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="bI/nppYE";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Yx/TCFoJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770051154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqehyBt96vpabiRX5hSgHUbnMMsVVtLcroHKHr7pcUo=;
	b=bI/nppYEDkcrb02Vroxrebw3eZ4QqB6YclclkJnmAVsBJDDG90Ws+Thvnp9q3LZQaPzlw4
	OLnSHs4kLIYB+fc5P//PFjDr642dYmmh0oLYoKoa/n6HVmZdO4rvt7lGLK7BrV6wlfRydD
	DAKPjfIv1ropdsPirwZMmWFvHDf/atg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770051154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqehyBt96vpabiRX5hSgHUbnMMsVVtLcroHKHr7pcUo=;
	b=Yx/TCFoJk+WytBaw20v22Cs0jcKsq/pAs0CnG4y2pmGlRyt8eugDC6rX/I3bL9aof2NvHe
	YvSPCe76vGyNETBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA7323EA62;
	Mon,  2 Feb 2026 16:52:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QaAQLVLWgGnmVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Feb 2026 16:52:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 773FAA08F8; Mon,  2 Feb 2026 17:52:30 +0100 (CET)
Date: Mon, 2 Feb 2026 17:52:30 +0100
From: Jan Kara <jack@suse.cz>
To: Li Chen <me@linux.beauty>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] jbd2: use READ_ONCE for lockless jinode reads
Message-ID: <jvo5sk46f6cvqmkgetrlybs46kryhxetsvapkmx4tocbdirk3w@ume4qfpsddco>
References: <20260130031232.60780-1-me@linux.beauty>
 <20260130031232.60780-2-me@linux.beauty>
 <cgms3ngtmgbhm6dftle6xqbezuhrjheeuiptnejf55uy2pwjil@w2vgwvm7y6hv>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cgms3ngtmgbhm6dftle6xqbezuhrjheeuiptnejf55uy2pwjil@w2vgwvm7y6hv>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.beauty:email,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13467-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2A4BACF431
X-Rspamd-Action: no action

On Mon 02-02-26 17:40:45, Jan Kara wrote:
> On Fri 30-01-26 11:12:30, Li Chen wrote:
> > jbd2_inode fields are updated under journal->j_list_lock, but some
> > paths read them without holding the lock (e.g. fast commit
> > helpers and the ordered truncate fast path).
> > 
> > Use READ_ONCE() for these lockless reads to correct the
> > concurrency assumptions.
> > 
> > Suggested-by: Jan Kara <jack@suse.com>
> > Signed-off-by: Li Chen <me@linux.beauty>
> 
> Just one nit below. With that fixed feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> > @@ -191,12 +197,30 @@ EXPORT_SYMBOL(jbd2_submit_inode_data);
> >  
> >  int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode)
> >  {
> > -	if (!jinode || !(jinode->i_flags & JI_WAIT_DATA) ||
> > -		!jinode->i_vfs_inode || !jinode->i_vfs_inode->i_mapping)
> > +	struct address_space *mapping;
> > +	struct inode *inode;
> > +	unsigned long flags;
> > +	loff_t start, end;
> > +
> > +	if (!jinode)
> > +		return 0;
> > +
> > +	flags = READ_ONCE(jinode->i_flags);
> > +	if (!(flags & JI_WAIT_DATA))
> > +		return 0;
> > +
> > +	inode = READ_ONCE(jinode->i_vfs_inode);
> 
> i_vfs_inode never changes so READ_ONCE is pointless here.

One more note: I've realized that for this to work you also need to make
jbd2_journal_file_inode() use WRITE_ONCE() when updating i_dirty_start,
i_dirty_end and i_flags.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

