Return-Path: <linux-ext4+bounces-14329-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP7tKVS+pWkbFgAAu9opvQ
	(envelope-from <linux-ext4+bounces-14329-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 17:44:04 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B42F1DD1F1
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 17:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 782BB305239D
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 16:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38CA3815DF;
	Mon,  2 Mar 2026 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="toGDf/Hg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z+mB/MMN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="toGDf/Hg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z+mB/MMN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5DF32AAA0
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468875; cv=none; b=Pdd9uA4rF414cVolyud9uN+6/iUyScvBlYlrot5a+x01d4w0uArUIj//wEJXA3hXfHghwQx9BUTtCDUejmKXkyxEtmgwWlRpkgbPgK/QpTIBPmX8SvaL7kKASlHnnBzHZARykk6+A14fIMtneZpSzbv3hy0UfH+ufMrYqv1xHuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468875; c=relaxed/simple;
	bh=haYIdXbd3zeH19rqZge5FBIjwqed7vhIFPAXDR/zs5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cmc9EVlaT2VbkQ+BlAxlVivHQMVK64JKgnvPB29K2GY0KXxOArOf1YGDt53j2pKC9ztmMywnanNoRMKoFELelzVSnQAeScV2NIP6iTreGUOMNKJX7zq8wTiqq3IYkAtXVAEXKHnkULV5RQ4UkmwADwS3R3loRYBSjSu/JjNahEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=toGDf/Hg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z+mB/MMN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=toGDf/Hg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z+mB/MMN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 595363F773;
	Mon,  2 Mar 2026 16:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772468872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vDrGouK59a7TemQboE82aoBhfxOPaJCRnDLSKM2hQY4=;
	b=toGDf/HgJ+KZcroOoskUbJj9cs5/MOhwAUEyKP95VVcGBs77HxJwyS42b1Yroib/tydfVs
	nb4uU56s7H3iO9R25AifjUCb2eO82XPHhlfpM/RF6SSnb09ur4JaJrobKv2sibB99TZXOf
	HpzOv+Hs6X+XXk0p9OlPJp8p0/KwiFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772468872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vDrGouK59a7TemQboE82aoBhfxOPaJCRnDLSKM2hQY4=;
	b=z+mB/MMNQBaO4D1Kndx+b1O9N7aVYVtyohHxXJoZCLmW6csxuLoQe2ukvZsZa0esaBS4bf
	C3BoT0Bv8oI6jUDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="toGDf/Hg";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="z+mB/MMN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772468872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vDrGouK59a7TemQboE82aoBhfxOPaJCRnDLSKM2hQY4=;
	b=toGDf/HgJ+KZcroOoskUbJj9cs5/MOhwAUEyKP95VVcGBs77HxJwyS42b1Yroib/tydfVs
	nb4uU56s7H3iO9R25AifjUCb2eO82XPHhlfpM/RF6SSnb09ur4JaJrobKv2sibB99TZXOf
	HpzOv+Hs6X+XXk0p9OlPJp8p0/KwiFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772468872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vDrGouK59a7TemQboE82aoBhfxOPaJCRnDLSKM2hQY4=;
	b=z+mB/MMNQBaO4D1Kndx+b1O9N7aVYVtyohHxXJoZCLmW6csxuLoQe2ukvZsZa0esaBS4bf
	C3BoT0Bv8oI6jUDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F2CA3EA69;
	Mon,  2 Mar 2026 16:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7sdJE4i6pWl9OgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Mar 2026 16:27:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0C589A0A0B; Mon,  2 Mar 2026 17:27:52 +0100 (CET)
Date: Mon, 2 Mar 2026 17:27:52 +0100
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	jack@suse.cz
Subject: Re: [PATCH] ext4: avoid allocate block from corrupted group in
 ext4_mb_find_by_goal()
Message-ID: <fjjzvezk7jqpcecowxcsr4vxcd3qox73fwjad3ubpkmiyl2d6c@hftw7uq3x4bs>
References: <20260302134619.3145520-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302134619.3145520-1-yebin@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 8B42F1DD1F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14329-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon 02-03-26 21:46:19, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's issue as follows:
> ...
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
> 
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
> 
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
> 
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
> 
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 2243 at logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
> 
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 2239 at logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
> 
> EXT4-fs (mmcblk0p1): error count since last fsck: 1
> EXT4-fs (mmcblk0p1): initial error at time 1765597433: ext4_mb_generate_buddy:760
> EXT4-fs (mmcblk0p1): last error at time 1765597433: ext4_mb_generate_buddy:760
> ...
> 
> According to the log analysis, blocks are always requested from the
> corrupted block group. This may happen as follows:
> ext4_mb_find_by_goal
>   ext4_mb_load_buddy
>    ext4_mb_load_buddy_gfp
>      ext4_mb_init_cache
>       ext4_read_block_bitmap_nowait
>       ext4_wait_block_bitmap
>        ext4_validate_block_bitmap
>         if (!grp || EXT4_MB_GRP_BBITMAP_CORRUPT(grp))
>          return -EFSCORRUPTED; // There's no logs.
>  if (err)
>   return err;  // Will return error
> ext4_lock_group(ac->ac_sb, group);
>   if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info))) // Unreachable
>    goto out;
> 
> After commit 9008a58e5dce ("ext4: make the bitmap read routines return
> real error codes") merged, Commit 163a203ddb36 ("ext4: mark block group
> as corrupt on block bitmap error") is no real solution for allocating
> blocks from corrupted block groups. This is because if
> 'EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)' is true, then
> 'ext4_mb_load_buddy()' may return an error. This means that the block
> allocation will fail.
> Therefore, check block group if corrupted when ext4_mb_load_buddy()
> returns error.
> 
> Fixes: 163a203ddb36 ("ext4: mark block group as corrupt on block bitmap error")
> Fixes: 9008a58e5dce ("ext4: make the bitmap read routines return real error codes")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index e2341489f4d0..ffa6886de8a3 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2443,8 +2443,12 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
>  		return 0;
>  
>  	err = ext4_mb_load_buddy(ac->ac_sb, group, e4b);
> -	if (err)
> +	if (err) {
> +		if (EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info) &&
> +		    !(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
> +			return 0;
>  		return err;
> +	}
>  
>  	ext4_lock_group(ac->ac_sb, group);
>  	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

