Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8F44502E7
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Nov 2021 11:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbhKOK7x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Nov 2021 05:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbhKOK7s (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Nov 2021 05:59:48 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FD2C061766
        for <linux-ext4@vger.kernel.org>; Mon, 15 Nov 2021 02:56:51 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r8so29709495wra.7
        for <linux-ext4@vger.kernel.org>; Mon, 15 Nov 2021 02:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PWwCW8mXVC/xZ6jkKVAjmXw3p7extKN8cI5Vy5wzrpg=;
        b=zTeGU0DGd+6H3acvrUE2XmrPSInU1UfGeLT82n0gAgOzIAUGvcaieXF8GUQEZPxBqK
         jvrks6SR/2vIKV7VKMe+TOnlfl7fE/HrQlg0Nx25nZp7hWCJen8zCaIO4V2UGmbYgmzl
         fXvaVjEtHMvAiLo9l0UUtcD8VYyyQaZSTrjpXo1ghMIL37QwgLF1Ml29n5wTR6OpdxZG
         hzT0HS0Obaphf+efyt4bLI+LncJ2uqyMsMNI5LM4WOHFRPhd+QqFi0zrxh5uNF8LrFQO
         yuAhU19+ib2k0jKfG6cZfQqc05M2xkl1lpoXdDhvAEqb6qJxry5Whz8oo77ZrM+GFZ7Z
         bsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PWwCW8mXVC/xZ6jkKVAjmXw3p7extKN8cI5Vy5wzrpg=;
        b=vmM4EBiwTxWNif0biEas8JWZOkzB4pS3pXJUoE49xFDl90d8oNGGRPGdpCVln/U8Cp
         OK3jHLKebTkPS8+tAYe5BmzCH9AR8xTlxvfm+TruDF5zi+5S8ncNw5xDRL49NRhcpwfY
         lRuCr/3MO+zmvafHRve6u9OIh4Zl+HGBzWJYAWDnYDDkizOMfv5Sp20JsmUXMBGhYqRU
         rRoDd4+jgAULfQlx9rvb51xrIl3wH99fD419rGEAA1zwUCrNREG8dRyj29HGYIWBNVHt
         yjrwlnGhTNBCZVdwB8SP3whC8bBkP2OcozJo18zg/SQDdJaphCz9Q/r2WMW/ocbGIOzu
         A8Bw==
X-Gm-Message-State: AOAM530I2ZeB2yQey3GwI4LQyL72wXMP1rkheERy21NuO7hFDZpFksSX
        l6b99jdizCVzsu6sXzy3fI9qQN45Kiy+0hWT4UhWDw==
X-Google-Smtp-Source: ABdhPJzLGB3NsTcTPq4kevF68H7VhflROSqzR9gvvsFeNbMe67/YJDWT0kS7qDrQbtICAWuFhf+uVoFXjda7cW+Oo68=
X-Received: by 2002:a5d:6da1:: with SMTP id u1mr46582938wrs.263.1636973809843;
 Mon, 15 Nov 2021 02:56:49 -0800 (PST)
MIME-Version: 1.0
References: <20201012220620.124408-1-linus.walleij@linaro.org>
 <20201013092240.GI32292@arm.com> <CACRpkdZoMoUQX+CPd31qwjXSKJvaZ6=jcFvUrK_3hkxaUWJNJg@mail.gmail.com>
In-Reply-To: <CACRpkdZoMoUQX+CPd31qwjXSKJvaZ6=jcFvUrK_3hkxaUWJNJg@mail.gmail.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Mon, 15 Nov 2021 10:56:39 +0000
Message-ID: <CAFEAcA9R3xc4PFZiojDZviFxeDFE0a9Ka=3okE3mt1c0NGc7MA@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] fcntl: Add 32bit filesystem mode
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 17 Nov 2020 at 23:38, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Oct 13, 2020 at 11:22 AM Dave Martin <Dave.Martin@arm.com> wrote:
>
> > >       case F_SETFD:
> > >               err = 0;
> > >               set_close_on_exec(fd, arg & FD_CLOEXEC);
> > > +             if (arg & FD_32BIT_MODE)
> > > +                     filp->f_mode |= FMODE_32BITHASH;
> > > +             else
> > > +                     filp->f_mode &= ~FMODE_32BITHASH;
> >
> > This seems inconsistent?  F_SETFD is for setting flags on a file
> > descriptor.  Won't setting a flag on filp here instead cause the
> > behaviour to change for all file descriptors across the system that are
> > open on this struct file?  Compare set_close_on_exec().
> >
> > I don't see any discussion on whether this should be an F_SETFL or an
> > F_SETFD, though I see F_SETFD was Ted's suggestion originally.
>
> I cannot honestly say I know the semantic difference.
>
> I would ask the QEMU people how a user program would expect
> the flag to behave.

Apologies for the very late response -- I hadn't noticed that
this thread had stalled out waiting for an answer to this,
and was only reminded of it recently when another QEMU user
ran into the problem that this kernel patch is trying to resolve.

If I understand the distinction here correctly, I think
QEMU wouldn't care about it in practice. We want the "32 bit readdir
offsets" behaviour on all file descriptors that correspond
to where we're emulating "the guest opened this file descriptor".
We don't want (but probably won't notice if we get) that behaviour
on file descriptors that QEMU has opened for its own purposes.
But we'll never open a file descriptor for the guest and then
dup it into one for QEMU's purposes. (I guess there might be
some weird unlikely-to-happen edge cases where an emulated
guest binary opens an fd for a directory and then passes it
via exec to a host binary: but even there I expect the host
binary wouldn't notice it was getting 32-bit hashes.)

But overall I think that the more natural behaviour would be that
it is per-file-descriptor.

-- PMM
