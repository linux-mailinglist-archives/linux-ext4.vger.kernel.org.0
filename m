Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381447B0267
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Sep 2023 13:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjI0LG2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Sep 2023 07:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjI0LGZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Sep 2023 07:06:25 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1AA13A;
        Wed, 27 Sep 2023 04:06:24 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c60778a3bfso66481505ad.1;
        Wed, 27 Sep 2023 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695812783; x=1696417583; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dJOVwtHQyTbslSpjfBitXSuheNCEieFwv87lFiuO0e4=;
        b=AGG4GKT9Nfm7YZcZ+WK6e5OiEZqFGMj/jYnAMsdJKLym+BjJ2VabecAZ25zGZQiB7w
         l/0aSRBWgjF1Faw7VoOQj8kfCeuDUF8dBmuvlvNaRyZjZbEZ5s99TP6xmgnasxq+Lg1J
         Qg7twYI4nbZo+GWd5kGe5RzhhLUXob2S+ZT4xenBt0QA7T2cIjArWbJjDWZOwnlqShcV
         yd0txzI46P9nHgGqSUAV9aRxXZylJ0KACgqluXmA0qhtqkruVdPblYf33+4NQ4aL+ZFz
         VruPiKOd6yFlJ2kay4kUdX7dzguA4B3CbsrPmDdwBTqmH3RApW1pdyf4oQYMnP2iNgpK
         9N4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695812783; x=1696417583;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dJOVwtHQyTbslSpjfBitXSuheNCEieFwv87lFiuO0e4=;
        b=hz2i4oDA/pnUlzD/Qg2yjzF/Zrk24gxdJWTR6llInlowAd2byV5Eyzi0CkYhfRxmvP
         2P1hzWk3LfiQs7f928WtrDKZKPQBGicoAyX94F3sCQdenDhsonSpeoj1Z2eqBqGPibLN
         fEteFtqTEirWCkrDvPQ4hnsmVJAPHR9VLAWVfXY1mqG+wz8/3aNkrc/sjSMHyoShgMZy
         Cdz+Mvt1OmzMCAlZKiWsKO3jzpGTmKbc1FGuH/D2OIeOIJM1oox2gwUTXU3UdeOKJoSQ
         7f12ISAY5ynDrmS4cKh8Lz6DhVNX2DvfJvmoDrJjFrOxvMUm806Ze6uZ31xnkQAH7L92
         GiIw==
X-Gm-Message-State: AOJu0Ywx5TTOMZT48framdkSmHHWmDEeT7PcFwF3BfL5Dm+VbbwRorVp
        00sBJlefetPhupgeffBtUUr4Wkr6tiE=
X-Google-Smtp-Source: AGHT+IHGJyc5X9QIGk5v8z83vxna6oBlQiLfhrPYWSJPyk+YiOKb89q7WCne8KDZjPONZGqTQnHkqg==
X-Received: by 2002:a17:903:187:b0:1bf:826:9e30 with SMTP id z7-20020a170903018700b001bf08269e30mr1504287plg.16.1695812783029;
        Wed, 27 Sep 2023 04:06:23 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902d2cb00b001c06dcd453csm12797430plc.236.2023.09.27.04.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 04:06:22 -0700 (PDT)
Date:   Wed, 27 Sep 2023 16:36:18 +0530
Message-Id: <87o7hng9jp.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 06/12] ext4: Separate block bitmap and buddy bitmap freeing in ext4_mb_clear_bb()
In-Reply-To: <20230919201532.310085-7-shikemeng@huaweicloud.com>
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

> This patch separates block bitmap and buddy bitmap freeing in order to
> update block bitmap with ext4_mb_mark_context in following patch.
>
> Separated freeing is safe with concurrent allocation as long as:
> 1. Firstly allocate block in buddy bitmap, and then in block bitmap.
> 2. Firstly free block in block bitmap, and then buddy bitmap.
> Then freed block will only be available to allocation when both buddy
> bitmap and block bitmap are updated by freeing.
> Allocation obeys rule 1 already, just do sperated freeing with rule 2.
>
> Separated freeing has no race with generate_buddy as:
> Once ext4_mb_load_buddy_gfp is executed successfully, the update-to-date
> buddy page can be found in sbi->s_buddy_cache and no more buddy
> initialization of the buddy page will be executed concurrently until
> buddy page is unloaded. As we always do free in "load buddy, free,
> unload buddy" sequence, separated freeing has no race with generate_buddy.
>

Agreed. And thanks for adding a separate patch which talks about this
change. 

> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 98 +++++++++++++++++++++++------------------------
>  1 file changed, 49 insertions(+), 49 deletions(-)

The patch looks good to me. Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
