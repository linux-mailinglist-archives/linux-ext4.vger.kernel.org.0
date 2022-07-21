Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2845757C178
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jul 2022 02:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiGUAMs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jul 2022 20:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiGUAMr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jul 2022 20:12:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186694A81B;
        Wed, 20 Jul 2022 17:12:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A89FBB82156;
        Thu, 21 Jul 2022 00:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2A4C3411E;
        Thu, 21 Jul 2022 00:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658362363;
        bh=2Xu/bY52cBNKD0aenZIB3K742OBCJaMnfl5ejT+HdkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TNoyJeN1QMwkTwq16E0WrGpBFoD3N8t1vj6LlOZDRBgJSewWBXUkbGRtlX/drVY9/
         eCfsVj+coJ6PUuF43Kj8SJXfGtOw72VUqC/qf03sKqiWMpet7nIuIoY4TIK+CS1GjD
         FV34XsSH65rw8hFyiGmJ0/3WJ0H0+G9MmUsfD3BfneRLJHNLqCslyB3Gmc19lYPTXV
         lYJycAf4JMsC3d5lPdNjCN6GZt6KQafMO9KoVboA6ETGhrDhuYtlCndIqqKJtsjSOQ
         2fujDPnLZETUJ+dM6bI3PzSbjl9fc3/xSD8lzH2GwY61n3T3q96DDRlCoeYnHcGYrH
         rOAdKyF4HnffA==
Date:   Wed, 20 Jul 2022 17:12:42 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeremy Bongio <bongiojp@gmail.com>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-man@vger.kernel.org
Subject: Re: [PATCH v2] Add manpage for get/set fsuuid ioctl for ext4
 filesystem.
Message-ID: <YtiZ+gOmOFTpiAjW@magnolia>
References: <20220720234512.354076-1-bongiojp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720234512.354076-1-bongiojp@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 20, 2022 at 04:45:12PM -0700, Jeremy Bongio wrote:
> Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
> ---
> 
> This is a ext4 filesystem specific ioctl. However, this ioctl will
> likely be implemented for multiple filesystems at which point this
> manpage will be updated.
> 
>  man2/ioctl_fsuuid.2 | 115 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 man2/ioctl_fsuuid.2
> 
> diff --git a/man2/ioctl_fsuuid.2 b/man2/ioctl_fsuuid.2
> new file mode 100644
> index 000000000..53747684f
> --- /dev/null
> +++ b/man2/ioctl_fsuuid.2
> @@ -0,0 +1,115 @@
> +.\" Copyright (c) 2022 Google, Inc., written by Jeremy Bongio <bongiojp@gmail.com>
> +.\"
> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> +.TH IOCTL_FSUUID 2 2022-07-20 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +ioctl_fsuuid \- get or set an ext4 filesystem uuid
> +.SH LIBRARY
> +Standard C library
> +.RI ( libc ", " \-lc )

I'm not sure if libc will actually wrap this one, they often won't do
that for ioctls.

> +.SH SYNOPSIS
> +.nf
> +.B #include <sys/ioctl.h>
> +.PP
> +.BI "int ioctl(int " fd ", EXT4_IOC_GETFSUUID, struct " fsuuid ");"
> +.BI "int ioctl(int " fd ", EXT4_IOC_SETFSUUID, struct " fsuuid ");"
> +.fi
> +.SH DESCRIPTION
> +If an ext4 filesystem supports uuid manipulation, these
> +.BR ioctl (2)
> +operations can be used to get or set the uuid for the ext4 filesystem
> +on which
> +.I fd
> +resides.
> +.PP
> +The argument to these operations should be a pointer to a
> +.IR "struct fsuuid" ":"
> +.PP
> +.in +4n
> +.EX
> +struct fsuuid {
> +       __u32 fsu_len;      /* Number of bytes in a uuid */
> +       __u32 fsu_flags;    /* Mapping flags */
> +       __u8  fsu_uuid[];   /* Byte array for uuid */
> +};
> +.EE
> +.PP
> +The
> +.I fsu_flags
> +field must be set to 0. 

Nit: whitespace at the end of the line.

> +.PP
> +If an
> +.BR EXT4_IOC_GETFSUUID
> +operation is called with
> +.I fsu_len
> +set to 0,
> +.I fsu_len
> +will be reassigned the number of bytes in an ext4 filesystem uuid

"...will be set to the number of bytes..." ?

> +and the return code will be -EINVAL.
> +.PP
> +If an
> +.BR EXT4_IOC_GETFSUUID
> +operation is called with
> +.I fsu_len
> +set to the number of bytes in an ext4 filesystem uuid and
> +.I fsu_uuid
> +is allocated at least that many bytes, then
> +the filesystem uuid will be written to
> +.I fsu_uuid.

Hm.  It's not like the kernel actually checks the allocation -- if
fsu_len is set to the length of the filesystem's volume uuid, then
the that volume uuid will be written to fsu_uuid[].  How about:

"If EXT4_IOC_GETFSUUID is called with fsu_len matching the length of the
ext4 filesystem uuid, then that uuid will be written to fsu_uuid[] and
the return value will be zero.
If fsu_len does not match, the return value will be -EINVAL."

> +.PP
> +If an
> +.BR EXT4_IOC_SETFSUUID
> +operation is called with
> +.I fsu_len
> +set to the number of bytes in an ext4 filesystem uuid and
> +.I fsu_uuid
> +contains a uuid with 

Nit: whitespace at EOL.

> +.I fsu_uuid
> +bytes, then
> +the filesystem uuid will be set to
> +.I fsu_uuid.

"If EXT4_IOC_SETFSUUID is called with fsu_len matching the length of the
ext4 filesystem uuid, then the filesystem uuid will be set to the
contents of fsu_uuid[] and the return value will reflect the outcome of
the update operation.
If fsu_len does not match, the return value will be -EINVAL."

> +.PP
> +The
> +.B FS_IOC_SETFSUUID
> +operation requires privilege
> +.RB ( CAP_SYS_ADMIN ).
> +If the filesystem is currently being resized, an
> +.B EXT4_IOC_SETFSUUID
> +operation will wait until the resize is finished and the uuid can safely be set.
> +This may take a long time.

Why is resize called out here specifically?  Won't setfsuuid block on
/any/ operation that has tied up the filesystem superblocks?  I think
this could be more general:

"If the filesystem is busy, an EXT4_IOC_SETFSUUID operation will wait
until it can apply the uuid changes.
This may take a long time."

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
> +.I fsu_uuid
> +has not been initialized properly.

Invalid?  Isn't that what EINVAL is for?

I think EFAULT is for "could not copy to/from userspace".

> +.TP
> +.B EINVAL
> +The specified arguments are invalid.
> +.I fsu_len
> +did not match the filesystem uuid length or
> +.I fsu_flags
> +has bits set that are not implemented.

"...not recognized."

If they're not implemented, shouldn't that be EOPNOTSUPP?

--D

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
> +.SH CONFORMING TO
> +This API is Linux-specific.
> +.SH SEE ALSO
> +.BR ioctl (2)
> -- 
> 2.37.0.170.g444d1eabd0-goog
> 
