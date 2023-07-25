Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C969676131D
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jul 2023 13:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbjGYLIT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jul 2023 07:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjGYLIA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Jul 2023 07:08:00 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4AB19A0;
        Tue, 25 Jul 2023 04:06:33 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68336d06620so5031777b3a.1;
        Tue, 25 Jul 2023 04:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690283193; x=1690887993;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jxo6App/CgZGpWLnlrQ5JN9zlgf5XBdiJvk1vlDo3iA=;
        b=cv9wUDYGjfqpNaB58SD8ThhvBpLaBiF/sXeDoHd/7Y+ZpbHv7Y8CO6+wVI3acHT4Bv
         CHfeCexJJDavZma+i4mV+sqYN7a+oK/dkoW8rkupyOh4TZRv4qJ+0RiCEG+frPgNXLkh
         Zjj7tK+G+W5N57Qc7MdfuOz06Kqj4au6yIJBMhduZxy5b7AJ+7lDIXZQCBP7XV9caRZJ
         LiaZAMXCp01riRPPNYUsJx8l4YBh8GexAzncVYS4OgH41CH9wmFXpupILyf+9Nl9YWi+
         xJM3Rv/5ZgcTaCaVhwWEeeaC661tTv8RS5Wo4YiNC1WCAJsF4XX0AwxU+FOyOU3waPh6
         kFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690283193; x=1690887993;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jxo6App/CgZGpWLnlrQ5JN9zlgf5XBdiJvk1vlDo3iA=;
        b=QQ5veCkpH5b9pp+gSAQ3fnTho3rc4bi7YYnmVHr40S/tdwx1E01UJvh2t82GXIXu95
         RS39Zo8ZSbVgJw8JvcgMHE16WgG9QLLO1fgTZ69qtLq4EOj5Itg8t9XVjBtbQavcUPk/
         2iz7TR+7eDKyHZfEBADhpOfEAmUveNFacapkBCoRfSQXCR48ce79V6zL8WE5CSy6v/ov
         MUlVSNaC4MxLxprVoETlrcca7aS5C1R58L8TnSZTBkUSJJSiFoobc4v7qN08iAMvK8FL
         SyrQEAQG/Vy3N5IMwfBS9LiAIOP7ID8wTfy0XJUwpMtD114GRCLmLTyZsiDB6VpJ2SbS
         8jbQ==
X-Gm-Message-State: ABy/qLbxgCxy6+6cX/WHHUtR3U1+XPZhmPrbe05eielkAekviHY4o3qu
        NdWRS5qyAg5xPnNpozAOkIU=
X-Google-Smtp-Source: APBJJlHwRxH/Fvv74vzZz4XH1TFYiZ4TZ3W6xoZXj8Y8xEsigfSH89MIbQzL3kNJzAv5Q/KwKAj8yA==
X-Received: by 2002:a05:6a20:1058:b0:133:bc8:8a47 with SMTP id gt24-20020a056a20105800b001330bc88a47mr12562878pzc.3.1690283193035;
        Tue, 25 Jul 2023 04:06:33 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id k9-20020a633d09000000b0054fd46531a1sm10328402pga.5.2023.07.25.04.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 04:06:32 -0700 (PDT)
Date:   Tue, 25 Jul 2023 16:36:24 +0530
Message-Id: <87a5vkw8r3.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: Re: [PATCH v2 01/10] ext4: correct grp validation in ext4_mb_good_group
In-Reply-To: <20230725185106.2147273-2-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> Group corruption check will access memory of grp and will trigger kernel
> crash if grp is NULL. So do NULL check before corruption check.
>
> Fixes: 5354b2af3406 ("ext4: allow ext4_get_group_info() to fail")
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks good to me. Feel free to add: 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 456150ef6111..62e7a045ad79 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2553,7 +2553,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
>  
>  	BUG_ON(cr < CR_POWER2_ALIGNED || cr >= EXT4_MB_NUM_CRS);
>  
> -	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp) || !grp))
> +	if (unlikely(!grp || EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
>  		return false;
>  
>  	free = grp->bb_free;
> -- 
> 2.30.0
