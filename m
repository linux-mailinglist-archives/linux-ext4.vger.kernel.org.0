Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F04232546B
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Feb 2021 18:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhBYROK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Feb 2021 12:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhBYROJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Feb 2021 12:14:09 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F58C061574
        for <linux-ext4@vger.kernel.org>; Thu, 25 Feb 2021 09:13:28 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id d13so2864520edp.4
        for <linux-ext4@vger.kernel.org>; Thu, 25 Feb 2021 09:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UcvihQ9gaqN3NwTrDdIf0/sOuhfOhcj7/GxlIDYshBk=;
        b=Jy1nwhW+85ns4BAS8U/CWlngnqHvHYH14Xp4Ahr9vARszVIj1LWymBwOJb0P6GHjUz
         9v8CZecl1WjKY18sVnhvcVg/dQiFmQeBpbXhBCjagEWM2i4DIJIJG7UgFSdvsoSHuP6B
         sTFXvWmO5V7fDKE69uQJt/jhnBQnOKaPUETawbtDsM121XdtdBgywPN2Yasmg0+Bqn47
         D2BXccrx4bnSxD6gKkcn65zGg5HhxW+Ci282O+tq2Rscb+eLDtICwwYlNsukFN06g3ig
         MdcYEERskhsg3aFNH93CAwVSgNUp338GLNNMLEDOOvyRZqNPlH4wY3Z6qNockPRy9+5G
         AQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UcvihQ9gaqN3NwTrDdIf0/sOuhfOhcj7/GxlIDYshBk=;
        b=uMEyXUBRpn2ieiXtP/m5zSkblXJPfuq9EQjNEVlBvnrEe9fVUw4hM5OKv/pVzLSUrY
         zZuZMoQcUtQys/0PmT+/dvwKjv540+WlsHhKe5wnDhzTRTV1/FHCYRJIiW78d2zhMDPJ
         IuxgHvxGyjbjCdHQk3NgBc6tQhWLQk2wKbROEsc2E2FT3OGR9VuisF/iM8YoFth3yYxg
         25dOj6TZycXckO9G/zrMWQqHQA4ES3+uGb84KfnnM4GtuucUxd2aozA9cg7QqsqXME3G
         nsvRkwMuyHB3NHLXSon2OP6/cmwnCMU/8S2EBxaQF0GYhrtD8PWlJQDkU1bPx+mxTJ0T
         wn+g==
X-Gm-Message-State: AOAM530BsN40nVtNu3Gj5078EvKfh+WNoDZCAWihdL2TyhO8f2Xr1udB
        Zr99WBxFNhv2CP6UqqHdNKBa0CoenbOVYJX8e9wPxQcJXPY=
X-Google-Smtp-Source: ABdhPJzHDLv9ZNN9M3xMUTWRCf16+xmLvszXUIF9BMYPqlzqsMrjRVVnb5CVBlYFGDwXVn3mW9JFRZOIfdVhXid/F2c=
X-Received: by 2002:a50:fb81:: with SMTP id e1mr4024495edq.213.1614273207152;
 Thu, 25 Feb 2021 09:13:27 -0800 (PST)
MIME-Version: 1.0
References: <c6fb0951-a472-dbb4-1970-fe9cece5d182@huawei.com>
 <CAD+ocbwkQ4rMYhiOm4msnBH65vh6Pm25ZkPsC2pD0sFy68bPgA@mail.gmail.com> <YDfYC+xUal5EdibL@mit.edu>
In-Reply-To: <YDfYC+xUal5EdibL@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 25 Feb 2021 09:13:15 -0800
Message-ID: <CAD+ocbyebaRPYws8==NuPS=v-bjZVSoPYc2AM=mvRVaYs9eZXQ@mail.gmail.com>
Subject: Re: [PATCH] debugfs: fix memory leak problem in read_list()
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linfeilong <linfeilong@huawei.com>,
        lihaotian <lihaotian9@huawei.com>,
        "lijinlin (A)" <lijinlin3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the clarification, I think my repo was a bit stale.

- Harshad

On Thu, Feb 25, 2021 at 9:02 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Feb 25, 2021 at 07:51:09AM -0800, harshad shirwadkar wrote:
> > On Sat, Feb 20, 2021 at 12:41 AM Zhiqiang Liu <liuzhiqiang26@huawei.com> wrote:
> > >
> > >
> > > In read_list func, if strtoull() fails in while loop,
> > > we will return the error code directly. Then, memory of
> > > variable lst will be leaked without setting to *list.
> > >
> > > Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> > > Signed-off-by: linfeilong <linfeilong@huawei.com>
> > > ---
> > >  debugfs/util.c | 12 ++++++++----
> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/debugfs/util.c b/debugfs/util.c
> > > index be6b550e..9e880548 100644
> > > --- a/debugfs/util.c
> > > +++ b/debugfs/util.c
> > > @@ -530,12 +530,16 @@ errcode_t read_list(char *str, blk64_t **list, size_t *len)
> > >
> > >                 errno = 0;
> > >                 y = x = strtoull(tok, &e, 0);
> > > -               if (errno)
> > > -                       return errno;
> > > +               if (errno) {
> > > +                       retval = errno;
> > > +                       break;
> > > +               }
> > Shouldn't we have `goto err;` here instead of break? strtoull failure
> > here indicates that no valid value was found, so instead of returning
> > the allocated memory, we should just free the memory and return error.
>
> As of commit 462c424500a5 ("debugfs: fix memory allocation failures
> when parsing journal_write arguments") there is no longer the err:
> goto target.  The goal is to move to a model where the caller is
> exclusively responsible for freeing any allocated memory, since if
> realloc() has gotten into the act, the memory pointed to in *list
> would have been freed by realloc().  The fix is to make sure *list is
> updated before we return.  This also allows the caller to have access
> to the list of numbers parsed before we ran into an error.
>
> So the Zhiqiang's patch is correc, and I will apply it.
>
>                                          - Ted
