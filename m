Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E5C271899
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Sep 2020 01:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgITXcW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 20 Sep 2020 19:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgITXcW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 20 Sep 2020 19:32:22 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F68C0613CE
        for <linux-ext4@vger.kernel.org>; Sun, 20 Sep 2020 16:32:18 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 77so4694622lfj.0
        for <linux-ext4@vger.kernel.org>; Sun, 20 Sep 2020 16:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O0Lvva2pzOg4MSfmxLtYlV2Z214VIUziFRqOpoCgUH4=;
        b=f4pMgd66GsDdOO7iIEGSyyUO6cS0q2FQjQQIQvpzvXTLzz8k/inXhBsqi+XAeEToIO
         9fbqyyIjBDHcaf0vOOU1daflBn2NpiXVuUVhIqDNput1NoSEysL+SZHxe2Aq+SmLknSu
         Pa3K/N298EZXdRLWyWO4uBBSCh5yPKtWDNld4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O0Lvva2pzOg4MSfmxLtYlV2Z214VIUziFRqOpoCgUH4=;
        b=SBPGuvEues3H+yDoeMRvF5twDwxWYQyCuk/++DJSDZd7c5zEUoCe030awtVPqxnCM6
         M4ahL/da+1p25ypY8+hDWXP/JCJx2oG0AGitdPSEgSk0AlN4Ns8N1AOWSF6E6B46zOkn
         6DZMffNUF4+13Vgq/5XmVft1fhJtE113DnXVcFalwzdLba8+rCCr+eu4a5mBOKO9mMoN
         kF5RUI+AhVlJzPp0KFypco3m7OdNL9rhLaOdSqq/fB0Ct0NBuAsfaHDYAc2+we1o0lwr
         R5A1JIV5LpuletURfjmY60YUQbpVhLdEeT38/Xj+rzbpKN6jDGblNJVreCTOikRXerQp
         rtfQ==
X-Gm-Message-State: AOAM530V4M/aQEYfPQgDZNthKFHWoOtyCPwKvEZxj4P27toYfSB6y+Mq
        LLxhrgqNHJa7hNo1Js892YpynqSsebUNEQ==
X-Google-Smtp-Source: ABdhPJxPaVNIkutt2Ql2w4GKeNA5eGHdwdaXgbsyPORoCuthFcsRkZHJaQtfqh97uTRCuBGRQ1jjIw==
X-Received: by 2002:a19:404:: with SMTP id 4mr14064661lfe.343.1600644736062;
        Sun, 20 Sep 2020 16:32:16 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id f6sm2092776lfq.211.2020.09.20.16.32.14
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 16:32:14 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id y11so12019348lfl.5
        for <linux-ext4@vger.kernel.org>; Sun, 20 Sep 2020 16:32:14 -0700 (PDT)
X-Received: by 2002:ac2:4a6a:: with SMTP id q10mr13257674lfp.534.1600644734040;
 Sun, 20 Sep 2020 16:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200912143704.GB6583@casper.infradead.org> <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com>
 <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com>
 <20200917182314.GU5449@casper.infradead.org> <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
 <20200917185049.GV5449@casper.infradead.org> <CAHk-=wj6Ha=cNU4kL3z661CV+c2x2=DKzPrfH=XujMa378NhWQ@mail.gmail.com>
 <20200917192707.GW5449@casper.infradead.org> <CAHk-=wjp+KiZE2EM=f8Z1J_wmZSoq0MVZTJi=bMSXmfZ7Gx76w@mail.gmail.com>
 <20200920232303.GW12096@dread.disaster.area>
In-Reply-To: <20200920232303.GW12096@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Sep 2020 16:31:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgufDZzm7U38eG4EPvr7ctSFJBhKZpu51wYbgUbmBeECg@mail.gmail.com>
Message-ID: <CAHk-=wgufDZzm7U38eG4EPvr7ctSFJBhKZpu51wYbgUbmBeECg@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 20, 2020 at 4:23 PM Dave Chinner <david@fromorbit.com> wrote:
>
> FWIW, if the fs layer is already providing this level of IO
> exclusion w.r.t. address space access, does it need to be replicated
> at the address space level?

Honestly, I'd rather do it the other way, and go "if the vfs layer
were to provide the IO exclusion, maybe the filesystems can drop it?

Because we end up having something like 60 different filesystems. It's
*really* hard to know that "Yeah, this filesystem does it right".

And if we do end up doing it at both levels, and end up having some of
the locking duplicated, that's still better than "sometimes we don't
do it at all", and have odd problems on the less usual (and often less
well maintained) filesystems..

              Linus
