Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EAE57B448
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Jul 2022 12:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiGTKKC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jul 2022 06:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiGTKKB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jul 2022 06:10:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6606A5E318
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 03:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658311798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YgZdj4HiWf8hYLYatruHwnRbt5XsSuFh9EjtrMbqXY0=;
        b=h8l8GAl4VmyHHwTxg4QXqOZkOTrht94J8FA+fIsQ8D2KtzGzw9GM+Roojb/KWSTLI5NTDV
        6qtXFVAaXUfX9FbbkNQNGsxsqGrLAXwm+AvU6W2kr+mxehmrIYin8CNFvcL8jJdVbq4qEc
        Ku1XxPDeA4OqnM6Hzi+BrvgwhC7JSmo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-vli5aJ9RNTyEMEt8cYxdYQ-1; Wed, 20 Jul 2022 06:09:57 -0400
X-MC-Unique: vli5aJ9RNTyEMEt8cYxdYQ-1
Received: by mail-qt1-f200.google.com with SMTP id q21-20020ac84115000000b0031bf60d9b35so11804264qtl.4
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 03:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YgZdj4HiWf8hYLYatruHwnRbt5XsSuFh9EjtrMbqXY0=;
        b=c/6/ov7wT9/9alo5VRYhSQbLRwFzdVOEzeLvzAYFDm+XfNHqlmVHmvA6JkYo9Nlyby
         MyOCfVC3q2vJLRxuJ0nheLRpzvloJHwg/pZcKBi1lqwbwDKXULzYOOQxwzdHPmCT8s+Z
         BhLC5DLWWPllTTC3OZn6gd56RuZ03qXFxMgY/Nmxzts7gBS8f+BZKGTt/9xYbsKptbKy
         xswzpAjHqGTj7iLDAKtdbMUek4Q2XBkh12Uh4XSvMWjiJBeYaGn+ir9IXx4cVSRDWBKB
         8Xm/yFmdFHQSEnkT3nTxW9OK3QlDBpReHE/PFFO8c3Zql2lnZOypfr2YQWux7yS+Ifnm
         UBzw==
X-Gm-Message-State: AJIora/V9d/wMB3ciq/pHD9y6ESdlMsSfQ7FshVQjEJTYBM+Mtz3pJgJ
        5xA2u3SsbpyGnwWGnJTXc0gngyeEtF/3K+v4LY7xk5PttoSZWZoOoRADS9BjJ5ZZ67uc4QIYZ/A
        Ow9Y96RqZ9QZc/Lbfdeqt5Q==
X-Received: by 2002:a37:88d:0:b0:6b5:cf2a:a485 with SMTP id 135-20020a37088d000000b006b5cf2aa485mr15847140qki.660.1658311796769;
        Wed, 20 Jul 2022 03:09:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uJPerdUt1iF7XBjf5dXIITvbz3Xyd7hg8dRBjwACY3qPHACap2FDpduP0hlDkRTxw04k7sfA==
X-Received: by 2002:a37:88d:0:b0:6b5:cf2a:a485 with SMTP id 135-20020a37088d000000b006b5cf2aa485mr15847121qki.660.1658311796475;
        Wed, 20 Jul 2022 03:09:56 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h13-20020a05620a284d00b006aee5df383csm15711621qkp.134.2022.07.20.03.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 03:09:55 -0700 (PDT)
Date:   Wed, 20 Jul 2022 18:09:49 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeremy Bongio <bongiojp@gmail.com>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        fstests@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v5] ext4/056: add a check to make sure ext4 uuid ioctls
 get/set during fsstress.
