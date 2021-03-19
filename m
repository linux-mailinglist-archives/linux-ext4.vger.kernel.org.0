Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D059341791
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Mar 2021 09:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhCSIgy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Mar 2021 04:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbhCSIgj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Mar 2021 04:36:39 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A8FC06174A
        for <linux-ext4@vger.kernel.org>; Fri, 19 Mar 2021 01:36:39 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id f11so1905830vkl.9
        for <linux-ext4@vger.kernel.org>; Fri, 19 Mar 2021 01:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V4zhu0iRCwggJtth86gVHoOF9LsK67CiVV+65APy0lw=;
        b=NgCrMxdUv4Dd24ZJIvn8txNnJehnCB0Ef7rmPJEieE+/Pctto1uAw6wc8B+cAtlWPK
         VogFl9h1lhnO/pQRfQNdNah50HLP2xzpEuCnE3YgrDtMJwGvVcwuif9zFRL72kwm9DBt
         MWvTGTqzBo/n60C6tmFnyjn7KQ95cqhO2fEH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V4zhu0iRCwggJtth86gVHoOF9LsK67CiVV+65APy0lw=;
        b=GbaBYZ/iRaWjbK8NU2SAYuaydoPMGEPL84vw2xWsTdBrDmDiY6taHU81XM3vVRUa4I
         wH6MJIkC2xGjEFwm/DwqkgJOdoszxyVKmJGxnQAuyXwqmJPz4D10SXYcqdxIxLnDU7mB
         fujJkl2b3jcUAN+KsNLYzbAXsb/UVoWhDjEHmgbzh5k0ACg7VzuKwFaNyvaCmp93k8Sv
         1oOFa1dUgSNH71qZp4r0hkw/K7YRzpVFpZlee2IdIJobSbQhaF+YrjhO1Q3ggUBkMUqP
         uPVqxbS0mgozRc84VRHttK7bkMBviZGuQgSKf+0dLzY152t81qIQr3lz9dOlaDiBcwos
         soUQ==
X-Gm-Message-State: AOAM531uEo9rR9Bs1xPQscCenbdHrbaEkWa5ModmdegdvgxVZb7y1HMJ
        Uow3yEcAltOKIyRKrhF6+HTbZL9VZtYAAVwp3MM2PH1OI5clSA==
X-Google-Smtp-Source: ABdhPJyOcUk9BCpUQ0OmCXVP5bM2ZRg/vsU1onqAIu9UwyE5TCXFqJUpY3TQHcZ9BOa0vAr40gKFZ8brFU5MB+38h8k=
X-Received: by 2002:a05:6122:54:: with SMTP id q20mr1666620vkn.3.1616142998580;
 Fri, 19 Mar 2021 01:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210316221921.1124955-1-harshadshirwadkar@gmail.com>
 <CAOQ4uxiD8WGLeSftqL6dOfz_kNp+YSE7qfXYG34Pea4j8G7CxA@mail.gmail.com>
 <CAD+ocbzMv6SyUUZFnBE0gTnHf8yvMFfq6Dm9rdnLXoUrh7gYkg@mail.gmail.com> <CAOQ4uxg+d2WoPEL2mC5H3d0uxh-_HGw3Bhyrun=z4O2nCg-yNQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxg+d2WoPEL2mC5H3d0uxh-_HGw3Bhyrun=z4O2nCg-yNQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 19 Mar 2021 09:36:27 +0100
