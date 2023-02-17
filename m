Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4240E69A5B7
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Feb 2023 07:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBQGqg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Feb 2023 01:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBQGqf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Feb 2023 01:46:35 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1FC5D3C0;
        Thu, 16 Feb 2023 22:46:33 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id v3so621808ply.2;
        Thu, 16 Feb 2023 22:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FldP8vVa1Blyxro3z6Zk/KBA6/hWrrqG0SFB204VBTo=;
        b=eNVCpMu/v+1JjVKUQGODiVBy6nVP/dyzKpAtnWx9lubIToGR+gOuXHZ8KaVCojpmx8
         YJ05InuAX3KjbYsXLVd+ozRNTnmWeSRi6DTPV0Yp7sEIJFiV4iIWIajuWqEr8U1sQT06
         O6aLsiMMc/85Gtyycf0Rv5ZKignqhcOcnfv9nJhGJg67lfZdAwQgWey3iRdUzzP1RxVn
         JOKgOoHqM85BYYBNOBeVHu9mur/OPiMxRYR7aFY0j11PxHjn4e6dVV6Tya8sw47A5/+o
         rzVsvj0LnCmjuiI1Qm6Jluk2Uz9iK0ohHveYwkYGzMnt4OS6A/Ul3ofgZltA+6nuS4Fa
         g34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FldP8vVa1Blyxro3z6Zk/KBA6/hWrrqG0SFB204VBTo=;
        b=G2Y1QiSAk8DSOFITLK0KpT8nTC4MGkff5pZsQlUSzjTroUJ45n0y5EibMA0kw9u611
         BYX3t/Lkmzc2ImBASvSi11jGaroIGqyGIAXQVdCPf/zeIPOK5iiQYF3SsB+TJAaXhJQV
         ZXg6NnwJPdzXQsfLD7KiL31GaDl2UXPkIVPSkHpe/gi4h7xcfVOUa6UK7UwazZtiBrmI
         2bVo8Ukk0CeCrGdxaJHKMDcvthy8Se+hJBoz5jCXgTaL3Q9LRhxDMUNPaqh9Keh9Chf4
         jqTsRh0NMEGKJkb/K4e4mHsKefEv2TqSXuJck4pGI+Lb9CvqmXRE56YMHm0JJFKIjrwj
         v5ag==
X-Gm-Message-State: AO0yUKULk4tlj1eeGV1CJUofaopTizibDtXJW8FCo+i05sr0FdhLYpIQ
        RdGBW0DSG3IqnYRMfxbxRNLR/7ANIm51yA==
X-Google-Smtp-Source: AK7set8Z1AAoepdSB1Z0ka84qru/85qM/KYlk/bRI7FcAeiHEHkWpZVcNINleM+7/F8Vj5ydv5gIfg==
X-Received: by 2002:a17:90b:3b4f:b0:235:1fb7:393d with SMTP id ot15-20020a17090b3b4f00b002351fb7393dmr2141357pjb.17.1676616392183;
        Thu, 16 Feb 2023 22:46:32 -0800 (PST)
Received: from rh-tp ([2406:7400:63:5056:148f:873b:4bc8:1e77])
        by smtp.gmail.com with ESMTPSA id w15-20020a17090a528f00b0022c326ad011sm2167881pjh.46.2023.02.16.22.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 22:46:31 -0800 (PST)
Date:   Fri, 17 Feb 2023 12:16:25 +0530
Message-Id: <87ttzkiybi.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/21] ext4: get correct ext4_group_info in ext4_mb_prefetch_fini
In-Reply-To: <20230209194825.511043-5-shikemeng@huaweicloud.com>
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

> We always get ext4_group_desc with group + 1 and ext4_group_info with
> group to check if we need do initialize ext4_group_info for the group.
> Just get ext4_group_desc with group for ext4_group_info initialization
> check.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 352ac9139fee..f24f80ecf318 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2570,13 +2570,13 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
>  			   unsigned int nr)
>  {
>  	while (nr-- > 0) {
> -		struct ext4_group_desc *gdp = ext4_get_group_desc(sb, group,
> -								  NULL);
> -		struct ext4_group_info *grp = ext4_get_group_info(sb, group);
> +		struct ext4_group_desc *gdp;
> +		struct ext4_group_info *grp;

We can even declare these variables at the begining of the function like
in [1]. Also I would advise to rearrange any "fixes" patches at the
begining of the patch series and "cleanup" patches at the end.
e.g. this looks like a fix to me.

That way it is sometimes easier for people to cherry-pick any fixes if
required in their older kernel trees. ;)

[1]: https://lore.kernel.org/all/85bbcb3774e38de65b737ef0000241ddbdda73aa.1674822311.git.ojaswin@linux.ibm.com/

-ritesh

>
>  		if (!group)
>  			group = ext4_get_groups_count(sb);
>  		group--;
> +		gdp = ext4_get_group_desc(sb, group, NULL);
>  		grp = ext4_get_group_info(sb, group);
>
>  		if (EXT4_MB_GRP_NEED_INIT(grp) &&
> --
> 2.30.0
