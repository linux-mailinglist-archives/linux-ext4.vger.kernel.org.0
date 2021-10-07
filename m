Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40F4425355
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Oct 2021 14:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhJGMqS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 08:46:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50192 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbhJGMqR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 08:46:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 53714200BB;
        Thu,  7 Oct 2021 12:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633610663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G65GojcZQ8Ipbwxht4B8fwZJf/a+OJgyLRYSeBMjKGk=;
        b=WF7e0T6qini8XSUp/XDK+xmFwahbmxm2TlJezEMyND1qsOLEE7tkNALM1mOIvinlchGqnD
        GJT6N38EB7jzNvvdqpYh1bccvOAy2+yxkv9T1pZZy+VHCschqQyiGNd/rVIk13MIVBcwOs
        Atxbs0ZUPIxqx2On9jEzlMXLEkEv51o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633610663;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G65GojcZQ8Ipbwxht4B8fwZJf/a+OJgyLRYSeBMjKGk=;
        b=kmBYD7ABH9r8nc7rnc/FlWkfRhvJgSDENh9ne5WgJdQIraadRn9KMWuw2KFJC7hTbb4vpH
        s6Gl5/EbT5H1EGBg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 437A0A3B83;
        Thu,  7 Oct 2021 12:44:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E96B31F2C96; Thu,  7 Oct 2021 14:44:22 +0200 (CEST)
Date:   Thu, 7 Oct 2021 14:44:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v2 4/6] ext4: avoid to re-read mmp check data get
 from page cache
Message-ID: <20211007124422.GI12712@quack2.suse.cz>
References: <20210911090059.1876456-1-yebin10@huawei.com>
 <20210911090059.1876456-5-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911090059.1876456-5-yebin10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 11-09-21 17:00:57, Ye Bin wrote:
> As call read_mmp_block pass bh_check which value is NULL, then call
> sb_getblk to get buffer_head. But mmp_block's buffer_head is already exist
>  which also is uptodate. Lead to compare the same data.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

This looks good, except that read_mmp_block() also releases bh it is passed
in case of error. So it can free buffer head which is still referenced from
EXT4_SB(sb)->s_mmp_bh and cause use-after-free issues.

I guess I would just get rid of sb_getblk() in read_mmp_block() and always
expect valid bh passed. The only place that passes NULL bh after this
patch is one case in ext4_multi_mount_protect() and that can call
sb_getblk() on its own. That way we can also simplify read_mmp_block()
prototype to:

static int read_mmp_block(struct super_block *sb, struct buffer_head *bh);

								Honza

> ---
>  fs/ext4/mmp.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index 4433fe7e9e86..007bde3c12b8 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -213,10 +213,7 @@ static int kmmpd(void *data)
>  		 * we need to check if the MMP block is as we write it.
>  		 */
>  		if (jiffies - last_check_time > mmp_check_interval * HZ) {
> -			struct buffer_head *bh_check = NULL;
> -			struct mmp_struct *mmp_check;
> -
> -			retval = read_mmp_block(sb, &bh_check, mmp_block);
> +			retval = read_mmp_block(sb, &bh, mmp_block);
>  			if (retval) {
>  				ext4_error_err(sb, -retval,
>  					       "error reading MMP data: %d",
> @@ -224,20 +221,18 @@ static int kmmpd(void *data)
>  				goto wait_to_exit;
>  			}
>  
> -			mmp_check = (struct mmp_struct *)(bh_check->b_data);
> -			if (seq != mmp_check->mmp_seq ||
> -			    memcmp(nodename, mmp_check->mmp_nodename,
> -				   sizeof(mmp->mmp_nodename))) {
> -				dump_mmp_msg(sb, mmp_check,
> +			mmp = (struct mmp_struct *)(bh->b_data);
> +			if (seq != le32_to_cpu(mmp->mmp_seq) ||
> +			    memcmp(nodename, mmp->mmp_nodename,
> +				    sizeof(nodename))) {
> +				dump_mmp_msg(sb, mmp,
>  					     "Error while updating MMP info. "
>  					     "The filesystem seems to have been"
>  					     " multiply mounted.");
>  				ext4_error_err(sb, EBUSY, "abort");
> -				put_bh(bh_check);
>  				retval = -EBUSY;
>  				goto wait_to_exit;
>  			}
> -			put_bh(bh_check);
>  			last_check_time = jiffies;
>  		}
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
