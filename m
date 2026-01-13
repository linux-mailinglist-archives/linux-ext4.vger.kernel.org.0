Return-Path: <linux-ext4+bounces-12790-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9358AD1A4AE
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jan 2026 17:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B90FB30559F6
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jan 2026 16:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919CD2F12C9;
	Tue, 13 Jan 2026 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PuZO1SGr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Yf5uHU1k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B0v+5vpZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qCzDSQvr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED672F0692
	for <linux-ext4@vger.kernel.org>; Tue, 13 Jan 2026 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321693; cv=none; b=eiMxgQmVge1k4o132FtBdJrcsEcWhL8cYKWoZ+sXZByG7/vxFSBjOExFohycDcQNwuqiuS5tG/YeTPCckjFEoPSPGh7jlu3E/nIXVgltFRkXxGUZcjr5fX0Ai3tHhEQsTvOCkCUk1qWVfNfNTZgjMKBzUNlB8cyOVX3yBayZ2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321693; c=relaxed/simple;
	bh=/3+m+46lXzyegDfq8dV9+NyADzYcl2TxBR2ctQh4HYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0YvGhJ1OhC+WzFamIthLbqrjvOpOyFxWCkSPml+BgbglejAGwWn/IKRw3OZVhPQ/d2agMyWM4jVF/keMlXPEkjQLbQowLUM5MC/iNMVOxMpq6BLgBcU4wNxr+nsJ+U2Hj6uc3A5zqxxHr7gygmhv3SBGNedmanJO7F/6QPnU24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PuZO1SGr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Yf5uHU1k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B0v+5vpZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qCzDSQvr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E1136336A0;
	Tue, 13 Jan 2026 16:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768321690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ocUNv6pMUwOEbBFdvqhV168obNPAYCWNvjfm6okRfnA=;
	b=PuZO1SGrpn026dYVN0qtKJgCSb5Ncoag934eye+AxBNOnig+LpxUgfFyvou3LdC5rST43H
	QpsMl23fdXYdy3wCrwvHdXsZn9+TxkV3Q+SZI24y07wIul4xIQjfCB7Eq49M20VUpStfAz
	ZdvcHwwkgJZoBhapW5ccj/Uxn6Uv8JI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768321690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ocUNv6pMUwOEbBFdvqhV168obNPAYCWNvjfm6okRfnA=;
	b=Yf5uHU1kmQJ2tXf9PHhp3U81ItcyfQQTz2iFB0zlsdnLQ5Y9zVvHsLSxfLtfWoglA6vHIe
	BvogLKAxcDwoNEBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768321689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ocUNv6pMUwOEbBFdvqhV168obNPAYCWNvjfm6okRfnA=;
	b=B0v+5vpZouZ204GKVGTXmsZbcQwR/55sS6xFRQx3rZ/xZGfOVNY3llXK2iHCMPXdBJV/mD
	+18rGpjBU89nIwLxQhUTJ+topGIEEVVau2I9eeJB6HgZd2X3UMDPKxQ44jCxg5O79g0LIK
	wJm+ViAOMIgo73dp9Smb8jijRN0dK1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768321689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ocUNv6pMUwOEbBFdvqhV168obNPAYCWNvjfm6okRfnA=;
	b=qCzDSQvr/ou0SxhQZ1MErqUL17pO6Spq/gaXHExyMX3W1wH2cY6KWBojdEyxO0LWznPVwe
	TfsbyNegoT7czGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BA913EA63;
	Tue, 13 Jan 2026 16:28:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ndTlHplyZmkXRgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 13 Jan 2026 16:28:09 +0000
Date: Tue, 13 Jan 2026 16:28:07 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Jan Kara <jack@suse.cz>
Cc: Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 1/2] ext4: always allocate blocks only from groups inode
 can use
Message-ID: <fmycqmyw25fpfkov5bvl77gqz7mc3kgsfi44al4rn4n5mhzara@ijqxuq6wpna7>
References: <20260109105007.27673-1-jack@suse.cz>
 <20260109105354.16008-3-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109105354.16008-3-jack@suse.cz>
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
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Fri, Jan 09, 2026 at 11:53:37AM +0100, Jan Kara wrote:
> For filesystems with more than 2^32 blocks inodes using indirect block
> based format cannot use blocks beyond the 32-bit limit.
> ext4_mb_scan_groups_linear() takes care to not select these unsupported
> groups for such inodes however other functions selecting groups for
> allocation don't. So far this is harmless because the other selection
> functions are used only with mb_optimize_scan and this is currently
> disabled for inodes with indirect blocks however in the following patch
> we want to enable mb_optimize_scan regardless of inode format.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/mballoc.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 56d50fd3310b..f0e07bf11a93 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -892,6 +892,18 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
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
> +	return ngroups;
> +}

I know you're mostly only moving code around, but I think I see a problem here.
Namely, we (probably?) need an smp_rmb() right after the s_blockfile_groups
read to pair with the one in ext4_update_super(). The pre-existing smp_rmb()
in ext4_get_groups_acount() after the s_groups_count load perhaps *incidentally*
works here, but it seems to me like we need a new barrier. So fundamentally
something like:

static ext4_group_t ext4_get_allocation_groups_count(...)
{
	struct ext4_sb_info *sb = EXT4_SB(ac->ac_sb);
	ext4_group_t ngroups;

	ngroups = sb->s_groups_count;
	if (!ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
		ngroups = sb->s_blockfile_groups;
	/* pairs with ext4_group_add() logic */
	smp_rmb();
	return ngroups;
}

and to be even more technically correct, we probably want READ_ONCE()
and WRITE_ONCE() here as well.

Does this make sense?

-- 
Pedro

