Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3022555AEF6
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jun 2022 06:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiFZEoI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 26 Jun 2022 00:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbiFZEoH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 26 Jun 2022 00:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93A7213D15
        for <linux-ext4@vger.kernel.org>; Sat, 25 Jun 2022 21:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656218645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=arHf+ANxJDI0hQ8qj6GIDK7awNKxZGlAP2yk16Mo0tc=;
        b=BLZx+IrV8WqvaZG8cDUqOvFIZSY6mBvkuXBxlGsaZKEO6z9PSOqm6DGW6pTo2F4NxB0RuF
        gLjdPyKg3jES3JwiwJdNPdQ7UgQlA63JlRK75vJRtjjZoyrW+eBlGzKwza7CYVDxIyjaKh
        A8N5JzIc/3FzwDYDFxW7fDgOQE50b+Q=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-vpcCLdwlO6OiN42kkWEpng-1; Sun, 26 Jun 2022 00:44:03 -0400
X-MC-Unique: vpcCLdwlO6OiN42kkWEpng-1
Received: by mail-qv1-f72.google.com with SMTP id ls8-20020a0562145f8800b0047078180732so6335424qvb.2
        for <linux-ext4@vger.kernel.org>; Sat, 25 Jun 2022 21:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=arHf+ANxJDI0hQ8qj6GIDK7awNKxZGlAP2yk16Mo0tc=;
        b=gGFiz8bJRXLXCHweiqmCyma8xCzhMCLn69Rq1gjQayXOOW0p73E+DCIzWXxrKqsu0y
         Y55Be5yYuhfHnYNONMFzda09y+xDzKNnv1Hm9no1QlihTJo8ceglrSGu+EyDVztTaNVO
         Fd9NZR3Mdrav5vd0S93iXwM5SukBm/a87QcskJrA33oJMnTVx+yrBlM0mRIDGIs5DzYQ
         UB9HeSfNRnlWDpc47aZCFgXr/jf6flShRSJc0iiTMwnB0Ee5+iMK93W8Az9v1Dq/8xoF
         kMRPUVSGP/bXk0RbI0/egp/2n4esCfEZ2zjYhtZ8PQ1tztE5Y4weVsEi9QrPb0rRg446
         Yffw==
X-Gm-Message-State: AJIora/+Npk/k/XJx/g5N/dMVGkkkAi8zIwy4GqRasYN4UMmp424njwf
        nd7CCSG2gTlGrKXBBNfp1BMWPrtd/MlkbuQ37MqcczzrpBhLABDhZEq4dpEv4ygTUtZBgsVwW07
        hSBk9j0UU5/3XXmCq28Av2g==
X-Received: by 2002:a05:620a:372c:b0:6a7:3ad2:68cd with SMTP id de44-20020a05620a372c00b006a73ad268cdmr4599805qkb.418.1656218642678;
        Sat, 25 Jun 2022 21:44:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sFZ0ZrtkfZNt1XgBSRsEC5+Xea2ig8+LC9TEBH+I+ytKp8vAsicTz89NdJpocbwJlK3Uc5tA==
X-Received: by 2002:a05:620a:372c:b0:6a7:3ad2:68cd with SMTP id de44-20020a05620a372c00b006a73ad268cdmr4599796qkb.418.1656218642338;
        Sat, 25 Jun 2022 21:44:02 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 194-20020a370acb000000b006a8b6848556sm5536707qkk.7.2022.06.25.21.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 21:44:01 -0700 (PDT)
Date:   Sun, 26 Jun 2022 12:43:56 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeremy Bongio <bongiojp@gmail.com>
Cc:     Ted Tso <tytso@mit.edu>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4/056: add a check to make sure ext4 uuid ioctls
 get/set during fsstress.
