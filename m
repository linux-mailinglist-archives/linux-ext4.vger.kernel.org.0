Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F3857D2FF
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jul 2022 20:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiGUSMX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jul 2022 14:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGUSMW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jul 2022 14:12:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5439A31385;
        Thu, 21 Jul 2022 11:12:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E336661F93;
        Thu, 21 Jul 2022 18:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B154C3411E;
        Thu, 21 Jul 2022 18:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658427140;
        bh=5nTWpDRIopP+J/Wzcq+D+bUTThpaXXKcFMiclbj+jiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nmLNKCsu5n53a2HbQWxj67VEwv4KFKHDcvzNRC5/itaC+pjlB6ekLsZnZ1DYnoSfX
         IEjRbpEYbEFmNq3EVHTGSUTK7+xYhEZaiXLIqTzF26yMfAsV7jdFJh+5w2ZMHu0uaU
         mCdasYUHb0AVIVPuwoWVM2W9FahS24RLRPZkA1tufwAshWrAMTQ4yvtvmcaADlgsBQ
         bdAgdPS43yzl35Bll4o0tq/uwVTpFd34VQPQfQyzwgga4Ck7WT9EjjqtacXapF/36o
         JuKDuK9ABrTPqL5giKVsS3dyHtrYSBd+TI/vk/qkCbQH6HT9z9rXhsg96PYlHRe4SV
         s8YKm0HyCqtIg==
Date:   Thu, 21 Jul 2022 11:12:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Jeremy Bongio <bongiojp@gmail.com>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH v2] Add manpage for get/set fsuuid ioctl for ext4
 filesystem.
Message-ID: <YtmXAyoF2PXstnLY@magnolia>
References: <20220720234512.354076-1-bongiojp@gmail.com>
 <YtiZ+gOmOFTpiAjW@magnolia>
 <e503645b-e665-50c4-37a9-cdc8637ba1d8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e503645b-e665-50c4-37a9-cdc8637ba1d8@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 21, 2022 at 03:04:23PM +0200, Alejandro Colomar wrote:
> Hi Jeremy and Darrick,
> 
> On 7/21/22 02:12, Darrick J. Wong wrote:
> > On Wed, Jul 20, 2022 at 04:45:12PM -0700, Jeremy Bongio wrote:
> > > Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
> > > ---
> > > 
> > > This is a ext4 filesystem specific ioctl. However, this ioctl will
> > > likely be implemented for multiple filesystems at which point this
> > > manpage will be updated.
> > > 
> > >   man2/ioctl_fsuuid.2 | 115 ++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 115 insertions(+)
> > >   create mode 100644 man2/ioctl_fsuuid.2
> > > 
> > > diff --git a/man2/ioctl_fsuuid.2 b/man2/ioctl_fsuuid.2
> > > new file mode 100644
> > > index 000000000..53747684f
> > > --- /dev/null
> > > +++ b/man2/ioctl_fsuuid.2
> > > @@ -0,0 +1,115 @@
> > > +.\" Copyright (c) 2022 Google, Inc., written by Jeremy Bongio <bongiojp@gmail.com>
> > > +.\"
> > > +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> > > +.TH IOCTL_FSUUID 2 2022-07-20 "Linux" "Linux Programmer's Manual"
> > > +.SH NAME
> > > +ioctl_fsuuid \- get or set an ext4 filesystem uuid
> > > +.SH LIBRARY
> > > +Standard C library
> > > +.RI ( libc ", " \-lc )
> > 
> > I'm not sure if libc will actually wrap this one, they often won't do
> > that for ioctls.
> 
> Actually, we also specify libc for syscalls without a wrapper (e.g., see
> membarrier(2)).  That rationale is that you need libc even if you use
> syscall(SYS_membarrier, ...), since syscall(2) is provided by libc.
> 
> However, there's a difference in the synopsis:
> If syscall(2) needs to be used to call the syscall, we document it as such.
> Again, see membarrier(2) for an example of how we document that.

