Return-Path: <linux-ext4+bounces-12858-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6423D2458D
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 13:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D9723014DCA
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 12:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D37E2D47F1;
	Thu, 15 Jan 2026 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="selsF1ni";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xPVtoVzJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="selsF1ni";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xPVtoVzJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9028D3803DA
	for <linux-ext4@vger.kernel.org>; Thu, 15 Jan 2026 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478401; cv=none; b=O6ppH9ZdDABSnKOpVosd+OR5mkPF2YJG3n2W6DfZLQALobzrWJudIQ+mb9GdlELCvsxT3mC0lXgc6w7eLfpcFTDldoLaAHuHlJRf4yOJXS9xLS7sOIaHm6dyjDvhvSHbY2PZT29F2eMqPskPv0SvOAowwdP4qAIN0gOOg/A2cfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478401; c=relaxed/simple;
	bh=cXDhioZmUk+wpSZIiENSrkBWznDAT5UCbyAH2iEJrPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jC++I75MUe6i+n3EwR1X2o46a2Suk1Qoovc76igBr0yPtM3emlx1YLRD/Ebxo0rP1R/9xDYDx0+qMz+cXyrb9I/uI6/jib5l+iVuXFk2ytQMeeWYmutG2T1mgiKS6U8Lxu4ZJG2toGP5S9QJRHP+c/aCGDpJewQ9D9HPwgP4uug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=selsF1ni; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xPVtoVzJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=selsF1ni; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xPVtoVzJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 98B8933691;
	Thu, 15 Jan 2026 11:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768478398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FkZHce/Nxv57ydiyE7dI47c8wLAbDIz/PrHqm2w/1ss=;
	b=selsF1nivyAJ7p0ybK30Uxfg/OMf/MYGdL8ghXi/+VkJZufJNNoBxGh76wu2FTLSk4sZTW
	3hihebrSMacAPbwmSODGdfLG9qFlHE+o52MCOS4QwPw8wNIahlfyMDcIwz06DBv0mEHLW0
	kwipu4QJk9+7hPEjTLXkRvd60IOvzcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768478398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FkZHce/Nxv57ydiyE7dI47c8wLAbDIz/PrHqm2w/1ss=;
	b=xPVtoVzJFfkxHYcgckyMAFgwty77qJcr+KBQMDH2RY3sXzfOkmmJD+dA3AIY80f5QSgaOq
	ax3IZypOtjYgAqDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768478398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FkZHce/Nxv57ydiyE7dI47c8wLAbDIz/PrHqm2w/1ss=;
	b=selsF1nivyAJ7p0ybK30Uxfg/OMf/MYGdL8ghXi/+VkJZufJNNoBxGh76wu2FTLSk4sZTW
	3hihebrSMacAPbwmSODGdfLG9qFlHE+o52MCOS4QwPw8wNIahlfyMDcIwz06DBv0mEHLW0
	kwipu4QJk9+7hPEjTLXkRvd60IOvzcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768478398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FkZHce/Nxv57ydiyE7dI47c8wLAbDIz/PrHqm2w/1ss=;
	b=xPVtoVzJFfkxHYcgckyMAFgwty77qJcr+KBQMDH2RY3sXzfOkmmJD+dA3AIY80f5QSgaOq
	ax3IZypOtjYgAqDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 288F43EA63;
	Thu, 15 Jan 2026 11:59:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X7vNBr7WaGnWWQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 15 Jan 2026 11:59:58 +0000
Date: Thu, 15 Jan 2026 11:59:52 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Jan Kara <jack@suse.cz>
Cc: Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Baokun Li <libaokun1@huawei.com>, Zhang Yi <yi.zhang@huawei.com>
Subject: Re: [PATCH 1/2] ext4: always allocate blocks only from groups inode
 can use
Message-ID: <tai2z6hjykb26rqhtql3wd6fg23747wdioliyzqmtq2s432ii6@euiky43uwohz>
References: <20260114182333.7287-1-jack@suse.cz>
 <20260114182836.14120-3-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114182836.14120-3-jack@suse.cz>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed, Jan 14, 2026 at 07:28:18PM +0100, Jan Kara wrote:
> For filesystems with more than 2^32 blocks inodes using indirect block
> based format cannot use blocks beyond the 32-bit limit.
> ext4_mb_scan_groups_linear() takes care to not select these unsupported
> groups for such inodes however other functions selecting groups for
> allocation don't. So far this is harmless because the other selection
> functions are used only with mb_optimize_scan and this is currently
> disabled for inodes with indirect blocks however in the following patch
> we want to enable mb_optimize_scan regardless of inode format.
> 
> Reviewed-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Pedro Falcato <pfalcato@suse.de>

Thanks for addressing my nit :)

> ---
>  fs/ext4/mballoc.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 56d50fd3310b..a88fbaa4f5f4 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -892,6 +892,21 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
>  	}
>  }
>  
> +static ext4_group_t ext4_get_allocation_groups_count(
> +				struct ext4_allocation_context *ac)
> +{
> +	ext4_group_t ngroups = ext4_get_groups_count(ac->ac_sb);
> +
> +	/* non-extent files are limited to low blocks/groups */
> +	if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)))
> +		ngroups = EXT4_SB(ac->ac_sb)->s_blockfile_groups;
> +
> +	/* Pairs with smp_wmb() in ext4_update_super() */
> +	smp_rmb();
> +
> +	return ngroups;
> +}

For what it's worth now we get 2 smp_rmb()'s (get_groups_count() has one),
but I suppose this can be fixed up later. Probably doesn't make sense to
withold these patches further.

-- 
Pedro

