Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E67322318
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Feb 2021 01:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhBWAYN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Feb 2021 19:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhBWAYM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Feb 2021 19:24:12 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA717C061786
        for <linux-ext4@vger.kernel.org>; Mon, 22 Feb 2021 16:23:32 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id f6so15277695iop.11
        for <linux-ext4@vger.kernel.org>; Mon, 22 Feb 2021 16:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSYZaJXIS6C1ICWmDRD2w5Tj1QqQKhWbKh2gJxndPhk=;
        b=ajmxv4fS6M6sj14txf7zaT5coPITkpoKwRIgXe473kZuObcls/OHDfGBn1Zihh2Eu/
         JL8+BksJ8U7tz/nbwyj/NK/FJT7PRIywEFQ/nTqSK2J1+QGfUW7pvHjGADl7yfGif/PQ
         JsKO2L5Izy22clabS/Gi+5t/LgcNevs3sDMoXu2D0JGepUdh5NXI540WWhd0W/njG60W
         9HLFkSQrO1wKU1qMm9LPMVsFmXkZd4sBQ34vbJB/KkHM00eBx7bzK0UaGrpGDaX6pXUs
         mOFGdDXRMwE52Y754dfNs3cD686Djdv6EoODN/fCWYPTWB3UKdMjC9vDvDGmYEVOKtLK
         S8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSYZaJXIS6C1ICWmDRD2w5Tj1QqQKhWbKh2gJxndPhk=;
        b=O39zWmd1eTwvFUO7kEAx12et0gMlYY4trdm3KDbpYF/aAzVSoMnEqP68Po9H2sFwj3
         0T3hkslk5ZpDVlPwI2HZ0AyVtQp+i3r/GXcZoRDGyG1fE/Jsu9nsuSgLPhdjrJ1hfahH
         3qjdsdLJNAOktYPFEo8XslLdQWW0+up2M4eYdapfkC1yG3nPn3+8qUP14TUVKuzBGQCi
         WTuCSdrAbEIBqbhMjRpdRi8JctSYgHW+X5LVwZCyfndr3+ORmGT7YMqb8BCrEodVNObR
         NCs04ZHC28nWlVnynNYXAy1ojks0X61YU3EjxNx5AnE4wF5NK0kXbq88wgYJwvAJO5GP
         OroQ==
X-Gm-Message-State: AOAM5335mwUn6V80gCT2zVK8ICKV82i68bGqZWMF2mjrHGJ3xt+PoIlV
        2fSn9Ji9diQsEfFlQAsSmn+RbXF/MJCJN+4tPI/lXA==
X-Google-Smtp-Source: ABdhPJwhGfngyKx+KH1gapYhp//gieSYgnDoX6gnuQ/irJzk5wEu3895VGrImqqIbcMBtkWsLQpTgbyXNiKx+vlyL/8=
X-Received: by 2002:a02:3541:: with SMTP id y1mr24777666jae.66.1614039811998;
 Mon, 22 Feb 2021 16:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20210210013206.136227-1-dlatypov@google.com> <YCNF4yP1dB97zzwD@mit.edu>
In-Reply-To: <YCNF4yP1dB97zzwD@mit.edu>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 22 Feb 2021 16:23:20 -0800
Message-ID: <CAGS_qxrPEa8kUK+U_bw+isnVRVP_6RdxmyE+Az=G0EhgG45Xhg@mail.gmail.com>
Subject: Re: [PATCH] ext4: add .kunitconfig fragment to enable ext4-specific tests
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 9, 2021 at 6:33 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Feb 09, 2021 at 05:32:06PM -0800, Daniel Latypov wrote:
> >
> > After [2]:
> >   $ ./tools/testing/kunit.py run --kunitconfig=fs/ext4/.kunitconfig
>
> Any chance that in the future this might become:
>
> $ ./tools/testing/kunit.py run --kunitconfig=fs/ext4

For future reference, this patch would make ^ work.
https://lore.kernel.org/linux-kselftest/20210222225241.201145-1-dlatypov@google.com

(This time w/o the typo in the path to kunit.py :)

>
> Or better yet, syntactic sugar like:
>
> $ ./tools/testing/kunit.py test fs/ext4
>
> would be really nice.
>
>                                                 - Ted
