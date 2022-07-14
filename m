Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23723574A14
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 12:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbiGNKFH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 06:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237972AbiGNKE7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 06:04:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D124C628;
        Thu, 14 Jul 2022 03:04:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 997261FAAE;
        Thu, 14 Jul 2022 10:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657793096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Op6Yqxo0eUA3M0cvIstD63tWZwIIC5z/12lqmDQcqw=;
        b=puLzZmrKBUI21sM3c6r7C+q/p2ShjcDYpI2ToKWo4rWtQvjheqj822NTr4JsRFT/c7oZh2
        +vm/i8yZeJ0hALXMKc+HVjfcd/ynm/XaKTE6PgW1JM9J21GBdW9ARXGwNhr7bxDrt1kHF/
        vZZEK6f22YF93cl4l2mFhro2lCI2S1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657793096;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Op6Yqxo0eUA3M0cvIstD63tWZwIIC5z/12lqmDQcqw=;
        b=HXwu2FKVBRKBIkzyo5zkxg7DPBSfcULECIKbZTGYCahKLmQJcoEgGxia25epKV8YSEEUH6
        S58h4ewdFFxhraDg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1D6372C141;
        Thu, 14 Jul 2022 10:04:55 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 803BCA05FB; Thu, 14 Jul 2022 12:04:54 +0200 (CEST)
Date:   Thu, 14 Jul 2022 12:04:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jiangshan Yi <13667453960@163.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: Re: [PATCH] fs/ext2: replace ternary operator with min_t()
Message-ID: <20220714100454.zjcm4bnmygq3ryqb@quack3>
References: <20220714063318.1777139-1-13667453960@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714063318.1777139-1-13667453960@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 14-07-22 14:33:18, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix the following coccicheck warning:
> 
> fs/ext2/super.c:1494: WARNING opportunity for min().
> fs/ext2/super.c:1533: WARNING opportunity for min().
> 
> min_t() macro is defined in include/linux/minmax.h. It avoids
> multiple evaluations of the arguments when non-constant and performs
> strict type-checking.
> 
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

Yeah, looks like a good cleanup. Merged to my tree. Thanks!

								Honza

> ---
>  fs/ext2/super.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index f6a19f6d9f6d..300f2f0cf566 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -1490,8 +1490,7 @@ static ssize_t ext2_quota_read(struct super_block *sb, int type, char *data,
>  		len = i_size-off;
>  	toread = len;
>  	while (toread > 0) {
> -		tocopy = sb->s_blocksize - offset < toread ?
> -				sb->s_blocksize - offset : toread;
> +		tocopy = min_t(size_t, sb->s_blocksize - offset, toread);
>  
>  		tmp_bh.b_state = 0;
>  		tmp_bh.b_size = sb->s_blocksize;
> @@ -1529,8 +1528,7 @@ static ssize_t ext2_quota_write(struct super_block *sb, int type,
>  	struct buffer_head *bh;
>  
>  	while (towrite > 0) {
> -		tocopy = sb->s_blocksize - offset < towrite ?
> -				sb->s_blocksize - offset : towrite;
> +		tocopy = min_t(size_t, sb->s_blocksize - offset, towrite);
>  
>  		tmp_bh.b_state = 0;
>  		tmp_bh.b_size = sb->s_blocksize;
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
