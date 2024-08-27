Return-Path: <linux-ext4+bounces-3925-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD0596166D
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 20:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19AD31F23BEE
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 18:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708851D1F7F;
	Tue, 27 Aug 2024 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ee55fad9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NlR7KR9v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ee55fad9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NlR7KR9v"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1731CBE8F;
	Tue, 27 Aug 2024 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782055; cv=none; b=FF1Xcu7VQdKhpEIxpblUwM07hXZQJRhHG8SUZ8fjP5Lb2TDR/0D32EaOpF6C+ZMjsZq1q+Ib5z774sCgNw3Ua+1+mrzUUVQCj+0JIkD8ZhrbCpEsZDE7G+w4U0xiWb5j5m1STHQMc+ZWAfRmXnsg9gs0W26FnolVy1/GoKeCSoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782055; c=relaxed/simple;
	bh=HD0DU6/Ak4uG6iNwnuS9V1ryHdCYVLwO8f5Yn3oUj40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCFg2rsX1fktGL4UddyceKDg0+Wb8TdeGxmgJkxG8URemb4FzW/4Ve48Q7iURcwxvMQhG7ABiTvRhFgX+/olX/4DyqjoOyBs40UIwbGAk6cEU5QJM4tvspGc5fL9AOVmR7UDz2W2htk5MZf/MBbI7y48JQvThJKZQMdg8Ok5qMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ee55fad9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NlR7KR9v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ee55fad9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NlR7KR9v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31D4121998;
	Tue, 27 Aug 2024 18:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724782051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WKGdn9+0SrYc0yQIW+Fi1/KCIXluwxO27U17KX1tvIk=;
	b=Ee55fad9qnhuJoy2b3Xu7VFnEC6VKzm6KbAdQkbT6AlpcnW6++3eNyGbRd6Fh29QqIvcE7
	FilvH1QPIvaMaqQDaEnL2A4FwAzkZqycLqieaapQ+dpFkMBrfOismLQp+dEHz7GytaZuhG
	1McJvVBoNHIMOhW03MqTk9BPZvgltSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724782051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WKGdn9+0SrYc0yQIW+Fi1/KCIXluwxO27U17KX1tvIk=;
	b=NlR7KR9vDfBdieymY/0271OqZh17zIvYDACtRCwQXrmjxwvdLjz4j+Uqs7l7Y7NuRFNIFb
	1BRg9sF8t4bZVdBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ee55fad9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NlR7KR9v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724782051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WKGdn9+0SrYc0yQIW+Fi1/KCIXluwxO27U17KX1tvIk=;
	b=Ee55fad9qnhuJoy2b3Xu7VFnEC6VKzm6KbAdQkbT6AlpcnW6++3eNyGbRd6Fh29QqIvcE7
	FilvH1QPIvaMaqQDaEnL2A4FwAzkZqycLqieaapQ+dpFkMBrfOismLQp+dEHz7GytaZuhG
	1McJvVBoNHIMOhW03MqTk9BPZvgltSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724782051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WKGdn9+0SrYc0yQIW+Fi1/KCIXluwxO27U17KX1tvIk=;
	b=NlR7KR9vDfBdieymY/0271OqZh17zIvYDACtRCwQXrmjxwvdLjz4j+Uqs7l7Y7NuRFNIFb
	1BRg9sF8t4bZVdBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24DF513A20;
	Tue, 27 Aug 2024 18:07:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fv34COMVzmY5VwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 27 Aug 2024 18:07:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E1142A0968; Tue, 27 Aug 2024 20:07:24 +0200 (CEST)
Date: Tue, 27 Aug 2024 20:07:24 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org
Subject: Re: [PATCH v2 06/25] ext4: aovid use-after-free in
 ext4_ext_insert_extent()
Message-ID: <20240827180724.7y4qnopci6exggzj@quack3>
References: <20240822023545.1994557-1-libaokun@huaweicloud.com>
 <20240822023545.1994557-7-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822023545.1994557-7-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: 31D4121998
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,linux.ibm.com,huawei.com,kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,huawei.com:email,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 22-08-24 10:35:26, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> As Ojaswin mentioned in Link, in ext4_ext_insert_extent(), if the path is
> reallocated in ext4_ext_create_new_leaf(), we'll use the stale path and
> cause UAF. Below is a sample trace with dummy values:
> 
> ext4_ext_insert_extent
>   path = *ppath = 2000
>   ext4_ext_create_new_leaf(ppath)
>     ext4_find_extent(ppath)
>       path = *ppath = 2000
>       if (depth > path[0].p_maxdepth)
>             kfree(path = 2000);
>             *ppath = path = NULL;
>       path = kcalloc() = 3000
>       *ppath = 3000;
>       return path;
>   /* here path is still 2000, UAF! */
>   eh = path[depth].p_hdr
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in ext4_ext_insert_extent+0x26d4/0x3330
> Read of size 8 at addr ffff8881027bf7d0 by task kworker/u36:1/179
> CPU: 3 UID: 0 PID: 179 Comm: kworker/u6:1 Not tainted 6.11.0-rc2-dirty #866
> Call Trace:
>  <TASK>
>  ext4_ext_insert_extent+0x26d4/0x3330
>  ext4_ext_map_blocks+0xe22/0x2d40
>  ext4_map_blocks+0x71e/0x1700
>  ext4_do_writepages+0x1290/0x2800
> [...]
> 
> Allocated by task 179:
>  ext4_find_extent+0x81c/0x1f70
>  ext4_ext_map_blocks+0x146/0x2d40
>  ext4_map_blocks+0x71e/0x1700
>  ext4_do_writepages+0x1290/0x2800
>  ext4_writepages+0x26d/0x4e0
>  do_writepages+0x175/0x700
> [...]
> 
> Freed by task 179:
>  kfree+0xcb/0x240
>  ext4_find_extent+0x7c0/0x1f70
>  ext4_ext_insert_extent+0xa26/0x3330
>  ext4_ext_map_blocks+0xe22/0x2d40
>  ext4_map_blocks+0x71e/0x1700
>  ext4_do_writepages+0x1290/0x2800
>  ext4_writepages+0x26d/0x4e0
>  do_writepages+0x175/0x700
> [...]
> ==================================================================
> 
> So use *ppath to update the path to avoid the above problem.
> 
> Reported-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Closes: https://lore.kernel.org/r/ZqyL6rmtwl6N4MWR@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com
> Fixes: 10809df84a4d ("ext4: teach ext4_ext_find_extent() to realloc path if necessary")
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
> index 5879aef159d8..91c6586afcca 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -2116,6 +2116,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  				       ppath, newext);
>  	if (err)
>  		goto cleanup;
> +	path = *ppath;
>  	depth = ext_depth(inode);
>  	eh = path[depth].p_hdr;
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

