Return-Path: <linux-ext4+bounces-5805-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D729F902F
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 11:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33ABD162B83
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4491C07CB;
	Fri, 20 Dec 2024 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e4yfVhhG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MigQc213";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e4yfVhhG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MigQc213"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EAA1A8402;
	Fri, 20 Dec 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734690493; cv=none; b=dydpzjU1kLHKdBcZJCtE0BbKV5hVueE77nFxK2r9OhVkfCddkM/XfBZ2EmbPLQduN1ZljJ8FOf+4z7qpdUXyuJW/Z+DmGDlb3g0agjXldL7cAkL+KjzGpPtT5zyPdRQEpCkyM/fXWcNsrlY+p7ehduPvywGHJVNXXmyd+BtMozg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734690493; c=relaxed/simple;
	bh=Yk8IJyP82CW2tV9Bep6ZurCZgDBFnXNtfOLj0jnREks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7wyuHLva67Ws30WoDt1wBIbwtUKaZYmU5b/DPgtF5MkHUDuJomcnWkGiCqjE6trXYgGev8VACD466PpTeO1xjG7blBGOGnrDEQOfsjjaUtwJlTnQo++tW1zy1BMVwEtWj44vO//Okz/7GyyNvC+f73CEMUoXqlaESG416hrjAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e4yfVhhG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MigQc213; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e4yfVhhG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MigQc213; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A12821106;
	Fri, 20 Dec 2024 10:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734690489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x3WxmlooJ4j2ExTFa3X/5D1q10aoQb4RmDkE4GfX6V4=;
	b=e4yfVhhGlN0NfSiGP+X441vdmEiKlRUmWB8M3SN5Oy41BpEZh3Ch3QLYfBZm8WJ5H4gxx9
	gIoVxxNpJS9LCUa6/h7ULXm53jEfqQXE2zNOrMfAfhF/Zt5GmCKlYwoMvz22jvfZ2YqE2o
	VqM5zs6Gu90U/Grx0Nu6ravx1azIo1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734690489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x3WxmlooJ4j2ExTFa3X/5D1q10aoQb4RmDkE4GfX6V4=;
	b=MigQc213czKkWEzYi/rFVuevTkxBD8cZbeaKShdIJXptk9cTvq0CJikv0r4E8iwXXVfMaP
	yBfMe70B0GDyNCCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=e4yfVhhG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MigQc213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734690489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x3WxmlooJ4j2ExTFa3X/5D1q10aoQb4RmDkE4GfX6V4=;
	b=e4yfVhhGlN0NfSiGP+X441vdmEiKlRUmWB8M3SN5Oy41BpEZh3Ch3QLYfBZm8WJ5H4gxx9
	gIoVxxNpJS9LCUa6/h7ULXm53jEfqQXE2zNOrMfAfhF/Zt5GmCKlYwoMvz22jvfZ2YqE2o
	VqM5zs6Gu90U/Grx0Nu6ravx1azIo1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734690489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x3WxmlooJ4j2ExTFa3X/5D1q10aoQb4RmDkE4GfX6V4=;
	b=MigQc213czKkWEzYi/rFVuevTkxBD8cZbeaKShdIJXptk9cTvq0CJikv0r4E8iwXXVfMaP
	yBfMe70B0GDyNCCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DED713AE6;
	Fri, 20 Dec 2024 10:28:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BUvTGrlGZWdDBwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Dec 2024 10:28:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 01798A08CF; Fri, 20 Dec 2024 11:28:04 +0100 (CET)
Date: Fri, 20 Dec 2024 11:28:04 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 2/5] ext4: do not convert the unwritten extents if data
 writeback fails
Message-ID: <20241220102804.m2a4zkiypahqbuvz@quack3>
References: <20241220060757.1781418-1-libaokun@huaweicloud.com>
 <20241220060757.1781418-3-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220060757.1781418-3-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: 7A12821106
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,huawei.com:email,suse.cz:email,suse.cz:dkim,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 20-12-24 14:07:54, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> When dioread_nolock is turned on (the default), it will convert unwritten
> extents to written at ext4_end_io_end(), even if the data writeback fails.
> 
> It leads to the possibility that stale data may be exposed when the
> physical block corresponding to the file data is read-only (i.e., writes
> return -EIO, but reads are normal).
> 
> Therefore a new ext4_io_end->flags EXT4_IO_END_FAILED is added, which
> indicates that some bio write-back failed in the current ext4_io_end.
> When this flag is set, the unwritten to written conversion is no longer
> performed. Users can read the data normally until the caches are dropped,
> after that, the failed extents can only be read to all 0.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h    |  3 ++-
>  fs/ext4/page-io.c | 16 ++++++++++++++--
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 4e7de7eaa374..9da0e32af02a 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -278,7 +278,8 @@ struct ext4_system_blocks {
>  /*
>   * Flags for ext4_io_end->flags
>   */
> -#define	EXT4_IO_END_UNWRITTEN	0x0001
> +#define EXT4_IO_END_UNWRITTEN	0x0001
> +#define EXT4_IO_END_FAILED	0x0002
>  
>  struct ext4_io_end_vec {
>  	struct list_head list;		/* list of io_end_vec */
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index f53b018ea259..6054ec27fb48 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -181,14 +181,25 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
>  		   "list->prev 0x%p\n",
>  		   io_end, inode->i_ino, io_end->list.next, io_end->list.prev);
>  
> -	io_end->handle = NULL;	/* Following call will use up the handle */
> -	ret = ext4_convert_unwritten_io_end_vec(handle, io_end);
> +	/*
> +	 * Do not convert the unwritten extents if data writeback fails,
> +	 * or stale data may be exposed.
> +	 */
> +	io_end->handle = NULL;  /* Following call will use up the handle */
> +	if (unlikely(io_end->flag & EXT4_IO_END_FAILED)) {
> +		ret = -EIO;
> +		if (handle)
> +			jbd2_journal_free_reserved(handle);
> +	} else {
> +		ret = ext4_convert_unwritten_io_end_vec(handle, io_end);
> +	}
>  	if (ret < 0 && !ext4_forced_shutdown(inode->i_sb)) {
>  		ext4_msg(inode->i_sb, KERN_EMERG,
>  			 "failed to convert unwritten extents to written "
>  			 "extents -- potential data loss!  "
>  			 "(inode %lu, error %d)", inode->i_ino, ret);
>  	}
> +
>  	ext4_clear_io_unwritten_flag(io_end);
>  	ext4_release_io_end(io_end);
>  	return ret;
> @@ -339,6 +350,7 @@ static void ext4_end_bio(struct bio *bio)
>  			     bio->bi_status, inode->i_ino,
>  			     (unsigned long long)
>  			     bi_sector >> (inode->i_blkbits - 9));
> +		io_end->flag |= EXT4_IO_END_FAILED;
>  		mapping_set_error(inode->i_mapping,
>  				blk_status_to_errno(bio->bi_status));
>  	}
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

