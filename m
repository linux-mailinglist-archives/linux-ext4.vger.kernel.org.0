Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845604350FD
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Oct 2021 19:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhJTRLS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Oct 2021 13:11:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40200 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJTRLS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Oct 2021 13:11:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CA3C01F770;
        Wed, 20 Oct 2021 17:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634749742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mq67sHKUJ+31hJu3iQ4ZQez73tAoaQf8LyFy7s28/DI=;
        b=FalrpZB89I6eYukGXczCtmFVEKS/LKQRa3yHqVOk4ml/gfd6m5pU3gQCI6Q7jTPlhgxrtO
        jIEBkPkMzSL3CB+0gYsLZaLzrEyLnNCgvs7qfnT/k61G2wKLJ7DSrnV4Alh0EWDyY5PN5R
        wcSh8z4Xm3f/Nji4SCFkEJcU7i+OE+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634749742;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mq67sHKUJ+31hJu3iQ4ZQez73tAoaQf8LyFy7s28/DI=;
        b=E3Gd/niAZtGmzd7lBBOViLaWcsVV051298rPcFPx0CZjUjfJBFo+BjSSxpW+nuIQ0TSXuC
        N7K4L2945nf4IJCQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 90AC5A3B83;
        Wed, 20 Oct 2021 17:09:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 630371F2C7D; Wed, 20 Oct 2021 19:09:02 +0200 (CEST)
