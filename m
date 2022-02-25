Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D694C4516
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Feb 2022 13:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbiBYM6Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Feb 2022 07:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiBYM6X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Feb 2022 07:58:23 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292A9151685
        for <linux-ext4@vger.kernel.org>; Fri, 25 Feb 2022 04:57:51 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DEC2721114;
        Fri, 25 Feb 2022 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645793869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZtYQ1Q/xVros9bnCGf9i0g1Xf/fdppJMUah8i82o80s=;
        b=B48gDsQalbVkEv7tSeO1uKpoo5em7BF/rBwSOHMjH2nN3CjzbPK5wAS/6EeNCwV/Kmp2yH
        y4YkXO1bYhwVqOSK2LsyZ0LqdEbAVkDUwzD7hWLy5IyG9FpES31GfpM+3nvsbA20zpquax
        sPFfHlp3BpKLag4eIoTF06w/oqfEE38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645793869;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZtYQ1Q/xVros9bnCGf9i0g1Xf/fdppJMUah8i82o80s=;
        b=uLqytfB8ATg0SkIo6q86Iy9zjNdbHUgCaErIoCT8+v5q2C2o9QaEYoiOWXasEl4X9BRuBq
        Jjhh/bzde+XYAkDw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A6754A3B9F;
        Fri, 25 Feb 2022 12:57:49 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1FA91A05D9; Fri, 25 Feb 2022 13:57:47 +0100 (CET)
Date:   Fri, 25 Feb 2022 13:57:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH] ext2: correct max file size computing
Message-ID: <20220225125747.jmvjuauznesx2md7@quack3.lan>
References: <20220212050532.179055-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212050532.179055-1-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 12-02-22 13:05:32, Zhang Yi wrote:
> We need to calculate the max file size accurately if the total blocks
> that can address by block tree exceed the upper_limit. But this check is
> not correct now, it only compute the total data blocks but missing
> metadata blocks are needed. So in the case of "data blocks < upper_limit
> && total blocks > upper_limit", we will get wrong result. Fortunately,
> this case could not happen in reality, but it's confused and better to
> correct the computing.
> 
>   bits   data blocks   metadatablocks   upper_limit
>   10        16843020            66051    2147483647
>   11       134480396           263171    1073741823
>   12      1074791436          1050627     536870911 (*)
>   13      8594130956          4198403     268435455 (*)
>   14     68736258060         16785411     134217727 (*)
>   15    549822930956         67125251      67108863 (*)
>   16   4398314962956        268468227      33554431 (*)
> 
>   [*] Need to calculate in depth.
> 
> Fixes: 1c2d14212b15 ("ext2: Fix underflow in ext2_max_size()")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Thanks for the cleanup! I've merged the patch to my tree.

								Honza

> ---
>  fs/ext2/super.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 94f1fbd7d3ac..6d4f5ef74766 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -753,8 +753,12 @@ static loff_t ext2_max_size(int bits)
>  	res += 1LL << (bits-2);
>  	res += 1LL << (2*(bits-2));
>  	res += 1LL << (3*(bits-2));
> +	/* Compute how many metadata blocks are needed */
> +	meta_blocks = 1;
> +	meta_blocks += 1 + ppb;
> +	meta_blocks += 1 + ppb + ppb * ppb;
>  	/* Does block tree limit file size? */
> -	if (res < upper_limit)
> +	if (res + meta_blocks <= upper_limit)
>  		goto check_lfs;
>  
>  	res = upper_limit;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
