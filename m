Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A6A757ADC
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Jul 2023 13:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjGRLsQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Jul 2023 07:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjGRLsI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Jul 2023 07:48:08 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F42EC0
        for <linux-ext4@vger.kernel.org>; Tue, 18 Jul 2023 04:48:07 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e48e1f6d1so7600529a12.1
        for <linux-ext4@vger.kernel.org>; Tue, 18 Jul 2023 04:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689680886; x=1692272886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zlIs2dsVoMlsB/D5YESYBz8KY0+SG3lYxZZPQTzebVI=;
        b=frcHAFDOWpjvuR36HpnIiI72u46e2CI0GU5+TvRTYYrKYhzpHE1jrPxYSJpHb1WZ5u
         Rjvu3QuVwgrssy1PGJBfjXSgeoHvbLEBcq6o9pGZTRy8rXryEJkmJsKGrX44KuirUX/S
         Bjbra8AqzdhaNbsmCtLTLmR2L1UK9PwUFAEHGuIFjm5a+LQijfaIBIIj4z1HqpkM+Lwo
         pW0Ex8ONIDt9E45A2Zlex2R3W6Ho7WHjQA6dNGePcE9pod5uKo5N7m3vvl7MrKq3gYcy
         cy2AZU6ewullzS2mWYg3aXPuoOjS4HFCJ2vDeikr/9IrtasI5b+MryhNPKGWkJ6gEqSU
         I9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689680886; x=1692272886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlIs2dsVoMlsB/D5YESYBz8KY0+SG3lYxZZPQTzebVI=;
        b=XtO5d1d+03UVHyh3WROyLog+hmOERuc03CTCI2YOkG8N7ZTJPYsrPOavGQKBsxZLEK
         eLrHCvSAeaiFavTbLt5n8ISuqpmhY3KvnJm7qnxCRRrmJd5qzNtQU3bIsKsZnl6iz9ML
         WI4xoPrgzw5ewIMmtJ/MOA3ru1nVcupqr2/rO/4s3TUzIIqRTMwv0wT5xaH4sBznGVMU
         ipU1EZnzf7e4xQ8NbtDIQXjudpBYUPuEW5pHHMFkLDJvE8SVecO6coiH4r//z9q1G6E2
         of/eC827mNwP8zqCeNAj2ypIUQ6DP9txP/DAFKBOq8TueHwcWEko0f4+H0vUutIgDmSu
         vGuA==
X-Gm-Message-State: ABy/qLb/eZwV/zjTY2IKYaWNoWAEMh8jJ/EysTznK3RdnTfpY0kczFD3
        8tGiVVePun3x/raoIrAVM924KDhF/bJzTxm6nvUk/g==
X-Google-Smtp-Source: APBJJlFOb4s90Dp23tihg0GBLYaT6KbaJU1ZWY/54YeFcSGLkmVWc1J7vMYdT7KOfZGpbIWxsV9ACDuKXIxwSpFDJ64=
X-Received: by 2002:a05:6402:457:b0:521:8bf7:bd32 with SMTP id
 p23-20020a056402045700b005218bf7bd32mr4736081edw.19.1689680885550; Tue, 18
 Jul 2023 04:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <87o7kbnle9.fsf@doe.com> <87jzuyobch.fsf@doe.com> <20230717213424.GB3842864@mit.edu>
In-Reply-To: <20230717213424.GB3842864@mit.edu>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 18 Jul 2023 17:17:52 +0530
Message-ID: <CA+G9fYt4dDCw+nLvUGcX-JHG6fvyA8qsu1Caqdog53DW8MO4Mw@mail.gmail.com>
Subject: Re: next: kernel BUG at fs/ext4/mballoc.c:4369!
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 18 Jul 2023 at 03:04, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Jul 17, 2023 at 08:04:54PM +0530, Ritesh Harjani wrote:
> >
> > These can basically trigger in extremely low memory space and only when
> > such ranges exist in the PA rbtree. Hence, I guess it is a little hard
> > to tigger race.
>
> Ritesh, thanks for looking into this!
>
> Naresh, how easy is it for you to trigger the BUG when using LTP?  I
> did two xfstests runs using "gce-xfstests -c ext2/default -g auto",
> one on the ext4 dev branch, and one on linux-next 20230717, and I
> wasn't able to trigger the BUG.
>
> If you can trivially trigger it using LTP (perhaps with a low memory
> configuration in your test setup?), that would be useful to know.

In our setup it is not easy to reproduce with the same device and
same build on x86_4 and arm64 juno-r2 connected with SSD drive
and running LTP fs testing.

LTP fs_fill is triggering several ENOSPC before getting this reported
kernel BUG at fs/ext4/mballoc.c:4369!

The reported issues are not noticed on latest Linux next tags.

- Naresh

>
> Cheers,
>
>                                         - Ted
