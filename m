Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F88E2B728D
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 00:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgKQXi4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Nov 2020 18:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbgKQXiz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Nov 2020 18:38:55 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F4CC0617A7
        for <linux-ext4@vger.kernel.org>; Tue, 17 Nov 2020 15:38:54 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id e139so335251lfd.1
        for <linux-ext4@vger.kernel.org>; Tue, 17 Nov 2020 15:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PgbGhxXCXE3uvLAMGWkjJK4WmB/v6iS8EBQqNl2pLPI=;
        b=OBJfkgzQBj9kHYb1L6tM3RsVNEtxEjS8ET0Oh9YK0275YFj9QadFCAwWSCozN1QtCo
         +8Zz4vWkjpcxgMUMVDIsC7IboLPaOi0ADF1TZADraVsZmRwj/NsiImqyAR/KgSYJNR8X
         ueDXr5NVFB/NX7+PUdIQbuXJ0/Xn1IKQaTgwH0JlwVPOQ4U7BNCy8dygFfyfSFbzvMPj
         KNBOrDZJk2o+gWAICmNIT3BDdwL6xbmjbK4mnEg0HnMpBfrKjfO9/sARAlJuRLBusV0N
         +r735iTU1GwDxFrw8cviIxYPtfyPzaG3pqHLpRgNqOVbnYc1FdyiqF3KfAPDV2bJ3VxT
         v8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PgbGhxXCXE3uvLAMGWkjJK4WmB/v6iS8EBQqNl2pLPI=;
        b=R1fCBatTtdA+n3pDHKkKg2JlEaIS2nAqOZ4Iiw8gNMEu3Pw72Z6Csc4ll2QwPT3OOj
         dL8PxD4KpsoWML10CZG9yF0VtjHCO1ND0sumyve/Gi1J7q//7JkoQBlpqhl/r8Z6XFqB
         XnPy/+8z2rBaYrcOs+ajlpCTCm4HmDIQZ9uhpxUFXBGRxvNRfxdqThBIQd+wjieJ5V4Y
         uob9PsO8fSCaBs7TBcUotsuhUIfZL8NZfAKJ5noigZwCkbtJo8+MSUO0Gmrc5A7J74nX
         /jQkVRup9MtRLzb8SJ+E+Vsw1aXS4o+ZgUxdXGBCBiHYAN7o03FWhjQkWD04LS/WkTfc
         gynA==
X-Gm-Message-State: AOAM531hTrM8HhY7YWI7L7wt9aaVq4zn4EVRKrTReVXVXl8G1A/e+P+M
        tDOmzgBKyczvnvhdYVTX0DJPo+az+xEZ+PWyJifVzQ==
X-Google-Smtp-Source: ABdhPJyodrlIwxvXj9j6gGI51r9cXRj8xfoOFdh+vq78US7qyWBMu+ApjS1npnI+qftmyyjBQOFSWsXXnoO8nCD8tvg=
X-Received: by 2002:a19:e08:: with SMTP id 8mr2417659lfo.441.1605656332549;
 Tue, 17 Nov 2020 15:38:52 -0800 (PST)
MIME-Version: 1.0
References: <20201012220620.124408-1-linus.walleij@linaro.org> <20201013092240.GI32292@arm.com>
In-Reply-To: <20201013092240.GI32292@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Nov 2020 00:38:41 +0100
Message-ID: <CACRpkdZoMoUQX+CPd31qwjXSKJvaZ6=jcFvUrK_3hkxaUWJNJg@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] fcntl: Add 32bit filesystem mode
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Peter Maydell <peter.maydell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 13, 2020 at 11:22 AM Dave Martin <Dave.Martin@arm.com> wrote:

> >       case F_SETFD:
> >               err = 0;
> >               set_close_on_exec(fd, arg & FD_CLOEXEC);
> > +             if (arg & FD_32BIT_MODE)
> > +                     filp->f_mode |= FMODE_32BITHASH;
> > +             else
> > +                     filp->f_mode &= ~FMODE_32BITHASH;
>
> This seems inconsistent?  F_SETFD is for setting flags on a file
> descriptor.  Won't setting a flag on filp here instead cause the
> behaviour to change for all file descriptors across the system that are
> open on this struct file?  Compare set_close_on_exec().
>
> I don't see any discussion on whether this should be an F_SETFL or an
> F_SETFD, though I see F_SETFD was Ted's suggestion originally.

I cannot honestly say I know the semantic difference.

I would ask the QEMU people how a user program would expect
the flag to behave.

Yours,
Linus Walleij
