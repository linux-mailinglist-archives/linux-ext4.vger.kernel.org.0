Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0307D341A77
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Mar 2021 11:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCSKwM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Mar 2021 06:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCSKwH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Mar 2021 06:52:07 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318E0C06174A
        for <linux-ext4@vger.kernel.org>; Fri, 19 Mar 2021 03:52:06 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id b5so3221164vsl.9
        for <linux-ext4@vger.kernel.org>; Fri, 19 Mar 2021 03:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyU0kfhyJ9K9PwDpeZgafjUaj5wayL2Dd1uu3ttNySA=;
        b=X8iKjZKkXYwh3BR84dUDizD/1NFrlbgZCIGwoUQIOsscM/6j6yFdalp+0zHlY0afLn
         2TTOEZwIma6EHaZtjOqsTYsEb8tM38HBkrCQKxJekX0F6Gu8kT4t4O/jhs4t1r4qM08d
         IsqnUJVbVcdM3PYW9BAKdBv2zowZxdkW2mVcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyU0kfhyJ9K9PwDpeZgafjUaj5wayL2Dd1uu3ttNySA=;
        b=WNt49dcjibX68hNVjIjt7jY/lZeHUDgRPG4FqFMBVajw0wWHMYnEXP0vbZVYcad9lI
         cbFw8aYpyuBciMQ0QpmN3rYMStsA0/lFSbKI/7YfX6Cb7/3R7XKAbYNi54yk9zn7Zyuh
         k52QD1k+UQxfL4iP7rdl6XJ2EUBUMoqryrZYZtAx2qsLzAwJ9xv5lwkZc3os264GFnJg
         fQG3dv2aDrdSLanVpzk5uc49zM/UrsvntyUOCAUNZU91srbkFLiegEfcu386GX0wVJ+x
         uOiEZWUDKpSnGlX+c92wTk+RtzZk1MVyDEWdpm65sdj8lIbDGzTND5qvW1Vj1NXLwCPv
         CLJQ==
X-Gm-Message-State: AOAM530QsqddLkPVjHHwGbNwsG1Z6+ZvLdtuCDHLu9FwwX35n6gIQDMj
        vViUNg6orbdauha/8MzCZwx4NSIx3PsfwItkkKGjSQ==
X-Google-Smtp-Source: ABdhPJyKXHCKa1uQYDJ36wfBLGH7zSQQ4glHPyYkdKrk6MfMGZWPApUav49zfHhz35XD+Gis8mq8yciY5zILs46+sW0=
X-Received: by 2002:a67:f7d2:: with SMTP id a18mr1977372vsp.21.1616151125453;
 Fri, 19 Mar 2021 03:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210316221921.1124955-1-harshadshirwadkar@gmail.com>
 <CAOQ4uxiD8WGLeSftqL6dOfz_kNp+YSE7qfXYG34Pea4j8G7CxA@mail.gmail.com>
 <CAD+ocbzMv6SyUUZFnBE0gTnHf8yvMFfq6Dm9rdnLXoUrh7gYkg@mail.gmail.com>
 <CAOQ4uxg+d2WoPEL2mC5H3d0uxh-_HGw3Bhyrun=z4O2nCg-yNQ@mail.gmail.com>
 <CAJfpeguiFU5qv-L-jeXBhc+PqeMOUoVnPO3EN4xOB0nCH9Z2cA@mail.gmail.com> <CAOQ4uxjcQWQ9n1rO7=js2SQ8-ZEbX2Wjvq-6ZGCyy5X5CJcTbw@mail.gmail.com>
In-Reply-To: <CAOQ4uxjcQWQ9n1rO7=js2SQ8-ZEbX2Wjvq-6ZGCyy5X5CJcTbw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 19 Mar 2021 11:51:54 +0100
Message-ID: <CAJfpegsGpaFdLcmUsBW66qhJSfXuog=3UbsZ50O_FSw2WUGhJA@mail.gmail.com>
Subject: Re: [PATCH] ext4: add rename whiteout support for fast commit
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Ext4 <linux-ext4@vger.kernel.org>, Theodore Tso <tytso@mit.edu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 19, 2021 at 11:35 AM Amir Goldstein <amir73il@gmail.com> wrote:

> One thing that we will probably need to do is use the RENAME_WHITEOUT
> interface as the explicit way to create the shared whiteout instead of using
> vfs_whiteout() for filesystems that support RENAME_WHITEOUT
> (we check for RENAME_WHITEOUT support anyway).
>
> The only thing that bothered me in moving from per-ovl-instance singleton
> to per-ext4-singleton is what happens if someone tries to (say) chown -R
> the upper layer or some other offline modification that was working up to
> now and seemed to make sense.

Eek.

>
> Surely, the ext4 singleton whiteout cannot allow modifications like that,
> so what do we do about this? Let those scripts fail (if they exist) and
> let their owners fix them to skip errors on whiteouts?

Might try that.  But the no-regressions rule means we'd have to change
that in case it breaks something.

Thanks,
Miklos

> Thanks,
> Amir.
