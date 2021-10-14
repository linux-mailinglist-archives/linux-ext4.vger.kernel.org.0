Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2A742D692
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Oct 2021 11:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhJNJ7E (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Oct 2021 05:59:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44426 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhJNJ7D (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Oct 2021 05:59:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 37C7E21A7B;
        Thu, 14 Oct 2021 09:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634205418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JHEZWtjIFaYGa2u7VcBpTpqyUvSnrIxCc/PVAzBXk8s=;
        b=mrfOUtPr9c2M6Zwb8A5goWY9bju+0hxdI3E4ORE6i3U3TvCOIqfR8m5bash0mmontOvzJk
        oFhXPY4p2SWzGuUTm2df+aYUkmRFrCamFstvK+TS2EdZHUxlEGNkAvaBuTtKvF4zSutCXz
        UlhRCzJNX1GHpetVP13SfFTYBhZClsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634205418;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JHEZWtjIFaYGa2u7VcBpTpqyUvSnrIxCc/PVAzBXk8s=;
        b=KxI37cx/XSINxH22eNzdu3ysxFD52yYq1Xk+5XIzHtiOmR17W54iiuEcqXm17sVDJa/DzL
        zp6ON+rTrj1B3jBA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 28BEDA3B83;
        Thu, 14 Oct 2021 09:56:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E9E0F1E0C03; Thu, 14 Oct 2021 11:56:57 +0200 (CEST)
Date:   Thu, 14 Oct 2021 11:56:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Shaoying Xu <shaoyi@amazon.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        fllinden@amazon.com, benh@amazon.com
Subject: Re: [PATCH 1/1] ext4: fix lazy initialization next schedule time
 computation in more granular unit
Message-ID: <20211014095657.GE15931@quack2.suse.cz>
References: <20210817225654.30487-1-shaoyi@amazon.com>
 <20210817225654.30487-2-shaoyi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817225654.30487-2-shaoyi@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 17-08-21 22:56:54, Shaoying Xu wrote:
> Ext4 file system has default lazy inode table initialization setup once
> it is mounted. However, it has issue on computing the next schedule time
> that makes the timeout same amount in jiffies but different real time in
> secs if with various HZ values. Therefore, fix by measuring the current
> time in a more granular unit nanoseconds and make the next schedule time
> independent of the HZ value.
> 
> Fixes: bfff68738f1c ("ext4: add support for lazy inode table initialization")
> Signed-off-by: Shaoying Xu <shaoyi@amazon.com>
> Cc: stable@vger.kernel.org

Thanks for the patch. It seems to have fallen through the cracks. It looks
good just some nits: The timeout will be still dependent on the HZ value
because we use jiffie-granular timer.  But yes, I guess it is unnecessary
to make the imprecision 10x worse when we know we are likely dealing with
small numbers. 

> @@ -3460,14 +3460,13 @@ static int ext4_run_li_request(struct ext4_li_request *elr)
>  		ret = 1;
>  
>  	if (!ret) {

Please add a comment here so that we don't forget. Like:
		/* Use ns-granular time as init can be really fast */

With this feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> -		timeout = jiffies;
> +		start_time = ktime_get_real_ns();
>  		ret = ext4_init_inode_table(sb, group,
>  					    elr->lr_timeout ? 0 : 1);
>  		trace_ext4_lazy_itable_init(sb, group);
>  		if (elr->lr_timeout == 0) {
> -			timeout = (jiffies - timeout) *
> -				EXT4_SB(elr->lr_super)->s_li_wait_mult;
> -			elr->lr_timeout = timeout;
> +			elr->lr_timeout = nsecs_to_jiffies((ktime_get_real_ns() - start_time) *
> +				EXT4_SB(elr->lr_super)->s_li_wait_mult);
>  		}
>  		elr->lr_next_sched = jiffies + elr->lr_timeout;
>  		elr->lr_next_group = group + 1;


								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
