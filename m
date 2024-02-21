Return-Path: <linux-ext4+bounces-1334-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FD985D6A3
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 12:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D571F2243A
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 11:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1903FB2A;
	Wed, 21 Feb 2024 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZNEmnhk4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0KcFXYue";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZNEmnhk4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0KcFXYue"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908D3376E2
	for <linux-ext4@vger.kernel.org>; Wed, 21 Feb 2024 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514336; cv=none; b=Fego4Y/q+8SKislH4KIBjZ+A8tgqlAqeaRqFoX458dEWko2r+eBEVIA30hLv+0wxsJ//5eqQzR6VPsV5RakBxs4fI7dJsN5SgF8nAsnoLkc1tpDg3fUmcknvsGql0ZQsDAUUDyjgMSveG6Z26UWe9GN46Wb3X/hbjbnigMKHKW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514336; c=relaxed/simple;
	bh=oArCVA/vaX7nAOe+jXz6mJ6W0IrK7n8UuHQ/22BpUy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abpB27Dlaa7zwoy7TNjTwUXyXoXMXslkfka2mPs/tWKjAMhc0H5baUctFv61ZXf1+Qtqlyg+3bWhZo3BaJxblDIkvu1wrBSG/2WTgIZxpA58KCVy1kfFaddkMTLvknIBhggIH7rwEdaouwWFv1oe0NX2TR/bRXS2dWQOBtzHIpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZNEmnhk4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0KcFXYue; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZNEmnhk4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0KcFXYue; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0D9422215;
	Wed, 21 Feb 2024 11:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708514332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mM0kny/bu5V19uuSaqtDMB0C7QKfq5IRw6w6CGQLIpY=;
	b=ZNEmnhk4rkwMz0iHDvemgIk8BwjC1EzvNrZfYQRPefmQnbYP6/MEnGnszXaBsee5c6aT+O
	EwLakS4/5EtapS4pPw7ydpldQCtasXYXhDacBa21MnfofG1/0Ivc7Ri2faF0uBUe0zT9u8
	FfCHp0tab26CSinTqHp5tX8gR0EkdMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708514332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mM0kny/bu5V19uuSaqtDMB0C7QKfq5IRw6w6CGQLIpY=;
	b=0KcFXYuecCkO7MTKcCtsgE01IAIAIJfbYDAc5alMrIY7GdYZ4nrGYeHNoV1AI78ghC4ams
	x8QKfm/zEjxyr+Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708514332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mM0kny/bu5V19uuSaqtDMB0C7QKfq5IRw6w6CGQLIpY=;
	b=ZNEmnhk4rkwMz0iHDvemgIk8BwjC1EzvNrZfYQRPefmQnbYP6/MEnGnszXaBsee5c6aT+O
	EwLakS4/5EtapS4pPw7ydpldQCtasXYXhDacBa21MnfofG1/0Ivc7Ri2faF0uBUe0zT9u8
	FfCHp0tab26CSinTqHp5tX8gR0EkdMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708514332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mM0kny/bu5V19uuSaqtDMB0C7QKfq5IRw6w6CGQLIpY=;
	b=0KcFXYuecCkO7MTKcCtsgE01IAIAIJfbYDAc5alMrIY7GdYZ4nrGYeHNoV1AI78ghC4ams
	x8QKfm/zEjxyr+Ag==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 95C4C13A25;
	Wed, 21 Feb 2024 11:18:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id wYqMJBzc1WUdIQAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 21 Feb 2024 11:18:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4C10FA0807; Wed, 21 Feb 2024 12:18:52 +0100 (CET)
Date: Wed, 21 Feb 2024 12:18:52 +0100
From: Jan Kara <jack@suse.cz>
To: yangerkun <yangerkun@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, boyu.mt@taobao.com,
	linux-ext4@vger.kernel.org, yangerkun@huawei.com
Subject: Re: [PATCH] ext4: clear EXT4_GROUP_INFO_WAS_TRIMMED_BIT even mount
 with discard
Message-ID: <20240221111852.olo7jeycctz7xntj@quack3>
References: <20231230070654.178638-1-yangerkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231230070654.178638-1-yangerkun@huaweicloud.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZNEmnhk4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0KcFXYue
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A0D9422215
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Sat 30-12-23 15:06:54, yangerkun wrote:
> Commit 3d56b8d2c74c ("ext4: Speed up FITRIM by recording flags in
> ext4_group_info") speed up fstrim by skipping trim trimmed group. We
> also has the chance to clear trimmed once there exists some block free
> for this group(mount without discard), and the next trim for this group
> will work well too.
> 
> For mount with discard, we will issue dicard when we free blocks, so
> leave trimmed flag keep alive to skip useless trim trigger from
> userspace seems reasonable. But for some case like ext4 build on
> dm-thinpool(ext4 blocksize 4K, pool blocksize 128K), discard from ext4
> maybe unaligned for dm thinpool, and thinpool will just finish this
> discard(see process_discard_bio when begein equals to end) without
> actually process discard. For this case, trim from userspace can really
> help us to free some thinpool block.
> 
> So convert to clear trimmed flag for all case no matter mounted with
> discard or not.
> 
> Fixes: 3d56b8d2c74c ("ext4: Speed up FITRIM by recording flags in ext4_group_info")
> Signed-off-by: yangerkun <yangerkun@huaweicloud.com>

Thanks for the fix. It looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index d72b5e3c92ec..69240ae775f1 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3855,11 +3855,8 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
>  	/*
>  	 * Clear the trimmed flag for the group so that the next
>  	 * ext4_trim_fs can trim it.
> -	 * If the volume is mounted with -o discard, online discard
> -	 * is supported and the free blocks will be trimmed online.
>  	 */
> -	if (!test_opt(sb, DISCARD))
> -		EXT4_MB_GRP_CLEAR_TRIMMED(db);
> +	EXT4_MB_GRP_CLEAR_TRIMMED(db);
>  
>  	if (!db->bb_free_root.rb_node) {
>  		/* No more items in the per group rb tree
> @@ -6481,8 +6478,9 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  					 " group:%u block:%d count:%lu failed"
>  					 " with %d", block_group, bit, count,
>  					 err);
> -		} else
> -			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
> +		}
> +
> +		EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
>  
>  		ext4_lock_group(sb, block_group);
>  		mb_free_blocks(inode, &e4b, bit, count_clusters);
> -- 
> 2.39.2
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