Message-ID: <CAJfpeguiFU5qv-L-jeXBhc+PqeMOUoVnPO3EN4xOB0nCH9Z2cA@mail.gmail.com>
Subject: Re: [PATCH] ext4: add rename whiteout support for fast commit
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Ext4 <linux-ext4@vger.kernel.org>, Theodore Tso <tytso@mit.edu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 19, 2021 at 6:52 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> [adding overlayfs list]
>
> On Fri, Mar 19, 2021 at 3:32 AM harshad shirwadkar
> <harshadshirwadkar@gmail.com> wrote:
> >
> > Thanks for the review Amir.
> >
> > Sure changing the subject makes sense.
> >
> > Also, on further discussions on Ext4 conference call, we also thought
> > that with this patch, overlayfs customers would not benefit from fast
> > commits much if they call renames often. So, in order to really make
> > rename whiteout a fast commit compatible operation, we probably would
> > need to add support in fast commit to replay a char device creation
> > event (since whiteout object is a char device). That would imply, we
> > would need to do careful versioning and would need to burn an on-disk
> > feature flag.
> >
> > An alternative to this would be to have a static whiteout object with
> > irrelevant nlink count and to have every rename point to that object
> > instead. Based on how we decide to implement that, at max only the
> > first rename operation would be fast commit incompatible since that's
> > when this object would get created. All the further operations would
> > be fast commit compatible. The big benefit of this approach is that
> > this way we don't have to add support for char device creation in fast
> > commit replay code and thus we don't have to worry about versioning.
> >
>
> I'm glad to hear that, Harshad.
>
> Please note that creating a static whiteout object on-disk is one possible
> implementation option. Not creating any object on-disk may be even better.

I don't really get it.  What's the advantage of not having an object?

Readdir returning DT_WHT internally might be nice, but I'd be careful
with exporting that to userspace, since it's likely to cause more
problems that it solves.   And on the stat(2) interface adding S_IFWHT
or even worse: ENOENT are really out of the question due to backward
incompatibility with almost every application.

> One other challenge is how to handle users trying to make operations
> on the upper layer directly (migrating images etc).
> As long as the tools still observe the whiteout as a chadev (with stat(2))
> then export and import should work fine (creating a real chardev on import).

Right.

Can't mkfs.ext4 just create the static object?  That sounds to me like
the simplest approach.

Thanks,
Miklos


Thanks,
Miklos
>
> I had suggested the static object approach because it should be pretty
> simple to implement and add e2fsprogs support for.
>
> However, if we look at the requirements for RENAME_WHITEOUT,
> the resulting directory entry does not actually need to point to any
> object on-disk at all.
>
> An alternative implementation would be to create a directory entry
> with {d_ino = 0, d_type = DT_WHT}. Lookup of this entry will return
> a reference to a singleton read-only ext4 whiteout inode object, which
> does not reside on disk, so fast commit is irrelevant in that sense.
> i_nlink should be handled carefully, but that should be easier from
> doing that for a static on-disk object.
>
> I am not sure how userland tools handle DT_WHT, but I see that
> other filesystems can emit this value in theory and man rename(2)
> claims that BSD uses DT_WHT, so the common tools should be
> able to handle it.
>
> As far as overlayfs is concerned:
> 1. ovl_lookup() will find an IS_WHITEOUT() inode as usual
> 2. ovl_dir_read_merged() will need this small patch (below) and will
>     not access the inode object at all
> 3. At first, ovl_whiteout() -> vfs_whiteout() can still create a usual chardev
> 4. Later, we can initiate the overlayfs instance singleton whiteout
>     reference in ovl_check_rename_whiteout() and ovl_whiteout() will
>     never get -EMLINK when linking this whiteout object
>
> If there are tools that try to change  inode permissions recursively on the
> upper layer (?) there may be a problem with those read-only whiteouts
> although the permission of a whiteout is a moot concept.
>
> Thanks,
> Amir.
>
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -161,7 +161,7 @@ static struct ovl_cache_entry
> *ovl_cache_entry_new(struct ovl_readdir_data *rdd,
>         if (ovl_calc_d_ino(rdd, p))
>                 p->ino = 0;
>         p->is_upper = rdd->is_upper;
> -       p->is_whiteout = false;
> +       p->is_whiteout = (d_type == DT_WHT);
>
>         if (d_type == DT_CHR) {
>                 p->next_maybe_whiteout = rdd->first_maybe_whiteout;
