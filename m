Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2611D43319A
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Oct 2021 10:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhJSI4w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Oct 2021 04:56:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36534 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbhJSI4v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Oct 2021 04:56:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ABC1D21986;
        Tue, 19 Oct 2021 08:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634633678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q3e/jjXcNyGFaKNzbVvSv6+G6C96ksBGSuuR1wTWY/k=;
        b=NjxXL8c91hkn16Nk/wWkAcUz9EdvoWUX6HS86P6j96Dvz+bXOdJwzPho34e2d7AtUWrzlg
        7NTCzNbhpho528JSZTqDIX1CoGgi/q3BeMqDARt0242fWPlsu3cQ4hpCNUHg11C8TVc6Fv
        7IOLtxsLR2ouoJr30Soa8CTFZx4k+Sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634633678;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q3e/jjXcNyGFaKNzbVvSv6+G6C96ksBGSuuR1wTWY/k=;
        b=2bTMuUIaVlpTzKXxBJvlbvuWdnMsZTs7PHR+Zrpcs34QHm1W/7Gk15WWIiRla0urIxqN8n
        yL5CaGHfvWRlRwCg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 9E5CAA3B83;
        Tue, 19 Oct 2021 08:54:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 878031E0BE5; Tue, 19 Oct 2021 10:54:37 +0200 (CEST)
Date:   Tue, 19 Oct 2021 10:54:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v3 2/5] ext4: compare to local seq and nodename
 when check conflict
Message-ID: <20211019085437.GB3255@quack2.suse.cz>
References: <20211019064959.625557-1-yebin10@huawei.com>
 <20211019064959.625557-3-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019064959.625557-3-yebin10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 19-10-21 14:49:56, Ye Bin wrote:
> As mmp and check_mmp is point to the same data, so there will never
> detect conflict.
> To solve this issue just compare to local data.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 404dd50856e5..9a487a558787 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2601,6 +2601,8 @@ struct ext4_features {
>  #define EXT4_MMP_SEQ_FSCK  0xE24D4D50U /* mmp_seq value when being fscked */
>  #define EXT4_MMP_SEQ_MAX   0xE24D4D4FU /* maximum valid mmp_seq value */
>  
> +#define EXT4_MMP_NODENAME_LEN   64 /* mmp_nodename length */
> +
>  struct mmp_struct {
>  	__le32	mmp_magic;		/* Magic number for MMP */
>  	__le32	mmp_seq;		/* Sequence no. updated periodically */
> @@ -2610,7 +2612,8 @@ struct mmp_struct {
>  	 * purposes and do not affect the correctness of the algorithm
>  	 */
>  	__le64	mmp_time;		/* Time last updated */
> -	char	mmp_nodename[64];	/* Node which last updated MMP block */
> +	/* Node which last updated MMP block */
> +	char	mmp_nodename[EXT4_MMP_NODENAME_LEN];
>  	char	mmp_bdevname[32];	/* Bdev which last updated MMP block */
>  
>  	/*
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index 11627ff002d3..4af8b99ade84 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -138,6 +138,7 @@ static int kmmpd(void *data)
>  	unsigned mmp_check_interval;
>  	unsigned long last_update_time;
>  	unsigned long diff;
> +	char nodename[EXT4_MMP_NODENAME_LEN];
>  	int retval = 0;
>  
>  	mmp_block = le64_to_cpu(es->s_mmp_block);
> @@ -154,8 +155,8 @@ static int kmmpd(void *data)
>  	BUILD_BUG_ON(sizeof(mmp->mmp_bdevname) < BDEVNAME_SIZE);
>  	bdevname(bh->b_bdev, mmp->mmp_bdevname);
>  
> -	memcpy(mmp->mmp_nodename, init_utsname()->nodename,
> -	       sizeof(mmp->mmp_nodename));
> +	memcpy(nodename, init_utsname()->nodename, sizeof(nodename));
> +	memcpy(mmp->mmp_nodename, nodename, sizeof(mmp->mmp_nodename));
>  
>  	while (!kthread_should_stop() && !sb_rdonly(sb)) {
>  		if (!ext4_has_feature_mmp(sb)) {
> @@ -207,8 +208,8 @@ static int kmmpd(void *data)
>  			}
>  
>  			mmp_check = (struct mmp_struct *)(bh_check->b_data);
> -			if (mmp->mmp_seq != mmp_check->mmp_seq ||
> -			    memcmp(mmp->mmp_nodename, mmp_check->mmp_nodename,
> +			if (seq != mmp_check->mmp_seq ||
> +			    memcmp(nodename, mmp_check->mmp_nodename,
>  				   sizeof(mmp->mmp_nodename))) {
>  				dump_mmp_msg(sb, mmp_check,
>  					     "Error while updating MMP info. "
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
