Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B3A3C7841
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jul 2021 22:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbhGMUzO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jul 2021 16:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbhGMUzO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jul 2021 16:55:14 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6185C0613DD;
        Tue, 13 Jul 2021 13:52:23 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id g19so37065192ybe.11;
        Tue, 13 Jul 2021 13:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HNa1uyGKthgEsfSPk6zTopnzfVQXtNCng1FQUxNRDSk=;
        b=RmyMSiR+gZjiltux2RtDJC9wYxWRfpJpHq3AYSrrmnuCKICYtPApkh+owtwJP89vl1
         z7oaBD9NMcPLBWMjqZQdX86qizAsAjP5p49Z3XOmZuCgBxa2z2TVQ0LAhtOXtxXtR3dU
         rTXtc+Znv211XjFUfgebzEESkCBPRqv3vKAhQ0ZhN/TDaASqH7zmqDUxrPsuyOSkPm1C
         L0iZqN7GHzkWush+LBkyIVVr/kt9fsiun19+2cvyy1hLZBsmbBguEHRcMF76U6Ux/7S7
         F+RUe6An+owsQ+c7uD1ygdvd1+x/NfA0Lvc7BRV72vPzouwk6EZq5lY144c3PCGPvCam
         /JSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNa1uyGKthgEsfSPk6zTopnzfVQXtNCng1FQUxNRDSk=;
        b=jyL4Ijj0NqXov+VYu4X61aJ20kgP94N/OsdvU8Lso1mE4odl/U0xdyleLl7/5LUyVD
         KnOdcd5VwC67hRRvPRQK+4n40dBOBYuJ1TWzduKmu69VQKBnwxh8Vj008tBTEBRZsL5K
         0C/CNQ673Uwm+wpiiSD93ZhEonzxOK3DemX6OE3RYuOk3nInk2UcdIEWZSpigvRMCgOw
         LRkWgMBTUkfZb9m735MNviCyBHaMxgRMtyyvu0URof38J5JhWKk2bf2Iu2abBGVP9CjI
         H4QcydxTvEC1ibOr7vxeY0wzpy7gkpU/ORVWg1taydyLikEfcZjWJvMA1A5uFwR49Qsm
         EvGA==
X-Gm-Message-State: AOAM532OA7udkuG4E8EHcisYtAw/u8CKXlq4H7dfGvdQvITmGSrIIk7H
        eRy4vKzQG38OZrfRu82ULOe9k6FPuPuzsZZPtlc=
X-Google-Smtp-Source: ABdhPJwIMUd+WE4l6xMme3qrqlBQ8xVcjP6/S9s4k4GOUlHN5X8yyjoXQwZzIzbiW/j6/TRc953ym5Ix33p2UcBOaME=
X-Received: by 2002:a25:ad62:: with SMTP id l34mr8482235ybe.457.1626209543069;
 Tue, 13 Jul 2021 13:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAMdYzYqvT+X9C_YZ+DtspgHLSeb=RVHLeS2-0pEHeotyvb+iXQ@mail.gmail.com>
 <20210713154310.GE24271@quack2.suse.cz>
In-Reply-To: <20210713154310.GE24271@quack2.suse.cz>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 13 Jul 2021 16:52:11 -0400
Message-ID: <CAMdYzYroicgDkWuiQ7Xaw_5aYD9mLkrz8qvE9WwS6mPw9uWe8g@mail.gmail.com>
Subject: Re: ext4_xattr_ibody_find:2180: inode #2669312: comm systemd-journal:
 corrupted in-inode xattr
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 13, 2021 at 11:43 AM Jan Kara <jack@suse.cz> wrote:
>
> Hello!

Good Evening,

>
> On Fri 28-05-21 08:36:17, Peter Geis wrote:
> > I have run into a fun issue where I have the follow error on boot,
> > which causes the device to drop to read only mode:
> > ext4_xattr_ibody_find:2180: inode #2669312: comm systemd-journal:
> > corrupted in-inode xattr
> > It marks the file system as unclean, which forces a fsck, but it seems
> > that even as of v1.46.2 e2fsprogs does not have the ability to resolve
> > this issue.
> > Any attempts to touch the corrupted files (I've found two so far)
> > leads to the same error, and I cannot find a way to remove or repair
> > the affected inodes without wiping the entire file system.
>
> This seems to have fallen through the cracks. Have you managed to fix your
> filesystem? If not, please obtain filesystem image using e2image (it will
> contain only fs metadata, not any data), compress it and put it somewhere for
> download so that we can better diagnose the issue. Thanks!

Unfortunately no I don't have the file system anymore.
I put about two weeks into trying to fix it, but in the end I had to
nuke it from orbit.

Thanks for reaching out,
Peter

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
