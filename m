Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AF733ED16
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Mar 2021 10:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhCQJdu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Mar 2021 05:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhCQJdZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Mar 2021 05:33:25 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576F8C06174A
        for <linux-ext4@vger.kernel.org>; Wed, 17 Mar 2021 02:33:25 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id g27so40250660iox.2
        for <linux-ext4@vger.kernel.org>; Wed, 17 Mar 2021 02:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YdE/GWjzdcfZ8Bavs6zrITWcjIlNUaZXMc+H9PL8C7Y=;
        b=sTE7JJ2GKSAIWnREJZtuiVgWD/jjs73c2OJIF3Y+FB8ybLLD5GIHvQi/SpmSI/XakK
         If8Bc5nOVIFD8KpeyHD70SRj0iwJ/WS9gPVuBYFxxpWJskGy6Y4QexSOGac3gnftk+HB
         b4nJ+MRiVhBz8DU/68C3EbL4wnVsqoeNRL9t/DCwK3D8OthvLFmyPaTaOGjdXESrgg1p
         1MjPrsoFNexC1cjiehkkJrbFF3oVtmuAyj9BtYOE+QCffJsnZTnVZi2wH9b+7XCOrzlr
         VXmheazW8Lx5ZQULgDbttd0eg3uC3uI1/LbuWM2nX4ZfKUVzgXw5nUQAfvPO41GPmq3W
         4+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YdE/GWjzdcfZ8Bavs6zrITWcjIlNUaZXMc+H9PL8C7Y=;
        b=FYWDgJ+mLopQ/G4dDBRSP3u6v3dYOAH/C8L/ty27wTfRW0uNS+sCiusdLG7s4jIKoc
         cxsuB2H/wk6+xMNEpePCmGW4haiU9XaCmixNF88BqZ/4Trr86s5dJxdBWMr6OqquIF3N
         qoonAoKkD6gGcLFgM3G3A1EnvFH9U1XD1cKV9w2AnML2jQAKSncuX3XhtFXFUNswoTDt
         xCZGA9Z86ma49GAo5++mASFiWD1mfsK4BQZm8Rq4oopPSCLR4YcnqlWEpAhfm6diGPVk
         vxliM8RuRBFsAOfa6QAQGiZyDHLJr+jNKikFF0Xq7xTm4EtvcExM754+3zjZVFi0mRh1
         t3yg==
X-Gm-Message-State: AOAM532MrGMm4gl4nYz2Y/UR3asJpdwzgrnVxqpmJa0+svQH5Hs+UB6Z
        7J46KOZk0AYLuZRMvI6gdP1k8o0UXMzMIbz/BFEv8nnQ7Tk=
X-Google-Smtp-Source: ABdhPJz78RSG4Nqc/dG/uUq9m0Y0yxnDZ07vrGsj8hg8LCWsq3KPxY4D6HSlA59+5DYGtfLAEGNsvlAu8/R8AbjVoK8=
X-Received: by 2002:a02:a796:: with SMTP id e22mr2095797jaj.93.1615973604858;
 Wed, 17 Mar 2021 02:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210316221921.1124955-1-harshadshirwadkar@gmail.com>
In-Reply-To: <20210316221921.1124955-1-harshadshirwadkar@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 17 Mar 2021 11:33:13 +0200
Message-ID: <CAOQ4uxiD8WGLeSftqL6dOfz_kNp+YSE7qfXYG34Pea4j8G7CxA@mail.gmail.com>
Subject: Re: [PATCH] ext4: add rename whiteout support for fast commit
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Ext4 <linux-ext4@vger.kernel.org>, Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 17, 2021 at 12:19 AM Harshad Shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> This patch adds rename whiteout support in fast commits. Note that the

My only problem with this change is the subject.
It sounds like rename whiteout was not possible and now support was added
and it is now possible. This is not the case.
The truth is that rename whiteout is supported but broken with fast commits.
So the subject should reflect that this is a FIX commit, i.e.:

"ext4: fix rename whiteout with fast commit"

And patch should have a Fixes: tag with the commit that added fast commit
support to rename.

Otherwise, patch has stray newline but the rest looks pretty straightforward
to me.

Thanks,
Amir.
