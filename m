Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A11575CCC6
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 17:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjGUP4R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 11:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjGUP4P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 11:56:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1A1359F;
        Fri, 21 Jul 2023 08:56:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b8ad356f03so13395575ad.1;
        Fri, 21 Jul 2023 08:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689954961; x=1690559761;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VibBhfAmpo7g9rNI688LGzgM6u6sTP/EcrjxZUdK32s=;
        b=P7bWSeoDKv75IRxhioSl5JP6HfISxZkViAc6M/xqc2Ik6yDRauZxmzcDi6nQXXAIer
         BTVcwTfTQh4cvBG7+h7sU9trWkWW1ieJgp9jPgLccEVPo2Jp0G09aYuLGZomC/RtGxOy
         9OmpGut+NkiUAof5AXvDOQwCI8bFR5mkzDgWjMMzCcwZZn4ska3CoCSuN57QFmQmddIK
         yLgxhlOnLtuFHDjBePv6GFDalR/wP9ULoTnRGSRWh9VPCRhS6jzMTLLmZxICgiwbQbwI
         YwLyUy5hz5bwdU+7nv9OL9QtASw6vdITWZoPVYP7jJHyxBrDQHf+vDDmVnQv0EwDRyhk
         ROGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689954961; x=1690559761;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VibBhfAmpo7g9rNI688LGzgM6u6sTP/EcrjxZUdK32s=;
        b=Bfpsi2n1nnM7eZ1Tp+rmzhf+hTGW+hOMUNIGlUk0BBHZW4pb1ig5heD2Ex82cTZwfG
         Knizi3prH2iy/obyCvfPdPdFBS+EV+lD4Tn3CHru4+X1JScv9kfQ0+GvcbMdcTnmcqAQ
         tcs12yBaZr2R3sJt8uTFfUo5L0+J9szaXwzBL+nqI1AA69AS/EfprlFpodXrLW04mmma
         FytQ34xhBdVntoQyGx7BnL3+NupWWRUmnrJeYF6UkcGqerGuLS0BAD7B/sorzmQBLfxP
         Gg7VHebaOWgDcrk3l5bugsnAxKoqjkDwsdr7D8EJtjGZYOe3P5/M4wGQNgn5MZc3YYMP
         Mqfg==
X-Gm-Message-State: ABy/qLaVS6veypJAsHs4qGsDoUdguIXUG8GWqeg59hsZM7Vp95IKrAoq
        vqBBN5nWNfET/rIL26m/DI4=
X-Google-Smtp-Source: APBJJlF7y037M3XL7JEidVjX0CUTHlew3nLMq6JQMa17hN6K8gXqZXWrBT+bueKJoN37pAcEZvyNeA==
X-Received: by 2002:a17:902:70cb:b0:1b8:2dca:fa19 with SMTP id l11-20020a17090270cb00b001b82dcafa19mr1718927plt.28.1689954961091;
        Fri, 21 Jul 2023 08:56:01 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090282c400b001b9cd9d7ce4sm3641668plz.219.2023.07.21.08.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:56:00 -0700 (PDT)
Date:   Fri, 21 Jul 2023 21:25:56 +0530
Message-Id: <87o7k5jm2b.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: Re: [PATCH 00/10] A few fixes and cleanups to mballoc
In-Reply-To: <20230721171007.2065423-1-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> Hi all, this series contains some random fixes and cleanups to mballoc
> which include correct grp validation, fix data overflow and so on.
> More details can be found in respective patches.
> Besides, 'kvm-xfstest smoke' runs successfully without error.

Thanks Kemeng for the cleanup series. Looks good to me with few minor
nits which I have commented in individual patches.

Note that I couldn't cleanly apply the series on ted's dev branch
(Patch-05 gave some minor conflict). Maybe you might have based your
changes on top of linux master or something. Anyways it was just a minor
conflict and I don't know what is Ted's general preference here, but I
thought of doing an FYI - 

-ritesh


>
> Thanks!
>
> Kemeng Shi (10):
>   ext4: correct grp validation in ext4_mb_good_group
>   ext4: avoid potential data overflow in next_linear_group
>   ext4: return found group directly in
>     ext4_mb_choose_next_group_p2_aligned
>   ext4: use is_power_of_2 helper in ext4_mb_regular_allocator
>   ext4: remove unnecessary return for void function
>   ext4: replace the traditional ternary conditional operator with with
>     max()/min()
>   ext4: remove unused ext4_{set}/{clear}_bit_atomic
>   ext4: return found group directly in
>     ext4_mb_choose_next_group_goal_fast
>   ext4: return found group directly in
>     ext4_mb_choose_next_group_best_avail
>   ext4: correct some stale comment of criteria
>
>  fs/ext4/ext4.h    |  2 --
>  fs/ext4/mballoc.c | 85 ++++++++++++++++++-----------------------------
>  2 files changed, 32 insertions(+), 55 deletions(-)
>
> -- 
> 2.30.0
