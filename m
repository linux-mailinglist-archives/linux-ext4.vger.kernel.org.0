Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF611461137
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Nov 2021 10:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244463AbhK2JmP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Nov 2021 04:42:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229623AbhK2JkO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 29 Nov 2021 04:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638178616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yScirW0vJSGEpQKUiw3i65G5A9eRg3ZLtWP83Pnc3ZA=;
        b=dI1+0l/kJvO8ubffoT4c9sZh047/hi/p+GBghH6L90nhkM8pkgf20Agx+8OLhMR8ZWcd0j
        fUBp/6vr+CWvW8Qes3fWv+EsUUnj1V53imaJBloAw4YhBnxIfd0dqVc8484tjQswx4WKJd
        Fv/+CNAj9XkL4d/V+WGoyd69gRgKvos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-59HQzJmFNIeKFgTo2OrcWw-1; Mon, 29 Nov 2021 04:36:53 -0500
X-MC-Unique: 59HQzJmFNIeKFgTo2OrcWw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C98E18C89C4;
        Mon, 29 Nov 2021 09:36:52 +0000 (UTC)
Received: from work (unknown [10.40.194.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1907C10013D6;
        Mon, 29 Nov 2021 09:36:50 +0000 (UTC)
Date:   Mon, 29 Nov 2021 10:36:47 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>, tytso@mit.edu
Subject: Re: [PATCH] tune2fs: implement support for set/get label iocts
Message-ID: <20211129093647.5iycxxodael4dkt5@work>
References: <20211124134542.22270-1-lczerner@redhat.com>
 <1563F233-9CCB-486E-AC87-7B752EED8ABA@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563F233-9CCB-486E-AC87-7B752EED8ABA@dilger.ca>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Nov 27, 2021 at 02:23:32PM -0700, Andreas Dilger wrote:
> On Nov 24, 2021, at 6:45 AM, Lukas Czerner <lczerner@redhat.com> wrote:
> > 
> > Implement support for FS_IOC_SETFSLABEL and FS_IOC_GETFSLABEL ioctls.
> > Try to use the ioctls if possible even before we open the file system
> > since we don't need it. Only fall back to the old method in the case the
> > file system is not mounted, is mounted read only in the set label case,
> > or the ioctls are not suppported by the kernel.
> > 
> > The new ioctls can also be supported by file system drivers other than
> > ext4. As a result tune2fs and e2label will work for those file systems
> > as well as long as the file system is mounted. Note that we still truncate
> > the label exceeds the supported lenghth on extN file system family, while
> > we keep the label intact for others.
> > 
> > Update tune2fs and e2label as well.
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > ---
> > lib/ext2fs/ext2fs.h    |  1 +
> > lib/ext2fs/ismounted.c |  5 +++
> > misc/e2label.8.in      |  7 ++-
> > misc/tune2fs.8.in      |  8 +++-
> > misc/tune2fs.c         | 96 ++++++++++++++++++++++++++++++++++++++++++
> > 5 files changed, 114 insertions(+), 3 deletions(-)
> > 
> > diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> > index 0ee0e7d0..68f9c1fe 100644
> > --- a/lib/ext2fs/ext2fs.h
> > +++ b/lib/ext2fs/ext2fs.h
> > @@ -531,6 +531,7 @@ typedef struct ext2_struct_inode_scan *ext2_inode_scan;
> > #define EXT2_MF_READONLY	4
> > #define EXT2_MF_SWAP		8
> > #define EXT2_MF_BUSY		16
> > +#define EXT2_MF_EXTFS		32
> > 
> > /*
> >  * Ext2/linux mode flags.  We define them here so that we don't need
> > diff --git a/lib/ext2fs/ismounted.c b/lib/ext2fs/ismounted.c
> > index aee7d726..c73273b8 100644
> > --- a/lib/ext2fs/ismounted.c
> > +++ b/lib/ext2fs/ismounted.c
> > @@ -207,6 +207,11 @@ is_root:
> > 			close(fd);
> > 		(void) unlink(TEST_FILE);
> > 	}
> > +
> > +	if (!strcmp(mnt->mnt_type, "ext4") ||
> > +	    !strcmp(mnt->mnt_type, "ext3") ||
> > +	    !strcmp(mnt->mnt_type, "ext2"))
> 
> IMHO, using "!strcmp(...)" reads like "not matching the string ...", so I prefer
> to use "strcmp(...) == 0".

Hi Andreas, thanks for thre review!

Ok, I can change that.

> 
> > +		*mount_flags |= EXT2_MF_EXTFS;
> > 	retval = 0;
> > errout:
> > 	endmntent (f);
> > diff --git a/misc/e2label.8.in b/misc/e2label.8.in
> > index 1dc96199..fa5294c4 100644
> > --- a/misc/e2label.8.in
> > +++ b/misc/e2label.8.in
> > @@ -33,7 +33,12 @@ Ext2 volume labels can be at most 16 characters long; if
> > .I volume-label
> > is longer than 16 characters,
> > .B e2label
> > -will truncate it and print a warning message.
> > +will truncate it and print a warning message.  For other file systems that
> > +support online label manipulation and are mounted
> > +.B e2label
> > +will work as well, but it will not attempt to truncate the
> > +.I volume-label
> > +at all.
> > .PP
> > It is also possible to set the volume label using the
> > .B \-L
> > diff --git a/misc/tune2fs.8.in b/misc/tune2fs.8.in
> > index 1e026e5f..628dcdc0 100644
> > --- a/misc/tune2fs.8.in
> > +++ b/misc/tune2fs.8.in
> > @@ -457,8 +457,12 @@ Ext2 file system labels can be at most 16 characters long; if
> > .I volume-label
> > is longer than 16 characters,
> > .B tune2fs
> > -will truncate it and print a warning.  The volume label can be used
> > -by
> > +will truncate it and print a warning.  For other file systems that
> > +support online label manipulation and are mounted
> > +.B tune2fs
> > +will work as well, but it will not attempt to truncate the
> > +.I volume-label
> > +at all.  The volume label can be used by
> > .BR mount (8),
> > .BR fsck (8),
> > and
> > diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> > index 71a8e99b..6c162ba5 100644
> > --- a/misc/tune2fs.c
> > +++ b/misc/tune2fs.c
> > @@ -52,6 +52,9 @@ extern int optind;
> > #include <sys/types.h>
> > #include <libgen.h>
> > #include <limits.h>
> > +#ifdef HAVE_SYS_IOCTL_H
> > +#include <sys/ioctl.h>
> > +#endif
> > 
> > #include "ext2fs/ext2_fs.h"
> > #include "ext2fs/ext2fs.h"
> > @@ -70,6 +73,15 @@ extern int optind;
> > #define QOPT_ENABLE	(1)
> > #define QOPT_DISABLE	(-1)
> > 
> > +#ifndef FS_IOC_SETFSLABEL
> > +#define FSLABEL_MAX 256
> > +#define FS_IOC_SETFSLABEL	_IOW(0x94, 50, char[FSLABEL_MAX])
> > +#endif
> > +
> > +#ifndef FS_IOC_GETFSLABEL
> > +#define FS_IOC_GETFSLABEL	_IOR(0x94, 49, char[FSLABEL_MAX])
> > +#endif
> > +
> > extern int ask_yn(const char *string, int def);
> > 
> > const char *program_name = "tune2fs";
> > @@ -2997,6 +3009,75 @@ fs_update_journal_user(struct ext2_super_block *sb, __u8 old_uuid[UUID_SIZE])
> > 	return 0;
> > }
> > 
> > +/*
> > + * Use FS_IOC_SETFSLABEL or FS_IOC_GETFSLABEL to set/get file system label
> > + * Return:	0 on success
> > + *		1 on error
> > + *		-1 when the old method should be used
> > + */
> > +int handle_fslabel(int setlabel) {
> > +	errcode_t ret;
> > +	int mnt_flags, fd;
> > +	char label[FSLABEL_MAX];
> > +	int maxlen = FSLABEL_MAX - 1;
> > +	char mntpt[PATH_MAX + 1];
> > +
> > +	ret = ext2fs_check_mount_point(device_name, &mnt_flags,
> > +					  mntpt, sizeof(mntpt));
> > +	if (ret) {
> > +		com_err(device_name, ret, _("while checking mount status"));
> > +		return 1;
> > +	}
> > +	if (!(mnt_flags & EXT2_MF_MOUNTED) ||
> > +	    (setlabel && (mnt_flags & EXT2_MF_READONLY)))
> > +		return -1;
> > +
> > +	if (!mntpt[0]) {
> > +		fprintf(stderr,_("Unknown mount point for %s\n"), device_name);
> > +		return 1;
> > +	}
> > +
> > +	fd = open(mntpt, O_RDONLY);
> 
> Opening read-only to change the label is a bit strange?  It would be better
> to open in write mode, and verify in the kernel that this is the case:
> 
> 	fd = open(mntpt, setlabel ? O_WRONLY : O_RDONLY);

I am not convinced about this. Sure it may feel strange, but:

 - we're not operating on the file itself but the file system in general
   and that needs to be rw mounted; kernel will check that
 - no other fslabel implementation requires the file to be opened for
   writing.
 - we don't even require file to be opened to writing for the most of our
   own special ioctls if they don't deal with the file itself such as
   EXT4_IOC_MOVE_EXT and EXT4_IOC_SWAP_BOOT
 - btrfs-progs uses O_RDONLY of setting label, fstrim uses O_RDONLY for
   FITRIM and I am sure there are plenty more examples.

So AFAICT the standard seems to be not to require it and just open
O_RDONLY if we really want a handle of a file system, not the file
itself. I don't really care either way, but I am not willing to change
what to me seems to be a standard way of doing this.

So if you insist I'll change the code here, but I won't change it on the
kernel side to require FMODE_WRITE.

Thanks again for the review.

-Lukas

> 
> > +	if (fd < 0) {
> > +		com_err(mntpt, errno, _("while opening mount point"));
> > +		return 1;
> > +	}
> > +
> > +	/* Get fs label */
> > +	if (!setlabel) {
> > +		if (ioctl(fd, FS_IOC_GETFSLABEL, &label)) {
> > +			close(fd);
> > +			if (errno == ENOTTY)
> > +				return -1;
> > +			com_err(mntpt, errno, _("while trying to get fs label"));
> > +			return 1;
> > +		}
> > +		close(fd);
> > +		printf("%.*s\n", EXT2_LEN_STR(label));
> > +		return 0;
> > +	}
> > +
> > +	/* If it's extN file system, truncate the label to appropriate size */
> > +	if (mnt_flags & EXT2_MF_EXTFS)
> > +		maxlen = EXT2_LABEL_LEN;
> > +	if (strlen(new_label) > maxlen) {
> > +		fputs(_("Warning: label too long, truncating.\n"),
> > +		      stderr);
> > +		new_label[maxlen] = '\0';
> > +	}
> > +
> > +	/* Set fs label */
> > +	if (ioctl(fd, FS_IOC_SETFSLABEL, new_label)) {
> > +		close(fd);
> > +		if (errno == ENOTTY)
> > +			return -1;
> > +		com_err(mntpt, errno, _("while trying to set fs label"));
> > +		return 1;
> > +	}
> > +	close(fd);
> > +	return 0;
> > +}
> > +
> > #ifndef BUILD_AS_LIB
> > int main(int argc, char **argv)
> > #else
> > @@ -3038,6 +3119,21 @@ int tune2fs_main(int argc, char **argv)
> > #endif
> > 		io_ptr = unix_io_manager;
> > 
> > +	/*
> > +	 * Try the get/set fs label using ioctls before we even attempt
> > +	 * to open the file system.
> > +	 */
> > +	if (L_flag || print_label) {
> > +		rc = handle_fslabel(L_flag);
> > +		if (rc != -1) {
> > +#ifndef BUILD_AS_LIB
> > +			exit(rc);
> > +#endif
> > +			return rc;
> > +		}
> > +		rc = 0;
> > +	}
> > +
> > retry_open:
> > 	if ((open_flag & EXT2_FLAG_RW) == 0 || f_flag)
> > 		open_flag |= EXT2_FLAG_SKIP_MMP;
> > --
> > 2.31.1
> > 
> 
> 
> Cheers, Andreas
> 
> 
> 
> 
> 