Date:   Wed, 20 Oct 2021 19:09:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: replace snprintf in show functions with sysfs_emit
Message-ID: <20211020170902.GE16460@quack2.suse.cz>
References: <1634095731-4528-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634095731-4528-1-git-send-email-wangqing@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 12-10-21 20:28:51, Qing Wang wrote:
> coccicheck complains about the use of snprintf() in sysfs show functions.
> 
> Fix the coccicheck warning:
> WARNING: use scnprintf or sprintf.
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Signed-off-by: Qing Wang <wangqing@vivo.com>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/ext4/sysfs.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 2314f74..2a4ae3d 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -63,7 +63,7 @@ static ssize_t session_write_kbytes_show(struct ext4_sb_info *sbi, char *buf)
>  {
>  	struct super_block *sb = sbi->s_buddy_cache->i_sb;
>  
> -	return snprintf(buf, PAGE_SIZE, "%lu\n",
> +	return sysfs_emit(buf, "%lu\n",
>  			(part_stat_read(sb->s_bdev, sectors[STAT_WRITE]) -
>  			 sbi->s_sectors_written_start) >> 1);
>  }
> @@ -72,7 +72,7 @@ static ssize_t lifetime_write_kbytes_show(struct ext4_sb_info *sbi, char *buf)
>  {
>  	struct super_block *sb = sbi->s_buddy_cache->i_sb;
>  
> -	return snprintf(buf, PAGE_SIZE, "%llu\n",
> +	return sysfs_emit(buf, "%llu\n",
>  			(unsigned long long)(sbi->s_kbytes_written +
>  			((part_stat_read(sb->s_bdev, sectors[STAT_WRITE]) -
>  			  EXT4_SB(sb)->s_sectors_written_start) >> 1)));
> @@ -130,8 +130,8 @@ static ssize_t trigger_test_error(struct ext4_sb_info *sbi,
>  static ssize_t journal_task_show(struct ext4_sb_info *sbi, char *buf)
>  {
>  	if (!sbi->s_journal)
> -		return snprintf(buf, PAGE_SIZE, "<none>\n");
> -	return snprintf(buf, PAGE_SIZE, "%d\n",
> +		return sysfs_emit(buf, "<none>\n");
> +	return sysfs_emit(buf, "%d\n",
>  			task_pid_vnr(sbi->s_journal->j_task));
>  }
>  
> @@ -357,7 +357,7 @@ static void *calc_ptr(struct ext4_attr *a, struct ext4_sb_info *sbi)
>  
>  static ssize_t __print_tstamp(char *buf, __le32 lo, __u8 hi)
>  {
> -	return snprintf(buf, PAGE_SIZE, "%lld\n",
> +	return sysfs_emit(buf, "%lld\n",
>  			((time64_t)hi << 32) + le32_to_cpu(lo));
>  }
>  
> @@ -374,7 +374,7 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
>  
>  	switch (a->attr_id) {
>  	case attr_delayed_allocation_blocks:
> -		return snprintf(buf, PAGE_SIZE, "%llu\n",
> +		return sysfs_emit(buf, "%llu\n",
>  				(s64) EXT4_C2B(sbi,
>  		       percpu_counter_sum(&sbi->s_dirtyclusters_counter)));
>  	case attr_session_write_kbytes:
> @@ -382,11 +382,11 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
>  	case attr_lifetime_write_kbytes:
>  		return lifetime_write_kbytes_show(sbi, buf);
>  	case attr_reserved_clusters:
> -		return snprintf(buf, PAGE_SIZE, "%llu\n",
> +		return sysfs_emit(buf, "%llu\n",
>  				(unsigned long long)
>  				atomic64_read(&sbi->s_resv_clusters));
>  	case attr_sra_exceeded_retry_limit:
> -		return snprintf(buf, PAGE_SIZE, "%llu\n",
> +		return sysfs_emit(buf, "%llu\n",
>  				(unsigned long long)
>  			percpu_counter_sum(&sbi->s_sra_exceeded_retry_limit));
>  	case attr_inode_readahead:
> @@ -394,42 +394,42 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
>  		if (!ptr)
>  			return 0;
>  		if (a->attr_ptr == ptr_ext4_super_block_offset)
> -			return snprintf(buf, PAGE_SIZE, "%u\n",
> +			return sysfs_emit(buf, "%u\n",
>  					le32_to_cpup(ptr));
>  		else
> -			return snprintf(buf, PAGE_SIZE, "%u\n",
> +			return sysfs_emit(buf, "%u\n",
>  					*((unsigned int *) ptr));
>  	case attr_pointer_ul:
>  		if (!ptr)
>  			return 0;
> -		return snprintf(buf, PAGE_SIZE, "%lu\n",
> +		return sysfs_emit(buf, "%lu\n",
>  				*((unsigned long *) ptr));
>  	case attr_pointer_u8:
>  		if (!ptr)
>  			return 0;
> -		return snprintf(buf, PAGE_SIZE, "%u\n",
> +		return sysfs_emit(buf, "%u\n",
>  				*((unsigned char *) ptr));
>  	case attr_pointer_u64:
>  		if (!ptr)
>  			return 0;
>  		if (a->attr_ptr == ptr_ext4_super_block_offset)
> -			return snprintf(buf, PAGE_SIZE, "%llu\n",
> +			return sysfs_emit(buf, "%llu\n",
>  					le64_to_cpup(ptr));
>  		else
> -			return snprintf(buf, PAGE_SIZE, "%llu\n",
> +			return sysfs_emit(buf, "%llu\n",
>  					*((unsigned long long *) ptr));
>  	case attr_pointer_string:
>  		if (!ptr)
>  			return 0;
> -		return snprintf(buf, PAGE_SIZE, "%.*s\n", a->attr_size,
> +		return sysfs_emit(buf, "%.*s\n", a->attr_size,
>  				(char *) ptr);
>  	case attr_pointer_atomic:
>  		if (!ptr)
>  			return 0;
> -		return snprintf(buf, PAGE_SIZE, "%d\n",
> +		return sysfs_emit(buf, "%d\n",
>  				atomic_read((atomic_t *) ptr));
>  	case attr_feature:
> -		return snprintf(buf, PAGE_SIZE, "supported\n");
> +		return sysfs_emit(buf, "supported\n");
>  	case attr_first_error_time:
>  		return print_tstamp(buf, sbi->s_es, s_first_error_time);
>  	case attr_last_error_time:
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
