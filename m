Return-Path: <linux-ext4+bounces-432-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583E2811C4A
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 19:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472F31C2118F
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 18:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4342E5955C;
	Wed, 13 Dec 2023 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zzu1JxWw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="krpw4KbH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t8yLolTk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BBuQXTUR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11302132
	for <linux-ext4@vger.kernel.org>; Wed, 13 Dec 2023 10:21:56 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CA7591F455;
	Wed, 13 Dec 2023 18:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702491694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/Aerd2sXG5lfnG7ZiHPzLyB2PZueQEpt0+Mt8CUEcw=;
	b=zzu1JxWwRriosOPc5AqeFf/f+m9i+uu9l807o6a3nr7ZnQ2C5iwvpHwf5/Odsu2titc5+1
	C6qfXUUqSF/x+tgqoFXnQPrptIntoxdqUiBrEo5/5+QBjE1qrIm1kDA2odsaZp8bCAVOFA
	YMQJX9OuTadM7kOe8ky6R6fu2PXiDdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702491694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/Aerd2sXG5lfnG7ZiHPzLyB2PZueQEpt0+Mt8CUEcw=;
	b=krpw4KbHzpuiz/PBZYRtfGG7hEINAiU/eBDuiWe9B4O5BiFDNF6SBrF0aykn6q55LUbEHj
	MG+X6dVh72yJaiAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702491689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/Aerd2sXG5lfnG7ZiHPzLyB2PZueQEpt0+Mt8CUEcw=;
	b=t8yLolTkvAOWXYcv274NIfJece6Kq6uz0mJXbe96CRBncZkgDY51Hx1rlYMFvyFH0DiXZJ
	TXGXQYI/Epwf+7GoipLv9pTAHvEPxqOAa/EFJ89ugAEaqrrEsggcESKmHcVVrs8oQHIYKv
	8ilV6YLB9mgknnkDBYTNFQXZf+UImy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702491689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/Aerd2sXG5lfnG7ZiHPzLyB2PZueQEpt0+Mt8CUEcw=;
	b=BBuQXTURGix8hHMluLyrPX4enB8SwEKqaSakP6/a1wNOj17Z8+IEDA1GSnzNEg3/e5SEN5
	3WLPP+iS7CcFkeCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AFB9F1391D;
	Wed, 13 Dec 2023 18:21:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ck6WKin2eWXmAwAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 13 Dec 2023 18:21:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 32D9DA07E0; Wed, 13 Dec 2023 19:21:14 +0100 (CET)
Date: Wed, 13 Dec 2023 19:21:14 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH 3/6] ext4: correct the hole length returned by
 ext4_map_blocks()
Message-ID: <20231213182114.tzwsqpeonr5ok3j2@quack3>
References: <20231121093429.1827390-1-yi.zhang@huaweicloud.com>
 <20231121093429.1827390-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121093429.1827390-4-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spam-Flag: NO
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SEM_URIBL_UNKNOWN_FAIL(0.00)[suse.com:query timed out];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SURBL_MULTI_FAIL(0.00)[suse.com:server fail,huawei.com:server fail];
	 BAYES_HAM(-3.00)[100.00%];
	 SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[suse.com:query timed out];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On Tue 21-11-23 17:34:26, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> In ext4_map_blocks(), if we can't find a range of mapping in the
> extents cache, we are calling ext4_ext_map_blocks() to search the real
> path. But if the querying range was tail overlaped by a delayed extent,
> we can't find it on the real extent path, so the returned hole length
> could be larger than it really is.
> 
>       |          querying map          |
>       v                                v
>       |----------{-------------}{------|----------------}-----...
>       ^          ^             ^^                       ^
>       | uncached | hole extent ||     delayed extent    |
> 
> We have to adjust the mapping length to the next not hole extent's
> lblk before searching the extent path.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

So I agree the ext4_ext_determine_hole() does return a hole that does not
reflect possible delalloc extent (it doesn't even need to be straddling the
end of looked up range, does it?). But ext4_ext_put_gap_in_cache() does
actually properly trim the hole length in the status tree so I think the
problem rather is that the trimming should happen in
ext4_ext_determine_hole() instead of ext4_ext_put_gap_in_cache() and that
will also make ext4_map_blocks() return proper hole length? And then
there's no need for this special handling? Or am I missing something?

								Honza

> ---
>  fs/ext4/inode.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 4ce35f1c8b0a..94e7b8500878 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -479,6 +479,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  		    struct ext4_map_blocks *map, int flags)
>  {
>  	struct extent_status es;
> +	ext4_lblk_t next;
>  	int retval;
>  	int ret = 0;
>  #ifdef ES_AGGRESSIVE_TEST
> @@ -502,8 +503,10 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  		return -EFSCORRUPTED;
>  
>  	/* Lookup extent status tree firstly */
> -	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) &&
> -	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
> +	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +		goto uncached;
> +
> +	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
>  		if (ext4_es_is_written(&es) || ext4_es_is_unwritten(&es)) {
>  			map->m_pblk = ext4_es_pblock(&es) +
>  					map->m_lblk - es.es_lblk;
> @@ -532,6 +535,23 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  #endif
>  		goto found;
>  	}
> +	/*
> +	 * Not found, maybe a hole, need to adjust the map length before
> +	 * seraching the real extent path. It can prevent incorrect hole
> +	 * length returned if the following entries have delayed only
> +	 * ones.
> +	 */
> +	if (!(flags & EXT4_GET_BLOCKS_CREATE) && es.es_lblk > map->m_lblk) {
> +		next = es.es_lblk;
> +		if (ext4_es_is_hole(&es))
> +			next = ext4_es_skip_hole_extent(inode, map->m_lblk,
> +							map->m_len);
> +		retval = next - map->m_lblk;
> +		if (map->m_len > retval)
> +			map->m_len = retval;
> +	}
> +
> +uncached:
>  	/*
>  	 * In the query cache no-wait mode, nothing we can do more if we
>  	 * cannot find extent in the cache.
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

