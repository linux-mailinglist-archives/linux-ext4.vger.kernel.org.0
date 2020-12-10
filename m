Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2D02D5076
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 02:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgLJBqc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Dec 2020 20:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgLJBqU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Dec 2020 20:46:20 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF75C0613CF
        for <linux-ext4@vger.kernel.org>; Wed,  9 Dec 2020 17:45:39 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id n26so5047957eju.6
        for <linux-ext4@vger.kernel.org>; Wed, 09 Dec 2020 17:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UYcII4nYGfLid6qAU3KjLJ0t+oJSwd+xH731sJxKqVI=;
        b=l/caJaJWabtcieNVWLCExfhVji5TJ6FE73ZQzZmHdc9BqynMTwnzJyOmhBORwwTMYu
         W8t5Rf9P1aVA1M2v6C0KxYsw39s5//oNeoUdjR6M/g7HPvT/H8lNl4ygvqgBojAIRpfV
         1QosQ27Esht8qhq0u+NMZ2Jx4u9ZPW8EQjlbwuFUhK/FbDgN8Y6B/FxjZoMnOnNEygG/
         T29jQQmb59/SQcAO21MjDPPaY+8nNGEBv2md9YeqE5F3GDzDxif9Vm7qUdSisZo63ga4
         YZaa+g4J5/QAkOZ76OPBiD2I4ZkU+5LcjFapWOHyq1Cay2YSGLzT6ctS6NbLZIFePkmZ
         YANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UYcII4nYGfLid6qAU3KjLJ0t+oJSwd+xH731sJxKqVI=;
        b=PdwbEqz/NqzLst2Y5SdMNi8pUHJXw5DR+QT60L9UQ6NyomBRfe7xhtYeI6DIdZGxGv
         zBgrf3QuA53YDaR/8KX5DN1RkO7TIUBy7mrIM0w2r4oFPoHtl9ZuCfHhcqcNfS7drMBT
         4hxncwLaUHQirkftrnfbEnzTR2YMLaQwn3lujci20s2rn0Pr3lwzz5fxFR3j3JOYTKSG
         P1PlpL8Qv+8SRwP5YkSGiHirTFAxegO7E7cq0tRAJC8ayyWddH7gQ430QGcQf1e/kfso
         606meqaHPwcrxwHGStcd1sdJGasO5+yhMojcC5GxSiXCG7atQh16M91F96TSQN+lNcmP
         Qa1A==
X-Gm-Message-State: AOAM532G33dakNixjHxH4ydAg+UK7WdTc8xAhnIrC+ZLmBPBo7MHZSmX
        i1DOAoosDl7vFvqTkm7/eeq7yCON9ZNDnQrcBSZayDXCoMg=
X-Google-Smtp-Source: ABdhPJz91BL2dHz2lNKfezHbiEFpLDgHlaKIEri+wNKq3jmyy76N6BQglvzXK4EDV8Vno1LHkHb77IRy9UR+U/VHxmE=
X-Received: by 2002:a17:907:204b:: with SMTP id pg11mr4549391ejb.192.1607564738633;
 Wed, 09 Dec 2020 17:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
 <20201120191606.2224881-7-harshadshirwadkar@gmail.com> <20201202184458.GJ390058@mit.edu>
In-Reply-To: <20201202184458.GJ390058@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 9 Dec 2020 17:45:27 -0800
Message-ID: <CAD+ocbxTHNDwqyucTif7n65pgiapTH1Exgh6F7fJQNDSkmXEcg@mail.gmail.com>
Subject: Re: [PATCH 06/15] ext2fs: add new APIs needed for fast commits
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I see that makes sense. In that case, I'll rename the function to
errcode_t ext2fs_decode_extent(struct ext2fs_extent *dst, void *src).
I wonder if it's okay if we make this function return an error in case
the on-disk format is not sane. If we do that, we can add
ext2fs_validate_extent() later. Does that make sense?

On Wed, Dec 2, 2020 at 10:45 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Nov 20, 2020 at 11:15:57AM -0800, Harshad Shirwadkar wrote:
> > This patch adds the following new APIs:
> >
> > Count the total number of blocks occupied by inode including
> > intermediate extent tree nodes.
> > extern blk64_t ext2fs_count_blocks(ext2_filsys fs, ext2_ino_t ino,
> >                                        struct ext2_inode *inode);
> >
> > Convert ext3_extent to ext2fs_extent.
> > extern void ext2fs_convert_extent(struct ext2fs_extent *to,
> >                                        struct ext3_extent *from);
>
> So one of the reasons why I've intentionally never exposed "struct
> ext3_extent" in the libext2fs interface is because that's an on-disk
> structure which I keep hoping we might change someday --- for example,
> to allow for 64-bit logical block numbers so we can create ext4 files
> greater than 2**32 blocks.  It might be that some other future
> enhancement, such as say, reflinks (depending on how we implement
> them), or reverse pointers, might also require making changes to the
> on-disk format.
>
> The kernel code has the on-disk format and the various logical
> manipulations of the extent tree hopelessly entangled with each other,
> which means changing the kernel code to support more than one on-disk
> extent structure is going to be **hard**.  But in the userspace code,
> all of the knowledge about the on-disk structure is abstracted away
> inside lib/ext2fs/extent.c.
>
> It may very well be that for fast commit, we're going to need to crack
> open that abstraction barrier a bit.  But let's make sure the function
> name makes it clear that what we are doing here is converting between
> a particular on-disk encoding and the ext2fs abtract extent type.
> "ext2fs_convert_extent" doesn't exactly make this clear.
>
> It might also be that what should do is include a pointer to the fs
> and inode structures, and call this something like
> "ext2fs_{decode,encode}_extent()", and pass in the on-disk format via
> a void *.  We might also want to have some kind of
> ext2fs_validate_extent() function which takes a void * and validates
> the on-disk structure to make sure it's sane.
>
> What do you think?
>
>                                         - Ted
