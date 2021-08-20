Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B593F31B2
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Aug 2021 18:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhHTQqi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Aug 2021 12:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhHTQqh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Aug 2021 12:46:37 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC1EC061575
        for <linux-ext4@vger.kernel.org>; Fri, 20 Aug 2021 09:45:59 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id v1so5822652qva.7
        for <linux-ext4@vger.kernel.org>; Fri, 20 Aug 2021 09:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D1C0AECYNalgQIH1As2TjpGRYNyOzoAK+c9kVmEd7/I=;
        b=kbjp6p2s/OkzNg1crM3kr5LOpkCALtyZtjJVOhbgLpvAiZmr/5de3mU3tKyciSyU21
         3TZlwSdokFejgZJBySqb/0fpMEQbi4zlmrvvbNIClnBLSp3BgBKjzKMGY6D1M/RQLLST
         bEJv1DoDHVkJxDPTNbBFLkQU1Ry6JxQIA+dOGx89It5hm9gOEjjYWpdyFXMhaiPXSTtB
         Nf6Uilen/qIIxq0sxL5LhRCF3bcrfdHkP/wUqFB/GrCHh/eNROP59CvXyCCUFXmxymkq
         blAWnJqXPtxLzEkbXA1f0GAmCsog4h/hQ/Rjo0g5yGsVMkCKgIzJ4cDXxPDxZrZ+0hrM
         7/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D1C0AECYNalgQIH1As2TjpGRYNyOzoAK+c9kVmEd7/I=;
        b=AUoFvRMp63MP7qaz0gHskHj7g9X702Yvf4ZLnuWUpftxUtfrO3jKzHFImUucYxvVlH
         U6PIKsbmORU6iVFE6+0Mq858x2P/xvPH7NhUFm02o05ym2aal5LmvMn3HCHJy04nPk5r
         rQfIiVr1IWe1g/+OReBi5X6UH9ywAwqCTifEQp304MYMq5eUTpZKBspkBa6IoBgT/Xyl
         fLQVO6cIYM8NrHcPs8fFZAWeL/xT6xg3nv/+1H11e408+sFE6SCLZDzFHiD5gUBuR8Nm
         t2VAF0JcGchTcWKm0GQc+qjp8poNlJLRjK1wy+KjpG4KWYx3vJbnnFCWm4prxhZmDI0B
         A9CQ==
X-Gm-Message-State: AOAM532csT67zaaNvY90BPlEayZqr92Y/oqYu2XtCCaSYsC/htUoouas
        1t1UmYyJ/hevXK1ImRFMhWcBtnaaGzU=
X-Google-Smtp-Source: ABdhPJyQBd6cQHV/p/63z+DfVAjXJ1KR+kWXX6+iB1QQ3Vsnp/aC+4COwzjrNcV4TA0iHQFKmY/zvQ==
X-Received: by 2002:a0c:aad9:: with SMTP id g25mr21083846qvb.27.1629477958789;
        Fri, 20 Aug 2021 09:45:58 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id w6sm3364845qkf.95.2021.08.20.09.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 09:45:58 -0700 (PDT)
Date:   Fri, 20 Aug 2021 12:45:56 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH] ext4: fix reserved space counter leakage
Message-ID: <20210820164556.GA30851@localhost.localdomain>
References: <20210819091351.19297-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819091351.19297-1-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Jeffle Xu <jefflexu@linux.alibaba.com>:
> When ext4_es_insert_delayed_block() returns error, e.g., ENOMEM,
> previously reserved space is not released as the error handling,
> in which case @s_dirtyclusters_counter is left over. Since this delayed
> extent failes to be inserted into extent status tree, when inode is
> written back, the extra @s_dirtyclusters_counter won't be subtracted and
> remains there forever.
> 
> This can leads to /sys/fs/ext4/<dev>/delayed_allocation_blocks remains
> non-zero even when syncfs is executed on the filesystem.
> 

Hi:

I think the fix below looks fine.  However, this comment doesn't look right
to me.  Are you really seeing delayed_allocation_blocks values that remain
incorrectly elevated across last closes (or across file system unmounts and
remounts)?  s_dirtyclusters_counter isn't written out to stable storage -
it's an in-memory only variable that's created when a file is first opened
and destroyed on last close.

Eric

> Fixes: 51865fda28e5 ("ext4: let ext4 maintain extent status tree")
> Cc: <stable@vger.kernel.org>
> Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/ext4/inode.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 82087657860b..7f15da370281 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1650,6 +1650,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	int ret;
>  	bool allocated = false;
> +	bool reserved = false;
>  
>  	/*
>  	 * If the cluster containing lblk is shared with a delayed,
> @@ -1666,6 +1667,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  		ret = ext4_da_reserve_space(inode);
>  		if (ret != 0)   /* ENOSPC */
>  			goto errout;
> +		reserved = true;
>  	} else {   /* bigalloc */
>  		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
>  			if (!ext4_es_scan_clu(inode,
> @@ -1678,6 +1680,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  					ret = ext4_da_reserve_space(inode);
>  					if (ret != 0)   /* ENOSPC */
>  						goto errout;
> +					reserved = true;
>  				} else {
>  					allocated = true;
>  				}
> @@ -1688,6 +1691,8 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  	}
>  
>  	ret = ext4_es_insert_delayed_block(inode, lblk, allocated);
> +	if (ret && reserved)
> +		ext4_da_release_space(inode, 1);
>  
>  errout:
>  	return ret;
> -- 
> 2.27.0
> 
