Return-Path: <linux-ext4+bounces-3430-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6C493B721
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 21:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC96AB225ED
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 19:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A39613DDC3;
	Wed, 24 Jul 2024 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pMF3WK/V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NvXDaY6h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pMF3WK/V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NvXDaY6h"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DE765E20;
	Wed, 24 Jul 2024 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847711; cv=none; b=lFP9W8EiAAdSIV+XUbc3Mb3tAAaf9474ewG1f7/KlhHb+DqId7mjKhgUpZHLnYG/7pAe7/PqKs3rrSU4oIjZHLWOj0T1YSD8NPKPmb6ffsXDWYgw88RWWfnH1NRo+GMyg12bc3msrst4TCyRM/2LGDxCPkIZJg1sA1GWGSL5Rcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847711; c=relaxed/simple;
	bh=ov+REk4lvbu8apGUCz5Urqc9PfWBv70LoFSbIuXvwrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAwn/a0xx5iovw9HtCXz44nPxsG/nAtFviiUDiQSvWIa3ZW0aXYhBKYrdYMyMofp9XoXUqXwD/I0gQHfI7d0BLq+srbKpK++gz5lp9tLwoD1j//UlKwWs9kBcigAfnyLK4QHavNElYnMGszfnTFeJCEQILSgMRkj6YvfI6QXFco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pMF3WK/V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NvXDaY6h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pMF3WK/V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NvXDaY6h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3616C219AE;
	Wed, 24 Jul 2024 19:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721847708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fqLQm5fo9pIuKstqUUmjLAOGaoPGWHgDvL4rm2e5qtc=;
	b=pMF3WK/VlM5AEUfeaxL+OK0V4DeP9fnDAhDqHxGjTRwijMs2DEwDJ9IMOt933L40v+mIZ6
	gn2n6B/O9lnvje3AGf2KK4xuMEcNBw0F6u+o1bkX0vY3elTdB4Q0oIcwibpj9ga6UNXzTr
	8RFC1peUPJblymFihbjFZYw+BAJRYhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721847708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fqLQm5fo9pIuKstqUUmjLAOGaoPGWHgDvL4rm2e5qtc=;
	b=NvXDaY6h4yKraUPNIWhx0WE1YR9/LPr9r8Or2dzudL0zvoXZLuUzyTkMASu3f1indxg2oK
	h+asctgAkuUc62DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721847708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fqLQm5fo9pIuKstqUUmjLAOGaoPGWHgDvL4rm2e5qtc=;
	b=pMF3WK/VlM5AEUfeaxL+OK0V4DeP9fnDAhDqHxGjTRwijMs2DEwDJ9IMOt933L40v+mIZ6
	gn2n6B/O9lnvje3AGf2KK4xuMEcNBw0F6u+o1bkX0vY3elTdB4Q0oIcwibpj9ga6UNXzTr
	8RFC1peUPJblymFihbjFZYw+BAJRYhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721847708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fqLQm5fo9pIuKstqUUmjLAOGaoPGWHgDvL4rm2e5qtc=;
	b=NvXDaY6h4yKraUPNIWhx0WE1YR9/LPr9r8Or2dzudL0zvoXZLuUzyTkMASu3f1indxg2oK
	h+asctgAkuUc62DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 230E713411;
	Wed, 24 Jul 2024 19:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C5GDCJxPoWZMbgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Jul 2024 19:01:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C4722A08F2; Wed, 24 Jul 2024 21:01:47 +0200 (CEST)
Date: Wed, 24 Jul 2024 21:01:47 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>, stable@kernel.org
Subject: Re: [PATCH 03/20] ext4: fix double brelse() the buffer of the
 extents path
Message-ID: <20240724190147.mqd5oz74hxo5ox5z@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-4-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-4-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-2.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

On Wed 10-07-24 12:06:37, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> In ext4_ext_try_to_merge_up(), set path[1].p_bh to NULL after it has been
> released, otherwise it may be released twice.
> 
> An example of what triggers this is as follows:
> 
>   split2    map    split1
> |--------|-------|--------|
> 
> ext4_ext_map_blocks
>  ext4_ext_handle_unwritten_extents
>   ext4_split_convert_extents
>    // path->p_depth == 0
>    ext4_split_extent
>      // 1. do split1
>      ext4_split_extent_at
>        ext4_ext_insert_extent
>          ext4_ext_create_new_leaf
>            ext4_ext_grow_indepth
>              le16_add_cpu(&neh->eh_depth, 1)
>            ext4_find_extent
>              path->p_depth = 1
>          ext4_ext_try_to_merge
>            ext4_ext_try_to_merge_up
>              path->p_depth = 0
>              brelse(path[1].p_bh)  ---> not set to NULL here
>      // 2. update path
>      ext4_find_extent
>      // 3. do split2
>      ext4_split_extent_at
>        ext4_ext_insert_extent
>          ext4_ext_create_new_leaf
>            ext4_ext_grow_indepth
>              le16_add_cpu(&neh->eh_depth, 1)
>            ext4_find_extent
>              path[0].p_bh = NULL;
>              path->p_depth = 1
>              read_extent_tree_block  ---> return err
>              // path[1].p_bh is still the old value
>  ext4_free_ext_path
>   ext4_ext_drop_refs
>    // path->p_depth == 1
>    brelse(path[1].p_bh)  ---> brelse a buffer twice
> 
> Finally got the following WARRNING when removing the buffer from lru:
> 
> ============================================
> VFS: brelse: Trying to free free buffer
> WARNING: CPU: 2 PID: 72 at fs/buffer.c:1241 __brelse+0x58/0x90
> CPU: 2 PID: 72 Comm: kworker/u19:1 Not tainted 6.9.0-dirty #716
> RIP: 0010:__brelse+0x58/0x90
> Call Trace:
>  <TASK>
>  __find_get_block+0x6e7/0x810
>  bdev_getblk+0x2b/0x480
>  __ext4_get_inode_loc+0x48a/0x1240
>  ext4_get_inode_loc+0xb2/0x150
>  ext4_reserve_inode_write+0xb7/0x230
>  __ext4_mark_inode_dirty+0x144/0x6a0
>  ext4_ext_insert_extent+0x9c8/0x3230
>  ext4_ext_map_blocks+0xf45/0x2dc0
>  ext4_map_blocks+0x724/0x1700
>  ext4_do_writepages+0x12d6/0x2a70
> [...]
> ============================================
> 
> Fixes: ecb94f5fdf4b ("ext4: collapse a single extent tree block into the inode if possible")
> Cc: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 4d589d34b30e..657baf3991c1 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -1888,6 +1888,7 @@ static void ext4_ext_try_to_merge_up(handle_t *handle,
>  	path[0].p_hdr->eh_max = cpu_to_le16(max_root);
>  
>  	brelse(path[1].p_bh);
> +	path[1].p_bh = NULL;
>  	ext4_free_blocks(handle, inode, NULL, blk, 1,
>  			 EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET);
>  }
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

