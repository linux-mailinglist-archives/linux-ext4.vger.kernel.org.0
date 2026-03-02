Return-Path: <linux-ext4+bounces-14295-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNi3LP9apWlc+QUAu9opvQ
	(envelope-from <linux-ext4+bounces-14295-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 10:40:15 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1482C1D5AAD
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 10:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FDD3300B131
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 09:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8797532938D;
	Mon,  2 Mar 2026 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KUQKA5j4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lOxMqJZL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KUQKA5j4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lOxMqJZL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01B33B7A8
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444396; cv=none; b=rsqV6I649KIgKu749/FIHwP5WeZbb6GRZL/f5t0tQbZPVMI+ztyMDrc0U3ezdFogpcZQ43uewhT4zgH9dnQ8snsbxe38f9jFDr4wAKAof8pQfPeGtjmw3QXLT+ucmc8FZIKJAfTs3aPrVRKBl95YU+2yT+ToM15+5j+PTnB5pEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444396; c=relaxed/simple;
	bh=o9t91VHZqrCvG+QmOglDA2lBYTLUZm3Mtc+Pq09JxMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIA+BO1EpPl2P5Vjn94y7/eSk38XqKu6T5aciBDplgwT3bTQHKOQXdoDaBveOmjm92E2w6S7nB5l6cEjZTb3mwgKGSXezrUIETa4VhFmKuinX2BZejEyHoxw+9RGj8S9PW04oODMr8GcDFq/k4mIBB/yGd8WjLdwTHJJ3ukHBM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KUQKA5j4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lOxMqJZL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KUQKA5j4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lOxMqJZL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B03E3E806;
	Mon,  2 Mar 2026 09:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772444393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=whUKEMVbT9wAeIrApAGiAnvPRWmwMWV6hw0segYI0ao=;
	b=KUQKA5j4WRjs59hLGO/Djn2fcOqkfegfdoAMuax5Uy8s0f8vKDl3lsE8QA2rhs7rh2SM8R
	ek8oS2X+J3w0gLxyqFadiEWfrDOV1Y3Y1A1fojR1wcuukQnSiXlaCujFOtzYkgidnyswwc
	rm47y4j2xbL63VwhYCUrbf7xScecEJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772444393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=whUKEMVbT9wAeIrApAGiAnvPRWmwMWV6hw0segYI0ao=;
	b=lOxMqJZL7ZkaEIkRCsb1NVnIZciokrvzrOAKYSEEkQOSKQEMJVjiCwDfU2BcuP7GFeTLaK
	qbGwk1MyzHy7WMBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KUQKA5j4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lOxMqJZL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772444393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=whUKEMVbT9wAeIrApAGiAnvPRWmwMWV6hw0segYI0ao=;
	b=KUQKA5j4WRjs59hLGO/Djn2fcOqkfegfdoAMuax5Uy8s0f8vKDl3lsE8QA2rhs7rh2SM8R
	ek8oS2X+J3w0gLxyqFadiEWfrDOV1Y3Y1A1fojR1wcuukQnSiXlaCujFOtzYkgidnyswwc
	rm47y4j2xbL63VwhYCUrbf7xScecEJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772444393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=whUKEMVbT9wAeIrApAGiAnvPRWmwMWV6hw0segYI0ao=;
	b=lOxMqJZL7ZkaEIkRCsb1NVnIZciokrvzrOAKYSEEkQOSKQEMJVjiCwDfU2BcuP7GFeTLaK
	qbGwk1MyzHy7WMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2067C3EA69;
	Mon,  2 Mar 2026 09:39:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HlnhB+lapWk1fAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Mar 2026 09:39:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D75C2A0A27; Mon,  2 Mar 2026 10:39:48 +0100 (CET)
Date: Mon, 2 Mar 2026 10:39:48 +0100
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	jack@suse.cz
Subject: Re: [PATCH v2] ext4: test if inode's all dirty pages are submitted
 to disk
Message-ID: <lth55hzudtc53wjkwsob2x3riy3wj4bbq6rm2evp2hsav62tpd@cqfscuyimwi7>
References: <20260228025650.2664098-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228025650.2664098-1-yebin@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.cz:email,suse.cz:dkim,huawei.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14295-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1482C1D5AAD
X-Rspamd-Action: no action

On Sat 28-02-26 10:56:50, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> The commit aa373cf55099 ("writeback: stop background/kupdate works from
> livelocking other works") introduced an issue where unmounting a filesystem
> in a multi-logical-partition scenario could lead to batch file data loss.
> This problem was not fixed until the commit d92109891f21 ("fs/writeback:
> bail out if there is no more inodes for IO and queued once"). It took
> considerable time to identify the root cause. Additionally, in actual
> production environments, we frequently encountered file data loss after
> normal system reboots. Therefore, we are adding a check in the inode
> release flow to verify whether all dirty pages have been flushed to disk,
> in order to determine whether the data loss is caused by a logic issue in
> the filesystem code.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good! Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 396dc3a5d16b..a64d9c7381ea 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -184,6 +184,12 @@ void ext4_evict_inode(struct inode *inode)
>  	if (EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)
>  		ext4_evict_ea_inode(inode);
>  	if (inode->i_nlink) {
> +		/*
> +		 * If there's dirty page will lead to data loss, user
> +		 * could see stale data.
> +		 */
> +		WARN_ON(!ext4_emergency_state(inode->i_sb) &&
> +			mapping_tagged(&inode->i_data, PAGECACHE_TAG_DIRTY));
>  		truncate_inode_pages_final(&inode->i_data);
>  
>  		goto no_delete;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

