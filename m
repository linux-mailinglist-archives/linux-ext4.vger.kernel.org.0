Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBFC376897
	for <lists+linux-ext4@lfdr.de>; Fri,  7 May 2021 18:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbhEGQYK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 May 2021 12:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbhEGQYF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 May 2021 12:24:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B4FC061574
        for <linux-ext4@vger.kernel.org>; Fri,  7 May 2021 09:23:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id s20so8971611ejr.9
        for <linux-ext4@vger.kernel.org>; Fri, 07 May 2021 09:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AZG5LIGbxrcaihi/vkw91BcWm3f5d8BtDxqprZlEad8=;
        b=mkQ1VjFzpPCAsd69nbfzo/3UY5/OOvHv+NcxtkbJ6YQ+XC2tWJjU1/oVk7fdIv6Rz5
         7RoHuvDTqtkY2UPf65IP+C1eX8FnA1Vos75HgPgj7TvEcBJrL5qJiW+YwysMBdDhjBxV
         cpfBkUIVhjMYX+EjGdrkGJZviOqunU3U+k73jhcnObUBrphuKB7NCTk9gcGdVAQcX3A5
         VhPxjU/vDkOPVZVczvmSW4EzW62t3hs8xo8mhYC3yqTzace/PTzEbFspXkJCI9W43VTE
         nmjRaap6X+L7S96452Hx/2KQ4ynezBg/V1AwPfmbjfeMtwCSJl68IlS4GlaWMebmZVFD
         UNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AZG5LIGbxrcaihi/vkw91BcWm3f5d8BtDxqprZlEad8=;
        b=GMkI4oHF1rQPn+wNx2yvdGJUtnivEduiXD8FiE+iX1/+/5MDUXIOGAbXAc3Oo7ghWD
         bc9plf4fcB+o0pCBQoYzFWFggeDPmWN7v+SJI6h45yrQW6Jhrs1XsDWe4argtcGRQmx3
         7rwuoIObY+NkZq4fhJQDLINm/evG1iHQ5rxI8PhAKLx3KkN/e2RAroZizZUyahGn4EUk
         29UqM0WNScUy1zzIeECo1RvdigfrtiKE74kX7nMHfJxvqWGnPopV2XADHVdvBNRa4V/b
         ag9K0b4grbJfiATXwPJuPusExD9GJW/XtJ8BC6RegmxZnvzWZ2ayBpXajGyqExa5YS9H
         BGtg==
X-Gm-Message-State: AOAM5313bfsdRAMDzt/kQSSK2jZntHzwKhQO5IU60O/YX2gI55naynSD
        2SNjIL/Acntl92aiOkNzLKv2KJT3JV223Z4JdD0=
X-Google-Smtp-Source: ABdhPJzYCS74/4ehKRzb8RNChjVxjqzwH9JiMDqFHjq5G3/KX+ZUM4jeTjp4eAglz8Q2cjcEUlksUcewox4gqj5c6ZA=
X-Received: by 2002:a17:906:5584:: with SMTP id y4mr10847425ejp.120.1620404583062;
 Fri, 07 May 2021 09:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <YJFQ20rLK16rise2@mit.edu> <YJF6W7WHZBcVZexU@gmail.com>
 <CAD+ocby+01k9kx3-gEY_z+Ub9GFxi=AwxRS4Ax5-HUFDrVkT0w@mail.gmail.com>
 <YJGdDHLcYuRajhsb@gmail.com> <YJGmTNIHixCLiKok@mit.edu> <CAD+ocbwS9h4knUbhiXFUicvi-PwKSnPdF7hrZUhbg1MkzbDmrw@mail.gmail.com>
 <YJGyTjYKcEkx+fQq@gmail.com> <YJG4SrJ/ZEjv3Ha0@mit.edu> <YJG9CjVXKkha57RU@gmail.com>
 <YJTh9T3sgdFFE7fM@sol.localdomain> <YJVjJoI8sX531AL2@mit.edu>
In-Reply-To: <YJVjJoI8sX531AL2@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 7 May 2021 09:22:51 -0700
Message-ID: <CAD+ocbxtTP2Ow4JjXb5P9kZfrdbnQ27AWLFpwmR5RKLvJpnt+A@mail.gmail.com>
Subject: Re: [PATCH] e2fsck: fix portability problems caused by unaligned accesses
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Harshad Shirwadkar <harshads@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 7, 2021 at 8:56 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Thu, May 06, 2021 at 11:45:09PM -0700, Eric Biggers wrote:
> > Just to be clear (looking at the latest patches on the list which are copying
> > whole structs), by "the memcpy() approach does get optimized properly", I meant
> > that it gets optimized properly in implementations of get_unaligned_le16(),
> > get_unaligned_le32(), put_unaligned_le32(), etc., where a single word (or less
> > than a word) is loaded or stored.  I don't know how reliably the compilers will
> > optimize out the copy if you memcpy() a whole struct instead of a single word.
> >
> > Even if they don't optimize it out, I don't expect that it would be a
> > performance problem in this context, so it's probably still fine to solve the
> > problem.  But I just wanted to clarify what I meant here.
>
> For the most recent patch that sent out, we really needed to copy out
> the whole structure since we're then passing it to ext2fs library
> functions.  I agree that it's not likely going to be a performance
> problem, and at this point, I'm more concerned about code clarity and
> correctness.
>
> Especially since apparently the problems which Harshad's change and my
> most recent commit addressed were not picked up by UBSAN (either using
> gcc or clang), --- and IMHO they really should have.  So we can't
> count on UBSAN to find all possible alignment problems.
>
> Lesson learned, before I do future releases, I should do a build and
> "make check" on a armhf chroot running on a arm-64 machine, as well as
> on a sparc64 machine, since these seem to be the most sensitive to
> alignment issues.  And if I miss anything, fortunately Debian's
> autobuilders on a large cross-section of architectures will catch them
> since we run the regression test suite as part of the package build.
>
>                                         - Ted
>
> P.S.  Harshad, could you prepare patches to kernel files in ext4 and
> jbd2 to make similar alignment portability fixes?   Thanks!!

Sure, I'll take care of that, thanks!

- Harshad
