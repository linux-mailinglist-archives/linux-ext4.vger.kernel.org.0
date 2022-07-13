Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AF5572AD5
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Jul 2022 03:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiGMBaV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Jul 2022 21:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiGMBaU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Jul 2022 21:30:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74165C48DF
        for <linux-ext4@vger.kernel.org>; Tue, 12 Jul 2022 18:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BE20B81C94
        for <linux-ext4@vger.kernel.org>; Wed, 13 Jul 2022 01:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC4AC3411C;
        Wed, 13 Jul 2022 01:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657675816;
        bh=idXIfB4AZj4nTcBIkZUwPDS4pQByMRfyU8iVPc8jYDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfB2pIXx7Zm2Zsdfv52Eop8fBajNTSMffhViF/NLVn9LqA4eLa/uqt1A3Yq3RxW9f
         tD4RgBIiueovIctNgD4ty1dAZkx4nWjnjtD3vqIVKlKHHrKZc/jQXHtHqJtiU8ORDy
         iChd2W2pgpv9ulQflh8eMcVl4HrEGrqRc+ebPuqDMiHVsWZljGUf9xxhwzKaqyWCnq
         mGHgYKZ7U5QAGknTsSUbLSElBmZ3xKq85Bp50avdoFu58mMPek/EHYw/+T+RaXQ2gn
         J+7y6XRMZ03a2i1OwL7bkB3ARUfU1eXZN+vI4rHp9pfuGQJwLa5CD/ek89ssmT6qEs
         hmvxFJ1I2tlDg==
Date:   Tue, 12 Jul 2022 18:30:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeremy Bongio <bongiojp@gmail.com>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] Add manpage for get/set fsuuid ioctl.
Message-ID: <Ys4gKDDlPtOYvev0@magnolia>
References: <20220712225653.536984-1-bongiojp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712225653.536984-1-bongiojp@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 12, 2022 at 03:56:53PM -0700, Jeremy Bongio wrote:
> This manpage written for the case where xfs or other filesystems will
> implement the same ioctl.

You might want to cc the manpages project (linux-man@vger.kernel.org),
since this is likely to end up in there some day.

> Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
> ---
>  man2/ioctl_fsuuid.2 | 110 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 man2/ioctl_fsuuid.2
> 
> diff --git a/man2/ioctl_fsuuid.2 b/man2/ioctl_fsuuid.2
> new file mode 100644
> index 000000000..db414bf59
> --- /dev/null
> +++ b/man2/ioctl_fsuuid.2
> @@ -0,0 +1,110 @@
> +.\" Copyright (c) 2022 Google, Inc., written by Jeremy Bongio <bongiojp@gmail.com>
> +.\"
> +.\" SPDX-License-Identifier: GPL-2.0-or-later
> +.TH IOCTL_FSUUID 2 2022-07-08 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +ioctl_fsuuid \- get or set a filesystem label
> +.SH LIBRARY
> +Standard C library
> +.RI ( libc ", " \-lc )
> +.SH SYNOPSIS
> +.nf
> +.BR "#include <linux/fs.h>" "      /* Definition of " *FSLABEL* " constants */"
> +.BR "#include <uuid/uuid.h>" "     /* Definition of " *UUID_MAX* " constants */"

Hmm... that's in libuuid, and not everyone's going to want to link with
that.  You might consider defining EXT4_UUID_SIZE in the same place as
the ioctl definitions, or putting it in libext2fs somewhere.

> +.B #include <sys/ioctl.h>
> +.PP
> +.BI "int ioctl(int " fd ", FS_IOC_GETFSUUID, struct " fsuuid ");"
> +.BI "int ioctl(int " fd ", FS_IOC_SETFSUUID, struct " fsuuid ");"
> +.fi
> +.SH DESCRIPTION
> +If a filesystem supports online uuid manipulation, these

No need to say 'online', ioctls don't work on unmounted filesystems.

> +.BR ioctl (2)
> +operations can be used to get or set the uuid for the filesystem
> +on which
> +.I fd
> +resides.
> +.PP
> +The
> +.B FS_IOC_GETFSUUID
> +operation will read the filesystem uuid into
> +.I fu_uuid.
> +.I fu_len
> +must be set to the number of bytes allocated for the uuid.
> +.I fu_uuid
> +must be initialized to the size of the filesystem uuid.

Huh?

> +The maximmum number of bytes for a uuid is
> +.BR UUID_MAX.

"The number of bytes to allocate for the UUID is filesystem-dependent."?

> +.I fu_flags
> +must be set to 0.
> +.PP
> +The
> +.B FS_IOC_SETFSUUID
> +operation will set the filesystem uuid according to
> +.I fu_uuid.
> +.I fu_len
> +must be set to the number of bytes in the uuid.
> +.I fu_flags
> +must be set to 0. The
> +.B FS_IOC_SETFSUUID
> +operation requires privilege
> +.RB ( CAP_SYS_ADMIN ).
> +.PP
> +This information is conveyed in a structure of
> +the following form:
> +.PP
> +.in +4n
> +.EX
> +struct fsuuid {
> +       __u32       fu_len;
> +       __u32       fu_flags;
> +       __u8        fu_uuid[];
> +};

Question: Would it perhaps make more sense to describe the struct and
what goes in fu_len/fu_uuid first, and then describe what get and set
do?

> +.EE
> +.in
> +.PP
> +.SH RETURN VALUE
> +On success zero is returned.
> +On error, \-1 is returned, and
> +.I errno
> +is set to indicate the error.
> +.SH ERRORS
> +Possible errors include (but are not limited to) the following:
> +.TP
> +.B EFAULT
> +Either the pointer to the
> +.I fsuuid
> +structure is invalid or
> +.I fu_uuid
> +has not been initialized properly.
> +.TP
> +.B EINVAL
> +The specified arguments are invalid.
> +.I fu_len
> +does not match the filesystem uuid length or
> +.I fu_flags
> +has bits set that are not implemented.
> +.TP
> +.B ENOTTY
> +The filesystem does not support the ioctl.
> +.TP
> +.B EOPNOTSUPP
> +The filesystem does not currently support changing the uuid through this
> +ioctl. This may be due to incompatible feature flags.
> +.TP
> +.B EPERM
> +The calling process does not have sufficient permissions to set the uuid.
> +.SH VERSIONS
> +These
> +.BR ioctl (2)
> +operations first appeared in Linux 5.19.

5.20 at this point...

> +They were previously known as
> +.B EXT4_IOC_GETFSUUID
> +and
> +.B EXT4_IOC_SETFSUUID

Oh!  I had assumed you'd just leave these as "ext4" ioctls for now and
let whoever does the next filesystem port add these bits.

> +and were private to ext4.
> +.SH CONFORMING TO
> +This API is Linux-specific.
> +.BR UUID_MAX.
> +.SH SEE ALSO
> +.BR ioctl (2)
> +
> -- 
> 2.37.0.144.g8ac04bfd2-goog
> 
