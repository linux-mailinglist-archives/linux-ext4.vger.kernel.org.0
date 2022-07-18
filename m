Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59931578761
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Jul 2022 18:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiGRQ25 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Jul 2022 12:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbiGRQ2s (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Jul 2022 12:28:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E2FE3;
        Mon, 18 Jul 2022 09:28:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33516B81074;
        Mon, 18 Jul 2022 16:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58D0C341C0;
        Mon, 18 Jul 2022 16:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658161723;
        bh=x3YJVmOAJO6vXwxrUrX6FZun+JU8E91C4NxAd+ydL4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AKsagVgW5BSwWPFh8Lhi4rqR1Fzkn+j+FHTCV3seyyJubrFoa5CyZMUDIfAOenffa
         F+wUydb1v4lYswyeGE3ZUf3ivaLv0BsMCK9Zuz0P3LM1/gJEvuVj6KP8GIUK4zhngl
         C9zg8G665LGqseRnFzrFPrm0Z2qSaA5+myQ/SGWEiFOy1VLMfdQeCa+whFI+GoajKT
         Ye9djWbHmnnkBS4cNU4cIXaD6jHsTskQzu96gDPGRFBDXhSQwuMrlA9b4wgfUGs88U
         5+Dtk5Pq/2kjiaZielQnAveLuRqXbvr+1ZntV5TkppLp0MnsjQ9z1CJkwAvnnCJJfw
         XElD2JAlGkMSQ==
Date:   Mon, 18 Jul 2022 09:28:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeremy Bongio <bongiojp@gmail.com>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH v3] ext4/056: add a check to make sure ext4 uuid ioctls
 get/set during fsstress.
Message-ID: <YtWKO5acSlpHfkRv@magnolia>
References: <20220712080153.471437-1-bongiojp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712080153.471437-1-bongiojp@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Nit: "16 octet sequence", not just "16 octet" ?

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

printf("%s\n", uuid_str); perhaps?

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

It's unusual that there's no copyright or authorship attribution in any
of these new files, but perhaps that's deliberate?

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

Same thing Zorro said about using the new generic/390 method of starting
and killing fsstress pids.

With those bits fixed up I think this is more or less ready to go.

--D

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
