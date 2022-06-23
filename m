Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FF1558AFD
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jun 2022 23:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiFWVzl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Jun 2022 17:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiFWVzi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Jun 2022 17:55:38 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F6A6271B
        for <linux-ext4@vger.kernel.org>; Thu, 23 Jun 2022 14:55:36 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o16-20020a05600c379000b003a02eaea815so1587783wmr.0
        for <linux-ext4@vger.kernel.org>; Thu, 23 Jun 2022 14:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ihKyajXPwo31m8s/3QROb3WqvEJPKtjwbf0jerjz3Sw=;
        b=WPcW1rzW71o/OduvCM4MtZf5PJGdg60CJ3z/vKjf98theNYbcKVC2v/Yc0HYZGTIER
         3MLlJKwurOOxnVvhvbg6CvS2SokL4n88W8hEJ72R3IggqQNf15TCujLJrYHz7V/Cyuyd
         nTRw8bCpnT4X9G1Cv61VqkwYn1GuSjxfzHc2iCBD55J7txPyMSE+jp2nhXncN5rcKMjb
         iwT8E6SbCMsBOCZHALs9J/7Jyj50pRFsZlZChQKk+xzj2NVh8PTEJeT2hHg3zwqUHDdC
         p2zrHNbtCec5hk9bPZmkP9L7tb2qLW/8vSv5BsjcQ9mc/o1ruZw7ImetpF56Ky7KexMC
         YQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihKyajXPwo31m8s/3QROb3WqvEJPKtjwbf0jerjz3Sw=;
        b=Qs2iZtY5R+e48BW8fy30+lTg1moEPlqGp0D+HqtAOC676ZlddW66g3IoFoPXPxSOKg
         SucP5d6Zh36MQ95rjAV3zHAzar1cpSy3MiOfWTw4xtjZkrarVLGKkXoUfoucv327kTBl
         Cgbi++Dy5HFChCCMQJ7wFN2n+0yzRX0M2ZhBDMnPBxFRjirRt0MjoQYA7pwbN4sxW2KK
         vnaFnHaSWXsCY1XEDx8l7Y6mpcI6WdT6GDNgmcUvbfaE+NJPXy+1BmoAcyTzWj9Z4wHN
         Bug/Bg4cYUxTKIh1ZP8NpKrhZEbQLG01IQh8c1Jem8P2gUPI9IZnxwz+n0C0C/FZC/Ee
         q3Lw==
X-Gm-Message-State: AJIora8q3jZN08JvzFw9iwEFZq0wspQe6pZSkolGSTpsWWODegNbfy17
        AN8NJWVARZzQOWeyX8/fQiuTh4lS04OU+FG/aELzvvEB
X-Google-Smtp-Source: AGRyM1vrkoDSIQgyMBMNWXM5AaafrSgLlEeLmEW7bjzXHKpm1+LTDzZZrUFwK1pJX4AvE6596YwXz18oUv6tcdg+07s=
X-Received: by 2002:a1c:27c6:0:b0:39c:34a5:9f88 with SMTP id
 n189-20020a1c27c6000000b0039c34a59f88mr104515wmn.94.1656021334802; Thu, 23
 Jun 2022 14:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAGQ4T_Jne-bxdP9rMNBzqXw16a4kD4FM=F5VuGgUbczj5WgCLA@mail.gmail.com>
 <Yqz8a0ggTjIU3h7T@mit.edu> <CAGQ4T_J-43q5xszJK8yDTUt14NGjjQACK4Z1RST-ZQkju3xSzQ@mail.gmail.com>
 <117682F9-5CEF-44F2-935E-E048C8A9D75D@dilger.ca> <CAGQ4T_LM9kYSHNWW+wJdXUzq7Ymf1+RGmot1Rqz9fChZBeRcAA@mail.gmail.com>
 <YrTCbPK94Ejh4ei3@mit.edu>
