Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E639869A5A7
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Feb 2023 07:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjBQGhW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Feb 2023 01:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBQGhV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Feb 2023 01:37:21 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4454E5C0;
        Thu, 16 Feb 2023 22:37:20 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id j6so534779plh.1;
        Thu, 16 Feb 2023 22:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6C1SIQQP1gyo68CYQuiNgQYo/e8nc5EHGL0dfbTivTQ=;
        b=LA56g0wuQUdF6eil5NRihahKyK2ou8kA9rsjjxzuhBSiN0NF2JHkV9kTZFYvEswNpb
         495F4hs8s5RxowyqGbwXuwouiZBCC3lh4udBI/Xt09ykoIFxAr9RAvDgLtz9O3CmQcTD
         UucUfCBmqVdTSCQTozV510PmKXmpmWz7c2tPeItRACCqkZJ9vmuFuoP/3kL6IcMqMdKH
         PQXPTQHltFYRIoiY0p+5FyarpUfJnOYwWMSk34Cqx24wH/FToGfh9DDtwEDJ/3MDdGn6
         mgvTiB1/thRQHLuAWaq14CGZYV/EZSaCWFIUr6DXnZxYpQseYWQXG+nLfJkDVuRMckBJ
         fZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6C1SIQQP1gyo68CYQuiNgQYo/e8nc5EHGL0dfbTivTQ=;
        b=3hSQZNV2O6KbPChz2kA6+B0MjYcSOZbGkj6OUhdbpEkxNFAah63VGL7cSLmLJQKP7G
         Kr5Hc9z+6ysnmSR1sExTyMh4xlFwRxrlxid8j1p5y0Oj48I3ZFQd16veS10En4ch1EEX
         mu+bOwI/jGehkCnsPnnshj+BGRyqb4dgu0QfStugNcuZBPAwwG2WUe1we4tDsLIz1FyI
         naeoXbZgrXVX7T4UnxbUgtvUaJiabQbVEuPX/5t2eVd08EZ0i55KEbOozSTXxoIHpJ1o
         nUIBSJq1LyGCanSSzixTb1txYdrt3Q2pcIzCzDn5AlzTCET9qi5DO3cUsyGlnVblQwph
         3PqQ==
X-Gm-Message-State: AO0yUKVCoPASb8TGMUa4Qdv+ix4yzR41OLAkGtyh1uRmFlxirSZErCC6
        poJfc2a9LKvnko0wY4RfaXMeiYZeFsLogw==
X-Google-Smtp-Source: AK7set9saCwePeX6dQunOSjWUhjVF7TL2nEScuv/WW6p0j++ESfSLRkclVb4aqD/tF6wrAdDd/zlpg==
X-Received: by 2002:a17:902:f690:b0:19a:81c1:e743 with SMTP id l16-20020a170902f69000b0019a81c1e743mr10417610plg.2.1676615839569;
        Thu, 16 Feb 2023 22:37:19 -0800 (PST)
Received: from rh-tp ([2406:7400:63:5056:148f:873b:4bc8:1e77])
        by smtp.gmail.com with ESMTPSA id ix11-20020a170902f80b00b0019615a0d083sm2335646plb.210.2023.02.16.22.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 22:37:19 -0800 (PST)
Date:   Fri, 17 Feb 2023 12:06:54 +0530
Message-Id: <87wn4giyrd.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/21] ext4: remove unnecessary goto in ext4_mb_mark_diskspace_used
In-Reply-To: <20230209194825.511043-19-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> When ext4_read_block_bitmap fails, we can return PTR_ERR(bitmap_bh) to
> remove unnecessary NULL check of bitmap_bh.

bitmap_bh is a local pointer variable. So not setting it to NULL is not
a problem. I guess for consistency in return error code paths the author
would have kept it this way, but since this is the first return from the
function in case of an error, hence it looks ok if we simply call
return PTR_ERR(bitmap_bh), rather than a goto out_err.

Hence this looks good to me. Feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index f9fc461b633f..7d6991af50d8 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3739,9 +3739,7 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>  
>  	bitmap_bh = ext4_read_block_bitmap(sb, ac->ac_b_ex.fe_group);
>  	if (IS_ERR(bitmap_bh)) {
> -		err = PTR_ERR(bitmap_bh);
> -		bitmap_bh = NULL;
> -		goto out_err;
> +		return PTR_ERR(bitmap_bh);
>  	}
>  
>  	BUFFER_TRACE(bitmap_bh, "getting write access");
> -- 
> 2.30.0
