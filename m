Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5149C57A2CF
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Jul 2022 17:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiGSPSO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Jul 2022 11:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiGSPSN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Jul 2022 11:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C7E138A2
        for <linux-ext4@vger.kernel.org>; Tue, 19 Jul 2022 08:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658243891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N8X8r181SsE9bGEmXcY27OkuM3iBb59YL7z0rwhEJrQ=;
        b=byNXcX0C7ZHOzv0daluc3oEhWHYvWF5g25Had71JWpENXHwIfeREyVDMwQCH1T9L6lc/TQ
        dABjbjfW0O6I05Fke2K4Guc0g9kOBZKs9yoF4ZM4otrZkT58JNfTaegpzLFO2HDMrXZNXL
        8uwU9bUeirH2QbrRnJxi3RDk7vD9KFQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-05qCXUSgNAebyUF0CSNATw-1; Tue, 19 Jul 2022 11:18:10 -0400
X-MC-Unique: 05qCXUSgNAebyUF0CSNATw-1
Received: by mail-qk1-f198.google.com with SMTP id br36-20020a05620a462400b006b5fa8e5dd5so2491310qkb.1
        for <linux-ext4@vger.kernel.org>; Tue, 19 Jul 2022 08:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N8X8r181SsE9bGEmXcY27OkuM3iBb59YL7z0rwhEJrQ=;
        b=YCSr6Wqu/6r0JxokahEMkZwYi5+TMdZINMDw0i0D1t43ubMHRJ+M66YjFKGu73MZGc
         r8OloJMT9hqxPwRvoWVB4JBb67lpWhGTN/Ah0OEtzqS5iIOHXRpJU8GNCm8lyGls1v1t
         Sjwv683TmmAKndg87APR8Ne+DrulPhL3m4eGiHI/tzoDya30w9fx8sbPsjuYgtmThAnp
         lftpnG625X3vpGj4pvxwi4C/5idv9zSG4LXoyYBDkTtKENPZG38QOaD2Ia395mJQprjO
         v73r0/a6YRwHFaTUL8U8cqYtAsnQlLUxepOIVTJLqe56Xw+Bg3clvvqu96w0cTyNuW58
         L8IQ==
X-Gm-Message-State: AJIora+Yu1iQqC7qURxWBa0959nL0/ysnvkdZHEkQ5Xok3OBU6PY1yS6
        0uTM/GOalOEjNDBb9QUB0dUIzn27n+Y3EjlDPLWgbz4ydw8sObI1Wo2MMZXwPnv2g3falb7dwMr
        PFZErLTr+SMqfj07Do3oyuw==
X-Received: by 2002:ac8:5bd2:0:b0:31e:f083:7e57 with SMTP id b18-20020ac85bd2000000b0031ef0837e57mr7239865qtb.524.1658243889325;
        Tue, 19 Jul 2022 08:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uJ1q8ib/14PjQsbHlSX0P3T+t9ZUZOYoh+KdNjFCilOmqesAX0uXj5TMhObq1PUWsxT9eTMA==
X-Received: by 2002:ac8:5bd2:0:b0:31e:f083:7e57 with SMTP id b18-20020ac85bd2000000b0031ef0837e57mr7239837qtb.524.1658243889040;
        Tue, 19 Jul 2022 08:18:09 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j11-20020a05620a288b00b006b5ad8e5c3asm14624696qkp.68.2022.07.19.08.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:18:08 -0700 (PDT)
Date:   Tue, 19 Jul 2022 23:18:02 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeremy Bongio <bongiojp@gmail.com>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH v4] ext4/056: add a check to make sure ext4 uuid ioctls
 get/set during fsstress.
Message-ID: <20220719151802.iw42b3wrpcgynmyg@zlang-mailbox>
References: <20220719064853.152501-1-bongiojp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719064853.152501-1-bongiojp@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 18, 2022 at 11:48:53PM -0700, Jeremy Bongio wrote:
> Adds a utility to set/get uuid through ext4 ioctl. Executes the ioctls
> while running fsstress. These ioctls are used by tune2fs to safely change
> the uuid without racing other filesystem modifications.
> 
> Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
> ---
> 
> Outstanding fsstress pid is killed in _cleanup().
> 
> Copyright added.
> 
> Newline added to uuid_ioctl output.
> 
> fu_* fields are now named fsu_*.
> 
>  .gitignore         |   1 +
>  src/Makefile       |   4 +-
>  src/uuid_ioctl.c   | 105 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/056     |  63 +++++++++++++++++++++++++++
>  tests/ext4/056.out |   2 +
>  5 files changed, 173 insertions(+), 2 deletions(-)
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
> index 00000000..7fa4ac18
> --- /dev/null
> +++ b/tests/ext4/056
> @@ -0,0 +1,63 @@
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

wait ??

I think it's worth waiting at here. Due you this's the only one place we try to
kill fsstress processes, and we'd better to make sure there're not background
processes to cause later 'umount' fail.

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
                  ^^^^^^^^^^^^^^^
                 Useless, remove it directly

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

