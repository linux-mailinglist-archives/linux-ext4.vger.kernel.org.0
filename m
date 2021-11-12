Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD2D44E9FE
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Nov 2021 16:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhKLP33 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Nov 2021 10:29:29 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34700 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbhKLP32 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Nov 2021 10:29:28 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 239651FD3D;
        Fri, 12 Nov 2021 15:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636730797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1gNY/niLAf2nm1JKmGISpF3WFcaRy5Ahj8D8HSdUt/E=;
        b=XriQbg4fPQWU0dIhpRg0/fq4jzN2DZy39z3DsiZWsSfzwlL1jUs/C9j/wfCsxiwdn8sFk2
        zo/yK9pcOY83z1kd0n1t7CoBVBcg9LXR8Dz4/6SLU4C8T6Loe+t/yfggcO4DQsYXrLJCNd
        66XUoejBwfnvi8wlkk9msI7gz+ZElLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636730797;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1gNY/niLAf2nm1JKmGISpF3WFcaRy5Ahj8D8HSdUt/E=;
        b=8+IRedjyIHaC3IxaEBbNqN9OXbcP4eyD+YGgIVzuEfyKf2fvqCdIK/jNzl2kSoKhei+8G+
        aK9QdskinCXSXMBQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 13241A3B81;
        Fri, 12 Nov 2021 15:26:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E10641F2B50; Fri, 12 Nov 2021 16:26:36 +0100 (CET)
Date:   Fri, 12 Nov 2021 16:26:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Lukas Czerner <lczerner@redhat.com>
Subject: Re: [PATCH] ext4: Avoid trim error on fs with small groups
Message-ID: <20211112152636.GC25491@quack2.suse.cz>
References: <20211112152202.26614-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112152202.26614-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 12-11-21 16:22:02, Jan Kara wrote:
> A user reported FITRIM ioctl failing for him on ext4 on some devices
> without apparent reason.  After some debugging we've found out that
> these devices (being LVM volumes) report rather large discard
> granularity of 42MB and the filesystem had 1k blocksize and thus group
> size of 8MB. Because ext4 FITRIM implementation puts discard
> granularity into minlen, ext4_trim_fs() declared the trim request as
> invalid. However just silently doing nothing seems to be a more
> appropriate reaction to such combination of parameters since user did
> not specify anything wrong.
> 
> CC: Lukas Czerner <lczerner@redhat.com>
> Fixes: 5c2ed62fd447 ("ext4: Adjust minlen with discard_granularity in the FITRIM ioctl")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/ioctl.c   | 2 --
>  fs/ext4/mballoc.c | 8 ++++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)

I wanted to add one more comment: Alternatively we could return EOPNOTSUPP
in this case to indicate trim is never going to work on this fs. But just
doing nothing since we cannot submit useful discard request seems
appropriate to me.

								Honza


> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 606dee9e08a3..220a4c8178b5 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -1117,8 +1117,6 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		    sizeof(range)))
>  			return -EFAULT;
>  
> -		range.minlen = max((unsigned int)range.minlen,
> -				   q->limits.discard_granularity);
>  		ret = ext4_trim_fs(sb, &range);
>  		if (ret < 0)
>  			return ret;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 72bfac2d6dce..7174add7b153 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6405,6 +6405,7 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
>   */
>  int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
>  {
> +	struct request_queue *q = bdev_get_queue(sb->s_bdev);
>  	struct ext4_group_info *grp;
>  	ext4_group_t group, first_group, last_group;
>  	ext4_grpblk_t cnt = 0, first_cluster, last_cluster;
> @@ -6423,6 +6424,13 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
>  	    start >= max_blks ||
>  	    range->len < sb->s_blocksize)
>  		return -EINVAL;
> +	/* No point to try to trim less than discard granularity */
> +	if (range->minlen < q->limits.discard_granularity) {
> +		minlen = EXT4_NUM_B2C(EXT4_SB(sb),
> +			q->limits.discard_granularity >> sb->s_blocksize_bits);
> +		if (minlen > EXT4_CLUSTERS_PER_GROUP(sb))
> +			goto out;
> +	}
>  	if (end >= max_blks)
>  		end = max_blks - 1;
>  	if (end <= first_data_blk)
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
