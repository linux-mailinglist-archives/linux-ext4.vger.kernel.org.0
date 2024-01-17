Return-Path: <linux-ext4+bounces-836-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB9283064B
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jan 2024 13:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0DB1C2195A
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jan 2024 12:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9957B1EB2B;
	Wed, 17 Jan 2024 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tQ43QOUk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BLxe8sxv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tQ43QOUk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BLxe8sxv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CE61F5E7
	for <linux-ext4@vger.kernel.org>; Wed, 17 Jan 2024 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496213; cv=none; b=HeUfL7EbKrjTb448NhGuzTUBTzbyvtVBXfSfSE1h8jO5AGLQxE45Gqjw4Wsl3fg0o9SV2v/QB+3gGhnO4YDVllVAM6LI8O35j3GhwS/Cnqlpftu1kLVz/qIrBDB1w2exeKeVeDEuS9ewwlq/VzxiExD8qAqEefFDC0UwLYTSAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496213; c=relaxed/simple;
	bh=qQRXZoxPlp8bLjVLR1MbfO6K1IssHAx056W61Kso0uc=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spamd-Result:X-Rspamd-Server:
	 X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Level:X-Spam-Flag:
	 X-Spamd-Bar; b=oHwC6oT7zzudbsZy6xAUMgnoCnMSbojFS6bZAUbjsNhpyAbZnMgKQdXbUniXKquQk+ii0n1PG+zX/Qbbd6XOPCaKEpLjlcqO1xhH8i/BWXNPTjzJattPMtYB7OE5hvJ0hDJTlM+VpBlfuG03deB7HLgdEnxbMCfbnifhJ4+gv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tQ43QOUk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BLxe8sxv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tQ43QOUk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BLxe8sxv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 304DA22271;
	Wed, 17 Jan 2024 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705496208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kYpMVtDaP5IdY96L2ZQH9zl2Dr903ZmSPUV6/SzUphY=;
	b=tQ43QOUka3qPuut2GjkzqpD7yRqmoirQ0OLbisQpAWNog/ekSjPNTpp9msxNk/I7hrIymm
	cGyCDtzdSdE6LF0X/W+Ak38Z+6RQFDJj19JgZNJk8MI/wP5yPJSl5XdTXz9Vf+m4XCXkv5
	djgxKPXvZ/4K7CxDDyGlar8geZg+lP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705496208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kYpMVtDaP5IdY96L2ZQH9zl2Dr903ZmSPUV6/SzUphY=;
	b=BLxe8sxvkYgDtqckxQlJ49ap8rm0X0JI/ZOYcONvcNCFNf4EsHmSLAUnfsteyCpLGKYaPH
	BZpuH4jCm3MYI7DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705496208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kYpMVtDaP5IdY96L2ZQH9zl2Dr903ZmSPUV6/SzUphY=;
	b=tQ43QOUka3qPuut2GjkzqpD7yRqmoirQ0OLbisQpAWNog/ekSjPNTpp9msxNk/I7hrIymm
	cGyCDtzdSdE6LF0X/W+Ak38Z+6RQFDJj19JgZNJk8MI/wP5yPJSl5XdTXz9Vf+m4XCXkv5
	djgxKPXvZ/4K7CxDDyGlar8geZg+lP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705496208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kYpMVtDaP5IdY96L2ZQH9zl2Dr903ZmSPUV6/SzUphY=;
	b=BLxe8sxvkYgDtqckxQlJ49ap8rm0X0JI/ZOYcONvcNCFNf4EsHmSLAUnfsteyCpLGKYaPH
	BZpuH4jCm3MYI7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2696413800;
	Wed, 17 Jan 2024 12:56:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IBNoCZDOp2UjYwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jan 2024 12:56:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BCC19A0803; Wed, 17 Jan 2024 13:56:47 +0100 (CET)
Date: Wed, 17 Jan 2024 13:56:47 +0100
From: Jan Kara <jack@suse.cz>
To: yangerkun <yangerkun@huawei.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	linux-ext4@vger.kernel.org, yangerkun@huaweicloud.com
Subject: Re: [PATCH 1/2] ext4: remove unused buddy_loaded in
 ext4_mb_seq_groups_show
Message-ID: <20240117125647.4gyqfhngii2dxnlo@quack3>
References: <20240117115223.80253-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117115223.80253-1-yangerkun@huawei.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tQ43QOUk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BLxe8sxv
X-Spamd-Result: default: False [0.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.19
X-Rspamd-Queue-Id: 304DA22271
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Wed 17-01-24 19:52:22, yangerkun wrote:
> We can just first call ext4_mb_unload_buddy, then copy information from
> ext4_group_info. So remove this unused value.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Although I'd prefer if you add a comment before memcpy() like:

	/*
	 * We care only about free space counters in the group info and
	 * these are safe to access even after the buddy has been unloaded
	 */

								Honza

> ---
>  fs/ext4/mballoc.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index f44f668e407f..139f232bdbb5 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2990,8 +2990,7 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
>  {
>  	struct super_block *sb = pde_data(file_inode(seq->file));
>  	ext4_group_t group = (ext4_group_t) ((unsigned long) v);
> -	int i;
> -	int err, buddy_loaded = 0;
> +	int i, err;
>  	struct ext4_buddy e4b;
>  	struct ext4_group_info *grinfo;
>  	unsigned char blocksize_bits = min_t(unsigned char,
> @@ -3021,14 +3020,10 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
>  			seq_printf(seq, "#%-5u: I/O error\n", group);
>  			return 0;
>  		}
> -		buddy_loaded = 1;
> +		ext4_mb_unload_buddy(&e4b);
>  	}
>  
>  	memcpy(&sg, grinfo, i);
> -
> -	if (buddy_loaded)
> -		ext4_mb_unload_buddy(&e4b);
> -
>  	seq_printf(seq, "#%-5u: %-5u %-5u %-5u [", group, sg.info.bb_free,
>  			sg.info.bb_fragments, sg.info.bb_first_free);
>  	for (i = 0; i <= 13; i++)
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

