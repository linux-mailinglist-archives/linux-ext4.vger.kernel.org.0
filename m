Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED12C567282
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Jul 2022 17:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiGEPZS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Jul 2022 11:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiGEPZR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Jul 2022 11:25:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6F3A18B3E
        for <linux-ext4@vger.kernel.org>; Tue,  5 Jul 2022 08:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657034715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PIB0P1ZoPByNJNpXaSib9unjusLtkFO0XUkrmvBQSyU=;
        b=hsNc1wfOEsJID5GrgvR7uSFNlslzTnyPaEwXEXzKf6UoGm47oBsDI7CFa2hdYRAkLCRiNq
        9ZN7+kdb9YDFxLXg/2CP6KgtUD6D5LezFgSStEN8nEgEC8Pi7xTNyNagbvh4ZfMz/bHMF6
        yMv9Cx6cXO3aWAQ9ur8xLkLPmH5fZG8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-nZcYEXdzNCuHUYP26x-ABA-1; Tue, 05 Jul 2022 11:25:14 -0400
X-MC-Unique: nZcYEXdzNCuHUYP26x-ABA-1
Received: by mail-qt1-f197.google.com with SMTP id m6-20020ac866c6000000b002f52f9fb4edso9626739qtp.19
        for <linux-ext4@vger.kernel.org>; Tue, 05 Jul 2022 08:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PIB0P1ZoPByNJNpXaSib9unjusLtkFO0XUkrmvBQSyU=;
        b=qqxmINRR4WwHaIwvoYcsDKPnp6HWmL2/y0FpAPh/aa/JVvTt8oObb2sUZhkP6dPZR8
         d/VWQyyf8U0ab+TTAcxjgQePKpTxL9TOxhKpYvZ+0Jjearcijxn0Hy0ZN1cxRVw/C/bY
         5n+f/+MHZMZrndhUTAszmCjH6VMGiuDF9NyKQCcGE+XezDDkd73UfY3WKV1wJLbudG84
         IsstfEcLNXCJ4s6952ThC35KI5Tugue5Y2TcS6GYH28yuU3jUEu0UDjsZbWV85yd33cz
         Th6MeX4q8YepZgDgdteiSdapNmBsNPQ+Gz/S3Shfycn3CkWRLAKZzTeu2dJFT+bTsank
         h4Iw==
X-Gm-Message-State: AJIora9DV0v5mbaIdP+6L9PQHHXbSugIOa14R7ePWUSn58YJgJJTRyhT
        hj5N1aQI+CQTiv/nBMS5ras5cAosAkor8rxUDqgF/A+7li+Q3YGRSZbdSyI/+UTIuaUyWxdJlgf
        y/83OhVhg2JgyteisqdUEUQ==
X-Received: by 2002:a05:620a:44c9:b0:6b2:1f49:f0f5 with SMTP id y9-20020a05620a44c900b006b21f49f0f5mr19715012qkp.327.1657034713911;
        Tue, 05 Jul 2022 08:25:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tqJ0OR6rL5oq2vdysVxabgA+/B7oTYTurnjibitwzcRLzgT3r1/dwa+oHSWlpmj3Fl6RKNBA==
X-Received: by 2002:a05:620a:44c9:b0:6b2:1f49:f0f5 with SMTP id y9-20020a05620a44c900b006b21f49f0f5mr19714984qkp.327.1657034713556;
        Tue, 05 Jul 2022 08:25:13 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a0bca00b006af0ce13499sm26931607qki.115.2022.07.05.08.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 08:25:13 -0700 (PDT)
Date:   Tue, 5 Jul 2022 23:25:07 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeremy Bongio <bongiojp@gmail.com>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH v2] ext4/056: add a check to make sure ext4 uuid ioctls
 get/set during fsstress.
Message-ID: <20220705152507.wsnqr56o7h3hzfxn@zlang-mailbox>
References: <20220701201332.183711-1-bongiojp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701201332.183711-1-bongiojp@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 01, 2022 at 01:13:32PM -0700, Jeremy Bongio wrote:
> Adds a utility to set/get uuid through ext4 ioctl. Executes the ioctls
> while running fsstress. These ioctls are used by tune2fs to safely change
> the uuid without racing other filesystem modifications.
> 
> Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
> ---
>  .gitignore         |   1 +
>  src/Makefile       |   4 +-
>  src/uuid_ioctl.c   | 106 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/056     |  55 +++++++++++++++++++++++
>  tests/ext4/056.out |   2 +
>  5 files changed, 166 insertions(+), 2 deletions(-)
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
> index 00000000..a4937478
> --- /dev/null
> +++ b/src/uuid_ioctl.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Test program which uses the raw ext4 set_fsuuid ioctl directly.
> + * SYNOPSIS:
> + *   $0 COMMAND MOUNT_POINT [UUID]
> + *
> + * COMMAND must be either "get" or "set".
> + * The UUID must be a 16 octet represented as 32 hexadecimal digits in canonical
> + * textual representation, e.g. output from `uuidgen`.
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
> +	__u32   fu_len;
> +	__u32   fu_flags;
> +	__u8    fu_uuid[];
> +};
> +
> +#define EXT4_IOC_SETFSUUID_FLAG_BLOCKING 0x1
> +
> +#ifndef EXT4_IOC_GETFSUUID
> +#define EXT4_IOC_GETFSUUID      _IOR('f', 44, struct fsuuid)
> +#endif
> +
> +#ifndef EXT4_IOC_SETFSUUID
> +#define EXT4_IOC_SETFSUUID      _IOW('f', 44, struct fsuuid)
> +#endif

Will this be ext4 only ioctl? If this C program is only used for ext4 ioctl, I'd
like to rename it as "ext4_uuid_ioctl.c" (or something else make it not likes a
common test program). I think XFS doesn't has this ioctl, for now at least, it
get/set uuid by another way.

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
> +	fsuuid->fu_len = sizeof(uuid_t);
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
> +		memcpy(&uuid, fsuuid->fu_uuid, sizeof(uuid));
> +		uuid_unparse(uuid, uuid_str);
> +		printf("%s", uuid_str);
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
> +		memcpy(&fsuuid->fu_uuid, uuid, sizeof(uuid));
> +		fsuuid->fu_flags = EXT4_IOC_SETFSUUID_FLAG_BLOCKING;
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
> index 00000000..ebefb136
> --- /dev/null
> +++ b/tests/ext4/056
> @@ -0,0 +1,55 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Test the set/get UUID ioctl.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto ioctl
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
> +# if the ioctl is not supported by the kernel, then skip test.
> +current_uuid=$($UUID_IOCTL get $SCRATCH_MNT 2>&1)
> +if [[ "$current_uuid" =~ ^Inappropriate[[:space:]]ioctl ]]; then
> +        _notrun "UUID ioctls are not supported by kernel."
> +fi
> +
> +# Create filesystem and mount

Rather than this such obvious comment description, explain why the below
"metadata_csum_seed" is necessary?

> +_scratch_mkfs_ext4 -O metadata_csum_seed >> $seqres.full 2>&1
> +_scratch_mount >> $seqres.full
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
> +                echo "Current UUID ($current_uuid) does not equal what "
> +                "was sent with the ioctl ($new_uuid)"

Can these two lines really be printed?

> +        fi
> +done
> +
> +# success, all done
> +echo "Silence is golden"
> +kill $fsstress_pid >/dev/null 2>&1
> +wait

We can't make sure the testing will exit normally, so better to make sure the
fsstress processes are killed in _cleanup(). You can refer to generic/390.

Thanks,
Zorro

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
> 2.37.0.rc0.161.g10f37bed90-goog
> 

