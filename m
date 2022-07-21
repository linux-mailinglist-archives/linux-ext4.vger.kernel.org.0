Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F4C57D746
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 01:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiGUXNe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jul 2022 19:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGUXNd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jul 2022 19:13:33 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AB84E600;
        Thu, 21 Jul 2022 16:13:32 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id d187so2903688vsd.10;
        Thu, 21 Jul 2022 16:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VEm39c/KgOfoYMOeSll5ocVLqvVQCAlLbsYoDSKO20k=;
        b=FrLo4m53+ay2ODbgDWr3cpcxuaz2Hiamferz4XoN1Opj/yS1WJIioaY72QJVT+O2Qv
         tI8NG7v1jZ6uxgU6Cg+fweZWFueD5OrNpNXV0yZtVyy5tP60FkQgzWi2yf24WVv3ahno
         4eliJctBinJMxVrVCdaLr8Rf6noD/E4rwv2jXQTP0b8p5cYU8nspICkM+u1gmt4B6roz
         /nZPky00MsiLCZKrdV0rrDbnoo5O9LOQ5KsaUEvwP7uoRTZQQaoFuVZOkX0ms72dmBFM
         kV+O6gWSSPxhQD7Nscw8xi2NYw/MMOsFrAYI+jKW6MvRd/97sv3w5J5XottM/65Zfyng
         K33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VEm39c/KgOfoYMOeSll5ocVLqvVQCAlLbsYoDSKO20k=;
        b=7+gbxfl57jQNbVeGd0EU+z10K8y/8L7OgVLqcBTUZpaH1hGchZbJp80OqK3OC2Bmtg
         KBQ2dDgZUkmN6iH0dedhz8XmA8yMK9mJ9KJbUNeAttfiGugAMWl0hHJQwmoL+bWQFQwO
         7zy+zrevipjx+fYH5EKidD+dSOMEfePhoETalZETMVjlfzjLBhndoFvA+eXbFxkSmTiT
         fLsdtlyqjF4mLHYuh6QdYzhVJqkLAEqfAJ3zwYJDQs6G5wgvOrl7MfG0sX6vFpropLi/
         18KR7XAOnnY3OJjLNY8fWDga2C92jLzTygfnywYdWYpvIgaBshCKIR2DJzhC7QtJeLYD
         vv4A==
X-Gm-Message-State: AJIora+GR51VqZ66ziKvh6uZhiZU4Y17mxPA8tg8IMOPltfCE7718bq5
        A7CHtw/8scHvJ+i6zbVevZQsjNO+NFV/BWPkuiIGhjvukFqbxw==
X-Google-Smtp-Source: AGRyM1tstxWNsyxualcL85+eKvM/UwwiZUJYiIK2Dmx8csYRYvsI/n5EPa1s0YveYrl20uBht4nMw2zeoPzn7WZ+vVI=
X-Received: by 2002:a05:6102:3e23:b0:357:4974:e07e with SMTP id
 j35-20020a0561023e2300b003574974e07emr258330vsv.31.1658445211533; Thu, 21 Jul
 2022 16:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220720234512.354076-1-bongiojp@gmail.com> <YtiZ+gOmOFTpiAjW@magnolia>
