Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CA0341510
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Mar 2021 06:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhCSFwf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Mar 2021 01:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbhCSFwG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Mar 2021 01:52:06 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A76C06174A;
        Thu, 18 Mar 2021 22:52:06 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id v3so4872788ioq.2;
        Thu, 18 Mar 2021 22:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFEUCsXB/846GPTkksZ0MN9Gughl9FrFefeL2AgymC8=;
        b=jUqDRjzzBert2lOnmK3GKqrOzOpVX/FrIXwQhOgJ3CC9OgXZF8QdYhKCCrcMog46jE
         zr6dq2oqQgnHmVQbphZJQXkUcmWzBFc46vxdm+Igus4KeeGWCINLHMoL1W2wH5Oabxy6
         zOZo7TSLXRFJRW12Hq7uIFISsAapq2tWguVZojl1RWwxa84p8Fy6m6pTp8HVJv7u9fhD
         PxZiAhdcaB7EXNKQpTRemg7skK9TLZ9f+ZklgtWZvzOjCd6H3i1kPKwTWHvuzv8EO2mL
         WnGv8kzXMPxrjRI+KCdgDkq0trHm5gqA7r9hh79HUD7FH/AjLIHGDKZ4q9n0SoBsKZrN
         6cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFEUCsXB/846GPTkksZ0MN9Gughl9FrFefeL2AgymC8=;
        b=tVJGTN0fakX26q5Gt3wrt683rwCg0Oz4uoM/EngezJ9tnDDlaQhlJaLxqCPqCGYPg8
         2bgcn/gwEt5ez5KPjxDdtZxHf4jVuq4nJPVAbIxoHcgq1TsMW0gVMYggrMYI3mFYEPUW
         C153WmiuQGt3wxLc1EZRuIbqGdm7Vr1JXV+mtw7RYwGn90YuQFO2si1RAFE5WqyTt2LL
         zSHuibF3xRz0XiCs9OndqV3iV+sgq2gkA4t0kLMWxZTcgA+YRghIey2W7LldgqXqiYSo
         RS2J95x8Y+2GKUPZxoE1Wbw8CB5Ya+53Jdx7m8aOyy8tgPlMb20D7EbppugxXO+6Zba4
         09mw==
X-Gm-Message-State: AOAM532lHgtGXj4/rKyxyKlv+kdjyae8uDc7aranFs+pUsK980NbjYwh
        hsH6+2MyXiCjHONfbflzc0x81tuo/TVEwTga2k20aHZgWMo=
X-Google-Smtp-Source: ABdhPJyYk1EFF/LztG1Ubn763IGlb8GnJ/ky4LkYv8NJ1KUe76W3DQ01bH/SFmhoE/tfIH8HlwfYL10FMgwUc/xFAks=
X-Received: by 2002:a6b:4411:: with SMTP id r17mr1520221ioa.64.1616133125575;
 Thu, 18 Mar 2021 22:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210316221921.1124955-1-harshadshirwadkar@gmail.com>
 <CAOQ4uxiD8WGLeSftqL6dOfz_kNp+YSE7qfXYG34Pea4j8G7CxA@mail.gmail.com> <CAD+ocbzMv6SyUUZFnBE0gTnHf8yvMFfq6Dm9rdnLXoUrh7gYkg@mail.gmail.com>
In-Reply-To: <CAD+ocbzMv6SyUUZFnBE0gTnHf8yvMFfq6Dm9rdnLXoUrh7gYkg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 19 Mar 2021 07:51:54 +0200
Message-ID: <CAOQ4uxg+d2WoPEL2mC5H3d0uxh-_HGw3Bhyrun=z4O2nCg-yNQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: add rename whiteout support for fast commit
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Ext4 <linux-ext4@vger.kernel.org>, Theodore Tso <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[adding overlayfs list]

On Fri, Mar 19, 2021 at 3:32 AM harshad shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> Thanks for the review Amir.
>
> Sure changing the subject makes sense.
>
> Also, on further discussions on Ext4 conference call, we also thought
> that with this patch, overlayfs customers would not benefit from fast
> commits much if they call renames often. So, in order to really make
> rename whiteout a fast commit compatible operation, we probably would
> need to add support in fast commit to replay a char device creation
> event (since whiteout object is a char device). That would imply, we
> would need to do careful versioning and would need to burn an on-disk
> feature flag.
>
> An alternative to this would be to have a static whiteout object with
> irrelevant nlink count and to have every rename point to that object
> instead. Based on how we decide to implement that, at max only the
> first rename operation would be fast commit incompatible since that's
> when this object would get created. All the further operations would
> be fast commit compatible. The big benefit of this approach is that
> this way we don't have to add support for char device creation in fast
> commit replay code and thus we don't have to worry about versioning.
>

I'm glad to hear that, Harshad.

Please note that creating a static whiteout object on-disk is one possible
implementation option. Not creating any object on-disk may be even better.

I had suggested the static object approach because it should be pretty
simple to implement and add e2fsprogs support for.

However, if we look at the requirements for RENAME_WHITEOUT,
the resulting directory entry does not actually need to point to any
object on-disk at all.

An alternative implementation would be to create a directory entry
with {d_ino = 0, d_type = DT_WHT}. Lookup of this entry will return
a reference to a singleton read-only ext4 whiteout inode object, which
does not reside on disk, so fast commit is irrelevant in that sense.
i_nlink should be handled carefully, but that should be easier from
doing that for a static on-disk object.

I am not sure how userland tools handle DT_WHT, but I see that
other filesystems can emit this value in theory and man rename(2)
claims that BSD uses DT_WHT, so the common tools should be
able to handle it.

As far as overlayfs is concerned:
1. ovl_lookup() will find an IS_WHITEOUT() inode as usual
2. ovl_dir_read_merged() will need this small patch (below) and will
    not access the inode object at all
3. At first, ovl_whiteout() -> vfs_whiteout() can still create a usual chardev
4. Later, we can initiate the overlayfs instance singleton whiteout
    reference in ovl_check_rename_whiteout() and ovl_whiteout() will
    never get -EMLINK when linking this whiteout object

One other challenge is how to handle users trying to make operations
on the upper layer directly (migrating images etc).
As long as the tools still observe the whiteout as a chadev (with stat(2))
then export and import should work fine (creating a real chardev on import).

If there are tools that try to change  inode permissions recursively on the
upper layer (?) there may be a problem with those read-only whiteouts
although the permission of a whiteout is a moot concept.

Thanks,
Amir.

--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -161,7 +161,7 @@ static struct ovl_cache_entry
*ovl_cache_entry_new(struct ovl_readdir_data *rdd,
        if (ovl_calc_d_ino(rdd, p))
                p->ino = 0;
        p->is_upper = rdd->is_upper;
-       p->is_whiteout = false;
+       p->is_whiteout = (d_type == DT_WHT);

        if (d_type == DT_CHR) {
                p->next_maybe_whiteout = rdd->first_maybe_whiteout;
