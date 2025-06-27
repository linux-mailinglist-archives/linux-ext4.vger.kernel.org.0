Return-Path: <linux-ext4+bounces-8681-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBED9AEBF16
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Jun 2025 20:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B3A17B450
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Jun 2025 18:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3C52EA753;
	Fri, 27 Jun 2025 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dgPHdGs4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xNh6E+95";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YGjr8Q8s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hrjKs/vA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02E11E22FC
	for <linux-ext4@vger.kernel.org>; Fri, 27 Jun 2025 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751049211; cv=none; b=dUbLUrpSRcj5ceK/0SubFqXbJEhG7e1y+2R9Z2xQOvH2AvpS+vcHDK314smc8CdODl2CikGubWo4nJRKeIYKRXWyDpQ+PVP6kbJgARlj85oqgAqvYYK7kcqXaTpQ6dQuyd20CHSuGs7SBqVJFcJC7rqyXXFRuvZ8lPpeRT8V2w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751049211; c=relaxed/simple;
	bh=LFdvlMY3TCqK4PRtgCei2Vpx/E4wStOIaecqT6ZOtU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+x9S+jZ58gPc+cwHc9tNjCrVf1Kx2ZAF+i/AdIfoaeICft1LHv3/MF36dHuFpxKvvSCzOND3RqaIMtqRIZl3PncUKWJYhqITLjX7LeLfMR2xmSaBgl5uxyX4hCgNnl+kTXW+VOxlum+PKmvU36zoQV7AJ7PXwjrhodUdT72Iu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dgPHdGs4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xNh6E+95; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YGjr8Q8s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hrjKs/vA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EBAC81F390;
	Fri, 27 Jun 2025 18:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751049204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6oRt6nVMCmDpOH4aMgxdoDBrGumgwgOaEOZ7NzWu0N4=;
	b=dgPHdGs4YmmLr5vEaIZWlDKHeUGWJXVoQesD6IT+XcCTtFWeURk3mfNZzbSVIY8IsA8jsW
	lbeCwJOGDr726kMXdjqqvLSvURVaGvTzek2foqRWTCMbrbh0tM/CSxMjOzTIwSO2QbeJOM
	x0POoFhx49nN/zgNBBLo9P8hWCL2g/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751049204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6oRt6nVMCmDpOH4aMgxdoDBrGumgwgOaEOZ7NzWu0N4=;
	b=xNh6E+95sb8wX6QGofCmy2z/DNKUF/ZslSd2esJYAwX76olXEswfNJToHCPZ5KQHjnd/pt
	DlQQ/yjnCnPrtiCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YGjr8Q8s;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="hrjKs/vA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751049203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6oRt6nVMCmDpOH4aMgxdoDBrGumgwgOaEOZ7NzWu0N4=;
	b=YGjr8Q8sh1i0hDViiW+E5ofYy239qvViV7O8Ey1Q07oJGjYm9r9EkgPAnFlsJNpyXzwnCw
	49hUM+7tXVGLp37cKv4ca5ZDtp+/ucw+ixyLaZqdgW8WDJFCd7MEytMm3Zn+8ip1ExHNkJ
	1K8IsTwYM0Y0BNZVX51oi2Jn//LlNWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751049203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6oRt6nVMCmDpOH4aMgxdoDBrGumgwgOaEOZ7NzWu0N4=;
	b=hrjKs/vA2/6gtHySr1Ue6sfmwlqUfIMF8NNuOntLjBreUMZIvtJjorq70jVCa9em6C/3pk
	yh2ZfduBxznMFCCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3EBF13786;
	Fri, 27 Jun 2025 18:33:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pcxkM/PjXmhjFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Jun 2025 18:33:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 31A4EA08D2; Fri, 27 Jun 2025 20:33:23 +0200 (CEST)
