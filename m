Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C2D6B6D5B
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Mar 2023 03:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjCMCNu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 12 Mar 2023 22:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCMCNt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 12 Mar 2023 22:13:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2792D152;
        Sun, 12 Mar 2023 19:13:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so11916764pjn.1;
        Sun, 12 Mar 2023 19:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678673628;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G5M4veBYufJzjA6KeJEbr/OhWNwQRqEHVIYpMQs6GyU=;
        b=J+xEjPiN74JFK3jJ9S4F2ql6EodVAV5SxPFHTqaMSRUpX3M8JRR3W6yWSj71RxToAS
         3cOj+o9z0r/rqb25YkaXeoKYJMZmj1HNS8TfPy6wwuJeiAdc50TftB55d7ZDccBNGMV6
         twio7Qk97jM4LMQo1Ur8yXCu3XWfJXwVdvotSOIK6ECDnoBFQdgTcfb5dKjHESCOL00R
         VqO3yrn7T9wmcA/KEQ/dvzykwx/iGk5fpdB4Ex+QWOjKtmUesX/4AWjTwFSxA4w3nFuv
         8d9aZZFn//Sky6DBcUvaBK2sTWC2H4VajkNHytHaeZDcZcHsgKKY+Ow8btsu59o4LkTJ
         QSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678673628;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G5M4veBYufJzjA6KeJEbr/OhWNwQRqEHVIYpMQs6GyU=;
        b=CMwp3TOoqihVtO8UBRLpTjP0JL1canfTZ8L6f5ULnY2LmI1ZJ8zik0l2vInP5VsCiS
         y1NcQs+Y6hI8REd+yD888a+a43bSWPyA4sLvcbnmmrX84lDC+bh25d7gwUQJSTluNhEm
         TVPas+br18U2g/0+PzdGkr2/dJzb5lu3IjWRby6AcKO4miohc2Jrii5/VK5RnT5IJEtz
         LU4JdL1mBYne/HXEXU/pz/Iq0gQJUE9J5Imr7Gu1UFEaz7jq0ad0BbwXAHojzf+9rcTo
         tlHKMiUCxKQ99co3NFkC67busrn3+FO7wR6u4EP/exWwBr1fJ7ref1CST6/tikK1FH6q
         I96Q==
X-Gm-Message-State: AO0yUKVdefUilSgAMu3N6SB4kn/7GGuYrdyLVkyouPWoE/0FiGrNPM56
        u6D3Z8mapMjQzx/SlGF2XZg=
X-Google-Smtp-Source: AK7set/qGlLdxK8V4INRJNzjSuOAIjb/6g/te7G0wNvJEZLwAgGuQhpc1+gEfgFU5CErh9kpzyUTYA==
X-Received: by 2002:a05:6a20:3d0b:b0:c9:9312:5f1d with SMTP id y11-20020a056a203d0b00b000c993125f1dmr43333630pzi.4.1678673627944;
        Sun, 12 Mar 2023 19:13:47 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:469f:1474:7c59:3a57:aab6])
        by smtp.gmail.com with ESMTPSA id d13-20020aa78e4d000000b00592417157f2sm3388390pfr.148.2023.03.12.19.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 19:13:47 -0700 (PDT)
Date:   Mon, 13 Mar 2023 07:43:42 +0530
Message-Id: <87pm9dflex.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: Re: [PATCH 2/2] ext4: avoid unnecessary pointer dereference in ext4_mb_normalize_request
In-Reply-To: <20230311170949.1047958-3-shikemeng@huaweicloud.com>
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

> Result of EXT4_SB(ac->ac_sb) is already stored in sbi at beginning of
> ext4_mb_normalize_request. Use sbi instead of EXT4_SB(ac->ac_sb) to
> remove unnecessary pointer dereference.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>

Looks good to me. Please feel free to add -

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 13dce6f07fa4..d94eb52dda17 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4049,7 +4049,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  		size = 8 * 1024 * 1024;
>  	} else {
>  		start_off = (loff_t) ac->ac_o_ex.fe_logical << bsbits;
> -		size	  = (loff_t) EXT4_C2B(EXT4_SB(ac->ac_sb),
> +		size	  = (loff_t) EXT4_C2B(sbi,
>  					      ac->ac_o_ex.fe_len) << bsbits;
>  	}
>  	size = size >> bsbits;
> @@ -4094,8 +4094,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  			continue;
>  		}
>
> -		pa_end = pa->pa_lstart + EXT4_C2B(EXT4_SB(ac->ac_sb),
> -						  pa->pa_len);
> +		pa_end = pa->pa_lstart + EXT4_C2B(sbi, pa->pa_len);
>
>  		/* PA must not overlap original request */
>  		BUG_ON(!(ac->ac_o_ex.fe_logical >= pa_end ||
> @@ -4128,8 +4127,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>
>  		spin_lock(&pa->pa_lock);
>  		if (pa->pa_deleted == 0) {
> -			pa_end = pa->pa_lstart + EXT4_C2B(EXT4_SB(ac->ac_sb),
> -							  pa->pa_len);
> +			pa_end = pa->pa_lstart + EXT4_C2B(sbi, pa->pa_len);
>  			BUG_ON(!(start >= pa_end || end <= pa->pa_lstart));
>  		}
>  		spin_unlock(&pa->pa_lock);
> --
> 2.30.0
