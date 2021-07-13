Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1B93C70C6
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jul 2021 14:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbhGMNAl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jul 2021 09:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbhGMNAk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jul 2021 09:00:40 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6B5C0613DD
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jul 2021 05:57:49 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id y38so34598719ybi.1
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jul 2021 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9wjl9Wb8715Xwj8nPs5h6S/JLHoE3Ri522/f/fBryQg=;
        b=a+OzNv1WYnvh+6GTsS6zhnYTzEhsY+KXFZJdAHnXiM08Fd+t8TBoirQqnVO6+BWzIV
         2f0UyaRCZwpZzfKTvmT6aj3qaKcsxg/+/kvm0pA2OnLepwG7xYxX1ICixZmBYYUy2hMl
         dzRXHPYHIAU5pI2U2Y3Zpx93eFItKgQJC2M6s7TUMwNdn/Qp5307SkG1oTh/W2N9xRZC
         KDFDwk1QxePRxNT5tL+zmVj3/AUm+JptXMj79e70+X3tc1yEok0qtnCg60rePC/D2Sm+
         X4U8cZ4O5G9Pwg1TmF+lT9RqMTOklV9YqNeDKDWjb9jcMN+9BtF7UAugdgGNhrqSS+4Y
         EOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wjl9Wb8715Xwj8nPs5h6S/JLHoE3Ri522/f/fBryQg=;
        b=feJjHxaijtxBrWF6VfRO+qslwItNeI2mpjRE+X8W4F+3zvcwrl/3kiMSqZpxEMM5VR
         oJ4nMZy4n4Ydi6jSl8ZraqPqIKHNBsOUVd5Wnpddl+hQ1kqxl6UTF2PgNCalnho7fThL
         60SF9UVWamCwSAqIkcycNoxgkkFkhIRRlUVBzz20wAoqCNCDjLn3pM/CiljTIBbvE8lq
         RlkZXndqbecMZdGlqDwuRm501RHwvWe2a5ir02WTjbPn8PFrlccoK7UULWztWupVXm6h
         bRo3kw0rXMRI7JJNVnTjqVRAkf6X88IHssLabq8dHT9In+FXmRnh7v1H1YOwLAsjW1Oq
         a9Qg==
X-Gm-Message-State: AOAM5300OTLqQTI77lJcIr7Z2y7Jm46BuQPDUbLmoRJsrdxfkej6AyBs
        4vDINZqaO+lvxZk8qjmMd6ntY/NEftGM5tgMeCM=
X-Google-Smtp-Source: ABdhPJweumDpB/T5PFzoWdEapjWVNIpiXlQ+P4jYobtnAcjv3iJjMFjTeQXX/GriqILBtWcREhwaIvc0T0UqCT6xUN0=
X-Received: by 2002:a25:9243:: with SMTP id e3mr1562090ybo.97.1626181069075;
 Tue, 13 Jul 2021 05:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <CANT5p=o3i4kWQuMFF5zKQp04JnWEQnYuo+cvyH8asGMvTVBBkw@mail.gmail.com>
 <YO17ZNOcq+9PajfQ@mit.edu>
In-Reply-To: <YO17ZNOcq+9PajfQ@mit.edu>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Tue, 13 Jul 2021 18:27:37 +0530
Message-ID: <CANT5p=qi8-9iZa0XE70ZaCUdqscKufovjcUAZZPDRmN9W5_uQA@mail.gmail.com>
Subject: Re: Regarding ext4 extent allocation strategy
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     David Howells <dhowells@redhat.com>,
        Steve French <smfrench@gmail.com>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 13, 2021 at 5:09 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Jul 13, 2021 at 12:22:14PM +0530, Shyam Prasad N wrote:
> >
> > Our team in Microsoft, which works on the Linux SMB3 client kernel
> > filesystem has recently been exploring the use of fscache on top of
> > ext4 for caching the network filesystem data for some customer
> > workloads.
> >
> > However, the maintainer of fscache (David Howells) recently warned us
> > that a few other extent based filesystem developers pointed out a
> > theoretical bug in the current implementation of fscache/cachefiles.
> > It currently does not maintain a separate metadata for the cached data
> > it holds, but instead uses the sparseness of the underlying filesystem
> > to track the ranges of the data that is being cached.
> > The bug that has been pointed out with this is that the underlying
> > filesystems could bridge holes between data ranges with zeroes or
> > punch hole in data ranges that contain zeroes. (@David please add if I
> > missed something).
> >
> > David has already begun working on the fix to this by maintaining the
> > metadata of the cached ranges in fscache itself.
> > However, since it could take some time for this fix to be approved and
> > then backported by various distros, I'd like to understand if there is
> > a potential problem in using fscache on top of ext4 without the fix.
> > If ext4 doesn't do any such optimizations on the data ranges, or has a
> > way to disable such optimizations, I think we'll be okay to use the
> > older versions of fscache even without the fix mentioned above.
>
> Yes, the tuning knob you are looking for is:
>
> What:           /sys/fs/ext4/<disk>/extent_max_zeroout_kb
> Date:           August 2012
> Contact:        "Theodore Ts'o" <tytso@mit.edu>
> Description:
>                 The maximum number of kilobytes which will be zeroed
>                 out in preference to creating a new uninitialized
>                 extent when manipulating an inode's extent tree.  Note
>                 that using a larger value will increase the
>                 variability of time necessary to complete a random
>                 write operation (since a 4k random write might turn
>                 into a much larger write due to the zeroout
>                 operation).
>
> (From Documentation/ABI/testing/sysfs-fs-ext4)
>
> The basic idea here is that with a random workload, with HDD's, the
> cost of writing a 16k random write is not much more than the time to
> write a 4k random write; that is, the cost of HDD seeks dominates.
> There is also a cost in having a many additional entries in the extent
> tree.  So if we have a fallocated region, e.g:
>
>     +-------------+---+---+---+----------+---+---+---------+
> ... + Uninit (U)  | W | U | W |   Uninit | W | U | Written | ...
>     +-------------+---+---+---+----------+---+---+---------+
>
> It's more efficient to have the extent tree look like this
>
>     +-------------+-----------+----------+---+---+---------+
> ... + Uninit (U)  |  Written  |   Uninit | W | U | Written | ...
>     +-------------+-----------+----------+---+---+---------+
>
> And just simply write zeros to the first "U" in the above figure.
>
> The default value of extent_max_zeroout_kb is 32k.  This optimization
> can be disabled by setting extent_max_zeroout_kb to 0.  The downside
> of this is a potential degredation of a random write workload (using
> for example the fio benchmark program) on that file system.
>
> Cheers,
>
>                                                 - Ted

Hi Ted,

Thanks for pointing this out. We'll look into the use of this option.

Also, is this parameter also respected when a hole is punched in the
middle of an allocated data extent? i.e. is there still a possibility
that a punched hole does not translate to splitting the data extent,
even when extent_max_zeroout_kb is set to 0?

-- 
Regards,
Shyam
