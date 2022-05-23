Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56F5531979
	for <lists+linux-ext4@lfdr.de>; Mon, 23 May 2022 22:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiEWUIz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 May 2022 16:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiEWUIv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 May 2022 16:08:51 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA59D95DFE;
        Mon, 23 May 2022 13:08:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso317007pjg.0;
        Mon, 23 May 2022 13:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7d9nbsvCLtyt4SE1LQI20db/wKfkJniu8VI2Xtq/pPA=;
        b=CumatuY13rYV01GPWyRdKxK0dp57QCbY0shsjjPzyXfScK71RT20DTtJp9y/kp6uMr
         cbgTbU8MkjRGGUx/3jFJnuHXaVYJz8QXFriJdsyEggLVhSlR83JVScLbvaLPhTpJytz5
         Utb7XlLzP4eOHHUEqIrK3dkRwYozBa3rvzUoYw0+LA/b53th9RMIV6oHbUHQ66fn8YDo
         pKFM3u6k/BfOMobwTEy5uRjV62fsmJ6PuNcOo34OcGdsMvdZwtqhi1GdGGdALZ6WAFJN
         YOu5v1aPXmswJ36xrA9/yasUsmJLfz7+2dXpi/cq25t6YxSCC1hFQdLN0P1PlzmslI5o
         4qtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7d9nbsvCLtyt4SE1LQI20db/wKfkJniu8VI2Xtq/pPA=;
        b=iCsWcG2cv0xBV7cNWF68LMgfDFFRaX3n3Qoery4EiVOgXTSXtKep8kEHKMp3t3xn4e
         D60FVE6ZYQwRQFWYVqEcXgPQxWfw8TzqlouKTVF9Ybs4IXXXn4vMY3InlC/ouaTEYvUB
         9ubX64CvHUu+DkfVa+kcb4pJspa1n0yhCd8/O+8hX+XLxRpkRBik8gLF5Umj2+nY3yqK
         R7lETj8VsBssMWYd3uLI05cnH7w+oTXoD9HRdtOmTMiPuBOA1nLPbLS4q9fL10Iuwv/t
         AcFzkzn6w2PHfXnfmihCZKwY2RZEAKZx6f7Kd35sagqeHSGDSE41nBVrolSS7E31Ww6M
         KarA==
X-Gm-Message-State: AOAM533yAZtsCcDn/p18NEtFA8G1WHAR85bpc65iIjxiUnk99QM2O6ud
        N6fg/Cr8UNwv3d+gTRk/BPU=
X-Google-Smtp-Source: ABdhPJxh3HexU7RHHGe6u9xlpsDl0dJLlsMgTMgsx//jvZv6m15sBgilOZUcBXOo17FU7omZCuvIuA==
X-Received: by 2002:a17:90b:391:b0:1df:42e2:ae17 with SMTP id ga17-20020a17090b039100b001df42e2ae17mr704995pjb.198.1653336529942;
        Mon, 23 May 2022 13:08:49 -0700 (PDT)
Received: from localhost ([2406:7400:63:4576:78:9648:3f92:a905])
        by smtp.gmail.com with ESMTPSA id e18-20020a056a0000d200b0050dc76281ecsm7636171pfj.198.2022.05.23.13.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:08:49 -0700 (PDT)
Date:   Tue, 24 May 2022 01:38:44 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/2] ext4: correct the judgment of BUG in
 ext4_mb_normalize_request
Message-ID: <20220523200844.fal3pmp7epid3rvv@riteshh-domain>
References: <20220521134217.312071-1-libaokun1@huawei.com>
 <20220521134217.312071-3-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521134217.312071-3-libaokun1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/05/21 09:42PM, Baokun Li wrote:
> When either of the "start + size <= ac->ac_o_ex.fe_logical" or
> "start > ac->ac_o_ex.fe_logical" conditions is met, it indicates
> that the fe_logical is not in the allocated range.

Sounds about right to me based on the logic in ext4_mb_use_inode_pa().
We try to allocate/preallocate such that ac->ac_o_ex.fe_logical should fall
within the preallocated range. So if our start or start + size doesn't include
fe_logical then it is a bug in the ext4_mb_normalize_request() logic.

But should we be so harsh to hit a bug_on() or make it warn_on()?

Also did you run any fs tests with this change. Since it looks like this
logic existed since mballoc was introduced.


> In this case, it should be bug_ON.
>
> Fixes: dfe076c106f6 ("ext4: get rid of code duplication")

No, there is no issue with this patch. It correctly just removes the duplicate
logic.

> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/mballoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 32410b79b664..d0fb57970648 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4190,7 +4190,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  	}
>  	rcu_read_unlock();
>
> -	if (start + size <= ac->ac_o_ex.fe_logical &&
> +	if (start + size <= ac->ac_o_ex.fe_logical ||
>  			start > ac->ac_o_ex.fe_logical) {
>  		ext4_msg(ac->ac_sb, KERN_ERR,
>  			 "start %lu, size %lu, fe_logical %lu",
> --
> 2.31.1
>
