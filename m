Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E7F27189D
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Sep 2020 01:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgITXkm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 20 Sep 2020 19:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgITXkl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 20 Sep 2020 19:40:41 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C8FC061755
        for <linux-ext4@vger.kernel.org>; Sun, 20 Sep 2020 16:40:41 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d15so12007471lfq.11
        for <linux-ext4@vger.kernel.org>; Sun, 20 Sep 2020 16:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bDYTO6ZHAocBqDq8dENc7+9/1NYi0FO0+BjnujPaGI8=;
        b=JhDrBz4VpfnwLwexhSfCra/1ljR+0DDuhhSmlK485+9M4Na6YRzV375YZRt8ot7FoR
         txVEzV4FjQhUG1H2jkoLuvnO/1KJqe+mlHoMYZtxOQIBTrhesN0I421m31sdB07MvhLV
         GRmW/3mZz0d3TLrvySNRdpKtqcWatAyZd4SpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bDYTO6ZHAocBqDq8dENc7+9/1NYi0FO0+BjnujPaGI8=;
        b=ctQmQ2jd1PD3RbvfqR38XtcUq61IMNxCISVb5fhywvayidUE/IRbSd/K4Qqsrw2SKK
         IejX5jSz2p1SdQ2mIUsB+wlzM8GBRCUnR1fL/pkFV9v9OZcDpzKq9OC54Bc5IVy+2qcc
         FNI1YOsMwb9dOPmJh82muCtcZhAgQ/fOCvfCAachFesrSdIwxPLDxIPOETvK0jfgn78B
         s9AFvr/MP89G7tkkAUn0ObZFk2OqIGkjXx+k7VrKh0gnWqZgNmAozFGzSyCP+rFlm4XV
         Ax/IEoQWIYQ4ECU7kC/YPHUusjrCantIXQgKyF+GiIlB5b6CUk0HwCZ5vCt4Io79GiBE
         uPxA==
X-Gm-Message-State: AOAM531fWyXOCv98q0rQDgR8UbsXBmokyLOUBkJZ5BMhjN1Q8D18E+ed
        puVW64k2PXZ3LSF8I1ze/ZVZGpKyCD/bPA==
X-Google-Smtp-Source: ABdhPJzpr0LDRmucFrf+r2v9Gkei5GwHyDdLxTyLXmI/jI3U5sTfHhH91lRDBHe95i2jgLgKL9T+Tw==
X-Received: by 2002:a19:8a55:: with SMTP id m82mr2888215lfd.393.1600645239485;
        Sun, 20 Sep 2020 16:40:39 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id c198sm2062234lfd.228.2020.09.20.16.40.37
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 16:40:38 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id w11so12053017lfn.2
        for <linux-ext4@vger.kernel.org>; Sun, 20 Sep 2020 16:40:37 -0700 (PDT)
X-Received: by 2002:ac2:4ec7:: with SMTP id p7mr12864272lfr.352.1600645237669;
 Sun, 20 Sep 2020 16:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200912143704.GB6583@casper.infradead.org> <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com>
 <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com>
 <20200917182314.GU5449@casper.infradead.org> <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
 <20200917185049.GV5449@casper.infradead.org> <CAHk-=wj6Ha=cNU4kL3z661CV+c2x2=DKzPrfH=XujMa378NhWQ@mail.gmail.com>
 <20200917192707.GW5449@casper.infradead.org> <CAHk-=wjp+KiZE2EM=f8Z1J_wmZSoq0MVZTJi=bMSXmfZ7Gx76w@mail.gmail.com>
 <20200920232303.GW12096@dread.disaster.area> <CAHk-=wgufDZzm7U38eG4EPvr7ctSFJBhKZpu51wYbgUbmBeECg@mail.gmail.com>
In-Reply-To: <CAHk-=wgufDZzm7U38eG4EPvr7ctSFJBhKZpu51wYbgUbmBeECg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Sep 2020 16:40:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKR51JXc3LQoZ2qpJSJ9qKx7jDes9yRQgxWbddG0hPLw@mail.gmail.com>
Message-ID: <CAHk-=whKR51JXc3LQoZ2qpJSJ9qKx7jDes9yRQgxWbddG0hPLw@mail.gmail.com>
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

On Sun, Sep 20, 2020 at 4:31 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And if we do end up doing it at both levels, and end up having some of
> the locking duplicated, that's still better than "sometimes we don't
> do it at all", and have odd problems on the less usual (and often less
> well maintained) filesystems..

Doing locking at a higher level also often allows for much more easily
changing and improving semantics.

For example, the only reason we have absolutely the best pathname
lookup in the industry (by a couple of orders of magnitude) is that
it's done by the VFS layer and the dentry caching has been worked on
for decades to tune it and do all the lockless lookups.

That would simply not have been possible to do at a filesystem level.
A filesystem might have some complex and cumbersom code to do multiple
sequential lookups as long as they stay inside that filesystem, but it
would be ugly and it would be strictly worse than what the VFS layer
can and does do.

That is a fairly extreme example of course - and pathname resolution
really is somewhat odd - but I do think there are advantages to having
locking and access rules that are centralized across filesystems.

               Linus
