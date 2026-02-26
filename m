Return-Path: <linux-ext4+bounces-14056-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCQUCeFOoGmIiAQAu9opvQ
	(envelope-from <linux-ext4+bounces-14056-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 14:47:13 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4604F1A6E73
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 14:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31068302DE65
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 13:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61A333557C;
	Thu, 26 Feb 2026 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yeY6NJuG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0mS2fLSZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yeY6NJuG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0mS2fLSZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDFA2877C3
	for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113451; cv=none; b=qizScfkkkj5lhhv1zNOfHxlSpE2+BzSwcp70QcIBJPKNVFMvdFOd7uBlOsMeaLu3H5TyuHmoyuS5LWcAmyJ5+e5sbKV8MeuoUsK8Uy5r+z8dlkeqhiMI0VTwvEwwlSrRm0syWKXKK1qhheVf7CpKDQFzCC9S79dG2RO2n4JQhDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113451; c=relaxed/simple;
	bh=aVyxnaphYH09zaMoMk6YI9+KLHu+fDt0c/8tIjFTDpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBAL9wbm3KRGU9IxN7RczJM3yWAy8tAVWn4oc8Xoh2+m3MNyugKvG50dVMQtf+GR6KMAywcjXAnWlii4IKRcej3en4FtdU0/EbfGPw0qI3RNBhRWK/w97SPQ/+q3Py6cMYeIVEbotQk/7AoWWbFZa0403AWkm0dHOG3naqoM0uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yeY6NJuG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0mS2fLSZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yeY6NJuG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0mS2fLSZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8892D1FAA3;
	Thu, 26 Feb 2026 13:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772113448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bD8In2Pqqip5SvucbTJbN6F6/sVncoeBtq9JUwrA1eE=;
	b=yeY6NJuG/Pz+bPGQUiSO8Rd42As90s8sB2dwNocs1NmGix8YFNQ9f6Iouwst/A7lKdWEwM
	fGj0ezn0xFL82ix+UN21RUZzNp31WCtqp/q0bxrZeVJ8vm9T/7JxAYKUkn91yoao6bdvIv
	C5dDGPvO+LLKDlZnqyr+U3rqSGPaMDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772113448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bD8In2Pqqip5SvucbTJbN6F6/sVncoeBtq9JUwrA1eE=;
	b=0mS2fLSZMdy2oNeWjGrb0Av5uGYlRY6ISeDU4soJuPnaA3TSc4kxYV8xir4oE5h2smXpxt
	tNFi+eP0af9UK5AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772113448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bD8In2Pqqip5SvucbTJbN6F6/sVncoeBtq9JUwrA1eE=;
	b=yeY6NJuG/Pz+bPGQUiSO8Rd42As90s8sB2dwNocs1NmGix8YFNQ9f6Iouwst/A7lKdWEwM
	fGj0ezn0xFL82ix+UN21RUZzNp31WCtqp/q0bxrZeVJ8vm9T/7JxAYKUkn91yoao6bdvIv
	C5dDGPvO+LLKDlZnqyr+U3rqSGPaMDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772113448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bD8In2Pqqip5SvucbTJbN6F6/sVncoeBtq9JUwrA1eE=;
	b=0mS2fLSZMdy2oNeWjGrb0Av5uGYlRY6ISeDU4soJuPnaA3TSc4kxYV8xir4oE5h2smXpxt
	tNFi+eP0af9UK5AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EA323EA62;
	Thu, 26 Feb 2026 13:44:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +53lHihOoGmpaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Feb 2026 13:44:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4BDBBA0A27; Thu, 26 Feb 2026 14:44:04 +0100 (CET)
Date: Thu, 26 Feb 2026 14:44:04 +0100
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	jack@suse.cz
Subject: Re: [PATCH] ext4: test if inode's all dirty pages are submitted to
 disk
Message-ID: <esl72gpbi555gkbmu5sbsjeiqpz4xxlcqg6hoexct3q7hyn36q@uxtmfrfzjvta>
References: <20260226110718.1904825-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226110718.1904825-1-yebin@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14056-lists,linux-ext4=lfdr.de];
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
X-Rspamd-Queue-Id: 4604F1A6E73
X-Rspamd-Action: no action

On Thu 26-02-26 19:07:18, Ye Bin wrote:
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

It would be nice to have this in generic code but that would likely result
in false positives for some filesystems. So I guess this is better than
nothing so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 396dc3a5d16b..37df83ce9ad6 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -184,6 +184,11 @@ void ext4_evict_inode(struct inode *inode)
>  	if (EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)
>  		ext4_evict_ea_inode(inode);
>  	if (inode->i_nlink) {
> +		/*
> +		 * If there's dirty page will lead to data loss, user
> +		 * could see stale data.
> +		 */
> +		WARN_ON(mapping_tagged(&inode->i_data, PAGECACHE_TAG_DIRTY));
>  		truncate_inode_pages_final(&inode->i_data);
>  
>  		goto no_delete;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

