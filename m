Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D284042019A
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Oct 2021 14:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhJCMtD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Oct 2021 08:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhJCMtC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 Oct 2021 08:49:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933F1C0613EC
        for <linux-ext4@vger.kernel.org>; Sun,  3 Oct 2021 05:47:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id p11so453322edy.10
        for <linux-ext4@vger.kernel.org>; Sun, 03 Oct 2021 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deitcher-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=X3xTNBqrAPeWetQyX0mgGNU9IhIdQFU8X083g79QyIg=;
        b=gAOd7B9Xm6Y3wMNcIY0UE9JB8JKBFNZFTc8vvkVHyVKeFrMHGYERtLNQRAVbgT0tP4
         01t1wxbBis4uKuc3DP43CZ2TT52juGPu4VBQwZW3Twj/vTQCydqVHEOl9SRwn0Bezh3w
         2+K8raBnGaI1CnOFNp6swVVkFar/jbpsAS4V9Tw2fKpY7z36K6hZcizvgaMNH8HsTCHs
         oqnxECGS1T2KiTITKuCvSa2yUYNgqridvAX4TiYewTC4NxrcZ9Ys0RqCU2L+OaNW1H+F
         oKQQNJ5sBDMDr7zCsfWNzsWavfZnUg+DwEHvlqseXR2Gb/1Ne7qHywfpevsMjhw7mciY
         XZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=X3xTNBqrAPeWetQyX0mgGNU9IhIdQFU8X083g79QyIg=;
        b=Hd5rM/Zf0yC9KD57I/iWnuBv9M8hGwiCu2tu/VyCcV/5U62RQ0ZGIlY6dBfT4v3Ps9
         ZPzVthUkp1+T7ZtH2N0O6oyOtcSAvniXXA+poY4XrAtQ64fe8FAP9HVQVHuF9W0R1WVu
         fwxhws+5+qI7iXBDucJEW3QQCiX3dqqaDDseYIrFaX8grX7m4mTbI4f7RQvb4TT+ZMft
         8buiAoyDQJ3qd4jsFWJwSgM8//i5KtcD5xhxaqseHxV2oJR8sTopYLrsNQ+n4YONh55u
         ildMoK0+mV4IzSA/cf5XESi/GiKPmVDMSTuIPEoRNHropVrDNqd/nO08lPOJa4OPCN7d
         5aLA==
X-Gm-Message-State: AOAM533tbjEv3EAEHM3btTVef/wxdzt//eGLp9JGSDEkSMMhCIZLUviK
        ncB62CyYqNHJ7U8lua99T2EvLINn+YZE7VeUVV8kFWVUoaEuVg==
X-Google-Smtp-Source: ABdhPJzdIImigDgqE2drzsn9aYTIiuSIn2puxi5uN+ltiADPyTcqsDNvUKjGL1dDxKvCyOudv9BLCkD5KwJJktOQ5rI=
X-Received: by 2002:a17:906:b1d5:: with SMTP id bv21mr10388075ejb.346.1633265232688;
 Sun, 03 Oct 2021 05:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAF1vpkgE3XopWRqzFqdyCWg0hQB9FtEhbWmz1t=HZPE+WNEQ3A@mail.gmail.com>
In-Reply-To: <CAF1vpkgE3XopWRqzFqdyCWg0hQB9FtEhbWmz1t=HZPE+WNEQ3A@mail.gmail.com>
From:   Avi Deitcher <avi@deitcher.net>
Date:   Sun, 3 Oct 2021 15:47:01 +0300
Message-ID: <CAF1vpkgPAy3FJ9mN22OVQ41jQAYoRdoCdqzYwRYYPXD4uucdpg@mail.gmail.com>
Subject: Re: algorithm for half-md4 used in htree directories
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I can narrow down the question further. In my live sample, one of the
entries in the tree is for a directory named "dir155".

If I run "dx_hash dir155", I get:

# debugfs -R "dx_hash dir155" /var/lib/file.img
debugfs 1.46.2 (28-Feb-2021)
Hash of dir155 is 0x16279534 (minor 0x0)

If I look in the tree with "htree_dump", I get:

# debugfs -R "htree_dump /testdir" /var/lib/file.img
debugfs 1.46.2 (28-Feb-2021)
....
Entry #0: Hash 0x00000000, block 1
Reading directory block 1, phys 6459
168 0x00d11d98-b9b6b16b (16) dir155   332 0x009edafe-77de7d72 (16) dir319

That hash for dir155 does not match what dx_hash gave. If I try to
take the code from fs/ext4/hash.c and build a small program to
calculate the hash, I get:

$ ./md4 dir155
MD4: d90278a1 25182ac7 a02e56be c3f30f04
hash: 0x25182ac6
minor: 0xa02e56be

Clearly that isn't what is in the tree. What basic am I missing?

On Fri, Oct 1, 2021 at 2:49 PM Avi Deitcher <avi@deitcher.net> wrote:
>
> Hi,
>
> I have been trying to understand the algorithm used for the "half-md4"
> in htree-structured directories. Going through the code (and trying
> not to get into reverse engineering), it looks like it is part of md4
> but not entirely? Yet any subset I take doesn't quite line up with
> what I see in an actual sample.
>
> What is the algorithm it is using to turn an entry of, e.g., "file125"
> into the appropriate hash. I did run a live sample, and try to get
> some form of correlation between the actual md4 hash (16 bytes) of the
> above to the actual entry (4 bytes) shown by debugfs, without much
> luck.
>
> What basic thing am I missing?
>
> Separately, how does the seed play into it?
>
> Thanks
> Avi



-- 
Avi Deitcher
avi@deitcher.net
Follow me http://twitter.com/avideitcher
Read me http://blog.atomicinc.com
