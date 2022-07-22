Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BE657E592
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 19:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiGVRbf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 13:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiGVRbe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 13:31:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D3A87C3F;
        Fri, 22 Jul 2022 10:31:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62884B829B4;
        Fri, 22 Jul 2022 17:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7B3C341C6;
        Fri, 22 Jul 2022 17:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658511090;
        bh=a3AdWTwkRu806AtqPGZZoXgqI77wgso2z+u/CTFUOCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fvyZylqkFe8Oa7eFQ7syg12R+1sK6D4uh+32flmCf29y3KlC3MZO6X75XRccGkybE
         4yMzXNC1+jqIIS5h/hrABGvcd/zNQPa6YLo4nSVX7PVYfqplyeFs0MmsFRTuT5rl/y
         71n3BQ1JcW33FSYt/wBDKzGjYn5L/lFQ4d04AhxQnGRLLrMGKkxZWZD+vFnI2UZqwP
         INcGr1GlaNkL2CPmeCXYzVAFQhkkEdEevFd595HlsQJgWsdcGNTUyGd8f0vXyWFuKN
         B1/jiorWasDepPg5vXlI52CT6ptqim8awK354nJ9WqLn+PL8d517lQtu3bqq+Bxj4M
         cVb1+tLRtJ2Gg==
Date:   Fri, 22 Jul 2022 10:31:29 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeremy Bongio <bongiojp@gmail.com>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-man@vger.kernel.org
Subject: Re: [PATCH v3] Add manpage for get/set fsuuid ioctl for ext4
 filesystem.
Message-ID: <Ytre8bHCS+S12/8M@magnolia>
References: <20220722063732.466621-1-bongiojp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722063732.466621-1-bongiojp@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 21, 2022 at 11:37:32PM -0700, Jeremy Bongio wrote:
> Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
> ---
> 
> Changes in v3:
> 
> Removed LIBRARY section since this ioctl won't be wrapped by a system library.
> 
> Code now uses 4-space indent.
> 
> Updated for semantic new lines. Please call out if I still break this rule.
> 
> Reworded based on Darrick's suggestions.
> 
> Unrecognized fsu_flags now results in EOPNOTSUPP error.
> 
> Added definitions of EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID which are not
> contained in a library.
> 
>  man2/ioctl_fsuuid.2 | 113 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 man2/ioctl_fsuuid.2
> 
> diff --git a/man2/ioctl_fsuuid.2 b/man2/ioctl_fsuuid.2
> new file mode 100644
> index 000000000..c9e2789b9
> --- /dev/null
> +++ b/man2/ioctl_fsuuid.2
> @@ -0,0 +1,113 @@
> +.\" Copyright (c) 2022 Google, Inc., written by Jeremy Bongio <bongiojp@gmail.com>
> +.\"
> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> +.TH IOCTL_FSUUID 2 2022-07-20 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +ioctl_fsuuid \- get or set an ext4 filesystem uuid
> +.SH SYNOPSIS
> +.nf
> +.B #include <sys/ioctl.h>
> +.BR "#include <linux/fs.h>" "         /* Definition of " _IOR " and " _IOW " */"
> +.PP
> +.BI "#define EXT4_IOC_GETFSUUID      _IOR('f', 44, struct fsuuid)"
> +.BI "#define EXT4_IOC_SETFSUUID      _IOW('f', 44, struct fsuuid)"
> +.BI "int ioctl(int " fd ", EXT4_IOC_GETFSUUID, struct " fsuuid ");"
> +.BI "int ioctl(int " fd ", EXT4_IOC_SETFSUUID, struct " fsuuid ");"
> +.fi
> +.SH DESCRIPTION
> +If an ext4 filesystem supports uuid manipulation, these
> +.BR ioctl (2)
> +operations can be used to get or set the uuid for the ext4 filesystem on which
> +.I fd
> +resides.
> +.PP
> +The argument to these operations should be a pointer to a
> +.IR "struct fsuuid" ":"
> +.PP
> +.in +4n
> +.EX
> +struct fsuuid {
> +    __u32 fsu_len;      /* Number of bytes in a uuid */
> +    __u32 fsu_flags;    /* Mapping flags */
> +    __u8  fsu_uuid[];   /* Byte array for uuid */
> +};
> +.EE
> +.PP
> +The
> +.I fsu_flags
> +field must be set to 0.
> +.PP
> +If
> +.BR EXT4_IOC_GETFSUUID
> +is called with
> +.I fsu_len
> +set to 0,
> +.I fsu_len
> +will be set to the number of bytes in an ext4 filesystem uuid
> +and the return code will be EINVAL.
> +.PP
> +If
> +.BR EXT4_IOC_GETFSUUID
> +is called with
> +.I fsu_len
> +matching the length of the ext4 filesystem uuid,
> +then that uuid will be written to
> +.I fsu_uuid[]
> +and the return value will be zero.
> +If
> +.I fsu_len
> +does not match, the return value will be
> +.B EINVAL.
> +.PP
> +If
> +.BR EXT4_IOC_SETFSUUID
> +is called with
> +.I fsu_len
> +matching the length of the ext4 filesystem uuid,
> +then the filesystem uuid will be set to the contents of
> +.I fsu_uuid[]
> +and  the return value will reflect the outcome of the update operation.
> +If 

Nit: trailing space.

> +.I fsu_len
> +does not match, the return value will be
> +.B EINVAL.
> +.PP
> +The
> +.BR FS_IOC_SETFSUUID
> +operation requires privilege
> +.RB ( CAP_SYS_ADMIN ).
> +If the filesystem is busy, an
> +.BR EXT4_IOC_SETFSUUID
> +operation will wait until it can apply the uuid changes.
> +This may take a long time.
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
> +Could not copy to/from userspace.
> +.TP
> +.B EINVAL
> +.I fsu_len
> +did not match the filesystem uuid length.
> +.TP
> +.B ENOTTY
> +The filesystem does not support the ioctl.
> +.TP
> +.B EOPNOTSUPP
> +The filesystem does not support changing the uuid through this ioctl.
> +This may be due to incompatible filesystem feature flags or
> +.I fsu_flags
> +has bits set that are not recognized.

Hm, I think I miscommunicated last time.  fsu_flags bits that are not
recognized by the implementation should return EINVAL.  fsu_flag bits
that *are* recognized but impossible to service should return
EOPNOTSUPP.

.TP
.B EINVAL
.I fsu_len
did not match the filesystem uuid length, or
.I fsu_flags
had bits set that the implementation does not understand.

.TP
.B EOPNOTSUPP
The filesystem does not support changing the uuid through this ioctl.
This may be due to incompatible filesystem feature flags or
.I fsu_flags
had bits set that make the operation impossible.

FWIW I agree with the manpages maintainer that this should have a
section with example code.  I don't know if he requires the example code
be embedded in the manpage, or if it would be sufficient to point
readers at a real implementation (e.g. uuid_ioctl.c in fstests, or the
relevant helper functions in tune2fs.c in e2fsprogs).

--D

> +.TP
> +.B EPERM
> +The calling process does not have sufficient permissions to set the uuid.
> +.SH CONFORMING TO
> +This API is Linux-specific.
> +.SH SEE ALSO
> +.BR ioctl (2)
> -- 
> 2.37.1.359.gd136c6c3e2-goog
> 
