Return-Path: <linux-ext4+bounces-1627-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9898D87BB4E
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 11:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16AE11F21E08
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 10:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F3962A02;
	Thu, 14 Mar 2024 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pvHPUSFf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GFzeyqTz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pvHPUSFf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GFzeyqTz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB2E4691;
	Thu, 14 Mar 2024 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412337; cv=none; b=Ut4e6UhQJDJbMoEOAh6tuQw6E4/7+kZpoRvdcCK/QLzhljkWVHQbcKcQNWC3CSxOA3tm2DOhQ96Zqvtcnvgw7AnE/vE9qKo+5y1zuM3l7WMcZ6X2CL8Yiw8/ESQurg1NPUYhneruoKNH/oMbyHkD2fRaopI0ttyER5ZGqGidTGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412337; c=relaxed/simple;
	bh=vw7wdm23uwZS6pIphnjO7/AoU/8xbWPwZ8qFWQYdYvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmg9WcmZ8UA6qJtAB/KK8IJVaTWCFIX+fQ6z+FXzFXzX3kozWKSfIlfi7/EKiMj5uwkLMGGqCVNPrmo0GNkf5t0RcvRNZ0TlbrZwjikoZCypE/FFSkz3osNseThEfi510XlzxLmfRTsEacYft4vEQ9JFLg6BmDm+ZkiLlflKB6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pvHPUSFf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GFzeyqTz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pvHPUSFf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GFzeyqTz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 77B8A1F846;
	Thu, 14 Mar 2024 10:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710412333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymEO7u+fo57Ow5kqOP3hpL0SJhTPlU4JkUffUxB9ezM=;
	b=pvHPUSFfwz8+Wyf9czzRvOicFs3Dgvs5ZodlsrNBNODVaGOSWkQZ0uvHRtweWc0IkC7y7b
	Qv5RdgQMRzOeuXRm3TQ5PBgq65N1rdCQ9loa5+87tGY+p6Qz1I3ChWtNVvPcOkwSlrdd9L
	WGvO7ANNTEZbA9ZmoLbrGI1ZWdzSQBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710412333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymEO7u+fo57Ow5kqOP3hpL0SJhTPlU4JkUffUxB9ezM=;
	b=GFzeyqTzb7GOitLngWldaSxWFgEhU4NE+7fmS+JCGQ8nS4b9IuntfwHNTTXNzR1DfZS0cm
	Sqmy1CqWgCJtc8Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710412333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymEO7u+fo57Ow5kqOP3hpL0SJhTPlU4JkUffUxB9ezM=;
	b=pvHPUSFfwz8+Wyf9czzRvOicFs3Dgvs5ZodlsrNBNODVaGOSWkQZ0uvHRtweWc0IkC7y7b
	Qv5RdgQMRzOeuXRm3TQ5PBgq65N1rdCQ9loa5+87tGY+p6Qz1I3ChWtNVvPcOkwSlrdd9L
	WGvO7ANNTEZbA9ZmoLbrGI1ZWdzSQBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710412333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymEO7u+fo57Ow5kqOP3hpL0SJhTPlU4JkUffUxB9ezM=;
	b=GFzeyqTzb7GOitLngWldaSxWFgEhU4NE+7fmS+JCGQ8nS4b9IuntfwHNTTXNzR1DfZS0cm
	Sqmy1CqWgCJtc8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67627139E7;
	Thu, 14 Mar 2024 10:32:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o741GS3S8mUfUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 14 Mar 2024 10:32:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 294B2A07D9; Thu, 14 Mar 2024 11:32:13 +0100 (CET)
Date: Thu, 14 Mar 2024 11:32:13 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
	adobriyan@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 5/9] ext4: add new attr pointer attr_mb_order
Message-ID: <20240314103213.vj3uvtq7cpms7c2x@quack3>
References: <20240227091148.178435-1-libaokun1@huawei.com>
 <20240227091148.178435-6-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227091148.178435-6-libaokun1@huawei.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pvHPUSFf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GFzeyqTz
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,huawei.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,linux.ibm.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 77B8A1F846
X-Spam-Flag: NO

On Tue 27-02-24 17:11:44, Baokun Li wrote:
> The s_mb_best_avail_max_trim_order is of type unsigned int, and has a
> range of values well beyond the normal use of the mb_order. Although the
> mballoc code is careful enough that large numbers don't matter there, but
> this can mislead the sysadmin into thinking that it's normal to set such
> values. Hence add a new attr_id attr_mb_order with values in the range
> [0, 64] to avoid storing garbage values and make us more resilient to
> surprises in the future.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/sysfs.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index ddd71673176c..8e0473169458 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -30,6 +30,7 @@ typedef enum {
>  	attr_first_error_time,
>  	attr_last_error_time,
>  	attr_clusters_in_group,
> +	attr_mb_order,
>  	attr_feature,
>  	attr_pointer_ui,
>  	attr_pointer_ul,
> @@ -210,6 +211,8 @@ EXT4_ATTR_OFFSET(inode_readahead_blks, 0644, inode_readahead,
>  		 ext4_sb_info, s_inode_readahead_blks);
>  EXT4_ATTR_OFFSET(mb_group_prealloc, 0644, clusters_in_group,
>  		 ext4_sb_info, s_mb_group_prealloc);
> +EXT4_ATTR_OFFSET(mb_best_avail_max_trim_order, 0644, mb_order,
> +		 ext4_sb_info, s_mb_best_avail_max_trim_order);
>  EXT4_RW_ATTR_SBI_UI(inode_goal, s_inode_goal);
>  EXT4_RW_ATTR_SBI_UI(mb_stats, s_mb_stats);
>  EXT4_RW_ATTR_SBI_UI(mb_max_to_scan, s_mb_max_to_scan);
> @@ -225,7 +228,6 @@ EXT4_RW_ATTR_SBI_UI(warning_ratelimit_interval_ms, s_warning_ratelimit_state.int
>  EXT4_RW_ATTR_SBI_UI(warning_ratelimit_burst, s_warning_ratelimit_state.burst);
>  EXT4_RW_ATTR_SBI_UI(msg_ratelimit_interval_ms, s_msg_ratelimit_state.interval);
>  EXT4_RW_ATTR_SBI_UI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
> -EXT4_RW_ATTR_SBI_UI(mb_best_avail_max_trim_order, s_mb_best_avail_max_trim_order);
>  #ifdef CONFIG_EXT4_DEBUG
>  EXT4_RW_ATTR_SBI_UL(simulate_fail, s_simulate_fail);
>  #endif
> @@ -379,6 +381,7 @@ static ssize_t ext4_generic_attr_show(struct ext4_attr *a,
>  	switch (a->attr_id) {
>  	case attr_inode_readahead:
>  	case attr_clusters_in_group:
> +	case attr_mb_order:
>  	case attr_pointer_ui:
>  		if (a->attr_ptr == ptr_ext4_super_block_offset)
>  			return sysfs_emit(buf, "%u\n", le32_to_cpup(ptr));
> @@ -458,6 +461,14 @@ static ssize_t ext4_generic_attr_store(struct ext4_attr *a,
>  		else
>  			*((unsigned int *) ptr) = t;
>  		return len;
> +	case attr_mb_order:
> +		ret = kstrtouint(skip_spaces(buf), 0, &t);
> +		if (ret)
> +			return ret;
> +		if (t > 64)
> +			return -EINVAL;
> +		*((unsigned int *) ptr) = t;
> +		return len;
>  	case attr_clusters_in_group:
>  		ret = kstrtouint(skip_spaces(buf), 0, &t);
>  		if (ret)
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

