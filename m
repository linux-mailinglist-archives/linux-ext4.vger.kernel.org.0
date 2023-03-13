Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E890C6B6D59
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Mar 2023 03:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjCMCNH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 12 Mar 2023 22:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCMCNG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 12 Mar 2023 22:13:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE04E1117E;
        Sun, 12 Mar 2023 19:13:03 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i3so11333715plg.6;
        Sun, 12 Mar 2023 19:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678673582;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K+n4Q9Elg6fENVtexuGItppUU9Gn6UAzLaqr/BQkJN0=;
        b=oE61nHcBmT2TIg2q7mM9+n/kO02Ag6KJ6+WWTDHnS32+pxO5wVg+z9LAlx0ZZEdYqi
         szzXcXWhbdDoQo1p+CpwRD45T+yEooxGEeMMi5oqgbOrcFr7bCuu/2EsMDZbhEoG+u+u
         jtuntKeF2y5wLLM/l7M/VgV6PVkgzC0hW0nWRlMEQhwwTGqoS+VFUrN6CHbsQRU1pVo2
         ihdIot257hhSQQpMD6rwDP0j7AO7HmDFf1JN5u502hr3lNxd/4FetXlpIWy/MJC7GjKh
         0X9mMQeVloxE0M33PyAH4chasPOMumqkPjL/eR8sV4HHbOKVLbOowxL/+cnQd+JEZYmH
         eLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678673582;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K+n4Q9Elg6fENVtexuGItppUU9Gn6UAzLaqr/BQkJN0=;
        b=oST16DuwJPpygBLJjv0KBoaz/7+NorxPbw1Cb+cEQybg/4FZRMnr3YiU21mgwfU95e
         QgXrcAPT1nIlPsZ6c/y26ZgTn6Dvr5j7FmGFT5jMR46XbhMSQHRoxp63ltcISA5px2wi
         Ff2i6Ygx8u+tzZ7b4xZJRbNQwqX0oi3p9zNwTaCFkt7AlMqHfbi/k4DTztz/CCBpN89+
         h8BIryxTXQ7BWii8MaV1jiFpanQMnPxt5NG7IaF9gJs8meU26EyqlY67uysQcu1AATCm
         dCgzKdnn/PhoHCT0kT2FJi8+/5GUtw6ukWO47AzkNDP/I4/VCoei9sC/kA2Aq544wT6a
         27Hw==
X-Gm-Message-State: AO0yUKXpO5Hd4BfLuzCOqfI+xkvfUaMvtJ4WExPtKudpapvXr/p8F6zI
        VHwLpk6+LgLCEaOP+/Oa2TQbhG+8R0/Cew==
X-Google-Smtp-Source: AK7set+rw2jvQFAQ1PJ1ybma1APMuGOa/itY8ZuKki/97LNJipWSsnM5beJVFdXmPiWx+0pb6Dl0tw==
X-Received: by 2002:a17:903:1111:b0:199:1160:956c with SMTP id n17-20020a170903111100b001991160956cmr9573628plh.31.1678673582529;
        Sun, 12 Mar 2023 19:13:02 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:469f:1474:7c59:3a57:aab6])
        by smtp.gmail.com with ESMTPSA id g1-20020a1709026b4100b0019a97f180fcsm3476764plt.37.2023.03.12.19.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 19:13:02 -0700 (PDT)
Date:   Mon, 13 Mar 2023 07:42:56 +0530
Message-Id: <87sfe9flg7.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: Re: [PATCH 1/2] ext4: fix typos in mballoc
In-Reply-To: <20230311170949.1047958-2-shikemeng@huaweicloud.com>
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

> pa_plen -> pa_len
> pa_start -> pa_pstart
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looks good to me. Please feel free to add -

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 85d5e219933f..13dce6f07fa4 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4146,7 +4146,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  	 * provide gurantee on number of contiguous blocks allocation since that
>  	 * depends upon free space left, etc).
>  	 * In case of inode pa, later we use the allocated blocks
> -	 * [pa_start + fe_logical - pa_lstart, fe_len/size] from the preallocated
> +	 * [pa_pstart + fe_logical - pa_lstart, fe_len/size] from the preallocated
>  	 * range of goal/best blocks [start, size] to put it at the
>  	 * ac_o_ex.fe_logical extent of this inode.
>  	 * (See ext4_mb_use_inode_pa() for more details)
> @@ -4298,7 +4298,7 @@ static void ext4_mb_use_group_pa(struct ext4_allocation_context *ac,
>  	ac->ac_status = AC_STATUS_FOUND;
>  	ac->ac_pa = pa;
>
> -	/* we don't correct pa_pstart or pa_plen here to avoid
> +	/* we don't correct pa_pstart or pa_len here to avoid
>  	 * possible race when the group is being loaded concurrently
>  	 * instead we correct pa later, after blocks are marked
>  	 * in on-disk bitmap -- see ext4_mb_release_context()
> --
> 2.30.0
