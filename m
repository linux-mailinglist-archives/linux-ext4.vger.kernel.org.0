Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF4D341A27
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Mar 2021 11:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCSKfz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Mar 2021 06:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhCSKfx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Mar 2021 06:35:53 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84DFC06174A;
        Fri, 19 Mar 2021 03:35:52 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id t18so7552765iln.3;
        Fri, 19 Mar 2021 03:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2XBRPFwO3mUryOuIcp1FSCaeNUh76Ms9fOWo+aL4IA=;
        b=RnjgkqRBk1CjzFHG+H7NbIwV63q6+VsQS9yuV1MvjbNj6x+CWhn+OrD6kdpmghj4ae
         UC+JPiU2Mr1cjhtzKa5veyPxB0Kdf8uRB21VH7dTRlw4LttE9SrP4a/WsMFxzGiZWGgH
         eRZf64DUTFqT67+IX7GGCrRBHMIcAdy3fF6LmA3MQ6tXdp4sGqfYFw/DE69pozfLdJ1A
         EP3+9nSUmY3aK/v58oTLqyMj0FH12dB1BmhpOxXAJRTPi8yvNULc+nA5caqhE45GDgWX
         G4oEeE1clP6cKHw/235tVL2Zhw+CzQ/eME+yh2yw2rtxveSAhAbxwkPp+P1QZRnTQyiv
         bomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2XBRPFwO3mUryOuIcp1FSCaeNUh76Ms9fOWo+aL4IA=;
        b=DZoQN/Zj7oiEcWcuTW23yY3z0ZlEa+Tvz5SjJnmw4cHOoj6AXvf1Qia454bKSXCf84
         RG9eZGV/Bff0L7TcpIhlUVLCRfkUAFU7i9ZjbXnmZtZVanaPTO2CU35fSb49WzGoHWZZ
         MemGU1A942cXjSeNnyCYLwLVFVXZYp+VI7SUDF/uRQWN8PdBi4nVc24J8crWjJeX9uNp
         5mdTlDuU4vjW4gNAV1bMaYDpUXK7OG7sprFvwew18ljEl/COYAQlXgpfC3CU3PxB4tda
         zo9ez6nOJ9Te+9yIAaZ6UyOfIee+8Qwj1E1dvV5I7vCHA19zsmn8HdEJ4jQsUahZhtQ/
         UuDg==
X-Gm-Message-State: AOAM5336UDxY5VnewDh8E9vDDwxqlpZIzy9185WlaRd70l1xRvVjvlmD
        wiTNHBOMWob0LJuDC5l4JDp/WlM7L4S9nr1jZE8=
X-Google-Smtp-Source: ABdhPJwf9+AbdFlQX+VJoXumFHuXZJmvB0EMwnQF8u3MJrTDGQtUZS6gAiFH4dwho9ZvO0fvUlDKCJtOtVZOs/oQwOw=
X-Received: by 2002:a92:c010:: with SMTP id q16mr2259173ild.250.1616150152167;
 Fri, 19 Mar 2021 03:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210316221921.1124955-1-harshadshirwadkar@gmail.com>
 <CAOQ4uxiD8WGLeSftqL6dOfz_kNp+YSE7qfXYG34Pea4j8G7CxA@mail.gmail.com>
 <CAD+ocbzMv6SyUUZFnBE0gTnHf8yvMFfq6Dm9rdnLXoUrh7gYkg@mail.gmail.com>
 <CAOQ4uxg+d2WoPEL2mC5H3d0uxh-_HGw3Bhyrun=z4O2nCg-yNQ@mail.gmail.com> <CAJfpeguiFU5qv-L-jeXBhc+PqeMOUoVnPO3EN4xOB0nCH9Z2cA@mail.gmail.com>
In-Reply-To: <CAJfpeguiFU5qv-L-jeXBhc+PqeMOUoVnPO3EN4xOB0nCH9Z2cA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 19 Mar 2021 12:35:40 +0200
Message-ID: <CAOQ4uxjcQWQ9n1rO7=js2SQ8-ZEbX2Wjvq-6ZGCyy5X5CJcTbw@mail.gmail.com>
Subject: Re: [PATCH] ext4: add rename whiteout support for fast commit
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Ext4 <linux-ext4@vger.kernel.org>, Theodore Tso <tytso@mit.edu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 19, 2021 at 10:36 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Fri, Mar 19, 2021 at 6:52 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > [adding overlayfs list]
> >
> > On Fri, Mar 19, 2021 at 3:32 AM harshad shirwadkar
> > <harshadshirwadkar@gmail.com> wrote:
> > >
> > > Thanks for the review Amir.
> > >
> > > Sure changing the subject makes sense.
> > >
> > > Also, on further discussions on Ext4 conference call, we also thought
> > > that with this patch, overlayfs customers would not benefit from fast
> > > commits much if they call renames often. So, in order to really make
> > > rename whiteout a fast commit compatible operation, we probably would
> > > need to add support in fast commit to replay a char device creation
> > > event (since whiteout object is a char device). That would imply, we
> > > would need to do careful versioning and would need to burn an on-disk
> > > feature flag.
> > >
> > > An alternative to this would be to have a static whiteout object with
> > > irrelevant nlink count and to have every rename point to that object
> > > instead. Based on how we decide to implement that, at max only the
> > > first rename operation would be fast commit incompatible since that's
> > > when this object would get created. All the further operations would
> > > be fast commit compatible. The big benefit of this approach is that
> > > this way we don't have to add support for char device creation in fast
> > > commit replay code and thus we don't have to worry about versioning.
> > >
> >
> > I'm glad to hear that, Harshad.
> >
> > Please note that creating a static whiteout object on-disk is one possible
> > implementation option. Not creating any object on-disk may be even better.
>
> I don't really get it.  What's the advantage of not having an object?
>
> Readdir returning DT_WHT internally might be nice, but I'd be careful
> with exporting that to userspace, since it's likely to cause more
> problems that it solves.   And on the stat(2) interface adding S_IFWHT
> or even worse: ENOENT are really out of the question due to backward
> incompatibility with almost every application.
>
> > One other challenge is how to handle users trying to make operations
> > on the upper layer directly (migrating images etc).
> > As long as the tools still observe the whiteout as a chadev (with stat(2))
> > then export and import should work fine (creating a real chardev on import).
>
> Right.
>
> Can't mkfs.ext4 just create the static object?  That sounds to me like
> the simplest approach.
>

Sure. I think that was the original intention and it is probably the easier way.

One thing that we will probably need to do is use the RENAME_WHITEOUT
interface as the explicit way to create the shared whiteout instead of using
vfs_whiteout() for filesystems that support RENAME_WHITEOUT
(we check for RENAME_WHITEOUT support anyway).

The only thing that bothered me in moving from per-ovl-instance singleton
to per-ext4-singleton is what happens if someone tries to (say) chown -R
the upper layer or some other offline modification that was working up to
now and seemed to make sense.

Surely, the ext4 singleton whiteout cannot allow modifications like that,
so what do we do about this? Let those scripts fail (if they exist) and
let their owners fix them to skip errors on whiteouts?

Thanks,
Amir.
