Return-Path: <linux-ext4+bounces-1628-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04DF87BB51
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 11:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8711C215EE
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 10:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696B759B6C;
	Thu, 14 Mar 2024 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KDjgmz2G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KZ2RI7x/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KDjgmz2G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KZ2RI7x/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA5D347C1;
	Thu, 14 Mar 2024 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412423; cv=none; b=du6Ybc82LhGEoefn2vQti1nxRLVTuMqgDNayxlbDQ+k1QbMoT75h0UdzDDPykVjU4BIsYErfVGzBIhvGhngJiF2LqQy+/lTTAVm+0oUzztjHXsuHkofJtPaNqqYwWXj1Poqm6wSagjFC5Ko/UGg14MlY8Xqzn43BVUwFgGWTn1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412423; c=relaxed/simple;
	bh=ZXKLVIB1m0fSMuF1GTNUjKfPE6NFABLw1foqiZj2YMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iThAPp1TGG9zSjbPYdmel6KkSoFWV55JF25f92SdsCzbptNl1HNki0yhJLSmBXINwso1fkL8jsLs7gx4BM3+Bj9m8PUJvwVHt6MgCVITczZ7vO/NrT8RWt9JUg+4HNt+vQubqxsfJzb042lwv6nJ3XCjqc//Fg4Fs0dkDHYMJfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KDjgmz2G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KZ2RI7x/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KDjgmz2G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KZ2RI7x/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 294001F844;
	Thu, 14 Mar 2024 10:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710412419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TtzFSiIKEr1T7bBqncP2DqIClM8BRRVMKUwFlDjRNf0=;
	b=KDjgmz2GObBi0/lk4omZm4RkqE+O06nXsYQ8LhDGZkUNY7n1DbBIIZM/EIF5z9RvWMQAHT
	lcPxBTLw9L+JHS7jd/hB9iaUcK0PyHiQoOxyVhGc+NX5G/pcRCsZesos5f/ehdnXVvshSS
	gNxBiRX+pzco4nZ45MXu+48LaUyo8/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710412419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TtzFSiIKEr1T7bBqncP2DqIClM8BRRVMKUwFlDjRNf0=;
	b=KZ2RI7x/zy2eZPmN8ZGZAJmEGfLCPb43rzD+auIjwzI/Zy+g/wZfIS7WWTef9x4OAE4f6s
	csXX+N0IUn0fivCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710412419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TtzFSiIKEr1T7bBqncP2DqIClM8BRRVMKUwFlDjRNf0=;
	b=KDjgmz2GObBi0/lk4omZm4RkqE+O06nXsYQ8LhDGZkUNY7n1DbBIIZM/EIF5z9RvWMQAHT
	lcPxBTLw9L+JHS7jd/hB9iaUcK0PyHiQoOxyVhGc+NX5G/pcRCsZesos5f/ehdnXVvshSS
	gNxBiRX+pzco4nZ45MXu+48LaUyo8/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710412419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TtzFSiIKEr1T7bBqncP2DqIClM8BRRVMKUwFlDjRNf0=;
	b=KZ2RI7x/zy2eZPmN8ZGZAJmEGfLCPb43rzD+auIjwzI/Zy+g/wZfIS7WWTef9x4OAE4f6s
	csXX+N0IUn0fivCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 136B7139E7;
	Thu, 14 Mar 2024 10:33:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cGq4BIPS8mWJUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 14 Mar 2024 10:33:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C26E0A07D9; Thu, 14 Mar 2024 11:33:34 +0100 (CET)
Date: Thu, 14 Mar 2024 11:33:34 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
	adobriyan@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 6/9] ext4: add positive int attr pointer to avoid
 sysfs variables overflow
Message-ID: <20240314103334.pvfgvw4dw7a27unb@quack3>
References: <20240227091148.178435-1-libaokun1@huawei.com>
 <20240227091148.178435-7-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227091148.178435-7-libaokun1@huawei.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,linux.ibm.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -1.10
X-Spam-Flag: NO