In-Reply-To: <YrTCbPK94Ejh4ei3@mit.edu>
From:   Santosh S <santosh.letterz@gmail.com>
Date:   Thu, 23 Jun 2022 17:55:20 -0400
Message-ID: <CAGQ4T_LU=aZ9og4E6RQgMCTC_RRGKpZzDQCSXjRBUsc9Nz5OkA@mail.gmail.com>
Subject: Re: Overwrite faster than fallocate
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 23, 2022 at 3:43 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Jun 23, 2022 at 02:28:47PM -0400, Santosh S wrote:
> >
> > What kind of write will stop an uninitialized extent from splitting?
> > For example, I want to create a file, fallocate 512MB, and zero-fill
> > it. But I want the file system to only create 4 extents so they all
> > reside in the inode itself, and each extent represents the entire
> > 128MB (so no splitting).
>
> If you write into an unitialized extent, it *has* to be split, since
> we have to record what has been initialized, and what has not.  So for
> example:
>
> root@kvm-xfstests:/vdc# fallocate  -l 1M test-file
> root@kvm-xfstests:/vdc# filefrag -vs test-file
> Filesystem type is: ef53
> File size of test-file is 1048576 (256 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:        0..     255:      68864..     69119:    256:             last,unwritten,eof
> test-file: 1 extent found
> root@kvm-xfstests:/vdc# dd if=/dev/zero of=test-file bs=1k conv=notrunc bs=4k count=1 seek=10
> 1+0 records in
> 1+0 records out
> 4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000252186 s, 16.2 MB/s
> root@kvm-xfstests:/vdc# filefrag -vs test-file
> Filesystem type is: ef53
> File size of test-file is 1048576 (256 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:        0..       9:      68864..     68873:     10:             unwritten
>    1:       10..      10:      68874..     68874:      1:
>    2:       11..     255:      68875..     69119:    245:             last,unwritten,eof
> test-file: 1 extent found
>
> However, if you write to an adjacent block, the extent will get split
> --- and then we will merge it to the initialized block.  So for
> example, if we write to block 9:
>
> root@kvm-xfstests:/vdc# dd if=/dev/zero of=test-file bs=1k conv=notrunc bs=4k count=1 seek=9
> 1+0 records in
> 1+0 records out
> 4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000205357 s, 19.9 MB/s
> root@kvm-xfstests:/vdc# filefrag -vs test-file
> Filesystem type is: ef53
> File size of test-file is 1048576 (256 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:        0..       8:      68864..     68872:      9:             unwritten
>    1:        9..      10:      68873..     68874:      2:
>    2:       11..     255:      68875..     69119:    245:             last,unwritten,eof
> test-file: 1 extent found
>
> So if you eventually write all of the blocks, because of the split and
> the merging behavior, eventually the extent tree will be put into an efficient state:
>
> root@kvm-xfstests:/vdc# dd if=/dev/zero of=test-file bs=1k conv=notrunc bs=4k count=9 seek=0
>     ...
> root@kvm-xfstests:/vdc# filefrag -vs test-file
> Filesystem type is: ef53
> File size of test-file is 1048576 (256 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:        0..      10:      68864..     68874:     11:
>    1:       11..     255:      68875..     69119:    245:             last,unwritten,eof
> test-file: 1 extent found
> root@kvm-xfstests:/vdc# dd if=/dev/zero of=test-file bs=1k conv=notrunc bs=4k count=240 seek=11
>     ...
> root@kvm-xfstests:/vdc# filefrag -vs test-file
> Filesystem type is: ef53
> File size of test-file is 1048576 (256 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:        0..     250:      68864..     69114:    251:
>    1:      251..     255:      69115..     69119:      5:             last,unwritten,eof
> test-file: 1 extent found
> root@kvm-xfstests:/vdc# dd if=/dev/zero of=test-file bs=1k conv=notrunc bs=4k count=5 seek=251
>     ...
> root@kvm-xfstests:/vdc# filefrag -vs test-file
> Filesystem type is: ef53
> File size of test-file is 1048576 (256 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:        0..     255:      68864..     69119:    256:             last,eof
> test-file: 1 extent found
> root@kvm-xfstests:/vdc#
>
> Bottom-line, there isn't just splitting, but there is also merging
> going on.  So it's not really something that you need to worry about.
>
> Cheers,
>
>                                                 - Ted

Nice! Thank you.