Message-ID: <20220626044356.aguhlcj2fb4embbj@zlang-mailbox>
References: <20220625085321.109451-1-bongiojp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625085321.109451-1-bongiojp@gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jun 25, 2022 at 01:53:21AM -0700, Jeremy Bongio wrote:
> Adds a utility to get/set uuid through ext4 ioctl. Executes the ioctls while
> running fsstress. These ioctls are used by tune2fs to safely change the uuid
> without racing other filesystem modifications.
> 
> Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
> ---

Hi Jeremy,

Thanks for the patch, some picky review points as below:

>  src/Makefile       |   4 +-
>  src/global.h       |   2 +
>  src/uuid_ioctl.c   | 106 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/056     |  59 +++++++++++++++++++++++++
>  tests/ext4/056.out |   1 +
>  5 files changed, 170 insertions(+), 2 deletions(-)
>  create mode 100644 src/uuid_ioctl.c
>  create mode 100755 tests/ext4/056
>  create mode 100644 tests/ext4/056.out
> 
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
> diff --git a/src/global.h b/src/global.h
> index b4407099..747d95f8 100644
> --- a/src/global.h
> +++ b/src/global.h
> @@ -184,4 +184,6 @@ roundup_64(unsigned long long x, unsigned int y)
>  	return rounddown_64(x + y - 1, y);
>  }
>  
> +#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
> +
>  #endif /* GLOBAL_H */
> diff --git a/src/uuid_ioctl.c b/src/uuid_ioctl.c
> new file mode 100644
> index 00000000..51480689
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
> +#include "global.h"
> +
> +struct fsuuid {
> +        size_t len;
> +        __u8 *b;
> +};
> +
> +#ifndef EXT4_IOC_GETFSUUID
> +#define EXT4_IOC_GETFSUUID      _IOR('f', 44, struct fsuuid)
> +#endif
> +
> +#ifndef EXT4_IOC_SETFSUUID
> +#define EXT4_IOC_SETFSUUID      _IOW('f', 45, struct fsuuid)
> +#endif
> +
> +int main(int argc, char **argv)
> +{
> +	int	error, fd;
> +        struct fsuuid fsuuid;
        ^

Bad indent at here, please check the indent of this program.

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
> +	BUILD_BUG_ON(sizeof(uuid_t) % 16);
> +	fsuuid.len = 16;
> +	fsuuid.b = calloc(fsuuid.len, sizeof(__u8));
> +
> +	if (strcmp(argv[1], "get") == 0) {
> +		uuid_t uuid;
> +		char uuid_str[37];
> +
> +		if (ioctl(fd, EXT4_IOC_GETFSUUID, &fsuuid)) {
> +			close(fd);
> +			fprintf(stderr, "%s while trying to get fs uuid\n",
> +				strerror(errno));
> +			return 1;
> +		}
> +
> +		memcpy(&uuid, fsuuid.b, sizeof(uuid));
> +		uuid_unparse(uuid, uuid_str);
> +		printf("%s", uuid_str);
> +	} else if (strcmp(argv[1], "set") == 0) {
> +		if (argc != 4) {
> +			fprintf(stderr, "UUID argument missing.\n");
> +			return 1;
> +		}
> +
> +		if (strlen(argv[3]) != 36) {
> +			fprintf(stderr, "Invalid UUID. The UUID should be in "
> +				"canonical format. Example: "
> +				"8c628557-6987-42b2-ba16-b7cc79ddfb43\n");
> +			return 1;
> +		}
> +
> +		uuid_t uuid;
> +		error = uuid_parse(argv[3], uuid);
> +		if (error < 0) {
> +			fprintf(stderr, "%s: invalid UUID.\n", argv[0]);
> +			return 1;
> +		}
> +
> +		memcpy(fsuuid.b, uuid, sizeof(uuid));
> +		if(ioctl(fd, EXT4_IOC_SETFSUUID, &fsuuid)) {
> +			close(fd);
> +			fprintf(stderr, "%s while trying to set fs uuid\n",
> +				strerror(errno));
> +			return 1;
> +		}
> +	} else {
> +		fprintf(stderr, "Invalid command\n");
> +	}
> +
> +	close(fd);
> +	return 0;
> +}
> diff --git a/tests/ext4/056 b/tests/ext4/056
> new file mode 100755
> index 00000000..46631d46
> --- /dev/null
> +++ b/tests/ext4/056
> @@ -0,0 +1,59 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2000-2005 Silicon Graphics, Inc.  All Rights Reserved.
> +#
> +# Test the set/get UUID ioctl.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto ioctl resize

