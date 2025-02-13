Return-Path: <linux-ext4+bounces-6447-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC02DA34201
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 15:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF0B7A5978
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 14:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9375281364;
	Thu, 13 Feb 2025 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xxayU8/o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QOetGoEw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xxayU8/o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QOetGoEw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8E4281343;
	Thu, 13 Feb 2025 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456973; cv=none; b=t8wDIY5y33g+cfLBHBs5BjfcKl40nXrvU+i4tARShQ35ytqBhKDsGv6kJt1jpU98BhwfR9Jt5URtDMn0MPllPEUlyF4UKqQE1vOcBY/iX7iLmo++8596Vr2Wy6bhLy71sP3c7pJYtIVePvX/aLailXW7Ee8AGpe5uDv/H/ZPXH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456973; c=relaxed/simple;
	bh=rAiv6TzHkeELsrLuZtk5FUe5Thv+lNBT27iUuGBHh7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCsYgkFXVNAFAuPZrMw0AGF9cWVudCTOwo1lVzvsPTy47Z6MEx3TWzDrp6oux8nIxDRdBnbLMBlUpD55emI/RUxzL5tpt/hkiNVr9gn6+DdlOjEDMwop0dcTJobyPVcwWka9XaPaoRSAq1QRcekz0Gy7004kDPbFNmJYct5VP4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xxayU8/o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QOetGoEw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xxayU8/o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QOetGoEw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B58B22652;
	Thu, 13 Feb 2025 14:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739456964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b08r9aID4TkiRVyoZGQPuYyotWopcKELHRkumgjrwAc=;
	b=xxayU8/o5cFo+GrXPM7qJd4gbNwPD3kf/QoA169ds6tqxxvhqWxNW+TFVTO0AHO+d52C6d
	4fffugqvXbQ1mDuFgjeDEEBJNfF2aCJnlpJ1qJVkZQ2fyCqKTNkI6hpdGAU/jHeushiqx7
	lbP+FAwb2F2xOupAtF/Aw7ydg/GH6RY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739456964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b08r9aID4TkiRVyoZGQPuYyotWopcKELHRkumgjrwAc=;
	b=QOetGoEwa4d2cmE9zMTDCWidfZi2Zl2V5cH/PE+mzWMpM5oksGYasXFG/ShYkDKA74KMKQ
	FUaJNtQW7k75sIAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739456964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b08r9aID4TkiRVyoZGQPuYyotWopcKELHRkumgjrwAc=;
	b=xxayU8/o5cFo+GrXPM7qJd4gbNwPD3kf/QoA169ds6tqxxvhqWxNW+TFVTO0AHO+d52C6d
	4fffugqvXbQ1mDuFgjeDEEBJNfF2aCJnlpJ1qJVkZQ2fyCqKTNkI6hpdGAU/jHeushiqx7
	lbP+FAwb2F2xOupAtF/Aw7ydg/GH6RY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739456964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b08r9aID4TkiRVyoZGQPuYyotWopcKELHRkumgjrwAc=;
	b=QOetGoEwa4d2cmE9zMTDCWidfZi2Zl2V5cH/PE+mzWMpM5oksGYasXFG/ShYkDKA74KMKQ
	FUaJNtQW7k75sIAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00BC2137DB;
	Thu, 13 Feb 2025 14:29:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vhwmAMQBrmc1aAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 13 Feb 2025 14:29:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F373DA0A07; Thu, 13 Feb 2025 15:29:18 +0100 (CET)
Date: Thu, 13 Feb 2025 15:29:18 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, bfoster@redhat.com, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH] ext4: goto right label 'out_mmap_sem' in ext4_setattr()
Message-ID: <c27l5iylz6t3qfd4v6sbwfvb4v6e4rifspbwts2u6w4i2wgqli@yorbu3soqgye>
References: <20250213112247.3168709-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213112247.3168709-1-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 13-02-25 19:22:47, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Otherwise, if ext4_inode_attach_jinode() fails, a hung task will
> happen because filemap_invalidate_unlock() isn't called to unlock
> mapping->invalidate_lock. Like this:
> 
> EXT4-fs error (device sda) in ext4_setattr:5557: Out of memory
> INFO: task fsstress:374 blocked for more than 122 seconds.
>       Not tainted 6.14.0-rc1-next-20250206-xfstests-dirty #726
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:fsstress state:D stack:0     pid:374   tgid:374   ppid:373
>                                   task_flags:0x440140 flags:0x00000000
> Call Trace:
>  <TASK>
>  __schedule+0x2c9/0x7f0
>  schedule+0x27/0xa0
>  schedule_preempt_disabled+0x15/0x30
>  rwsem_down_read_slowpath+0x278/0x4c0
>  down_read+0x59/0xb0
>  page_cache_ra_unbounded+0x65/0x1b0
>  filemap_get_pages+0x124/0x3e0
>  filemap_read+0x114/0x3d0
>  vfs_read+0x297/0x360
>  ksys_read+0x6c/0xe0
>  do_syscall_64+0x4b/0x110
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fixes: c7fc0366c656 ("ext4: partial zero eof block on unaligned inode size extension")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Indeed. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 3cc8da6357aa..04ffd802dbde 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5452,7 +5452,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  			    oldsize & (inode->i_sb->s_blocksize - 1)) {
>  				error = ext4_inode_attach_jinode(inode);
>  				if (error)
> -					goto err_out;
> +					goto out_mmap_sem;
>  			}
>  
>  			handle = ext4_journal_start(inode, EXT4_HT_INODE, 3);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