I understand that manpages for system calls that don't have a libc
wrapper document the use of syscall(SYS_fubar...) to call them.  But
this is an ioctl, not a kernel system call that has no convenient libc
wrapper.  ioctl(2) has been part of the Unix programming manual since
1979 or so, and it's been in Linux since v0.99.  I think we can take for
granted that programmers can figure out 'man -s2 ioctl' if we tell them
to.

> > 
> > > +.SH SYNOPSIS
> > > +.nf
> > > +.B #include <sys/ioctl.h>
> > > +.PP
> > > +.BI "int ioctl(int " fd ", EXT4_IOC_GETFSUUID, struct " fsuuid ");"
> > > +.BI "int ioctl(int " fd ", EXT4_IOC_SETFSUUID, struct " fsuuid ");"
> 
> Can we use ioctl(2), or do we need syscall(SYS_ioctl, ...)?

So yes, technically an ioctl_XXX manpage should document the fact that
it depends on the existence of an ioctl(fd, number, param...) call, and
that in turn depends on syscall(SYS_ioctl, fd, number, param...) if
somehow ioctl() itself is not available and that in turn depends on
using any of the usual Linux C libraries, but this seems very pedantic
to repeat that for every single ioctl manpage in existence.

IOWS, I think we can take for granted that most C programmers on Linux
are working with a conventional C library, so it's sufficient to put:

SEE ALSO
	ioctl(2)

at the end of an ioctl_XXX manpage like this one.

