Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D1728C5A5
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Oct 2020 02:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgJMA1u (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Oct 2020 20:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgJMA1u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Oct 2020 20:27:50 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394C2C0613D0
        for <linux-ext4@vger.kernel.org>; Mon, 12 Oct 2020 17:27:50 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id t25so25744384ejd.13
        for <linux-ext4@vger.kernel.org>; Mon, 12 Oct 2020 17:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4Wttd+A0+DB1q6HUUXbh8k60Zb40tfW6j7k43/5AOA=;
        b=fNi2em0VhNuNBPw5iO5eniJSHBEFpvlalBslHWLsna2DNWo1app6SJIfEgoXRjzjwR
         0ykrtTwiDQPrJ/jDmXHyxgatUWrje/8rIGqc+1EH4d5VdAYLMSbn1ci7SvqYOnw2Su4o
         QZrUqXSLZA10OM0HyhR2GoOz/2jbrkfE0j7qQdQl/FYlOn+/mL6+gKa+mzYNgNLbn5uQ
         8zyk3GalwM47YkKfIOYhDGDgZXNqReeovZxqufq3MzwCB/uiLpgGP2jqUrBwGv6Fs0g6
         FBLHoehH6i2KFmBqeFq+knrVnqWi9Zr/dVTQbxEqKUu89FNDptF0KYOuw45uWAa2Voje
         CrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4Wttd+A0+DB1q6HUUXbh8k60Zb40tfW6j7k43/5AOA=;
        b=U4fCdCj5IV1kG/nPJm1W+ucygLLRJyyDFwiO5o+HWTR9JRrICWQw++Q1XwucliNitE
         arFatiZFHl7chiJWJgabcXw4JVLy6k/0Bs10rJnA/hlWznKPtCo6XA4DRtdrnCD9ZVEA
         yw58vV1hZmqhohUNa90DnMo5JfS9G809jzLTF5T6Szk/n7oiU5QisFFf3RiodPmMM7Zg
         vX8u/71tiQyprEUt1HiUBGvR/L16QYGpnpDc1WGxrI/6hmXt+2UoFSoPSEeY2NL+T4IM
         0Llxg37/quxzB/m/3rxEkq6Nm6/4kUlAX95vwth1/5EJ4YmNLKq65eBUe4T7fjX0xIf5
         XUsQ==
X-Gm-Message-State: AOAM531/OFF3yAfsTn98s26jg7Er94fBe1DVSGo4npNPPdL3x9nUcDec
        0bl6ct6cKTYtdKvfKzhqcpMqD7pOh7M9wSukgKSBvVj+lG0=
X-Google-Smtp-Source: ABdhPJzpIR4V07VI97JWgO/3ILUKzNAjTijc8zUZsRAMlSw08bnhi3R9iZBLoSIX8vUvsp3SfNrPaqpfUjsEZZ3f/Ng=
X-Received: by 2002:a17:906:bc98:: with SMTP id lv24mr30385392ejb.545.1602548868870;
 Mon, 12 Oct 2020 17:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
 <20200919005451.3899779-2-harshadshirwadkar@gmail.com> <20201009182835.GN235506@mit.edu>
In-Reply-To: <20201009182835.GN235506@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 12 Oct 2020 17:27:37 -0700
Message-ID: <CAD+ocbyZ7mb=xZDbpQNdCyn5e6FT6pBMsGjZvN9O+=4d+f2F8w@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] doc: update ext4 and journalling docs to include
 fast commit feature
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 9, 2020 at 11:28 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Sep 18, 2020 at 05:54:43PM -0700, Harshad Shirwadkar wrote:
> > This patch adds necessary documentation for fast commits.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > ---
> >  Documentation/filesystems/ext4/journal.rst | 66 ++++++++++++++++++++++
> >  Documentation/filesystems/journalling.rst  | 28 +++++++++
> >  2 files changed, 94 insertions(+)
> >
> > diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
> > index ea613ee701f5..c2e4d010a201 100644
> > --- a/Documentation/filesystems/ext4/journal.rst
> > +++ b/Documentation/filesystems/ext4/journal.rst
> > @@ -609,3 +620,58 @@ bytes long (but uses a full block):
> >       - h\_commit\_nsec
> >       - Nanoseconds component of the above timestamp.
> >
> > +Fast commits
> > +~~~~~~~~~~~~
> > +
> > +Fast commit area is organized as a log of tag tag length values. Each TLV has
>
> s/tag tag/tag/
ack
>
> > +
> > +File system is free to perform fast commits as and when it wants as long as it
> > +gets permission from JBD2 to do so by calling the function
> > +:c:func:`jbd2_fc_start()`. Once a fast commit is done, the client
> > +file  system should tell JBD2 about it by calling :c:func:`jbd2_fc_stop()`.
> > +If file system wants JBD2 to perform a full commit immediately after stopping
> > +the fast commit it can do so by calling :c:func:`jbd2_fc_stop_do_commit()`.
> > +This is useful if fast commit operation fails for some reason and the only way
> > +to guarantee consistency is for JBD2 to perform the full traditional commit.
>
> One of the things which is a bit confusing is that there is a
> substantial part of the fast commit functionality which is implemented
> in ext4, and not in the jbd2 layer.
>
> We can't just talk about ext4_fc_start_update() and
> ext4_fc_stop_update() here, since it would be a vit of a layering
> violation.  But some kind of explanation of how a file system would
> use the jbd2 fast commit framework would be useful, and the big
> picture view of how the ext4 fast commit infrastruction (which is
> currently documented in the top-level comments of
> fs/ext4/fast_commit.c) fit into jbd2 infrastructure.
As we discussed offline, the names "jbd2_fc_start()" and
"jbd2_fc_stop()" are kind of confusing. I didn't mean to put any Ext4
specific information here and it sounds like the names
"jbd2_fc_start/stop()" should be renamed to something like
jbd2_fc_begin_commit() and jbd2_fc_end_commit(). My goal is to add
documentation here that explains how a client FS can use JBD2 fast
commits.
>
> Maybe put the big picture explanation in fs/ext4/fast_commit.c and
> then put a pointer in journaling.rst to the comments in
> fs/ext4/fast_commit.c as an example of how the jbd2 fast_commit
> infrastructure would get used (for example, if ocfs2 ever got
> interested in doing something similar)?  Or maybe we need to move some
> of the description from comments in fast_commit.c to a file in
> Documentation/filesystems/ext4/fast_commit.rst, perhaps?
I like the first option. I'll update the docs accordingly in V10.

Thanks,
Harshad.
>
>                                                 - Ted