In-Reply-To: <YtiZ+gOmOFTpiAjW@magnolia>
From:   Jeremy Bongio <bongiojp@gmail.com>
Date:   Thu, 21 Jul 2022 16:13:20 -0700
Message-ID: <CANfQU3w8yFpSC0=S4KSxG9g5pUCCRfAYdVgDr8Ey9c+Q7tovbw@mail.gmail.com>
Subject: Re: [PATCH v2] Add manpage for get/set fsuuid ioctl for ext4 filesystem.
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 20, 2022 at 5:12 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Wed, Jul 20, 2022 at 04:45:12PM -0700, Jeremy Bongio wrote:
> > Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
> > ---
> >
> > This is a ext4 filesystem specific ioctl. However, this ioctl will
> > likely be implemented for multiple filesystems at which point this
> > manpage will be updated.
> >
> >  man2/ioctl_fsuuid.2 | 115 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 115 insertions(+)
> >  create mode 100644 man2/ioctl_fsuuid.2
> >
> > diff --git a/man2/ioctl_fsuuid.2 b/man2/ioctl_fsuuid.2
> > new file mode 100644
> > index 000000000..53747684f
> > --- /dev/null
> > +++ b/man2/ioctl_fsuuid.2
> > @@ -0,0 +1,115 @@
> > +.\" Copyright (c) 2022 Google, Inc., written by Jeremy Bongio <bongiojp@gmail.com>
> > +.\"
> > +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> > +.TH IOCTL_FSUUID 2 2022-07-20 "Linux" "Linux Programmer's Manual"
> > +.SH NAME
> > +ioctl_fsuuid \- get or set an ext4 filesystem uuid
> > +.SH LIBRARY
> > +Standard C library
> > +.RI ( libc ", " \-lc )
>
> I'm not sure if libc will actually wrap this one, they often won't do
> that for ioctls.
>
> > +.SH SYNOPSIS
> > +.nf
> > +.B #include <sys/ioctl.h>
> > +.PP
> > +.BI "int ioctl(int " fd ", EXT4_IOC_GETFSUUID, struct " fsuuid ");"
> > +.BI "int ioctl(int " fd ", EXT4_IOC_SETFSUUID, struct " fsuuid ");"
> > +.fi
> > +.SH DESCRIPTION
> > +If an ext4 filesystem supports uuid manipulation, these
> > +.BR ioctl (2)
> > +operations can be used to get or set the uuid for the ext4 filesystem
> > +on which
> > +.I fd
> > +resides.
> > +.PP
> > +The argument to these operations should be a pointer to a
> > +.IR "struct fsuuid" ":"
> > +.PP
> > +.in +4n
> > +.EX
> > +struct fsuuid {
> > +       __u32 fsu_len;      /* Number of bytes in a uuid */
> > +       __u32 fsu_flags;    /* Mapping flags */
> > +       __u8  fsu_uuid[];   /* Byte array for uuid */
> > +};
> > +.EE
> > +.PP
> > +The
> > +.I fsu_flags
> > +field must be set to 0.
>
> Nit: whitespace at the end of the line.
>
> > +.PP
> > +If an
> > +.BR EXT4_IOC_GETFSUUID
> > +operation is called with
> > +.I fsu_len
> > +set to 0,
> > +.I fsu_len
> > +will be reassigned the number of bytes in an ext4 filesystem uuid
>
> "...will be set to the number of bytes..." ?
>
> > +and the return code will be -EINVAL.
> > +.PP
> > +If an
> > +.BR EXT4_IOC_GETFSUUID
> > +operation is called with
> > +.I fsu_len
> > +set to the number of bytes in an ext4 filesystem uuid and
> > +.I fsu_uuid
> > +is allocated at least that many bytes, then
> > +the filesystem uuid will be written to
> > +.I fsu_uuid.
>
> Hm.  It's not like the kernel actually checks the allocation -- if
> fsu_len is set to the length of the filesystem's volume uuid, then
> the that volume uuid will be written to fsu_uuid[].  How about:
>
> "If EXT4_IOC_GETFSUUID is called with fsu_len matching the length of the
> ext4 filesystem uuid, then that uuid will be written to fsu_uuid[] and
> the return value will be zero.
> If fsu_len does not match, the return value will be -EINVAL."
>
> > +.PP
> > +If an
> > +.BR EXT4_IOC_SETFSUUID
> > +operation is called with
> > +.I fsu_len
> > +set to the number of bytes in an ext4 filesystem uuid and
> > +.I fsu_uuid
> > +contains a uuid with
>
> Nit: whitespace at EOL.
>
> > +.I fsu_uuid
> > +bytes, then
> > +the filesystem uuid will be set to
> > +.I fsu_uuid.
>
> "If EXT4_IOC_SETFSUUID is called with fsu_len matching the length of the
> ext4 filesystem uuid, then the filesystem uuid will be set to the
> contents of fsu_uuid[] and the return value will reflect the outcome of
> the update operation.
> If fsu_len does not match, the return value will be -EINVAL."
>
> > +.PP
> > +The
> > +.B FS_IOC_SETFSUUID
> > +operation requires privilege
> > +.RB ( CAP_SYS_ADMIN ).
> > +If the filesystem is currently being resized, an
> > +.B EXT4_IOC_SETFSUUID
> > +operation will wait until the resize is finished and the uuid can safely be set.
> > +This may take a long time.
>
> Why is resize called out here specifically?  Won't setfsuuid block on
> /any/ operation that has tied up the filesystem superblocks?  I think
> this could be more general:
>
> "If the filesystem is busy, an EXT4_IOC_SETFSUUID operation will wait
> until it can apply the uuid changes.
> This may take a long time."
>
> > +.PP
> > +.SH RETURN VALUE
> > +On success zero is returned.
> > +On error, \-1 is returned, and
> > +.I errno
> > +is set to indicate the error.
> > +.SH ERRORS
> > +Possible errors include (but are not limited to) the following:
> > +.TP
> > +.B EFAULT
> > +Either the pointer to the
> > +.I fsuuid
> > +structure is invalid or
> > +.I fsu_uuid
> > +has not been initialized properly.
>
> Invalid?  Isn't that what EINVAL is for?
>
> I think EFAULT is for "could not copy to/from userspace".
>
> > +.TP
> > +.B EINVAL
> > +The specified arguments are invalid.
> > +.I fsu_len
> > +did not match the filesystem uuid length or
> > +.I fsu_flags
> > +has bits set that are not implemented.
>
> "...not recognized."
>
> If they're not implemented, shouldn't that be EOPNOTSUPP?

I see some ioctls that use EINVAL when an ioctl's flag is not recognized,
but yes, EOPNOTSUPP looks more common.

>
> --D
>
> > +.TP
> > +.B ENOTTY
> > +The filesystem does not support the ioctl.
> > +.TP
> > +.B EOPNOTSUPP
> > +The filesystem does not currently support changing the uuid through this
> > +ioctl. This may be due to incompatible feature flags.
> > +.TP
> > +.B EPERM
> > +The calling process does not have sufficient permissions to set the uuid.
> > +.SH CONFORMING TO
> > +This API is Linux-specific.
> > +.SH SEE ALSO
> > +.BR ioctl (2)
> > --
> > 2.37.0.170.g444d1eabd0-goog
> >
