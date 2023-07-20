Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E617775B7DD
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jul 2023 21:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjGTTXA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jul 2023 15:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjGTTW7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jul 2023 15:22:59 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092C61737;
        Thu, 20 Jul 2023 12:22:58 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55ba5bb0bf3so835863a12.1;
        Thu, 20 Jul 2023 12:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689880977; x=1690485777;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dWeQ5bA0LXI5Gg1E8GShfBchvp9P3BFr6XMZpPjv7HA=;
        b=Hm1zabsI6B5yqTTUDkEAD1aUEnfEdDWYc0GKtO9tPkr2mAaFzS9CCWomPD09xmh5eq
         eAiiAY/QVaMdEMr8miIi6YQZjRytx9NL1JyM+NoqxHiYr73ia/IUNAc1MlKuB3VJqQEC
         RocP8qSB1lblxWf4kEKqbkSexKajLqT4j6/wPK9kOiQEiiggLCGSz8l20phF7o98kw+Z
         9GV47hPo3t+NAoLSRb7iajr4kCdLKOGztDIpPtTN7pwWF0aPtJWLJtsuw0bn1jILb7ut
         8AMVuIG4UioLJTl4lM/OtKNg2oikvo2OtIkp/cpsSKq7Xf8Uj6/s+OWkZ/DwRa8gYurl
         SlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689880977; x=1690485777;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dWeQ5bA0LXI5Gg1E8GShfBchvp9P3BFr6XMZpPjv7HA=;
        b=l7MlJSVAyv7jA3bb36ZK0pYTiSdFl5Z24kLxdWRPmvXARt99xVoJs/q7x3ZAZsLfwP
         tsEWLlltO+HjVARarV+PJ7SqnSnkSk5xB+ildXAjACefy4efjP/87pMTX8AncOJ/KqEk
         uPkCirE8gn64PXeN7kqYSgo0Nj9HCBX1MioU4HHTAf3+v5Y0YlQ3O/DG8iPHDe3AQWMF
         RcuJ7lYbBeTIZ139pHiUqAvA0M10i11X/WQ0/Dk3xnOEp6mQ9V7qiYeAOzC8mL17v86K
         7E5xdLhoDvqqfo3fep4bJoVYqMMOrraOy3BO9RY4FnCfV+64j8VN/lbsY6caJR3d+KxO
         As+A==
X-Gm-Message-State: ABy/qLbLGWZPKtqotXvZGAODlewbRkimSReyqhfhnuXUx8btBY9JpoGQ
        1pnu9MfNsc1tYNScDDYXi3k+nbUVtcI=
X-Google-Smtp-Source: APBJJlGjgYSf2bMTvdj8w2LiVSaxFwjmKHfa+d9nLVZpM5BErhNU7fcxI9bdTbgNhg0LM2BnxWyJFw==
X-Received: by 2002:a17:90a:2bce:b0:263:7d8:4a with SMTP id n14-20020a17090a2bce00b0026307d8004amr513569pje.18.1689880977350;
        Thu, 20 Jul 2023 12:22:57 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id 4-20020a17090a1a4400b00262e9fbd5fbsm3190205pjl.32.2023.07.20.12.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:22:55 -0700 (PDT)
Date:   Fri, 21 Jul 2023 00:52:50 +0530
Message-Id: <875y6eo0ad.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
        libaokun1@huawei.com
Subject: Re: [PATCH 4/4] ext4: avoid prealloc space being skipped due to overflow
In-Reply-To: <20230718131052.283350-5-libaokun1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Baokun Li <libaokun1@huawei.com> writes:

> If there is a pa in the i_prealloc_list of an inode with a tmp_pa_end
> of 4294967296(0x100000000), since tmp_pa_end is of type ext4_lblk_t,
> tmp_pa_end will be recognized as 0 due to overflow, which causes
> (ac->ac_o_ ex.fe_logical >= tmp_pa_end) always holds, so that pa will
> always be skipped. This then triggers the regular allocation process,
> and if the excess tail of the free extent from that allocation is put
> into the i_prealloc_list again, it will again not be used. This ends up
> leaving us with a lot of free physical blocks in the i_prealloc_list.
>
> We avoid this problem by using pa_end() to compute tmp_pa_end and
> declaring tmp_pa_end to be of type loff_t.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me with fex_end() and pa_end() dropped.

-ritesh


> ---
>  fs/ext4/mballoc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 77d47af525d9..06db40fb29d6 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4765,7 +4765,8 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
>  	struct ext4_locality_group *lg;
>  	struct ext4_prealloc_space *tmp_pa, *cpa = NULL;
> -	ext4_lblk_t tmp_pa_start, tmp_pa_end;
> +	ext4_lblk_t tmp_pa_start;
> +	loff_t tmp_pa_end;
>  	struct rb_node *iter;
>  	ext4_fsblk_t goal_block;
>  
> @@ -4784,7 +4785,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  		/* all fields in this condition don't change,
>  		 * so we can skip locking for them */
>  		tmp_pa_start = tmp_pa->pa_lstart;
> -		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> +		tmp_pa_end = pa_end(sbi, tmp_pa);
>  
>  		/* original request start doesn't lie in this PA */
>  		if (ac->ac_o_ex.fe_logical < tmp_pa_start ||
> -- 
> 2.31.1
