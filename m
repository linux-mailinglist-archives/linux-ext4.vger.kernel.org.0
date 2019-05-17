Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3DC21BE4
	for <lists+linux-ext4@lfdr.de>; Fri, 17 May 2019 18:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfEQQo2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 May 2019 12:44:28 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:43005 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfEQQo2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 May 2019 12:44:28 -0400
Received: by mail-vs1-f48.google.com with SMTP id z11so5013414vsq.9;
        Fri, 17 May 2019 09:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=pAX0vxlKsS3At2+0IC66aeGJoN9UY9xs1pNI3LjZrqU=;
        b=hcWTPyTcC0C28QeJemeLJj2Un7sEQ8CRp3HjlV5AWcz9gGel/K4fLv69034j33+25n
         QKZZBthie2sqBsDnCkzR8isUK8aF1zyC9HEw1JCid0gxBZn7CSjav3AID2TvxzWKOmiA
         SnVjgCaowvx2C0txGQm6ko5xCVujHJw0OhcwVzV5hur8BxQF9B8aoHJ0jdVb6E//RRWA
         Zp/nh0JaSxVv4ZIGB31Vbp9CTVovyrV/sT1EWzHZ2fN3ZjmO69pCwxHUvcC8uPaSa48q
         0FrwrY7PVwNybk7u0VCX6WrT11ZVYtZxrB4j1t5aBB12PY7OEqdyxaVfl7euXf3a6s+O
         489Q==
X-Gm-Message-State: APjAAAV4XJ/gYorllwJOaVGhgo0HxLTETeLIsd2TE3uIQXIY+WPosaQZ
        ZSfkxOkc2luUbUoHZKA4Od0zZLIsW9ZoY5NcpIM=
X-Google-Smtp-Source: APXvYqzNvYYwImqNPDzJRP6G5nQbLNbvpqIfuJoTaq24rp/l5QGdM5wjmIZ8adSX7LTB5Q0ERt9LVWqdnm4R6IzrK0E=
X-Received: by 2002:a67:770f:: with SMTP id s15mr18946307vsc.11.1558111466813;
 Fri, 17 May 2019 09:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <48BA4A6E-5E2A-478E-A96E-A31FA959964C@internode.on.net>
 <CAFLxGvwnKKHOnM2w8i9hn7LTVYKh5PQP2zYMBmma2k9z7HBpzw@mail.gmail.com>
 <20190511220659.GB8507@mit.edu> <09D87554-6795-4AEA-B8D0-FEBCB45673A9@internode.on.net>
 <850EDDE2-5B82-4354-AF1C-A2D0B8571093@internode.on.net> <17C30FA3-1AB3-4DAD-9B86-9FA9088F11C9@internode.on.net>
 <20190515045717.GB5394@mit.edu>
In-Reply-To: <20190515045717.GB5394@mit.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 17 May 2019 18:44:13 +0200
Message-ID: <CAMuHMdV=63MwLdOB2kcX0=23itHg+_q22wXCycTvH3yn4zsfWw@mail.gmail.com>
Subject: Re: ext3/ext4 filesystem corruption under post 5.1.0 kernels
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Arthur Marsh <arthur.marsh@internode.on.net>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

On Wed, May 15, 2019 at 6:57 AM Theodore Ts'o <tytso@mit.edu> wrote:
> Ah, I think I see the problem.  Sorry, this one was my fault.  Does
> this fix things for you?

Thanks!
Sorry for missing this patch in the thread before.

> From 0c72924ef346d54e8627440e6d71257aa5b56105 Mon Sep 17 00:00:00 2001
> From: Theodore Ts'o <tytso@mit.edu>
> Date: Wed, 15 May 2019 00:51:19 -0400
> Subject: [PATCH] ext4: fix block validity checks for journal inodes using indirect blocks
>
> Commit 345c0dbf3a30 ("ext4: protect journal inode's blocks using
> block_validity") failed to add an exception for the journal inode in
> ext4_check_blockref(), which is the function used by ext4_get_branch()
> for indirect blocks.  This caused attempts to read from the ext3-style
> journals to fail with:
>
> [  848.968550] EXT4-fs error (device sdb7): ext4_get_branch:171: inode #8: block 30343695: comm jbd2/sdb7-8: invalid block
>
> Fix this by adding the missing exception check.
>
> Fixes: 345c0dbf3a30 ("ext4: protect journal inode's blocks using block_validity")
> Reported-by: Arthur Marsh <arthur.marsh@internode.on.net>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Intermittent issue no more seen in 10 test boots, so
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
