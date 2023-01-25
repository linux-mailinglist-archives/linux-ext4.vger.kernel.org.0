Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4728167AEE0
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Jan 2023 10:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbjAYJxI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Jan 2023 04:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbjAYJxH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Jan 2023 04:53:07 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5383A4C2A
        for <linux-ext4@vger.kernel.org>; Wed, 25 Jan 2023 01:52:34 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id p12so8546535ilq.10
        for <linux-ext4@vger.kernel.org>; Wed, 25 Jan 2023 01:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OuciH5zAUURnBDw16GG9WV+6Jm2kIAhFJoGWXvuLyzY=;
        b=A1AB+qgY+bNcqCoh6g/QPfcTbHSdfM703fBk6MwZVQpdjKXroZK1oH0ns7MrSkqpEh
         EOFNTevaPYrK/s2JxRXzjpxKJuFDLK0q2y5rZGlM4eYwU42FRyAmNuFKT7Bg1y72UQr6
         97toi8YHPu1hdYbPDOUE8UH3Qse8M8RNx9XwKsItw/AX5ZjEdGoF6VszDeJWjYB0aicF
         ydXIqaQhWbVJDKjQyaFJQGQ8Tb4O2relzLKrriy0p8DNZHpby7I/ajeseKccsiM2etXU
         gc06b1Ly5AKuKaPMG0ZIbCmyoYgFf9iOl8HavzkcQOMATVBkyu4NrQfUDAIvJdVcxVmJ
         W1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuciH5zAUURnBDw16GG9WV+6Jm2kIAhFJoGWXvuLyzY=;
        b=AAWSIz8KOjGh4TmAMRt9nZi51CUEdft/zqvTbTYRfss5DesHDutGZ/NyHNpZ8PnWji
         g2g2q6P+hxz8isnMNyOpK4RZfjNdtpV6ky9RekQeAuOpJRMeHeqTwWp4Ye0EVTrSbT1S
         9fh/yuz2XPcvCG/GWRm5MJRRux4SiMtlA9KNC5NCJwScvnyhsERbO02xumSXDD5Mc92u
         Yh7Q7t+z8PEvTlmoWZfjSLEX5HCMGZ1+HugW9dJbA1pLMzs8Z0j7om7rWZh8hiShi5qa
         EsaOJlKFCZ8ZFnUDrXI2mW/ssrrImrmdb770YpPPI5Z6soevZ9N4ipxtzHnGKcHU4Flc
         FNtA==
X-Gm-Message-State: AO0yUKUOfBdK9tHkqtcG7zmxVF5aTYaiTE1irBNKzKXtV9RmGcVlmzsI
        QzJTAIcfidfevj5HZUV7clZUv/PiPaeHbAdTkSgfnQ==
X-Google-Smtp-Source: AK7set/RqxBYpDySUQ4Hf1TOiGHp0yJPE0emZ8yXer/udU2W95b7BNk2ZoGFsf4v/GnYc+LqXkIFjxHDeLUfWqc82qo=
X-Received: by 2002:a05:6e02:b23:b0:310:9cb4:223d with SMTP id
 e3-20020a056e020b2300b003109cb4223dmr495004ilu.164.1674640351299; Wed, 25 Jan
 2023 01:52:31 -0800 (PST)
MIME-Version: 1.0
References: <20221121112134.407362-1-glider@google.com> <20221121112134.407362-4-glider@google.com>
 <CAG_fn=WDjw1MVYhEh7K4HOpGNBWsq6YuyG6Xx7XcP4Xpu+KhZg@mail.gmail.com> <20230124130401.eb5d453213d557cf3b7a8ed6@linux-foundation.org>
In-Reply-To: <20230124130401.eb5d453213d557cf3b7a8ed6@linux-foundation.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 25 Jan 2023 10:51:54 +0100
Message-ID: <CAG_fn=XgBL00Oo5v7se5ZyP+uBbFSOaed4KReZVgpg3n8Nu95g@mail.gmail.com>
Subject: Re: [PATCH 4/5] fs: hfs: initialize fsdata in hfs_file_truncate()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 24, 2023 at 10:04 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 24 Jan 2023 11:51:30 +0100 Alexander Potapenko <glider@google.com> wrote:
>
> > On Mon, Nov 21, 2022 at 12:21 PM Alexander Potapenko <glider@google.com> wrote:
> > >
> > > When aops->write_begin() does not initialize fsdata, KMSAN may report
> > > an error passing the latter to aops->write_end().
> > >
> > > Fix this by unconditionally initializing fsdata.
> > >
> > > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Alexander Potapenko <glider@google.com>
> >
> > Dear FS maintainers,
> >
> > HFS/HFSPLUS are orphaned, can someone take this patch to their tree?
> > Thanks in advance!
> > (same for "fs: hfsplus: initialize fsdata in hfsplus_file_truncate()":
> > https://lore.kernel.org/all/20221121112134.407362-5-glider@google.com/)
>
> I grabbed both.
>
> I removed the
>
>         Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>
> because that might provoke the backport bots to backport this fix
> across eight years worth of kernels.  Before KMSAN existed!

Right, makes sense.
