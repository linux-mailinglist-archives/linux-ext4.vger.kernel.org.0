Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D754EEAC8
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Apr 2022 11:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344807AbiDAJ4b (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Apr 2022 05:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243756AbiDAJ43 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Apr 2022 05:56:29 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5686E147AD9;
        Fri,  1 Apr 2022 02:54:40 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y10so2172840pfa.7;
        Fri, 01 Apr 2022 02:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wz8YVUbIP5nrpoUYrQkW7TtuDiEPJ3Xg42mnIzGwg5I=;
        b=dFmzRXQV21ibYwzi7Ayh1t6Wolpm2UrezH96+Q749JEdIflJbBh6i5nPWEEcJa9GLI
         QkVWYXd35aIINLVDoNEJESGco883A+pKdxzBg4M/ezTSoIwNT2X5Jix0s0tIWQWN5GaT
         2V9U9ClRKNSHNkh3HUpN6Rg98Jdv6U9iTLws/2Lhu7kP8YkTimPzw4JCWFe8JIljvsGZ
         BdJ2xc6CuSPteOxIGFtmEPVvaT7rjTmBPoaN9zQ6+PkeIlwD49a1ixiljpYGVDzPal/H
         gQpezLRo9ctRtTgV3PW/e2zL6J2IJahEP3HUXaJPdr55ws+UwQgD3Xf0w1wWWzxqeyFv
         qFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wz8YVUbIP5nrpoUYrQkW7TtuDiEPJ3Xg42mnIzGwg5I=;
        b=aKIAbi8sUH9jSOZ2aEsy1s8+2J+dE6F8RWESbrIyhd+ZGarl1vzkqyQLGfxNV8ZGKH
         5EsuV7aH85ydpByTBJdyGwe738a6mS2SlPkEN/8W5V0M8rsBVxYWO7sA5c0+JZZF+7Eq
         iqXkyX8FoLR4F3557+WrHpzEymmborGQsEDLPIF886Vvq4vEymWzcoGEuQgc+AryFat2
         q2d7j9oG2D2/OhPsAJCYmqvuT0+Xh7kk/ojENWvRqFYRafkackAgsKvnqPii6kB5qUT/
         ymzCWiRE66k3qr7Z6i0rSzOKMo399MNDC03EHjGBiBVSxOo+TQK/rlOSmUY8Bg7fxhVl
         z3mg==
X-Gm-Message-State: AOAM5320sEKk+MM3H+09IL5P7ffunyJxGx8nDH9UR6xD1tb27nE77Tgp
        JJT9YZCuZyzz455yxN7NInmnK7Pkaz0=
X-Google-Smtp-Source: ABdhPJz3yZtbUujbvFgD9334kdr1l4bb6xKKoNxXMzUqACAZooVSdoi5PdJG0uoxS8Xv6Kj06qlIrg==
X-Received: by 2002:a65:6d87:0:b0:374:2525:dcb0 with SMTP id bc7-20020a656d87000000b003742525dcb0mr14484850pgb.248.1648806879714;
        Fri, 01 Apr 2022 02:54:39 -0700 (PDT)
Received: from localhost ([122.179.46.149])
        by smtp.gmail.com with ESMTPSA id p13-20020a056a000b4d00b004faecee6e89sm2541921pfo.208.2022.04.01.02.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 02:54:39 -0700 (PDT)
Date:   Fri, 1 Apr 2022 15:24:36 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     fstests@vger.kernel.org, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] common/rc: Modify _require_batched_discard to improve
 test coverage
Message-ID: <20220401095436.oxdq2duhuudx2c4r@riteshh-domain>
References: <20220401055713.634842-1-ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401055713.634842-1-ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/04/01 11:27AM, Ojaswin Mujoo wrote:
> A recent ext4 patch discussed [1] that some devices (eg LVMs) can
> have a discard granularity as big as 42MB which makes it larger
> than the group size of ext4 FS with 1k BS. This causes the FITRIM
> IOCTL to fail on filesystems like ext4.
>
> This case was not correctly handle by "_require_batched_discard" as
> it incorrectly interpreted the FITRIM failure as fs not supporting
> the IOCTL. This caused the tests like generic/260 to incorectly
> report "not run" instead of "failed" in case of large discard
> granularity.

Ok, I looked at fstrim code and it does print [1]
"the discard operation is not supported" in case of rc == 1.
And if rc != 0 it will always returns EXIT_FAILURE.

So this patch looks good to me. Feel free to add:

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


Although it will be good to check if we can add a generic test case
using maybe lvm or dm device, where this device could report large
discard_granularity for actually excercising this code path
(rather then changing kernel code to test it).

-ritesh

[1]: https://github.com/util-linux/util-linux/blob/master/sys-utils/fstrim.c

>
> Fix "_require_batched_discard" to use a more accurate method
> to determine if discard is supported.
>
> [1] commit 173b6e383d2
>     ext4: avoid trim error on fs with small groups
>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  common/rc | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
