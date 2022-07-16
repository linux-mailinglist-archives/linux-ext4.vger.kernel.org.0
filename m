Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8C7576FFA
	for <lists+linux-ext4@lfdr.de>; Sat, 16 Jul 2022 17:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiGPPvM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 16 Jul 2022 11:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGPPvL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 16 Jul 2022 11:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A00E18399
        for <linux-ext4@vger.kernel.org>; Sat, 16 Jul 2022 08:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657986669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eLWEjzT8SlIlJ6rGvXY2AlZ8PbJ/EDswSTc9lUZbhOw=;
        b=TXR+wgJ7XqbTOStVj/H4laogBOb5K/nU3yS2slYT8PLFXArbZgu8t/iHTniTyLoEg3V4lc
        hGP3B0mGDgY0a0PX73qxpcFEASSqy33jqNRuSy/aP9VEYa1CTkEz6OQmSa95cPDS1Zly0s
        poKCoD30axUEtoCoOGZut4kP3P9G6sU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-th-NnwToNCendKqP31Id5g-1; Sat, 16 Jul 2022 11:51:07 -0400
X-MC-Unique: th-NnwToNCendKqP31Id5g-1
Received: by mail-qk1-f198.google.com with SMTP id s9-20020a05620a254900b006b54dd4d6deso5778623qko.3
        for <linux-ext4@vger.kernel.org>; Sat, 16 Jul 2022 08:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eLWEjzT8SlIlJ6rGvXY2AlZ8PbJ/EDswSTc9lUZbhOw=;
        b=ixiuojggqQLZ8zekvFYTx1R2cAvbNWH/N5xCEXiCMcEcoNDKf55bP5rhoaymLEgzdu
         9QjevZXheKiPdL3e5Er96Fb8mpaBwSJzyYgfHSHsnE0g420fyXnI3hy5bj0sEn9K0/GN
         v5kYjrfgo9C3Fl9t4T6WFJItMKVojD0wB/bqXBQa2kmZGa0C7nDPbRJemGVUAhrq3KR7
         E/AM6p0RvQ/4wMDnmuDyl37pF+5/hzthY0mvTuSXtB1Z0kkK8dGvGzkqshhFYtGqVMAU
         C5Mhpx/Hz+3tlmz+OCDTDuWgAIG1vdqPnYAEupB2cCUiqVUD72qlZnxwr7CXGqJqycO5
         o20w==
X-Gm-Message-State: AJIora8HT1AlPrPJVkZd0f6RqNBv+KUzYWFjh4L0TBc+q4ABkZnddAFR
        +/yL8CatnCFheAi8sEcl7ZJrE6yTOx9nDw0b3+fjtBZbKu7GpfACO7cu/rt1SD92JlPBSgA4So+
        Q6Bmv8BuZlzHirD+DhUm2lQ==
X-Received: by 2002:a05:622a:50d:b0:31e:ea35:8ab5 with SMTP id l13-20020a05622a050d00b0031eea358ab5mr955803qtx.427.1657986667402;
        Sat, 16 Jul 2022 08:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vAl/QO424Vg203KNGGWmQjufhT6/OE1W7gF2fd5vB6Pdlh5lkd2v89rk4P16LSXr9FATnqUw==
X-Received: by 2002:a05:622a:50d:b0:31e:ea35:8ab5 with SMTP id l13-20020a05622a050d00b0031eea358ab5mr955791qtx.427.1657986667050;
        Sat, 16 Jul 2022 08:51:07 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a280800b006a6ce613c7csm576565qkp.89.2022.07.16.08.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 08:51:06 -0700 (PDT)
Date:   Sat, 16 Jul 2022 23:50:59 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeremy Bongio <bongiojp@gmail.com>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH v3] ext4/056: add a check to make sure ext4 uuid ioctls
 get/set during fsstress.
Message-ID: <20220716155059.jdp3ciqhb5j6ihuo@zlang-mailbox>
References: <20220712080153.471437-1-bongiojp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712080153.471437-1-bongiojp@gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 12, 2022 at 01:01:53AM -0700, Jeremy Bongio wrote:
> Adds a utility to set/get uuid through ext4 ioctl. Executes the ioctls
> while running fsstress. These ioctls are used by tune2fs to safely change
> the uuid without racing other filesystem modifications.
> 
> Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
> ---
>  .gitignore         |   1 +
>  src/Makefile       |   4 +-
>  src/uuid_ioctl.c   | 104 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/056     |  61 ++++++++++++++++++++++++++
>  tests/ext4/056.out |   2 +
>  5 files changed, 170 insertions(+), 2 deletions(-)
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
> index 00000000..367e5ed5
> --- /dev/null
> +++ b/src/uuid_ioctl.c
> @@ -0,0 +1,104 @@
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
> +	fsuuid->fu_len = sizeof(uuid_t);
> +	fsuuid->fu_flags = 0;
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
> index 00000000..4a011fa3
> --- /dev/null
> +++ b/tests/ext4/056
> @@ -0,0 +1,61 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
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
> +  cd /
> +  rm -r -f $tmp.*
> +  $KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1

Better to refer to generic/390 ($fsstress_pid related part), it's current
recommended way to kill fsstress processes (before we have a fsstress_cleanup).
Others looks good to me, welcome more review points.

Thanks,
Zorro

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
> +_scratch_mount >> $seqres.full
> +
> +# Begin fsstress while modifying UUID
> +fsstress_args=$(_scale_fsstress_args -d $SCRATCH_MNT -p 15 -n 999999)
> +$FSSTRESS_PROG $fsstress_args > /dev/null 2>&1 &
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
> 2.37.0.144.g8ac04bfd2-goog
> 