Why this case is "resize" related?

> +
> +tmpfile="/tmp/$$."
> +trap "rm -f $tmpfile; exit" 0 1 2 3 15

We have default "trap" when you source ./common/preamble. If you need a custom
cleanup by youself, you can define a new one in this case (refer to other cases
which has their own _cleanup).

> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs ext4
> +_require_scratch
> +_require_test_program uuid_ioctl
> +
> +UUID_IOCTL=$here/src/uuid_ioctl
> +
> +# if the ioctl is not supported by the kernel, then skip test.
> +current_uid=$($UUID_IOCTL get $SCRATCH_MNT)
> +if [[ "$current_uid" = "Inappropriate ioctl for device while trying to set fs uuid" ]]; then
> +  _notrun "UUID ioctls are not supported by kernel."
   ^

It's not fault, but we recommended the tab width is 8, for fstests bash script.

> +fi
> +
> +# Create filesystem and mount
> +_scratch_mkfs_ext4 -O metadata_csum_seed >> $seqres.full 2>&1
                                            ^
Generally we make sure $seqres.full is null (rm -f $seqres.full) or truncated
at first. So an easier way is using "> $seqres.full" at the first place which
trys to write $seqres.full, to clean .full file.

> +_scratch_mount >> $seqres.full
> +
> +# Begin fsstress while modifying UUID
> +fsstress_args=$(_scale_fsstress_args -d $SCRATCH_MNT -p 15 -n 999999)
> +"$FSSTRESS_PROG" $fsstress_args > /dev/null &

Better to use "2>&1" if you don't want this case fails on some weird fsstress
error output. Or ">>$seqres.full 2>&1" if you'd like to know what happened
on fsstress.

Do I miss something? I didn't find any place try to make sure above fsstress
process is killed/end (by using kill and wait).

> +
> +test_uuid_ioctl()
> +{
> +  for n in $(seq 1 20); do
> +    new_uuid=$(uuidgen)

I think uuidgen isn't a tool which is 100% installed on all linux system. So

_require_command $UUIDGEN_PROG uuidgen

> +
> +    echo "Setting UUID to ${new_uuid}" >> $seqres.full 2>&1
> +    $UUID_IOCTL set $SCRATCH_MNT $new_uuid >> $seqres.full 2>&1
> +
> +    current_uuid=$($UUID_IOCTL get $SCRATCH_MNT)
> +    echo "$UUID_IOCTL get $SCARTCH_MNT: $current_uuid" >> $seqres.full 2>&1
> +    if [[ "$current_uuid" != "$new_uuid" ]]; then
> +      echo "UUID does not equal what was sent with the ioctl"
> +      exit

I think break is enough, but exit is fine too.

> +    fi
> +  done
> +}
> +
> +test_uuid_ioctl

I'm wondering why not run the code in test_uuid_ioctl directly. Looks like you
just make them into a function, then run this function once. It doesn't use
local variables, or be called many times, or have many complicated lines. Or
you'd like to package the codes in "for n in $(seq 1 20)" loop?

> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/056.out b/tests/ext4/056.out
> new file mode 100644
> index 00000000..06f52bb4
> --- /dev/null
> +++ b/tests/ext4/056.out
> @@ -0,0 +1 @@
> +QA output created by 056

Silence is golden ?

Thanks,
Zorro

> -- 
> 2.37.0.rc0.161.g10f37bed90-goog
> 

