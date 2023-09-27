Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE907B0299
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Sep 2023 13:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjI0LQk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Sep 2023 07:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjI0LQi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Sep 2023 07:16:38 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4CC192;
        Wed, 27 Sep 2023 04:16:37 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c61acd1285so48664335ad.2;
        Wed, 27 Sep 2023 04:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695813396; x=1696418196; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ykm/Uk/QqkPLTAOhiY+vkTfZ0jDuS8cAV70ZHjujM4Y=;
        b=beVLKTnFZYdOk9GAaQjpNzrVeTiS7NZoc02q7xOajnveDHfOZeE6bOn3xJSD0dxmKf
         dlROAKg+/Mgr50JC0jPGm5826NHttMGyHxPKfwoPqtyCyVvfpemR5CwLqZ8QKeC8lOGH
         tTT3tWLkD8nb07ZDmsg1iP3EZRw2XvlGq5Vgvk5k7P1eKhty6ZzzzYT5f2d7zUYohrin
         z1p1o7ptni5ZpXMhL+Lmce5CGgsSy5HFgeUoVi3sB/urHYWaKMICP1yZ2aTOjgDfJkCs
         IXrBWrQxVh27TMvP881JVVdHhVYEnzFuOOCh6d/Z+jLaFm/82q62UjAa45/ERjGe3aUH
         LJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813396; x=1696418196;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ykm/Uk/QqkPLTAOhiY+vkTfZ0jDuS8cAV70ZHjujM4Y=;
        b=G7tIHs69kyQn+AlwhC1xJCgUaa86D0jJQx/mT1qk8cVJP+eA7/j5vvYZZeyhGveS09
         HGCCzHywOQSH0Q9m5Zvf6nCD+KDYkIHjiRwnndkUTjI1z0JrrFp1N+b9PAbw4QRdyCtH
         vnT13/tc5rZS54vpSpdwOuzI0vMhUxjiEfKq31PtHI9bx2zIqyOLTpwSVNNHREywlJLC
         J5Wrx+/mjkO6gcvF3l9g4PdvIVk2L3P1xmL07pKmMVi/wvC9g6eUcrJoiCnCaXKujPsV
         trDDmsErukogNBuCEter9yDxgovzgV5YnFIv2WTgzbakp4A8BCbdsUnZkEsiCBezXnVP
         Xewg==
X-Gm-Message-State: AOJu0YwqXSoMg9F8Tajs2/eITZBA+AQg02fdNOdBrkGbJ5mZOlSqRYpN
        eCsO/GCyK0wU+5bXpMBx7QW7DADLEXQ=
X-Google-Smtp-Source: AGHT+IFk5G4LKT8halfgICK8nKsX9k9OZuVyWbwgabPvok44jAd88R1dib66k4czUCQvpWeD658vDg==
X-Received: by 2002:a17:902:6806:b0:1c5:8401:356c with SMTP id h6-20020a170902680600b001c58401356cmr1335425plk.62.1695813396032;
        Wed, 27 Sep 2023 04:16:36 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id z13-20020a170903018d00b001c0a414695dsm12835497plg.62.2023.09.27.04.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 04:16:35 -0700 (PDT)
Date:   Wed, 27 Sep 2023 16:46:31 +0530
Message-Id: <87il7vg92o.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/12] ext4: Separate block bitmap and buddy bitmap freeing in ext4_group_add_blocks()
In-Reply-To: <20230919201532.310085-9-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> This patch separates block bitmap and buddy bitmap freeing in order to
> udpate block bitmap with ext4_mb_mark_context in following patch.
> The reason why this can be sperated is explained in previous submit.
> Put the explanation here to simplify the code archeology to
> ext4_group_add_blocks():
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
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 54 +++++++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 28 deletions(-)
>

Looks good to me. Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

