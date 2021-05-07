Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A3F376893
	for <lists+linux-ext4@lfdr.de>; Fri,  7 May 2021 18:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbhEGQXi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 May 2021 12:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbhEGQXh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 May 2021 12:23:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF8FC061574
        for <linux-ext4@vger.kernel.org>; Fri,  7 May 2021 09:22:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id n15so6273172edw.8
        for <linux-ext4@vger.kernel.org>; Fri, 07 May 2021 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EK8C3eLLCqVzkewkDe363DVBUf8lJyQzx2wasTTuUsA=;
        b=p+KXtU+d3ZwvZqRkFzth7VcgK5pvfNqrgm7OO37c6y/PEeDiVkKxsozWetL9BIypFh
         +IhVXEIKd+2u24i0wrUJceSe5viSbkLVaANlBYRAA4y/vpVkNIpECgQwB87nOPnVPfS2
         NVhJziW+pVWdMJPVn2VKF0qVtxHm+4yKVgOaEnYtqI6ociyOjDpAIAS4Uk8N+TAjfwuk
         nQYs6u8CEOB4qChniuteDHUwG8B9fnXHITQJs/db3HJvoPkzxt14dJil32toMzRywXHP
         Wv1UB9xizZ7C30M/Cr09owEUo+spKT7+4l6YlXe0QR0Cn0zP7oUV5/AleEvT014YLJgG
         IuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EK8C3eLLCqVzkewkDe363DVBUf8lJyQzx2wasTTuUsA=;
        b=NHRFuaW9UHnNQUjkzIA25ci+jj09opFcsx51Fc18K5oEGGaOYyFaDvDJLeLDw2cQZX
         h/i7AH+ANFQavvq98QLkndsL8o6hzPDZDbmCXgwX6bgGd/yLLzxC+IOB/Z5gkGr5E8/m
         0LvhXupT9M1gAkwjfUmF2+4CvvGQb3WMFCYYKAYOJYCtW//0xS374IsVHGHy/VuoaqFj
         TjWlSzsDKLk8IzWq6h84DmfqWeBrWDHl5mlYVX4YPVfVeSaSoXvN/EdNYxaYuptJqiby
         b87q/ORujF/Q+a0gc95fhQaizFROh3mMEXNBWfikekFd4A+n9Rp8HCldrpx9nspvcVFU
         yPSw==
X-Gm-Message-State: AOAM533PAnx/FiL4ZXlhjmY9Mqk3u0QqIBbPdk8AfI+kHSwQ7aAccxzY
        uw0XFuzOx0YyEYgDWR7wiqVdTTl1INN3b5xAdo8=
X-Google-Smtp-Source: ABdhPJzyHcgSqWgN3d3YLlJq7V6/GTe55FKkgVwwje5iLj+xxF/IfyDc6WXW/UDsLgczvVy6OeEEGJQ1jxHNIpBz8Do=
X-Received: by 2002:a05:6402:2d6:: with SMTP id b22mr12483931edx.274.1620404556411;
 Fri, 07 May 2021 09:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210504163550.1486337-1-leah.rumancik@gmail.com>
 <20210504163550.1486337-2-leah.rumancik@gmail.com> <20210505212711.GA8532@magnolia>
 <20210505220844.GD8532@magnolia> <20210506155853.GF8532@magnolia> <YJQy/DfuCFyZdwe7@google.com>
In-Reply-To: <YJQy/DfuCFyZdwe7@google.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 7 May 2021 09:22:24 -0700
Message-ID: <CAD+ocbwK9v=ky+bBtMuVMP+zDNYnTSO2DjPZ4sE1AnYw8iEmew@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ext4: add ioctl EXT4_IOC_CHECKPOINT
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> > > > > +               err = jbd2_journal_flush(EXT4_SB(sb)->s_journal,
> > >
> > > Huh.  So we don't flush the filesystem at all, just the journal?  I
> > > don't see anything in the documentation saying that syncfs() is a
> > > prerequisite.
>
> This is just for the journal, good point, I'll update the documentation.
It just occurred to me this morning that we need to ensure that a
*full* commit happens before IOC_CHECKPOINT and not a *fast* commit.
Fast commits cannot be checkpointed, they rely on full commits for
checkpoint operation. So, if a syncfs call results in a fast commit,
the following sequence of events will happen:

* Ext4 writes fast commit information in fast commit area

* When user calls EXT4_IOC_CHECKPOINT, the checkpoint operation would
result in checkpointing everything in the main journal, except things
written in fast commit area

* During the discard phase of EXT4_IOC_CHECKPOINT, fast commit area
will be discarded and thus we'll lose the log updates present in the
fast commit area

However, this isn't a problem today. Syncfs doesn't result in a fast
commit but results in a full commit. But, that can change at some
point in the future. So, unless we can either come up with syncfs()
variant that can induce a full commit (which would be a little ugly -
I don't think the user needs to know what kind of journal commit file
system is doing) or add checkpointing support in fast commits, we
should just do a full commit from the IOCTL code.

- Harshad
