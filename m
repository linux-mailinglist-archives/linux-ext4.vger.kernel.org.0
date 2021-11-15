Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447D04503C2
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Nov 2021 12:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhKOLvb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Nov 2021 06:51:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53874 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229919AbhKOLv3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 15 Nov 2021 06:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636976914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TR0nS+7DbVIcFJQUgEYCbdcxOeGf5QarlNXh2pmRJes=;
        b=VS5wB3OxD/dOYeObVpvZdNDFr6MICKYWqEYtmc6mks9rz3udVdTPT78vD6Ry8RY+Ydf1X0
        A/Ja7sXgYgI0TuxMgiY8JHnuIdv06gxxgwf/l+yY0jdx0IDzdg4l1bNx2UvkPMnqFxCkBB
        HLhytyBjtMxdfZalQLrsajsf4onLd4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-3I9rb_v8O8qC0hFs-E2_ZQ-1; Mon, 15 Nov 2021 06:48:28 -0500
X-MC-Unique: 3I9rb_v8O8qC0hFs-E2_ZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05CA81B2C983;
        Mon, 15 Nov 2021 11:48:27 +0000 (UTC)
Received: from work (unknown [10.40.195.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C9F25D9CA;
        Mon, 15 Nov 2021 11:48:25 +0000 (UTC)
Date:   Mon, 15 Nov 2021 12:48:21 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Avoid trim error on fs with small groups
Message-ID: <20211115114821.swt3nqtw2pdgahsq@work>
References: <20211112152202.26614-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112152202.26614-1-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 12, 2021 at 04:22:02PM +0100, Jan Kara wrote:
> A user reported FITRIM ioctl failing for him on ext4 on some devices
> without apparent reason.  After some debugging we've found out that
> these devices (being LVM volumes) report rather large discard
> granularity of 42MB and the filesystem had 1k blocksize and thus group
> size of 8MB. Because ext4 FITRIM implementation puts discard
> granularity into minlen, ext4_trim_fs() declared the trim request as
> invalid. However just silently doing nothing seems to be a more
> appropriate reaction to such combination of parameters since user did
> not specify anything wrong.

Hi Jan,

I agree that it's better to silently do nothing rather than returning
-ENOTSUPP in this case and the patch looks mostly fine.

However currently we return the adjusted minlen back to the user and it
is also stated in the fstrim man page. I think it's worth keeping that
behavior.

When I think about it, it would probably be worth updating fstrim to
notify the user that the minlen changed, I can send a patch for that.

Thanks!
-Lukas

> 
> CC: Lukas Czerner <lczerner@redhat.com>
> Fixes: 5c2ed62fd447 ("ext4: Adjust minlen with discard_granularity in the FITRIM ioctl")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/ioctl.c   | 2 --
>  fs/ext4/mballoc.c | 8 ++++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
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