Message-ID: <20220720100949.dttc5qbmy4qziz65@zlang-mailbox>
References: <20220720000256.239531-1-bongiojp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720000256.239531-1-bongiojp@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 19, 2022 at 05:02:56PM -0700, Jeremy Bongio wrote:
> Adds a utility to set/get uuid through ext4 ioctl. Executes the ioctls
> while running fsstress. These ioctls are used by tune2fs to safely change
> the uuid without racing other filesystem modifications.
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
> ---
> 
> Changes in v5:
> 
> Added reviewed-by tag.
> 
> Added wait after killing fsstress pids.
> 
> Removed _scratch_mount output redirection.
> 
>  .gitignore         |   1 +
>  src/Makefile       |   4 +-
>  src/uuid_ioctl.c   | 105 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/056     |  64 +++++++++++++++++++++++++++
>  tests/ext4/056.out |   2 +
>  5 files changed, 174 insertions(+), 2 deletions(-)
>  create mode 100644 src/uuid_ioctl.c
>  create mode 100755 tests/ext4/056
>  create mode 100644 tests/ext4/056.out
> 
> diff --git a/.gitignore b/.gitignore
> index ba0c572b..dab24d68 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -169,6 +169,7 @@ tags
>  /src/unwritten_mmap
>  /src/unwritten_sync
>  /src/usemem
> +/src/uuid_ioctl
>  /src/writemod
>  /src/writev_on_pagefault
>  /src/xfsctl
> diff --git a/src/Makefile b/src/Makefile
> index 111ce1d9..e33e04de 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -31,14 +31,14 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	dio-invalidate-cache stat_test t_encrypted_d_revalidate \
>  	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
>  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
> -	detached_mounts_propagation ext4_resize
> +	detached_mounts_propagation ext4_resize uuid_ioctl
>  
>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>  	      btrfs_crc32c_forged_name.py
>  
>  SUBDIRS = log-writes perf
>  
> -LLDLIBS = $(LIBHANDLE) $(LIBACL) -lpthread -lrt
> +LLDLIBS = $(LIBHANDLE) $(LIBACL) -lpthread -lrt -luuid
>  
>  ifeq ($(HAVE_XLOG_ASSIGN_LSN), true)
>  LINUX_TARGETS += loggen
> diff --git a/src/uuid_ioctl.c b/src/uuid_ioctl.c
> new file mode 100644
> index 00000000..89a9b5d8
> --- /dev/null
> +++ b/src/uuid_ioctl.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Google, Inc. All Rights Reserved.
> + *
> + * Test program which uses the raw ext4 set_fsuuid ioctl directly.
> + * SYNOPSIS:
> + *   $0 COMMAND MOUNT_POINT [UUID]
> + *
> + * COMMAND must be either "get" or "set".
> + * The UUID must be a 16 octet sequence represented as 32 hexadecimal digits in
> + * canonical textual representation, e.g. output from `uuidgen`.
> + *
> + */
> +
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <uuid/uuid.h>
> +#include <linux/fs.h>
> +
> +struct fsuuid {
> +	__u32   fsu_len;
> +	__u32   fsu_flags;
> +	__u8    fsu_uuid[];
> +};
> +
> +#ifndef EXT4_IOC_GETFSUUID
> +#define EXT4_IOC_GETFSUUID      _IOR('f', 44, struct fsuuid)
> +#endif
> +
> +#ifndef EXT4_IOC_SETFSUUID
> +#define EXT4_IOC_SETFSUUID      _IOW('f', 44, struct fsuuid)
> +#endif
> +
> +int main(int argc, char **argv)
> +{
> +	int error, fd;
> +	struct fsuuid *fsuuid = NULL;
> +
> +	if (argc < 3) {
> +		fprintf(stderr, "Invalid arguments\n");
> +		return 1;
> +	}
> +
> +	fd = open(argv[2], O_RDONLY);
> +	if (!fd) {
> +		perror(argv[2]);
> +		return 1;
> +	}
> +
> +	fsuuid = malloc(sizeof(*fsuuid) + sizeof(uuid_t));
> +	if (!fsuuid) {
> +		perror("malloc");
> +		return 1;
> +	}
> +	fsuuid->fsu_len = sizeof(uuid_t);
> +	fsuuid->fsu_flags = 0;
> +
> +	if (strcmp(argv[1], "get") == 0) {
> +		uuid_t uuid;
> +		char uuid_str[37];
> +
> +		if (ioctl(fd, EXT4_IOC_GETFSUUID, fsuuid)) {
> +			fprintf(stderr, "%s while trying to get fs uuid\n",
> +				strerror(errno));
> +			return 1;
> +		}
> +
> +		memcpy(&uuid, fsuuid->fsu_uuid, sizeof(uuid));
> +		uuid_unparse(uuid, uuid_str);
> +		printf("%s\n", uuid_str);
> +	} else if (strcmp(argv[1], "set") == 0) {
> +		uuid_t uuid;
> +
> +		if (argc != 4) {
> +			fprintf(stderr, "UUID argument missing.\n");
> +			return 1;
> +		}
> +
> +		error = uuid_parse(argv[3], uuid);
> +		if (error < 0) {
> +			fprintf(stderr, "Invalid UUID. The UUID should be in "
> +				"canonical format. Example: "
> +				"8c628557-6987-42b2-ba16-b7cc79ddfb43\n");
> +			return 1;
> +		}
> +
> +		memcpy(&fsuuid->fsu_uuid, uuid, sizeof(uuid));
> +		if (ioctl(fd, EXT4_IOC_SETFSUUID, fsuuid)) {
> +			fprintf(stderr, "%s while trying to set fs uuid\n",
> +				strerror(errno));
> +			return 1;
> +		}
> +	} else {
> +		fprintf(stderr, "Invalid command\n");
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> diff --git a/tests/ext4/056 b/tests/ext4/056
> new file mode 100755
> index 00000000..376f2972
> --- /dev/null
> +++ b/tests/ext4/056
> @@ -0,0 +1,64 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Google, Inc. All Rights Reserved.
> +#
> +# Test the set/get UUID ioctl.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto ioctl
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +        cd /
> +        rm -r -f $tmp.*
> +        kill -9 $fsstress_pid 2>/dev/null;
> +        wait $fsstress_pid > /dev/null 2>&1

I think "wait" is enough. With this change, it's good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs ext4
> +_require_scratch
> +_require_test_program uuid_ioctl
> +_require_command $UUIDGEN_PROG uuidgen
> +
> +UUID_IOCTL=$here/src/uuid_ioctl
> +
> +# If the ioctl is not supported by the kernel, then skip test.
> +current_uuid=$($UUID_IOCTL get $SCRATCH_MNT 2>&1)
> +if [[ "$current_uuid" =~ ^Inappropriate[[:space:]]ioctl ]]; then
> +        _notrun "UUID ioctls are not supported by kernel."
> +fi
> +
> +# metadata_csum_seed must be set to decouple checksums from the uuid.
> +# Otherwise, checksums need to be recomputed when the uuid changes, which
> +# is not supported by the ioctl.
> +_scratch_mkfs_ext4 -O metadata_csum_seed >> $seqres.full 2>&1
> +_scratch_mount
> +
> +# Begin fsstress while modifying UUID
> +fsstress_args=$(_scale_fsstress_args -d $SCRATCH_MNT -p 15 -n 999999)
> +$FSSTRESS_PROG $fsstress_args > /dev/null 2>&1 &
> +fsstress_pid=$!
> +
> +for n in $(seq 1 20); do
> +        new_uuid=$($UUIDGEN_PROG)
> +
> +        echo "Setting UUID to ${new_uuid}" >> $seqres.full 2>&1
> +        $UUID_IOCTL set $SCRATCH_MNT $new_uuid
> +
> +        current_uuid=$($UUID_IOCTL get $SCRATCH_MNT)
> +        echo "$UUID_IOCTL get $SCARTCH_MNT: $current_uuid" >> $seqres.full 2>&1
> +        if [[ "$current_uuid" != "$new_uuid" ]]; then
> +                echo "Current UUID ($current_uuid) does not equal what was sent with the ioctl ($new_uuid)"
> +        fi
> +done
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/ext4/056.out b/tests/ext4/056.out
> new file mode 100644
> index 00000000..6142fcd2
> --- /dev/null
> +++ b/tests/ext4/056.out
> @@ -0,0 +1,2 @@
> +QA output created by 056
> +Silence is golden
> -- 
> 2.37.0.170.g444d1eabd0-goog
> 

