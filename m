Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2584448564F
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jan 2022 16:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241764AbiAEP5y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 10:57:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231191AbiAEP5v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 10:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641398271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CH3EhoBQaWd3kqc9tnFbgtaIJ9RzdHtafLpYunEyA7E=;
        b=F3xbvS5vHNHYcEl+5vEYECZeS6D+za9MKo+KasSARF6/b/qSGR1WntitKBV4bcvbqxDbDm
        lGRBKp6FRFcbWhnoFbobNY1gyuhh5lAdzeRMkbIjHa/Tr4+MKrpbl14ALogc+y2ZhsOa1J
        V/Zzd65fOuf5hlFSAue94piMHvDfmTw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-d-xMPpmmOIC8o093xtqQcw-1; Wed, 05 Jan 2022 10:57:50 -0500
X-MC-Unique: d-xMPpmmOIC8o093xtqQcw-1
Received: by mail-pg1-f198.google.com with SMTP id s16-20020a63ff50000000b0033b6e4cedc8so21581641pgk.8
        for <linux-ext4@vger.kernel.org>; Wed, 05 Jan 2022 07:57:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=CH3EhoBQaWd3kqc9tnFbgtaIJ9RzdHtafLpYunEyA7E=;
        b=C+SwPtA2DSyMW/Yz3QqoepD29R7lv3KrDvar1z47kfBA8hQz8sYVqCxud9ybEaPj50
         qn6Iuvti6zc8Fn80wnQMKUlq4LeiEuMVnpbjXXlRNMKSu+ZaWp6cnDFuAxMlAQOGpl2j
         Ydao95zlihU3n8mllUQAuJQ6AB3d88poODH+dWeShl7ULXuQrE1br/WS6tvYW7h6hcOQ
         iZk1HIj2rT0rVwjEcVYh3QBqjSZmji4PaqjvY/QfbaekHu8SOC8hkE6VZ6sn3mc/IQ5l
         SC4NfAeEVRe6V8NKPzyHZEr3LXhIQ+mXPq8kuC3pVd+cIX6m+4c94u927FUtxsnyhV9v
         URHQ==
X-Gm-Message-State: AOAM531b8Xua01/bfKAqxS3JomBATFogL0bzYJ4pFxwm73g0bV0wpol+
        JnTvx6z+pmtUtF8w5ydUvYpRiUe8MWjl+LjCHcysoQoaYGU+ENUG0YWLw05xIlXDrgjkJx+0uRm
        bqJDb8zgsOv91h6RHgOUZUg==
X-Received: by 2002:a17:90b:3907:: with SMTP id ob7mr4802049pjb.176.1641398268782;
        Wed, 05 Jan 2022 07:57:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcExbiuTXIdVISXSv7S3d5/tfNDTvl3B31jdNXawQurM1oWKCrT9JhfRBRTMJqZfaIxBe7Qg==
X-Received: by 2002:a17:90b:3907:: with SMTP id ob7mr4802020pjb.176.1641398268474;
        Wed, 05 Jan 2022 07:57:48 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g16sm44241605pfv.159.2022.01.05.07.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 07:57:48 -0800 (PST)
Date:   Wed, 5 Jan 2022 23:57:43 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     guan@eryu.me, fstests@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH] ext4/033: test EXT4_IOC_RESIZE_FS by calling the ioctl
 directly
Message-ID: <20220105155743.6knpj4zsbmy62uwj@zlang-mailbox>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, guan@eryu.me,
        fstests@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Eric Whitney <enwlinux@gmail.com>
References: <Yb9M3aIb9cJGIJaB@desktop>
 <20211220204059.2248577-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220204059.2248577-1-tytso@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Dec 20, 2021 at 03:40:59PM -0500, Theodore Ts'o wrote:
