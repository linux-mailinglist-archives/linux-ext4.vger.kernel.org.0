Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A672CAFC4
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Dec 2020 23:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgLAWKR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Dec 2020 17:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgLAWKR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Dec 2020 17:10:17 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4ACC0617A7
        for <linux-ext4@vger.kernel.org>; Tue,  1 Dec 2020 14:09:36 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id u19so7783617lfr.7
        for <linux-ext4@vger.kernel.org>; Tue, 01 Dec 2020 14:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NlzQ03tqfinj27u0ebVErPykOI5l7u1KcSRGpfzmnog=;
        b=grs1bdMFiMi2UC6AirzN97SNSTI07zwIKQxT3gXBGfbm1Q1pMTqHMCgMPdIxa2y1dD
         o39Md9e46IkNVhdiEh24MuI+Z2DFzE9JyFX2jbrY7vKkYrewjZXI8H66gdSvYLqycGu0
         c/vv62fx8jZiuldnafqCg7hi1Dytmxs4/Shfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NlzQ03tqfinj27u0ebVErPykOI5l7u1KcSRGpfzmnog=;
        b=CCatNBzDX8eTum8idiBTXCja2UFRKApspDkD/SKpTAemFVs9x3RBk5rnrtOZdxiVYn
         mGA47lZbRnoks9PRH1t+YrJS2Mo39KEI717Z3dEQguefZeD2mPJORMWc4VGZEuWXvo9H
         Yi8B6LNt422RC7gcxMQhukaMx5afFYzpXX0eDvokcObux9M7RWJPbCwsUgy1TW2fMYrt
         2h242WgHRbloCwkukFdHHcmnvsDvIkesaENjA8atr5Zuvf/FgiEalKswrVIBuEXCvzco
         S3YQZ367Y4zudr+n0BBBDLRGnNCtMFtITFkVDUYcjPMOglxU/ljv1aBsQlN1FaaZQ5Xa
         lWug==
X-Gm-Message-State: AOAM530V62XTKtsM+miGDqFg8yWDmqcCm4OeVc9Rkudba0hDNJiUq6ET
        0yZPkaQM2i4IQXybxxozfhJsgM+8PsITcg==
X-Google-Smtp-Source: ABdhPJzx5uz2322MBjYRcaXWgvxCqwWNr6WaMaOUoGXNXS7DrThqPaY9GkDo9F1KoyysypqZqDqTjg==
X-Received: by 2002:ac2:483b:: with SMTP id 27mr2361988lft.551.1606860574520;
        Tue, 01 Dec 2020 14:09:34 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id c5sm120906lfg.84.2020.12.01.14.09.33
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 14:09:34 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id r18so5853291ljc.2
        for <linux-ext4@vger.kernel.org>; Tue, 01 Dec 2020 14:09:33 -0800 (PST)
X-Received: by 2002:a05:651c:339:: with SMTP id b25mr2418268ljp.285.1606860572738;
 Tue, 01 Dec 2020 14:09:32 -0800 (PST)
MIME-Version: 1.0
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <05a0f4fd-7f62-8fbc-378d-886ccd5b3f11@redhat.com> <CAHk-=wgOu9vgUfOSsjO3hHHxGDn4BKhitC_8XCfgmGKiiSm_ag@mail.gmail.com>
 <300456.1606856642@warthog.procyon.org.uk>
In-Reply-To: <300456.1606856642@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Dec 2020 14:09:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgB_e1anR0b4B5p3qxR9nq1-xrRponA6Q6WbGTOSFNmPw@mail.gmail.com>
Message-ID: <CAHk-=wgB_e1anR0b4B5p3qxR9nq1-xrRponA6Q6WbGTOSFNmPw@mail.gmail.com>
Subject: Re: [PATCH 2/2] statx: move STATX_ATTR_DAX attribute handling to filesystems
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Sandeen <sandeen@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoli Feng <xifeng@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 1, 2020 at 1:04 PM David Howells <dhowells@redhat.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > And if IS_DAX() is correct, then why shouldn't this just be done in
> > generic code? Why move it to every individual filesystem?
>
> One way of looking at it is that the check is then done for every filesystem -
> most of which don't support it.  Not sure whether that's a big enough problem
> to worry about.  The same is true of the automount test too, I suppose...

So I'd rather have it in one single place than spread out in the filesystems.

Especially when it turns out that the STATX_ATTR_DAX bitmask value was
wrong - now clearly it doesn't seem to currently *matter* to anything,
but imagine if we had to have some strange compat rule to fix things
up with stat() versioning or similar. That's exactly the kind of code
we would _not_ want in every filesystem.

So basically, the thing that argues against this patch is that it
seems to just duplicate things inside filesystems, when the VFS layter
already has the information.

Now, if the VFS information was possibly stale or wrong, that woudl be
one thing. But then we'd have other and bigger  problems elsewhere as
far as I can tell.

IOW - make generic what can be made generic, and try to avoid having
filesystems do their own thing.

[ Replace "filesystems" by "architectures" or whatever else, this is
obviously not a filesystem-specific rule in general. ]

And don't get me wrong - I don't _hate_ the patch, and I don't care
_that_ deeply, but it just doesn't seem to make any sense to me. My
initial query was really about "what am I missing - can you please
flesh out the commit message because I don't understand what's wrong".

                Linus
