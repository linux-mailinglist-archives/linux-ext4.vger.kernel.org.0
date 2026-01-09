Return-Path: <linux-ext4+bounces-12700-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A92AD087AB
	for <lists+linux-ext4@lfdr.de>; Fri, 09 Jan 2026 11:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E919130662A8
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jan 2026 10:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BD035A920;
	Fri,  9 Jan 2026 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u26oqIw/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UoGFnkjz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u26oqIw/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UoGFnkjz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982F8337BA1
	for <linux-ext4@vger.kernel.org>; Fri,  9 Jan 2026 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767953030; cv=none; b=qt0Q4n65b1ZG4KamKn5Hbo0UMIlTL8TU2mb+FXET4aLoSnwRoUb6/meR5xSt4MILsf4ifV2bRI573lV3+XE2N4JgkV2qlKf68N46scEExageq6G+OOM/ooahumEZCal6B6+yAGSrdXxpNVs7yabkRz5tMykABOE39WxegqmmB4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767953030; c=relaxed/simple;
	bh=Ik+46WvxRb5SwYRU79POiQilcmgA/7byrnI3ylYtSQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZG6DR/hj8zPs2syvkJLtOsHaCdHgaHfpsjNIltyqBkVYUCX6JqYXpqztLzE/TH0zZtwHKKKu3YIiT3iw7tTTAddlIXvyqjJMMSIdqVvkLFaunA4PLK0I4Po0vpOhk0FziDTdOcTpEJnZB3xedJp8EW/Zs0dIvo1XXA1W2+BSbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u26oqIw/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UoGFnkjz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u26oqIw/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UoGFnkjz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A8BB433A58;
	Fri,  9 Jan 2026 10:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767953026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gd56EktucnPPbejC2078iWhlq677cEXldXYSZpngVHI=;
	b=u26oqIw/uupuo7PEsB3YE4dzNTcrjL2hnsMXSfOw9XraEplYDifZfClBBC3aF2f81iR1wq
	UCFMF2M6FrdYGENwpHDHQJFEtzYdsTvZjBeUGMd0IKOIKX/YWyalGV5FsFQTBJXMS1fbYo
	0q3W0BT1AK6gsWFvP9yO420c3RkPQS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767953026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gd56EktucnPPbejC2078iWhlq677cEXldXYSZpngVHI=;
	b=UoGFnkjzNM2IqrWQcFiSF+kF2omEd88tZLLKhdfyjl71uKk6AzH4XFZio9KrN2H6KWOHO8
	GoX4/jixt2gXQ6DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767953026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gd56EktucnPPbejC2078iWhlq677cEXldXYSZpngVHI=;
	b=u26oqIw/uupuo7PEsB3YE4dzNTcrjL2hnsMXSfOw9XraEplYDifZfClBBC3aF2f81iR1wq
	UCFMF2M6FrdYGENwpHDHQJFEtzYdsTvZjBeUGMd0IKOIKX/YWyalGV5FsFQTBJXMS1fbYo
	0q3W0BT1AK6gsWFvP9yO420c3RkPQS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767953026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gd56EktucnPPbejC2078iWhlq677cEXldXYSZpngVHI=;
	b=UoGFnkjzNM2IqrWQcFiSF+kF2omEd88tZLLKhdfyjl71uKk6AzH4XFZio9KrN2H6KWOHO8
	GoX4/jixt2gXQ6DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FE653EA63;
	Fri,  9 Jan 2026 10:03:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PYsFJ4LSYGmiJgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 09 Jan 2026 10:03:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 60043A0A4F; Fri,  9 Jan 2026 11:03:46 +0100 (CET)
Date: Fri, 9 Jan 2026 11:03:46 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	Ted Tso <tytso@mit.edu>, libaokun9@gmail.com
Subject: Re: [PATCH] ext4: Use optimized mballoc scanning regardless of inode
 format
Message-ID: <v2qznr26v5tbgscpnty3hujsmz3e2ajf6iuskdjdbk5yfyaxjf@lbd5yiju4r6s>
References: <20260108160907.24892-2-jack@suse.cz>
 <4b18f416-28da-45d3-8887-48f804d9e84a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b18f416-28da-45d3-8887-48f804d9e84a@huawei.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Fri 09-01-26 10:00:33, Baokun Li wrote:
> On 2026-01-09 00:09, Jan Kara wrote:
> > Currently we don't used mballoc optimized scanning (using max free
> > extent order and avg free extent order group lists) for inodes with
> > indirect block based format. This is confusing for users and I don't see
> > a good reason for that. Even with indirect block based inode format we
> > can spend big amount of time searching for free blocks for large
> > filesystems with fragmented free space. To add to the confusion before
> > commit 077d0c2c78df ("ext4: make mb_optimize_scan performance mount
> > option work with extents") optimized scanning was applied *only* to
> > indirect block based inodes so that commit appears as a performance
> > regression to some users. Just use optimized scanning whenever it is
> > enabled by mount options.
> >
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Makes sense. Block allocation should not be tied to the inode format,
> and we should remove this restriction.
> 
> However, inodes with the indirect block based format only support
> 32-bit physical block numbers. We already check the maximum supported
> block group in ext4_mb_scan_groups_linear, but we don’t perform the
> same check in ext4_mb_scan_groups_xa_range.
> 
> So if we want to drop this restriction, we need to specify the
> appropriate end value for inodes using the indirect block based format
> in ext4_mb_scan_groups_xa_range; otherwise, an overflow could occur and
> lead to corrupted block allocation.

Good point. I'll fix that up and send v2. Thanks for review!

								Honza

> 
> 
> Regards,
> Baokun
> 
> > ---
> >  fs/ext4/mballoc.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index 56d50fd3310b..4ee7ab4ce86e 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -1133,8 +1133,6 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
> >  		return 0;
> >  	if (ac->ac_criteria >= CR_GOAL_LEN_SLOW)
> >  		return 0;
> > -	if (!ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
> > -		return 0;
> >  	return 1;
> >  }
> >  
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

