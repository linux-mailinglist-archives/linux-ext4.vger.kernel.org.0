Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9454331DE
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Oct 2021 11:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhJSJMm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Oct 2021 05:12:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38218 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbhJSJMi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Oct 2021 05:12:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B4B04219CB;
        Tue, 19 Oct 2021 09:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634634624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gt6nuIzfE5vuSZe4ZA9CcRAzQz3OFqf/MbzOSu8nXv0=;
        b=jrGdc/z/gp7YCYVnsCW8LLfsGXkRBSwXLscwgzo6H16xoXV+RaQcHOhZLOHexwm9jtcDRf
        dXPj1/JD4xoJIbeE7saOkQJcJ1JVh0PUj72xiapSIT7WuJk4Mo+M2+ivn4xcGnoqcIaHLo
        iGO2Qm+X2dhsfaway/ZRRzzQEOY/oEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634634624;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gt6nuIzfE5vuSZe4ZA9CcRAzQz3OFqf/MbzOSu8nXv0=;
        b=6ZxVnHZ7i/taV0GT5pIwEfjBw5Nrtiy57ej5KXxqZRXzO6WPZ+0vUgIgDSs90JTBPPmn/M
        pQIvLkxaZP4cSxDw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 76F6CA3B81;
        Tue, 19 Oct 2021 09:10:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 56D1A1E0BE5; Tue, 19 Oct 2021 11:10:24 +0200 (CEST)
Date:   Tue, 19 Oct 2021 11:10:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v3 5/5] ext4: avoid to re-read mmp check data get
 from page cache
Message-ID: <20211019091024.GC3255@quack2.suse.cz>
References: <20211019064959.625557-1-yebin10@huawei.com>
 <20211019064959.625557-6-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019064959.625557-6-yebin10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 19-10-21 14:49:59, Ye Bin wrote:
> As call read_mmp_block pass bh_check which value is NULL, then call
> sb_getblk to get buffer_head. But mmp_block's buffer_head is already exist
>  which also is uptodate. Lead to compare the same data.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

This patch needs to go earlier in the series - just after patch 2.
Otherwise the read_mmp_block() cleanup is not correct. Otherwise it looks
good, just some language corrections:

ext4: remove useless bh_check variable

Since we initialize 'bh_check' to NULL and pass it to read_mmp_block(), that
function will just call sb_getblk() which will just return the buffer_head
we have in 'bh'. So just remove the pointless 'bh_check' variable and use
'bh' directly.

With this fixed feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mmp.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index 61c765c249b9..8018f6fb6ac2 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -186,10 +186,7 @@ static int kmmpd(void *data)
>  		 */
>  		diff = jiffies - last_update_time;
>  		if (diff > mmp_check_interval * HZ) {
> -			struct buffer_head *bh_check = NULL;
> -			struct mmp_struct *mmp_check;
> -
> -			retval = read_mmp_block(sb, bh_check);
> +			retval = read_mmp_block(sb, bh);
>  			if (retval) {
>  				ext4_error_err(sb, -retval,
>  					       "error reading MMP data: %d",
> @@ -197,20 +194,18 @@ static int kmmpd(void *data)
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
>  		}
>  
>  		 /*
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