On Tue 27-02-24 17:11:45, Baokun Li wrote:
> The following variables controlled by the sysfs interface are of type
> int and are normally used in the range [0, INT_MAX], but are declared as
> attr_pointer_ui, and thus may be set to values that exceed INT_MAX and
> result in overflows to get negative values.
> 
>   err_ratelimit_burst
>   msg_ratelimit_burst
>   warning_ratelimit_burst
>   err_ratelimit_interval_ms
>   msg_ratelimit_interval_ms
>   warning_ratelimit_interval_ms
> 
> Therefore, we add attr_pointer_pi (aka positive int attr pointer) with a
> value range of 0-INT_MAX to avoid overflow.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/sysfs.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 8e0473169458..ddb54608ca2e 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -32,6 +32,7 @@ typedef enum {
>  	attr_clusters_in_group,
>  	attr_mb_order,
>  	attr_feature,
> +	attr_pointer_pi,
>  	attr_pointer_ui,
>  	attr_pointer_ul,
>  	attr_pointer_u64,
> @@ -180,6 +181,9 @@ static struct ext4_attr ext4_attr_##_name = {			\
>  #define EXT4_RO_ATTR_ES_STRING(_name,_elname,_size)			\
>  	EXT4_ATTR_STRING(_name, 0444, _size, ext4_super_block, _elname)
>  
> +#define EXT4_RW_ATTR_SBI_PI(_name,_elname)      \
> +	EXT4_ATTR_OFFSET(_name, 0644, pointer_pi, ext4_sb_info, _elname)
> +
>  #define EXT4_RW_ATTR_SBI_UI(_name,_elname)	\
>  	EXT4_ATTR_OFFSET(_name, 0644, pointer_ui, ext4_sb_info, _elname)
>  
> @@ -222,12 +226,12 @@ EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
>  EXT4_RW_ATTR_SBI_UI(mb_max_linear_groups, s_mb_max_linear_groups);
>  EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
>  EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
> -EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, s_err_ratelimit_state.interval);
> -EXT4_RW_ATTR_SBI_UI(err_ratelimit_burst, s_err_ratelimit_state.burst);
> -EXT4_RW_ATTR_SBI_UI(warning_ratelimit_interval_ms, s_warning_ratelimit_state.interval);
> -EXT4_RW_ATTR_SBI_UI(warning_ratelimit_burst, s_warning_ratelimit_state.burst);
> -EXT4_RW_ATTR_SBI_UI(msg_ratelimit_interval_ms, s_msg_ratelimit_state.interval);
> -EXT4_RW_ATTR_SBI_UI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
> +EXT4_RW_ATTR_SBI_PI(err_ratelimit_interval_ms, s_err_ratelimit_state.interval);
> +EXT4_RW_ATTR_SBI_PI(err_ratelimit_burst, s_err_ratelimit_state.burst);
> +EXT4_RW_ATTR_SBI_PI(warning_ratelimit_interval_ms, s_warning_ratelimit_state.interval);
> +EXT4_RW_ATTR_SBI_PI(warning_ratelimit_burst, s_warning_ratelimit_state.burst);
> +EXT4_RW_ATTR_SBI_PI(msg_ratelimit_interval_ms, s_msg_ratelimit_state.interval);
> +EXT4_RW_ATTR_SBI_PI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
>  #ifdef CONFIG_EXT4_DEBUG
>  EXT4_RW_ATTR_SBI_UL(simulate_fail, s_simulate_fail);
>  #endif
> @@ -382,6 +386,7 @@ static ssize_t ext4_generic_attr_show(struct ext4_attr *a,
>  	case attr_inode_readahead:
>  	case attr_clusters_in_group:
>  	case attr_mb_order:
> +	case attr_pointer_pi:
>  	case attr_pointer_ui:
>  		if (a->attr_ptr == ptr_ext4_super_block_offset)
>  			return sysfs_emit(buf, "%u\n", le32_to_cpup(ptr));
> @@ -452,6 +457,14 @@ static ssize_t ext4_generic_attr_store(struct ext4_attr *a,
>  		return 0;
>  
>  	switch (a->attr_id) {
> +	case attr_pointer_pi:
> +		ret = kstrtouint(skip_spaces(buf), 0, &t);
> +		if (ret)
> +			return ret;
> +		if ((int)t < 0)
> +			return -EINVAL;
> +		*((unsigned int *) ptr) = t;
> +		return len;
>  	case attr_pointer_ui:
>  		ret = kstrtouint(skip_spaces(buf), 0, &t);
>  		if (ret)
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

