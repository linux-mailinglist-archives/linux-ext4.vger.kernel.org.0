Return-Path: <linux-ext4+bounces-737-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8209C827615
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Jan 2024 18:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8911F233C3
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Jan 2024 17:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184EF54750;
	Mon,  8 Jan 2024 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ki3VV2lW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3u+5h8VJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ki3VV2lW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3u+5h8VJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA4354662
	for <linux-ext4@vger.kernel.org>; Mon,  8 Jan 2024 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B01F21D81;
	Mon,  8 Jan 2024 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704734106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wr6NEoBhGORJ7z25w5NDPO6t9R4UmpbPXzDDaTnPue0=;
	b=Ki3VV2lWyAW1blB7+tOIlCCTh44RpnRWVmmG/T8Wr4VcKeLZQjcJwJf9oUYlGn7U72OCOa
	A5aOWKKKEmbIMLwuvMlkOwVVY80y2WEKXQBHTSvgzfFPR4vrDX1xAv9kkEhcqJRk5F0q7A
	ix6KBjK0Z/c9k7U4dGaBfWmVXcmKT0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704734106;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wr6NEoBhGORJ7z25w5NDPO6t9R4UmpbPXzDDaTnPue0=;
	b=3u+5h8VJs1EFWO6FTyZc8BljjLgvzjl/PVfGEMse9nq3mIY28rbEyxZ+87T7lERZw+uM/k
	U65pknEXnJyGOMCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704734106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wr6NEoBhGORJ7z25w5NDPO6t9R4UmpbPXzDDaTnPue0=;
	b=Ki3VV2lWyAW1blB7+tOIlCCTh44RpnRWVmmG/T8Wr4VcKeLZQjcJwJf9oUYlGn7U72OCOa
	A5aOWKKKEmbIMLwuvMlkOwVVY80y2WEKXQBHTSvgzfFPR4vrDX1xAv9kkEhcqJRk5F0q7A
	ix6KBjK0Z/c9k7U4dGaBfWmVXcmKT0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704734106;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wr6NEoBhGORJ7z25w5NDPO6t9R4UmpbPXzDDaTnPue0=;
	b=3u+5h8VJs1EFWO6FTyZc8BljjLgvzjl/PVfGEMse9nq3mIY28rbEyxZ+87T7lERZw+uM/k
	U65pknEXnJyGOMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E5641392C;
	Mon,  8 Jan 2024 17:15:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FD+4IpotnGV+LQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Jan 2024 17:15:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 33D74A07EB; Mon,  8 Jan 2024 18:15:06 +0100 (CET)
Date: Mon, 8 Jan 2024 18:15:06 +0100
From: Jan Kara <jack@suse.cz>
To: Fengnan Chang <changfengnan@bytedance.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6] ext4: improve trim efficiency
Message-ID: <20240108171506.k47t4qztbbhulsp3@quack3>
References: <20230901092820.33757-1-changfengnan@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901092820.33757-1-changfengnan@bytedance.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Fri 01-09-23 17:28:20, Fengnan Chang wrote:
> In commit a015434480dc("ext4: send parallel discards on commit
> completions"), issue all discard commands in parallel make all
> bios could merged into one request, so lowlevel drive can issue
> multi segments in one time which is more efficiency, but commit
> 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread contex")
> seems broke this way, let's fix it.
> 
> In my test:
> 1. create 10 normal files, each file size is 10G.
> 2. deallocate file, punch a 16k holes every 32k.
> 3. trim all fs.
> the time of fstrim fs reduce from 6.7s to 1.3s.
> 
> Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>

This seems to have fallen through the cracks... I'm sorry for that.

>  static int ext4_try_to_trim_range(struct super_block *sb,
>  		struct ext4_buddy *e4b, ext4_grpblk_t start,
>  		ext4_grpblk_t max, ext4_grpblk_t minblocks)
>  __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
>  __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>  {
> -	ext4_grpblk_t next, count, free_count;
> +	ext4_grpblk_t next, count, free_count, bak;
>  	void *bitmap;
> +	struct ext4_free_data *entry = NULL, *fd, *nfd;
> +	struct list_head discard_data_list;
> +	struct bio *discard_bio = NULL;
> +	struct blk_plug plug;
> +	ext4_group_t group = e4b->bd_group;
> +	struct ext4_free_extent ex;
> +	bool noalloc = false;
> +	int ret = 0;
> +
> +	INIT_LIST_HEAD(&discard_data_list);
>  
>  	bitmap = e4b->bd_bitmap;
>  	start = max(e4b->bd_info->bb_first_free, start);
>  	count = 0;
>  	free_count = 0;
>  
> +	blk_start_plug(&plug);
>  	while (start <= max) {
>  		start = mb_find_next_zero_bit(bitmap, max + 1, start);
>  		if (start > max)
>  			break;
> +		bak = start;
>  		next = mb_find_next_bit(bitmap, max + 1, start);
> -
>  		if ((next - start) >= minblocks) {
> -			int ret = ext4_trim_extent(sb, start, next - start, e4b);
> +			/* when only one segment, there is no need to alloc entry */
> +			noalloc = (free_count == 0) && (next >= max);

Is the single extent case really worth the complications to save one
allocation? I don't think it is but maybe I'm missing something. Otherwise
the patch looks good to me!

								Honza

>  
> -			if (ret && ret != -EOPNOTSUPP)
> +			trace_ext4_trim_extent(sb, group, start, next - start);
> +			ex.fe_start = start;
> +			ex.fe_group = group;
> +			ex.fe_len = next - start;
> +			/*
> +			 * Mark blocks used, so no one can reuse them while
> +			 * being trimmed.
> +			 */
> +			mb_mark_used(e4b, &ex);
> +			ext4_unlock_group(sb, group);
> +			ret = ext4_issue_discard(sb, group, start, next - start, &discard_bio);
> +			if (!noalloc) {
> +				entry = kmem_cache_alloc(ext4_free_data_cachep,
> +							GFP_NOFS|__GFP_NOFAIL);
> +				entry->efd_start_cluster = start;
> +				entry->efd_count = next - start;
> +				list_add_tail(&entry->efd_list, &discard_data_list);
> +			}
> +			ext4_lock_group(sb, group);
> +			if (ret < 0)
>  				break;
>  			count += next - start;
>  		}
> @@ -6959,6 +6950,22 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>  			break;
>  	}
>  
> +	if (discard_bio) {
> +		ext4_unlock_group(sb, e4b->bd_group);
> +		submit_bio_wait(discard_bio);
> +		bio_put(discard_bio);
> +		ext4_lock_group(sb, e4b->bd_group);
> +	}
> +	blk_finish_plug(&plug);
> +
> +	if (noalloc && free_count)
> +		mb_free_blocks(NULL, e4b, bak, free_count);
> +
> +	list_for_each_entry_safe(fd, nfd, &discard_data_list, efd_list) {
> +		mb_free_blocks(NULL, e4b, fd->efd_start_cluster, fd->efd_count);
> +		kmem_cache_free(ext4_free_data_cachep, fd);
> +	}
> +
>  	return count;
>  }
>  
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

