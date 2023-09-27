Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27A37AFAC4
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Sep 2023 08:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjI0GKm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Sep 2023 02:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI0GKl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Sep 2023 02:10:41 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E81B3;
        Tue, 26 Sep 2023 23:10:40 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c434c33ec0so78253455ad.3;
        Tue, 26 Sep 2023 23:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695795039; x=1696399839; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TyVIuA0BaMwLMxnZKzpQRdN52T1fvyT+B4ncon9Lv2I=;
        b=foXu9kVc/AsefpALsvO4BoZnN0dG4B5rYE93fhSIVANgZnFCRvmaAGgu+oj4CMtnwQ
         owk5LLtOQvcMxQbw8kGzkvOi+MDM5zna6enttWAYAfQbmt5row7TR5ki/4qA0z801fTP
         wl10+E/8iZOoaOXLbkg3KuN4se885RpOR7VthJP1nsWsJ5lOeRechE1edMc6V82hDio0
         nCMZ37p+ir8RBTSrzDCXHBzzYqn5lINolYZUh0SsDJqZEh0SBVR9aqjMg7EKarLkEV9k
         Ky/+dVFK7pYju1dV+AHnJxldi3vV+qz8Qq5wFiNwqN/hoHJU3tULXbfSUWpuobjmyHjk
         7WaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695795039; x=1696399839;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TyVIuA0BaMwLMxnZKzpQRdN52T1fvyT+B4ncon9Lv2I=;
        b=fNX0mpOYntW4LGeGFtct3Ctp4R4Bv36C2TQdo6Mg2MFajkgWT63E51dKkwYQbpK06z
         XGq4m8imF0eLwN+1eiNVPq+pUaGnDCyAnsMXtHibEXeQe3fciiY8uQ3m+LcY8+LA4A+C
         76DmGe1R2vCzYacl52pJPBg6YkGWI+K2iUDRA8uO70fB7v3eF+Par0EtAPxM3acfD+la
         OCZnJR3gORGsmuiSdxX+KgkTxiYgkYdwy7G6NhUkPJbSUm0xGvOtbQMcsiHUs1snVpBu
         hV3K+Rg0GMqlCZt17sODHgStj8E+xWd+hqarJnrq8j2KA/6Wlaz3hLT2U9XYeDoYNBHD
         NgBQ==
X-Gm-Message-State: AOJu0YzMLskphboUnIX1vXy0jCfRe3qnYX7EloZOGuz0Zr2+706HKfQc
        ElLYLbnvdLIQ9c5uECUxu+mFS8ceSnc=
X-Google-Smtp-Source: AGHT+IHwJ4q2Q8OTA5KHeThTLH4zGUEiwgr4sRcOwvb35xzSpQ4OxRtpy8CuI3DUMIGSzeEFprd8DA==
X-Received: by 2002:a17:903:2684:b0:1c6:19da:b2a5 with SMTP id jf4-20020a170903268400b001c619dab2a5mr795767plb.32.1695795038945;
        Tue, 26 Sep 2023 23:10:38 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902ed0200b001c444f185b4sm6054789pld.237.2023.09.26.23.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 23:10:38 -0700 (PDT)
Date:   Wed, 27 Sep 2023 11:40:34 +0530
Message-Id: <874jjggn8l.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/12] ext4: make state in ext4_mb_mark_bb to be bool
In-Reply-To: <20230919201532.310085-2-shikemeng@huaweicloud.com>
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

> As state could only be either 0 or 1, just make it bool.

Sure.

>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/ext4.h        | 2 +-
>  fs/ext4/fast_commit.c | 8 ++++----
>  fs/ext4/mballoc.c     | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)

But why not convert at all places?

git grep "ext4_mb_mark_bb" .
fs/ext4/ext4.h:extern void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
fs/ext4/extents.c:                                      ext4_mb_mark_bb(inode->i_sb,
fs/ext4/extents.c:                      ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
fs/ext4/fast_commit.c:                  ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
fs/ext4/fast_commit.c:                  ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
fs/ext4/fast_commit.c:                                          ext4_mb_mark_bb(inode->i_sb,
fs/ext4/fast_commit.c:                          ext4_mb_mark_bb(inode->i_sb, map.m_pblk,
fs/ext4/mballoc.c:void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
fs/ext4/mballoc.c:      ext4_mb_mark_bb(sb, block, 1, 1);

-ritesh
