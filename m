Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7092475CBA9
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 17:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjGUP0L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 11:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjGUP0K (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 11:26:10 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71C512F;
        Fri, 21 Jul 2023 08:26:04 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5607cdb0959so1127091eaf.2;
        Fri, 21 Jul 2023 08:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689953164; x=1690557964;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2XADGzXDE1Cmqc9k3erzJdoJdm6r5SA4QUqxQVr/X6c=;
        b=iKPRwnvs9sqCriXOw/HdWzzJ6w5MYPPuTn/ZViObaPe5zoVBNcUA394quv1FTU8IZA
         uu87NSHHwQ58Mzsz6a1RSavv6W00W2rwo5yt0OY0tcaaBXheCvltY30m/ycBNotVplUV
         CH6m1p+CbotMkZqG01VoSCFvAb8TQe7beRK81Xhk2GagSSz1QzX8SpWLNfnBXCGT3Bsn
         dXANoI57rj75kbUs9BF1IdbH9GoVSTf8vU409IHK2jdM5lGUXi0D7TS3k5oDRKqp0Xkb
         +1PpdI6SRXhc7Qk0/oAZ2p8AWVmyp9HgkvQoKtTRne4ZgIdkxXsjfmyGFEHvtuUWNe59
         XA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689953164; x=1690557964;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2XADGzXDE1Cmqc9k3erzJdoJdm6r5SA4QUqxQVr/X6c=;
        b=ML1bEyQLyjJx/ZoBmHpftWvGreUi70GpG0ULtRJM3yCWVhqp3hWzYN/uWGfPuFKQj1
         A6Dup7O/Yjn2IcgxHJFPk8Rq8hvzfkI0pUWodwvz0mllfoDsxNJbITAKjsmzjKSlWf+I
         hjtTDxhnr1/Bwc5eWjl8rOfnVoBwPOpBkFM0usl8CTgb2ZprB20ti80tmAhxNFaVBBhM
         p5XIOG4cKOdQkrfV3u9qI5B397oqWq6xm9GxUeUELVzyyOw4tLL831JzU0/pY9d5kchi
         DvmUtfkx/3v/366e+vh7uWfu6VlOw2Whcswuf5Gkt4/7fTnqj3iMZC3V6wFUKVw84EaF
         Dohg==
X-Gm-Message-State: ABy/qLZejKGPcQNAN7md0x6JG20RbHhPtOp4HBeCyKFaQpl9Mjwi9Eh5
        0GVjhepM2hbfLndKtXEyAbE=
X-Google-Smtp-Source: APBJJlFXGIAfsDoT/WoZZltvCYh3AlJifi4lbFeTodR9/ZlSsyKgDUUepmSm1K23OQAJrb4qZ9EwzQ==
X-Received: by 2002:a05:6808:1819:b0:3a1:f135:6a49 with SMTP id bh25-20020a056808181900b003a1f1356a49mr2925509oib.29.1689953164061;
        Fri, 21 Jul 2023 08:26:04 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090a850600b002635db431a0sm2688201pjn.45.2023.07.21.08.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:26:03 -0700 (PDT)
Date:   Fri, 21 Jul 2023 20:56:00 +0530
Message-Id: <87fs5hl20n.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: Re: [PATCH 02/10] ext4: avoid potential data overflow in next_linear_group
In-Reply-To: <20230721171007.2065423-3-shikemeng@huaweicloud.com>
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

> ngroups is ext4_group_t (unsigned int) while next_linear_group treat it
> in int. If ngroups is bigger than max number described by int, it will
> be treat as a negative number. Then "return group + 1 >= ngroups ? 0 :
> group + 1;" may keep returning 0.
> Switch int to ext4_group_t in next_linear_group to fix the overflow.
>

Fixes: 196e402adf2e ("ext4: improve cr 0 / cr 1 group scanning")

With that feel free to add: 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 90ffabac100b..33ee3991f62c 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1081,8 +1081,9 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
>   * Return next linear group for allocation. If linear traversal should not be
>   * performed, this function just returns the same group
>   */
> -static int
> -next_linear_group(struct ext4_allocation_context *ac, int group, int ngroups)
> +static ext4_group_t
> +next_linear_group(struct ext4_allocation_context *ac, ext4_group_t group,
> +		  ext4_group_t ngroups)
>  {
>  	if (!should_optimize_scan(ac))
>  		goto inc_and_return;
> -- 
> 2.30.0
