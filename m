Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE6142FB36
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Oct 2021 20:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241382AbhJOSp2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Oct 2021 14:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241405AbhJOSp1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Oct 2021 14:45:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761B1C061570
        for <linux-ext4@vger.kernel.org>; Fri, 15 Oct 2021 11:43:20 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i20so40744536edj.10
        for <linux-ext4@vger.kernel.org>; Fri, 15 Oct 2021 11:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deitcher-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UpFIIBbz72kAqXH7DYzSlH4vOBfR7gIZ/0dV0rUQMFI=;
        b=67zrQN+QHuk/D0OacGx0PCyp4Fv2pBRzCAoz6ujSc8v/PX239+XLWa8Az6xFqHqIQP
         zytRie1HMTKU/QzG+BgiprxzPDs/fnikE8Vtxr4LBc7B7KUnJQ/7MKYvO3NLFZHEIIlF
         0BQQfquVKtS1YEc5S0Zrl2Knw25TpKt7CRVqkWL7+AMTh96hTFJdJ5oinLLa8pazeKsl
         8FzjXrI0sM+o0OETAGLVU8gXm8TTIZgJq1qvnBKYqwCYHgSK1naet5bqHle/Cdj9nD7Y
         SCDz/ILv8Z32bbFrkRWBTXi9hT/zg60zGdiqbdJl/QL0wfB96X0y2spYxOkrPS2GvMrw
         LywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UpFIIBbz72kAqXH7DYzSlH4vOBfR7gIZ/0dV0rUQMFI=;
        b=M/W2317OiCRae/YxoOjWbK0MCi9Er7hRhbdyQBX9otCghtGWMNzs61nBcomqjMke9M
         ZhdH1FrLKoMr62tKKvRp+z0rxMbOgSQNq8iHQ+ZsQmBfWqNUyvqRuPMqRgQUncZ4VCbC
         S9qDA/5vpqRlpVWC+Kkzdj52tdFhHlHfkx5GfRvwPQUVsViYqiLc0KXHqxqFjyFFbsLu
         QVtkhQmdpdDiFR1/XiUH4eCoeShrkz9cGQdz2bzIMoYTcP3FgkaPbq3NklcU3edHxOJZ
         gyK0lCGiwCyJYYVCi8z3uHpjgAPsJysw859c82mJrAigVRpO42Nk1I8mEu67RQQBJEo1
         ua3Q==
X-Gm-Message-State: AOAM5326NMSRkQu2s3jiptrk4EVG+hyfeGsu0vv3Rx1/PVEzJxi4KEjU
        hc7pf1X9r/xpq125YJM54gtMGlGH+2Jq3gqa0HZXRyI4QgW/gA==
X-Google-Smtp-Source: ABdhPJyEDHskhpt+VfIFD5yX2YbUDNS8Vh4Fnc9xdUgZx5JodIITfFQU5Tqrf3+YzSx3Sd0sb0fC4X6oHMwRiwgOv+U=
X-Received: by 2002:a17:906:b1d5:: with SMTP id bv21mr8987694ejb.346.1634323398918;
 Fri, 15 Oct 2021 11:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAF1vpkgPAy3FJ9mN22OVQ41jQAYoRdoCdqzYwRYYPXD4uucdpg@mail.gmail.com>
 <3A493D20-568A-4D63-A575-5DEEBFAAF41A@dilger.ca> <CAF1vpkigHMdKphnNjDm7=rR6TTxViHGGHi3bb64rsHG7KbqYzQ@mail.gmail.com>
 <CAF1vpkhwSOfGfErUUrp0YU5hSt58TtykTECiJXTcgqDtG0WVVg@mail.gmail.com>
 <YWSck57bsX/LqAKr@mit.edu> <CAF1vpkiKx3jArgjNBrid9-MSHBweGsFL0zu0UgDX_dq_hrkUgw@mail.gmail.com>
 <YWXGRgfxJZMe9iut@mit.edu>
In-Reply-To: <YWXGRgfxJZMe9iut@mit.edu>
From:   Avi Deitcher <avi@deitcher.net>
Date:   Fri, 15 Oct 2021 11:43:07 -0700
Message-ID: <CAF1vpkggQpYrg7Z2VVK69pPBo0rSjDUsm8nB8dyES27cmDEf2g@mail.gmail.com>
Subject: Re: algorithm for half-md4 used in htree directories
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I am absolutely stumped. I tried the seed as four u32 as is on disk
(i.e. big-endian); four u32 little-endian; one long little-endian
array of bytes (I have no idea why that would make sense, but worth
trying); zeroed out so it gets the default. No one gives a consistent
solution.

As far as I can tell: hash tells you which intermediate block to look
in, minor hash tells you which leaf block to look in, and then you
scan. So it is pretty easy to see in what range the minor and major
hash should be, but no luck.

I put up a gist with debugfs and source and output.
https://gist.github.com/deitch/53b01a90635449e7674babfe7e7dd002

Anyone who feels like a look-see, I would much appreciate it (and if
they figure it out, owe a beer if ever in the same city).

On Tue, Oct 12, 2021 at 10:30 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Oct 11, 2021 at 07:58:00PM -0700, Avi Deitcher wrote:
> > Aha. I missed that the seed is injected into buf before passing it
> > into half_md4_transform. I was looking at it as just the empty buffer
> > before the first iteration of the loop (or, in my case, since I was
> > testing with a 6 char filename, the only iteration).
> >
> > I will repeat my experiment with that and see if I can tease it out.
>
> BTW, if you are looking for a userspace implementation of the hash,
> it's available in libext2fs in e2fsprogs.
>
> Cheers,
>
>                                         - Ted



-- 
Avi Deitcher
avi@deitcher.net
Follow me http://twitter.com/avideitcher
Read me http://blog.atomicinc.com