> 
> > > +.fi
> > > +.SH DESCRIPTION
> > > +If an ext4 filesystem supports uuid manipulation, these
> > > +.BR ioctl (2)
> > > +operations can be used to get or set the uuid for the ext4 filesystem
> > > +on which
> > > +.I fd
> > > +resides.
> > > +.PP
> > > +The argument to these operations should be a pointer to a
> > > +.IR "struct fsuuid" ":"
> > > +.PP
> > > +.in +4n
> > > +.EX
> > > +struct fsuuid {
> 
> Would you consider documenting the type separate manual page?
> See for example man2/open_how.2type and man3/tm.3type.

Why?  There's only one user of this struct, there's no need to waste
people's time making them look up the third ioctl argument in a separate
manpage.  If some other ioctl/syscall/whatever wants to start using
struct fsuuid then yes, this should be hoisted to a separate file so
that both manpages can reference it.

> > > +       __u32 fsu_len;      /* Number of bytes in a uuid */
> > > +       __u32 fsu_flags;    /* Mapping flags */
> > > +       __u8  fsu_uuid[];   /* Byte array for uuid */
> 
> We use 4-space indents for code.
> 
> > > +};
> > > +.EE
> > > +.PP
> > > +The
> > > +.I fsu_flags
> > > +field must be set to 0.
> > 
> > Nit: whitespace at the end of the line.
> > 
> > > +.PP
> > > +If an
> > > +.BR EXT4_IOC_GETFSUUID
> > > +operation is called with
> > > +.I fsu_len
> > > +set to 0,
> > > +.I fsu_len
> > > +will be reassigned the number of bytes in an ext4 filesystem uuid
> > 
> > "...will be set to the number of bytes..." ?
> > 
> > > +and the return code will be -EINVAL.
> > > +.PP
> > > +If an
> > > +.BR EXT4_IOC_GETFSUUID
> > > +operation is called with
> > > +.I fsu_len
> > > +set to the number of bytes in an ext4 filesystem uuid and
> > > +.I fsu_uuid
> > > +is allocated at least that many bytes, then
> > > +the filesystem uuid will be written to
> > > +.I fsu_uuid.
> > 
> > Hm.  It's not like the kernel actually checks the allocation -- if
> > fsu_len is set to the length of the filesystem's volume uuid, then
> > the that volume uuid will be written to fsu_uuid[].  How about:
> > 
> > "If EXT4_IOC_GETFSUUID is called with fsu_len matching the length of the
> > ext4 filesystem uuid, then that uuid will be written to fsu_uuid[] and
> > the return value will be zero.
> > If fsu_len does not match, the return value will be -EINVAL."
> > 
> > > +.PP
> > > +If an
> > > +.BR EXT4_IOC_SETFSUUID
> > > +operation is called with
> > > +.I fsu_len
> > > +set to the number of bytes in an ext4 filesystem uuid and
> > > +.I fsu_uuid
> > > +contains a uuid with
> > 
> > Nit: whitespace at EOL.
> > 
> > > +.I fsu_uuid
> > > +bytes, then
> > > +the filesystem uuid will be set to
> > > +.I fsu_uuid.
> > 
> > "If EXT4_IOC_SETFSUUID is called with fsu_len matching the length of the
> > ext4 filesystem uuid, then the filesystem uuid will be set to the
> > contents of fsu_uuid[] and the return value will reflect the outcome of
> > the update operation.
> > If fsu_len does not match, the return value will be -EINVAL."
> > 
> > > +.PP
> > > +The
> > > +.B FS_IOC_SETFSUUID
> > > +operation requires privilege
> > > +.RB ( CAP_SYS_ADMIN ).
> > > +If the filesystem is currently being resized, an
> > > +.B EXT4_IOC_SETFSUUID
> > > +operation will wait until the resize is finished and the uuid can safely be set.
> > > +This may take a long time.
> > 
> > Why is resize called out here specifically?  Won't setfsuuid block on
> > /any/ operation that has tied up the filesystem superblocks?  I think
> > this could be more general:
> > 
> > "If the filesystem is busy, an EXT4_IOC_SETFSUUID operation will wait
> > until it can apply the uuid changes.
> > This may take a long time."
> > 
> > > +.PP
> > > +.SH RETURN VALUE
> > > +On success zero is returned.
> > > +On error, \-1 is returned, and
> > > +.I errno
> > > +is set to indicate the error.
> > > +.SH ERRORS
> > > +Possible errors include (but are not limited to) the following:
> > > +.TP
> > > +.B EFAULT
> > > +Either the pointer to the
> > > +.I fsuuid
> > > +structure is invalid or
> > > +.I fsu_uuid
> > > +has not been initialized properly.
> > 
> > Invalid?  Isn't that what EINVAL is for?
> > 
> > I think EFAULT is for "could not copy to/from userspace".
> > 
> > > +.TP
> > > +.B EINVAL
> > > +The specified arguments are invalid.
> > > +.I fsu_len
> > > +did not match the filesystem uuid length or
> > > +.I fsu_flags
> > > +has bits set that are not implemented.
> > 
> > "...not recognized."
> > 
> > If they're not implemented, shouldn't that be EOPNOTSUPP?
> > 
> > --D
> > 
> > > +.TP
> > > +.B ENOTTY
> > > +The filesystem does not support the ioctl.
> > > +.TP
> > > +.B EOPNOTSUPP
> > > +The filesystem does not currently support changing the uuid through this
> > > +ioctl. This may be due to incompatible feature flags.
> 
> Please see the following paragraph from man-pages(7):
>    Use semantic newlines
>        In the source of a manual page, new sentences  should  be
>        started on new lines, long sentences should be split into
>        lines  at  clause breaks (commas, semicolons, colons, and
>        so on), and long clauses should be split at phrase bound‐
>        aries.  This convention,  sometimes  known  as  "semantic
>        newlines",  makes it easier to see the effect of patches,
>        which often operate at the level of individual sentences,
>        clauses, or phrases.

Agreed.

--D

> 
> Cheers,
> 
> Alex
> 
> 
> > > +.TP
> > > +.B EPERM
> > > +The calling process does not have sufficient permissions to set the uuid.
> > > +.SH CONFORMING TO
> > > +This API is Linux-specific.
> > > +.SH SEE ALSO
> > > +.BR ioctl (2)
> > > -- 
> > > 2.37.0.170.g444d1eabd0-goog
> > > 
