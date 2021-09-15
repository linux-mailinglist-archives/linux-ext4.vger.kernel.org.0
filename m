Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5786C40CCA2
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Sep 2021 20:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhIOSgr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Sep 2021 14:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhIOSgp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Sep 2021 14:36:45 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953B6C061575
        for <linux-ext4@vger.kernel.org>; Wed, 15 Sep 2021 11:35:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f21so2191406plb.4
        for <linux-ext4@vger.kernel.org>; Wed, 15 Sep 2021 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vn83ovDA+ACJz1QlomW2E1AWOsVVrVsXx6NcUhYq+dw=;
        b=1FQABg5BIvn3nSsg2QwsFD6SElQvcAPpCuLMMK5OD9pqFqn9Q7G43ka3QFJqEN0mP2
         2dTblz7dOX/f1+z1Gmz4e75Bp3Yz+j0jyVGJQO44mLKZLpJ0Op0YCjKpKJJxuc7mMGWh
         kBf/xlTHtrzYKkbG32LC6cCTcc94CrJ/0WMV/z6wbw8ffkmiZoh+A4zADFvcRiyDionM
         p33DjE/LyynE2UusGWiYYe0lau3j67a+/Zm7YJ4LiNUF786y8P9lzhBhkmJ8r6q4YuHW
         F+rRlxxV2VOYF+bW8OI73hqBPoyqbDRlwRDhC73uh43yNANJFnkNF8MiCQonKn2h2Xdl
         jNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vn83ovDA+ACJz1QlomW2E1AWOsVVrVsXx6NcUhYq+dw=;
        b=HuOrME5wA59VgyLX3YlwTGMHXcb6lp5qV+HNzZH5tV2B5jyLy2OpflwWKxsiJnDVim
         Dv7v38mY9yC5XQk4LrjbKzBGK2EpCYsMjSGrnUaMOCsYuLhaXj1Cv2FrUyt71KK34PJY
         A3gTAEqcSKnjPHvUoz8GhhSpg7JVL7pvH2wwT4rJakXlDXnDpvnyhL/11WQxZfm745vf
         +uHwueXK0FA3z32H2RpS1CvA/WzhMgeBOmTZn4jDCLEmPeisulnJcqs8fsJXIrWf8g6E
         3tz7h3Colm1Z/uxFGqH+57x11ASxmuNL/gHQEE9rd2wrKV/fUZ1v2/RbxTi9b7OSJeSu
         ecLA==
X-Gm-Message-State: AOAM533PRM3WkYwIUACnyX7/r/9TbLslVShFuBFf5F3eAVALilZUZtuq
        5KejU1CUFrGEzbtbvhyFV6JRGLEltr6a7JFvleh5IA==
X-Google-Smtp-Source: ABdhPJyIaerrmn8GG33arPqdGs0R9hdo0b2GNtFI1fMb3uig9V6fA/ou3usvO15aPXWKaCWTMySYlEZ5K2BPm1X0bM8=
X-Received: by 2002:a17:902:bd8d:b0:13a:8c8:a2b2 with SMTP id
 q13-20020a170902bd8d00b0013a08c8a2b2mr906080pls.89.1631730922072; Wed, 15 Sep
 2021 11:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <1631726561-16358-1-git-send-email-sandeen@redhat.com>
In-Reply-To: <1631726561-16358-1-git-send-email-sandeen@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 15 Sep 2021 11:35:11 -0700
Message-ID: <CAPcyv4gZqnp6CPh71o621sQ5Q9LZEr3MhkFYftW9LpuuMtAPRA@mail.gmail.com>
Subject: Re: [PATCH 0/3 RFC] Remove DAX experimental warnings
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 15, 2021 at 10:23 AM Eric Sandeen <sandeen@redhat.com> wrote:
>
> For six years now, when mounting xfs, ext4, or ext2 with dax, the drivers
> have logged "DAX enabled. Warning: EXPERIMENTAL, use at your own risk."
>
> IIRC, dchinner added this to the original XFS patchset, and Dan Williams
> followed suit for ext4 and ext2.
>
> After brief conversations with some ext4 and xfs developers and maintainers,
> it seems that it may be time to consider removing this warning.
>
> For XFS, we had been holding out for reflink+dax capability, but proposals
> which had seemed promising now appear to be indefinitely stalled, and
> I think we might want to consider that dax-without-reflink is no longer
> EXPERIMENTAL, while dax-with-reflink is simply an unimplemented future
> feature.

I do regret my gap in engagement since the last review as I got
distracted by CXL, but I've recently gotten my act together and picked
up the review again to help get Ruan's patches over the goal line [1].
I am currently awaiting Ruan's response to latest review feedback
(looks like a new posting this morning). During that review Christoph
identified some cleanups that would help Ruan's series, and those are
now merged upstream [2]. The last remaining stumbling block (further
block-device entanglements with dax-devices) I noted here [2]. The
proposal is to consider eliding device-mapper dax-reflink support for
now and proceed with just xfs-on-/dev/pmem until Mike, Jens, and
Christoph can chime in on the future of dax on block devices.

As far as I can see we have line of sight to land xfs-dax-reflink
support for v5.16, does anyone see that differently at this point?

[1]: https://lore.kernel.org/linux-xfs/CAPcyv4h0p+zD5tsT8HDUpNq_ZDCqo249KsmPLX-U8ia146r2Tg@mail.gmail.com/
[2]: https://lore.kernel.org/linux-xfs/CAPcyv4ic+LDagR8uF18tO3cCb6t=YTZNkAOK=vnsnERqY6Ze_g@mail.gmail.com/
[3]: https://lore.kernel.org/nvdimm/CAPcyv4hvzS1c01BweBkgDsjg=VGnaUUKi7b6j+1X=Rqzzm961Q@mail.gmail.com/