> E2fsprogs commits 4ea80d031c7e ("resize2fs: adjust new size of the
> file system to allow a successful resize") and 50088b1996cc
> ("resize2fs: attempt to keep the # of inodes valid by removing the
> last bg") will automatically reduce the requested new size of the file
> system by up to a single block group to avoid overflowing the 32-bit
> inode count.   This interferes with ext4/033's test of kernel commit
> 4f2f76f75143 ("ext4: Forbid overflowing inode count when # resizing".)
> 
> Address this by creating a new test program, ext4_resize which calls
> the EXT4_IOC_RESIZE_FS ioctl directly so we can correctly test the
> kernel's online resize code.
> 
> Reported-by: Eric Whitney <enwlinux@gmail.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  .gitignore        |  1 +
>  src/Makefile      |  2 +-
>  src/ext4_resize.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/033    | 16 ++++++++++-----
>  4 files changed, 63 insertions(+), 6 deletions(-)
>  create mode 100644 src/ext4_resize.c
> 
> diff --git a/.gitignore b/.gitignore
> index 9e6d2fd5..65b93307 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -77,6 +77,7 @@ tags
>  /src/dirperf
>  /src/dirstress
>  /src/e4compact
> +/src/ext4_resize
>  /src/fault
>  /src/feature
>  /src/fiemap-tester
> diff --git a/src/Makefile b/src/Makefile
> index 25ab061d..1737ed0e 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -31,7 +31,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	dio-invalidate-cache stat_test t_encrypted_d_revalidate \
>  	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
>  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
> -	detached_mounts_propagation
> +	detached_mounts_propagation ext4_resize
>  
>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>  	      btrfs_crc32c_forged_name.py
> diff --git a/src/ext4_resize.c b/src/ext4_resize.c
> new file mode 100644
> index 00000000..1ac51e6f
> --- /dev/null
> +++ b/src/ext4_resize.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Test program which uses the raw ext4 resize_fs ioctl directly.
> + */
> +
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <sys/ioctl.h>
> +#include <sys/mount.h>
> +
> +typedef unsigned long long __u64;
> +
> +#ifndef EXT4_IOC_RESIZE_FS
> +#define EXT4_IOC_RESIZE_FS		_IOW('f', 16, __u64)
> +#endif

This patch looks good to me, I just want to ask if we'd better to try to include
ext2fs/ext2fs.h at here? And of course, check it in configure.ac.
The EXT4_IOC_RESIZE_FS looks like defined in ext2fs/ext2_fs.h which comes from
e2fsprogs-devel package. I can't find this definition from kernel-hearders package.
As you're the expert of this part, please correct me if it's wrong :)

Thanks,
Zorro

> +
> +int main(int argc, char **argv)
> +{
> +	__u64	new_size;
> +	int	error, fd;
> +	char	*tmp = NULL;
> +
> +	if (argc != 3) {
> +		fputs("insufficient arguments\n", stderr);
> +		return 1;
> +	}
> +	fd = open(argv[1], O_RDONLY);
> +	if (!fd) {
> +		perror(argv[1]);
> +		return 1;
> +	}
> +
> +	new_size = strtoull(argv[2], &tmp, 10);
> +	if ((errno) || (*tmp != '\0')) {
> +		fprintf(stderr, "%s: invalid new size\n", argv[0]);
> +		return 1;
> +	}
> +
> +	error = ioctl(fd, EXT4_IOC_RESIZE_FS, &new_size);
> +	if (error < 0) {
> +		perror("EXT4_IOC_RESIZE_FS");
> +		return 1;
> +	}
> +	return 0;
> +}
> diff --git a/tests/ext4/033 b/tests/ext4/033
> index 1bc14c03..22041a17 100755
> --- a/tests/ext4/033
> +++ b/tests/ext4/033
> @@ -5,7 +5,8 @@
>  # FS QA Test 033
>  #
>  # Test s_inodes_count overflow for huge filesystems. This bug was fixed
> -# by commit "ext4: Forbid overflowing inode count when resizing".
> +# by commit 4f2f76f75143 ("ext4: Forbid overflowing inode count when
> +# resizing".)
>  #
>  . ./common/preamble
>  _begin_fstest auto ioctl resize
> @@ -28,7 +29,9 @@ _supported_fs ext4
>  _require_scratch_nocheck
>  _require_dmhugedisk
>  _require_dumpe2fs
> -_require_command "$RESIZE2FS_PROG" resize2fs
> +_require_test_program ext4_resize
> +
> +EXT4_RESIZE=$here/src/ext4_resize
>  
>  # Figure out whether device is large enough
>  devsize=$(blockdev --getsize64 $SCRATCH_DEV)
> @@ -68,7 +71,8 @@ $DUMPE2FS_PROG -h $DMHUGEDISK_DEV >> $seqres.full 2>&1
>  
>  # This should fail, s_inodes_count would just overflow!
>  echo "Resizing to inode limit + 1..."
> -$RESIZE2FS_PROG $DMHUGEDISK_DEV $((limit_groups*group_blocks)) >> $seqres.full 2>&1
> +echo $EXT4_RESIZE $SCRATCH_MNT $((limit_groups*group_blocks)) >> $seqres.full 2>&1
> +$EXT4_RESIZE $SCRATCH_MNT $((limit_groups*group_blocks)) >> $seqres.full 2>&1
>  if [ $? -eq 0 ]; then
>  	echo "Resizing succeeded but it should fail!"
>  	exit
> @@ -76,7 +80,8 @@ fi
>  
>  # This should succeed, we are maxing out inodes
>  echo "Resizing to max group count..."
> -$RESIZE2FS_PROG $DMHUGEDISK_DEV $(((limit_groups-1)*group_blocks)) >> $seqres.full 2>&1
> +echo $EXT4_RESIZE $SCRATCH_MNT $(((limit_groups-1)*group_blocks)) >> $seqres.full 2>&1
> +$EXT4_RESIZE $SCRATCH_MNT $(((limit_groups-1)*group_blocks)) >> $seqres.full 2>&1
>  if [ $? -ne 0 ]; then
>  	echo "Resizing failed!"
>  	exit
> @@ -87,7 +92,8 @@ $DUMPE2FS_PROG -h $DMHUGEDISK_DEV >> $seqres.full 2>&1
>  
>  # This should fail, s_inodes_count would overflow by quite a bit!
>  echo "Resizing to device size..."
> -$RESIZE2FS_PROG $DMHUGEDISK_DEV >> $seqres.full 2>&1
> +echo $EXT4_RESIZE $SCRATCH_MNT $(((limit_groups + 16)*group_blocks)) >> $seqres.full 2>&1
> +$EXT4_RESIZE $SCRATCH_MNT $(((limit_groups + 16)*group_blocks)) >> $seqres.full 2>&1
>  if [ $? -eq 0 ]; then
>  	echo "Resizing succeeded but it should fail!"
>  	exit
> -- 
> 2.31.0
> 