Date: Fri, 27 Jun 2025 20:33:23 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 07/16] ext4: convert sbi->s_mb_free_pending to atomic_t
Message-ID: <kn22zrgititzedfjutzudq6i3qn26ukmg26g7nzmgwahkrn3r7@bhpccisxsvz2>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-8-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623073304.3275702-8-libaokun1@huawei.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EBAC81F390
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Mon 23-06-25 15:32:55, Baokun Li wrote:
> Previously, s_md_lock was used to protect s_mb_free_pending during
> modifications, while smp_mb() ensured fresh reads, so s_md_lock just
> guarantees the atomicity of s_mb_free_pending. Thus we optimized it by
> converting s_mb_free_pending into an atomic variable, thereby eliminating
> s_md_lock and minimizing lock contention. This also prepares for future
> lockless merging of free extents.
> 
> Following this modification, s_md_lock is exclusively responsible for
> managing insertions and deletions within s_freed_data_list, along with
> operations involving list_splice.
> 
> Performance test data follows:
> 
> Test: Running will-it-scale/fallocate2 on CPU-bound containers.
> Observation: Average fallocate operations per container per second.
> 
>                    | Kunpeng 920 / 512GB -P80|  AMD 9654 / 1536GB -P96 |
>  Disk: 960GB SSD   |-------------------------|-------------------------|
>                    | base  |    patched      | base  |    patched      |
> -------------------|-------|-----------------|-------|-----------------|
> mb_optimize_scan=0 | 19699 | 20982 (+6.5%)   | 53093 | 50629 (-4.6%)   |
> mb_optimize_scan=1 | 9862  | 10703 (+8.5%)   | 14401 | 14856 (+3.1%)   |
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/balloc.c  | 2 +-
>  fs/ext4/ext4.h    | 2 +-
>  fs/ext4/mballoc.c | 9 +++------
>  3 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index c48fd36b2d74..c9329ed5c094 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -703,7 +703,7 @@ int ext4_should_retry_alloc(struct super_block *sb, int *retries)
>  	 * possible we just missed a transaction commit that did so
>  	 */
>  	smp_mb();
> -	if (sbi->s_mb_free_pending == 0) {
> +	if (atomic_read(&sbi->s_mb_free_pending) == 0) {
>  		if (test_opt(sb, DISCARD)) {
>  			atomic_inc(&sbi->s_retry_alloc_pending);
>  			flush_work(&sbi->s_discard_work);
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 294198c05cdd..003b8d3726e8 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1602,7 +1602,7 @@ struct ext4_sb_info {
>  	unsigned short *s_mb_offsets;
>  	unsigned int *s_mb_maxs;
>  	unsigned int s_group_info_size;
> -	unsigned int s_mb_free_pending;
> +	atomic_t s_mb_free_pending;
>  	struct list_head s_freed_data_list[2];	/* List of blocks to be freed
>  						   after commit completed */
>  	struct list_head s_discard_list;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 216b332a5054..5410fb3688ee 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3680,7 +3680,7 @@ int ext4_mb_init(struct super_block *sb)
>  	}
>  
>  	spin_lock_init(&sbi->s_md_lock);
> -	sbi->s_mb_free_pending = 0;
> +	atomic_set(&sbi->s_mb_free_pending, 0);
>  	INIT_LIST_HEAD(&sbi->s_freed_data_list[0]);
>  	INIT_LIST_HEAD(&sbi->s_freed_data_list[1]);
>  	INIT_LIST_HEAD(&sbi->s_discard_list);
> @@ -3894,10 +3894,7 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
>  	/* we expect to find existing buddy because it's pinned */
>  	BUG_ON(err != 0);
>  
> -	spin_lock(&EXT4_SB(sb)->s_md_lock);
> -	EXT4_SB(sb)->s_mb_free_pending -= entry->efd_count;
> -	spin_unlock(&EXT4_SB(sb)->s_md_lock);
> -
> +	atomic_sub(entry->efd_count, &EXT4_SB(sb)->s_mb_free_pending);
>  	db = e4b.bd_info;
>  	/* there are blocks to put in buddy to make them really free */
>  	count += entry->efd_count;
> @@ -6392,7 +6389,7 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
>  
>  	spin_lock(&sbi->s_md_lock);
>  	list_add_tail(&new_entry->efd_list, &sbi->s_freed_data_list[new_entry->efd_tid & 1]);
> -	sbi->s_mb_free_pending += clusters;
> +	atomic_add(clusters, &sbi->s_mb_free_pending);
>  	spin_unlock(&sbi->s_md_lock);
>  }
>  
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

