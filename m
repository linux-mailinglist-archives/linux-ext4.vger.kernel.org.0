Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E8A23F5CC
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Aug 2020 03:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgHHBa0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Aug 2020 21:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgHHBa0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Aug 2020 21:30:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA91C061756
        for <linux-ext4@vger.kernel.org>; Fri,  7 Aug 2020 18:30:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k20so3385715wmi.5
        for <linux-ext4@vger.kernel.org>; Fri, 07 Aug 2020 18:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDeJEkJ/8S3OE+Trl+Xe+daUwGAfoKP4kwo+HhNBbNI=;
        b=CAskl4+zmznwyjQuLEbwegDTyir+ypI5GFFwhOCOCB1f61uDbY36uj/RDiDouyfzPJ
         62OkZMQ30fnRuwzTpkRMb0IwGgl4fHfSLfyuixr9K6k41cvDYQHS7pmHFoEb4G48b4ce
         3/OeyQIo1AiQ7t07K4NslT/LKu2CcUKUpAHFg81ptMLpuvdlQSYyc84OO/eVFwO+Y+Yc
         si22noqlgbxWtkHfbrwOMV1YEKdtYmFyfuQcEgUxVutF17P1zWgUPeAr5EQKrULmu9ap
         /4NC923wrfeQzuY61vk7z/PdaGzZhoS8e+TLvLMUQlsJvNp27HU8B9G9k3b/s8qnFXnm
         HI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDeJEkJ/8S3OE+Trl+Xe+daUwGAfoKP4kwo+HhNBbNI=;
        b=Uq/+6k/+8RU9b/X25nx3Sxbwrh+QpexaOWHmnceVhw2GHcNuAHgf3pvYObztGuDJOG
         vaolmC2qGAL+QLNz2GY/w5gKKacy/ze6ROcOxiphMxfoYADxtLmongIy2lU9FD74UJit
         SQ8GX/g2KTLtYW2PJ6PfXGI4ARC+ijhISXszr2Lvb8jMm0OFDiLa3H/39yXg4F1pINjd
         e8T9///d+OB4KdhrVyvoCli9J7Dsu6V0uO6hCJKB/jZxk+akV89zHWNuzIzWNiTq3xoS
         vHobXc16w2lCayRPpER/1ox07e5iqwU1kblajNQs0iG4QTbuoeIpGSmqk0X8hUqT2WBX
         ePyg==
X-Gm-Message-State: AOAM5326pQYPF9ccAWG/iX8K/n/Q3hUCu9XGZddyyPvWwJL0ujVAwCBT
        Z+cMSdW8vl0zSAx3BBc3Tu7wDg2602NLjqI+TjvmM0xdePY=
X-Google-Smtp-Source: ABdhPJzCHaFaYT1yBx9HiDwkIjyBxv9qAi7ah4y+OssDDKTJhut4ttAhkkCnIa5WLQAaCJTOOcx/V0FeeV5eVJt2kaw=
X-Received: by 2002:a1c:dd06:: with SMTP id u6mr15736847wmg.39.1596850224710;
 Fri, 07 Aug 2020 18:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <1592831677-13945-1-git-send-email-wangshilong1991@gmail.com> <20200806044703.GC7657@mit.edu>
In-Reply-To: <20200806044703.GC7657@mit.edu>
From:   Wang Shilong <wangshilong1991@gmail.com>
Date:   Sat, 8 Aug 2020 09:29:50 +0800
Message-ID: <CAP9B-Qnv2LXva_szv+sDOiawQ6zRb9a8u-UAsbXqSqWiK+emiQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ext4: introduce EXT4_BG_WAS_TRIMMED to optimize trim
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Wang Shilong <wshilong@ddn.com>,
        Shuichi Ihara <sihara@ddn.com>,
        Andreas Dilger <adilger@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 6, 2020 at 12:47 PM <tytso@mit.edu> wrote:
>
> On Mon, Jun 22, 2020 at 10:14:36PM +0900, Wang Shilong wrote:
> > From: Wang Shilong <wshilong@ddn.com>
> >
> > Currently WAS_TRIMMED flag is not persistent, whenever filesystem was
> > remounted, fstrim need walk all block groups again, the problem with
> > this is FSTRIM could be slow on very large LUN SSD based filesystem.
> >
> > To avoid this kind of problem, we introduce a block group flag
> > EXT4_BG_WAS_TRIMMED, the side effect of this is we need introduce
> > extra one block group dirty write after trimming block group.
> >
> > And When clearing TRIMMED flag, block group will be journalled
> > anyway, so it won't introduce any overhead.
>
> This persistent flag will not be accurate if there are blocks that
> were freed in the block group in the same transaction, before
> EXT4_BG_WAS_TRIMMED flag is set.

Yup, i thought something like this, this might not be accurate, but this won't
cause some data corruptions etc, and trying to write data which was not
trimmed in advance, SSD will do erase finally.

And i sent e2fsprogs support which could clear all block groups
EXT4_BG_WAS_TRIMMED
flags, but it needs umounted state of course.

And for our case, when admin running fstrim on filesystem, usually there
are few IO for filesystem, so most of case, it might be fine.
>
> That's because we can't trim (or reuse) a block which has been
> released until the transaction has committed, since if we crash before
> it is commited, the file unlink or truncate will not have happened,
> and so we can't trash the block until after the deallocation has been
> freed.
>
> This problem is also there with a non-persistent flag, granted; but
> when the file system is unmounted and remounted, we will eventually
> trim the block via a fstrim.  When we make the flag persistent, the
> problem becomes worse, since it might mean that there are some blocks
> that have been released, that might never get discarded.
>
> I suppose the question is whether the sysadmin really wants unused
> blocks to be discarded, either to not leak blocks in some kind of
> thin-provisioned storage device, or if the sysadmin is depending on
> the discard for some kind of security/privacy application (because
> they know that a particular storage device actually has reliable,
> secure discards), and how does that get balanced with sysadmins think
> performance of fstrim is more important, especially if the device is
> really slow at doing discard.

Yup, that is good point, for our case, fstrim could take hours to complete
as it needs extra IO for disk arrays, so we really want repeated fstrim.

So what do you think extra mount option or a feature bit in the superblock.
In default, we still keep ext4 in previous behavior, but once turned
on it, we have
this optimized  "inaccurate" optimizations.

Thank you!
Shilong


>
>                                         - Ted
