Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13ADA78FF33
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Sep 2023 16:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjIAOaB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Sep 2023 10:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjIAOaA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Sep 2023 10:30:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4424EA4;
        Fri,  1 Sep 2023 07:29:58 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf48546ccfso14430425ad.2;
        Fri, 01 Sep 2023 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693578597; x=1694183397; darn=vger.kernel.org;
        h=in-reply-to:subject:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1JzqNYjXIl7nrNHm3ndUiyCC1a/Rpg54qkTk2CEy/A=;
        b=lEIQw++zrSLB2GlLZDzX4j/RINLJk8FsnE6Gf986YNFFgBcG9bX+jAIoMWJeSQ99iI
         9YK5OkTm2ngUR8RjigCs2rJNWBvW4jhEZM3Q5SW4EI96vXjBefcK3XSieHDc2rJnJF0o
         vnO9jCUp1Csaatj+IzCxTh6/DIwljqjTj3qVpadF2f3RFwM3dbLFY4eTik0WTl3aErWN
         +iqF7AgaAla24/aeKEOWQtjlPaGkedq5/GgrDcBVkUNuLOh3kpqIVeOcIOlHPptTvjhM
         wCdt5JqtI53KPemnM0Nf0JeQwslJ8G2H/CmUjjsSPo3p0WRn3XikXtWY6cAo1upgnK8U
         Lqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693578597; x=1694183397;
        h=in-reply-to:subject:to:from:message-id:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q1JzqNYjXIl7nrNHm3ndUiyCC1a/Rpg54qkTk2CEy/A=;
        b=XYOg3zyEmvZBJSfptEZXyCkdK3xtgf6VUQAL2ebZbqhJ/zuglUA21IVpVeGip8dvGz
         cR1MDU2d0ia74EnbstypMwVKIpgwGyFNE65dHIBBzO5WMYc+VhPR0xvP+c17BaS5T61A
         lgh7z6Z6o6VDzKraX34mB5N856A3aaDn9yDPf/SnXgmv2IajnKX0WCX9L2aiegM4zO90
         6+o5vQR7s3RhqTRywg6hnNjcCHawI7sn4vRU9ffPskFzS9q6xdf3/1nwegOc2H5gyZhJ
         T8yhmdqbbehuUpGbD2HGGTWUDmUskv3TaI1xladQfVGTOTW/+acE66QIBowWNk1g4yoB
         Ssug==
X-Gm-Message-State: AOJu0YzpdX+Ti+HzjsmWk/6zydw/+nUZAC1kiBBf/h866NHCjwBztMRo
        3zPNkj5EGclcObhehs/ztSn0hYjObHI=
X-Google-Smtp-Source: AGHT+IFwD9dDZNSA6TGFLYCYoigKKjl0e60HAcktKkDUTQaSe20gIcDdT3aU3bT2qD9ZvfEwghA5FA==
X-Received: by 2002:a17:902:ef82:b0:1b8:5b70:2988 with SMTP id iz2-20020a170902ef8200b001b85b702988mr2581304plb.30.1693578596994;
        Fri, 01 Sep 2023 07:29:56 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id iy22-20020a170903131600b001bf20c80684sm3097033plb.6.2023.09.01.07.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 07:29:56 -0700 (PDT)
Date:   Fri, 01 Sep 2023 19:59:53 +0530
Message-Id: <87wmxa6k66.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/11] ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc
In-Reply-To: <20230826155028.4019470-11-shikemeng@huaweicloud.com>
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

> Here are prepared work:
> 1. Include mballoc-test.c to mballoc.c to be able test static function
> in mballoc.c.
> 2. Implement static stub to avoid read IO to disk.
> 3. Construct fake super_block. Only partial members are set, more members
> will be set when more functions are tested.
> Then unit test for ext4_mb_new_blocks_simple is added.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc-test.c | 322 +++++++++++++++++++++++++++++++++++++++++
>  fs/ext4/mballoc.c      |   4 +
>  2 files changed, 326 insertions(+)
>  create mode 100644 fs/ext4/mballoc-test.c


Thanks for working on the review comments. The purpose of functions and
structures are much clear now. Also the approach of including
mballoc-test.c within #ifdef macros inside mballoc.c looks ok to me.

Nice work in getting this ready! 
ext4_mb_new_blocks_simple() is a good first start (even though as of now
it is a simple allocator for fast commit replay path)

-ritesh
