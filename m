Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6DD237AE4
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jun 2019 19:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfFFRVc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Jun 2019 13:21:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42518 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfFFRVc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Jun 2019 13:21:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so2784843lje.9
        for <linux-ext4@vger.kernel.org>; Thu, 06 Jun 2019 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fSh9JeAYZqEFU07GFlcm4g2RwNfVCw5VkJKLPgvFgpM=;
        b=GXSY8IkFrWa7J8B6PJEPqJ0gkrWF9aF2wuVJ0wQ40ziAUSXofomBUgMg2tSIClx+89
         +trdK2/MhDj4EjpP2yv3Xn8pX3rA48qk6bQhrjbIVV9fY3W5uHsxoW6S3hiV1u6bue1h
         +WQ8hOkagCs/4IfWuZtcPZAZi6BK/PN2CpG1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSh9JeAYZqEFU07GFlcm4g2RwNfVCw5VkJKLPgvFgpM=;
        b=bOACeuLd4HI2SYvCrahhhi1SXu5Mt0wJ4YfUdzyavFZrH5QhRPMYDJoPkpXb5n6UqU
         tLTjxW/YH+ttcszpWNY18D8Sxa9mVZp7lktKw3eRNgAJLdtTvM+YTYRZxqsxwR9XW77p
         BBUJ2zIdtXGZNBF943B4iksrWgdcHINR5VokUww3gTpWwl9o05jCAdxZc4wnPlxAcIiW
         Cz1SEI2U86oCh+b6zwHJoRjEnrl0Ji9+usKu6rDVUlthi28aksaoN07n2ERwF/EDpdzT
         DFEM1u0sUjSq5nWIzfCl0j8JuWEIcUM8345r2SpBd2x4Thai5SU7TLQPPf5fFhuJlwco
         ENdA==
X-Gm-Message-State: APjAAAVHIiKUQEOqv1GnwvqoVUqahbv6iKq/ljjG4ErnYpGK+ooOaBpt
        d0xxrYpCCwYtpWs/NJ/rz++1sHT0NZU=
X-Google-Smtp-Source: APXvYqz2ElXC9ahzdil4yaxz3mj98mLgZWoxgz6kJBqhPOmj6rIwru3o8Oz3+4j+xCdWmqcFak41Yg==
X-Received: by 2002:a2e:3013:: with SMTP id w19mr13068900ljw.73.1559841689566;
        Thu, 06 Jun 2019 10:21:29 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id u22sm499575ljd.18.2019.06.06.10.21.28
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 10:21:28 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id s21so2793352lji.8
        for <linux-ext4@vger.kernel.org>; Thu, 06 Jun 2019 10:21:28 -0700 (PDT)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr26100221ljj.147.1559841687851;
 Thu, 06 Jun 2019 10:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190606155205.2872-1-ebiggers@kernel.org>
In-Reply-To: <20190606155205.2872-1-ebiggers@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Jun 2019 10:21:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSzRzoro8ATO5xb6OFxN1A0fjUCQSAHfGuEPbEu+zWvA@mail.gmail.com>
Message-ID: <CAHk-=wgSzRzoro8ATO5xb6OFxN1A0fjUCQSAHfGuEPbEu+zWvA@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] fs-verity: read-only file-based authenticity protection
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 6, 2019 at 8:54 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> This is a redesigned version of the fs-verity patchset, implementing
> Ted's suggestion to build the Merkle tree in the kernel
> (https://lore.kernel.org/linux-fsdevel/20190207031101.GA7387@mit.edu/).
> This greatly simplifies the UAPI, since the verity metadata no longer
> needs to be transferred to the kernel.

Interfaces look sane to me. My only real concern is whether it would
make sense to make the FS_IOC_ENABLE_VERITY ioctl be something that
could be done incrementally, since the way it is done now it looks
like any random user could create a big file and then do the
FS_IOC_ENABLE_VERITY to make the kernel do a _very_ expensive
operation.

Yes, I see the

+               if (fatal_signal_pending(current))
+                       return -EINTR;
+               cond_resched();

in there, so it's not like it's some entirely unkillable thing, and
maybe we don't care as a result. But maybe the ioctl interface could
be fundamentally restartable?

If that was already considered and people just went "too complex", never mind.

               Linus
