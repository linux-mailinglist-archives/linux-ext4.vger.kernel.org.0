Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBE8567CFC
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Jul 2022 06:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiGFEGu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Jul 2022 00:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiGFEGt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Jul 2022 00:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3817C1C93E
        for <linux-ext4@vger.kernel.org>; Tue,  5 Jul 2022 21:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657080407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gA8tVthaUBeiD+VVwk7EEc1A2IUpND1y59kIELcdk64=;
        b=RsnsWy42jiK67Bmn60aIisJSY85qc69Mt0KLNLSwGsNFZhiIMj1WX3yzBlbDXVvCMciRHI
        5GOLIh/E/+KEL7ZdiKqz8RNIH4HKhOwWsHmXICOklUf9YLENTImVZ/tofm04DmOzxe45y8
        //JGqXVnKi+1A59qRnnlglpOpUNDrog=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-exLPHgNUOk6fng0ajLugiA-1; Wed, 06 Jul 2022 00:06:45 -0400
X-MC-Unique: exLPHgNUOk6fng0ajLugiA-1
Received: by mail-qk1-f199.google.com with SMTP id ay43-20020a05620a17ab00b006b25a9bef3dso12441579qkb.7
        for <linux-ext4@vger.kernel.org>; Tue, 05 Jul 2022 21:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gA8tVthaUBeiD+VVwk7EEc1A2IUpND1y59kIELcdk64=;
        b=gz9FbzZqJbSE/tkVAn2dNjv9aNWNtWsXyh9K0IVyCjyv3HPZ643bYxwp18LuZ+lUe4
         3xA2x+FEJtQkKjpPIX0J4jofJEm408VVLExXS3tg8pdkWKpkt7NwZlhO6Wwb9VW+duAs
         4D+BLR4jyokiAFLr36X3cMj9pqQxnIiRMTuo68iaTFdoD6Rbus7d4I0CEfqKqzyVVbT+
         wpHAh0J5rTmhzgp/LFuEEQlAauvYHVnyZzpUG1znYNzlZpEGjlb5hGhCCjOGE8BW5LV8
         d91Cv4CHOlk+gDc0dI1CAzWgVLHFr4jq/8FaGZduZJ0o1ECi9A0hy1lqIwrgKIK+NTx4
         R9KA==
X-Gm-Message-State: AJIora+NlP/ofTYry1AA72MpZOmS54V0S/vYDc1eI2NrmBPp9T7+uLnB
        aSGdMCVbGDJcPSmJJE9DCRCwVLvjmuh+9+UtNbMwi0ocgI1WzP3HGZuNyMNFFyJiOrHcYWQyTsS
        628feeVpjS5cOE/8hHAbekg==
X-Received: by 2002:a05:6214:4110:b0:470:7aff:7e8d with SMTP id kc16-20020a056214411000b004707aff7e8dmr35431729qvb.74.1657080405328;
        Tue, 05 Jul 2022 21:06:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sm+r4UDqGA7Zt4laiG6Z4cWBENMNKsU1HysqXfqSHodh2wKeDcSCsWBUA64bDFJWC2K74/0A==
X-Received: by 2002:a05:6214:4110:b0:470:7aff:7e8d with SMTP id kc16-20020a056214411000b004707aff7e8dmr35431721qvb.74.1657080405067;
        Tue, 05 Jul 2022 21:06:45 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d8-20020ac85ac8000000b00304e70585f9sm25540063qtd.72.2022.07.05.21.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 21:06:44 -0700 (PDT)
Date:   Wed, 6 Jul 2022 12:06:38 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jeremy Bongio <bongiojp@gmail.com>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] ext4/056: add a check to make sure ext4 uuid ioctls
 get/set during fsstress.
Message-ID: <20220706040638.wxt52glkncefarur@zlang-mailbox>
References: <20220701201332.183711-1-bongiojp@gmail.com>
 <20220705152507.wsnqr56o7h3hzfxn@zlang-mailbox>
 <YsS46dI6XQcJB/2B@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsS46dI6XQcJB/2B@magnolia>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 05, 2022 at 03:19:21PM -0700, Darrick J. Wong wrote:
> On Tue, Jul 05, 2022 at 11:25:07PM +0800, Zorro Lang wrote:
> > On Fri, Jul 01, 2022 at 01:13:32PM -0700, Jeremy Bongio wrote:
> > > Adds a utility to set/get uuid through ext4 ioctl. Executes the ioctls
> > > while running fsstress. These ioctls are used by tune2fs to safely change
> > > the uuid without racing other filesystem modifications.
> > > 
> > > Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
> > > ---
> > >  .gitignore         |   1 +
> > >  src/Makefile       |   4 +-
> > >  src/uuid_ioctl.c   | 106 +++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/ext4/056     |  55 +++++++++++++++++++++++
> > >  tests/ext4/056.out |   2 +
> > >  5 files changed, 166 insertions(+), 2 deletions(-)
> > >  create mode 100644 src/uuid_ioctl.c
> > >  create mode 100755 tests/ext4/056
> > >  create mode 100644 tests/ext4/056.out
> > > 
> > > diff --git a/.gitignore b/.gitignore
> > > index ba0c572b..dab24d68 100644
> > > --- a/.gitignore
> > > +++ b/.gitignore
> > > @@ -169,6 +169,7 @@ tags
> > >  /src/unwritten_mmap
> > >  /src/unwritten_sync
> > >  /src/usemem
> > > +/src/uuid_ioctl
> > >  /src/writemod
> > >  /src/writev_on_pagefault
> > >  /src/xfsctl
> > > diff --git a/src/Makefile b/src/Makefile
> > > index 111ce1d9..e33e04de 100644
> > > --- a/src/Makefile
> > > +++ b/src/Makefile
> > > @@ -31,14 +31,14 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> > >  	dio-invalidate-cache stat_test t_encrypted_d_revalidate \
> > >  	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
> > >  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
> > > -	detached_mounts_propagation ext4_resize
> > > +	detached_mounts_propagation ext4_resize uuid_ioctl
> > >  
> > >  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
> > >  	      btrfs_crc32c_forged_name.py
> > >  
> > >  SUBDIRS = log-writes perf
> > >  
> > > -LLDLIBS = $(LIBHANDLE) $(LIBACL) -lpthread -lrt
> > > +LLDLIBS = $(LIBHANDLE) $(LIBACL) -lpthread -lrt -luuid
> > >  
> > >  ifeq ($(HAVE_XLOG_ASSIGN_LSN), true)
> > >  LINUX_TARGETS += loggen
> > > diff --git a/src/uuid_ioctl.c b/src/uuid_ioctl.c
> > > new file mode 100644
> > > index 00000000..a4937478
> > > --- /dev/null
> > > +++ b/src/uuid_ioctl.c
> > > @@ -0,0 +1,106 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +/*
> > > + * Test program which uses the raw ext4 set_fsuuid ioctl directly.
> > > + * SYNOPSIS:
> > > + *   $0 COMMAND MOUNT_POINT [UUID]
> > > + *
> > > + * COMMAND must be either "get" or "set".
> > > + * The UUID must be a 16 octet represented as 32 hexadecimal digits in canonical
> > > + * textual representation, e.g. output from `uuidgen`.
> > > + *
> > > + */
> > > +
> > > +#include <stdio.h>
> > > +#include <fcntl.h>
> > > +#include <errno.h>
> > > +#include <unistd.h>
> > > +#include <stdint.h>
> > > +#include <stdlib.h>
> > > +#include <string.h>
> > > +#include <sys/ioctl.h>
> > > +#include <uuid/uuid.h>
> > > +#include <linux/fs.h>
> > > +
> > > +struct fsuuid {
> > > +	__u32   fu_len;
> > > +	__u32   fu_flags;
> > > +	__u8    fu_uuid[];
> > > +};
> > > +
> > > +#define EXT4_IOC_SETFSUUID_FLAG_BLOCKING 0x1
> > > +
> > > +#ifndef EXT4_IOC_GETFSUUID
> > > +#define EXT4_IOC_GETFSUUID      _IOR('f', 44, struct fsuuid)
> > > +#endif
> > > +
> > > +#ifndef EXT4_IOC_SETFSUUID
> > > +#define EXT4_IOC_SETFSUUID      _IOW('f', 44, struct fsuuid)
> > > +#endif
> > 
> > Will this be ext4 only ioctl? If this C program is only used for ext4 ioctl, I'd
> > like to rename it as "ext4_uuid_ioctl.c" (or something else make it not likes a
> > common test program). I think XFS doesn't has this ioctl, for now at least, it
> > get/set uuid by another way.
> 
> Right now XFS only supports offline changes to UUIDs, but in principle
> we could implement this pair of ioctls some day.

Oh, good to know that, so this program might become a common/shared test program
later? If so, we can keep current file name.

> 
> > > +
> > > +int main(int argc, char **argv)
> > > +{
> > > +	int error, fd;
> > > +	struct fsuuid *fsuuid = NULL;
> > > +
> > > +	if (argc < 3) {
> > > +		fprintf(stderr, "Invalid arguments\n");
> > > +		return 1;
> > > +	}
> > > +
> > > +	fd = open(argv[2], O_RDONLY);
> > > +	if (!fd) {
> > > +		perror(argv[2]);
> > > +		return 1;
> > > +	}
> > > +
> > > +	fsuuid = malloc(sizeof(*fsuuid) + sizeof(uuid_t));
> > > +	if (!fsuuid) {
> > > +		perror("malloc");
> > > +		return 1;
> > > +	}
> > > +	fsuuid->fu_len = sizeof(uuid_t);
> > > +
> > > +	if (strcmp(argv[1], "get") == 0) {
> > > +		uuid_t uuid;
> > > +		char uuid_str[37];
> > > +
> > > +		if (ioctl(fd, EXT4_IOC_GETFSUUID, fsuuid)) {
> > > +			fprintf(stderr, "%s while trying to get fs uuid\n",
> > > +				strerror(errno));
> > > +			return 1;
> > > +		}
> > > +
> > > +		memcpy(&uuid, fsuuid->fu_uuid, sizeof(uuid));
> > > +		uuid_unparse(uuid, uuid_str);
> > > +		printf("%s", uuid_str);
> > > +	} else if (strcmp(argv[1], "set") == 0) {
> > > +		uuid_t uuid;
> > > +
> > > +		if (argc != 4) {
> > > +			fprintf(stderr, "UUID argument missing.\n");
> > > +			return 1;
> > > +		}
> > > +
> > > +		error = uuid_parse(argv[3], uuid);
> > > +		if (error < 0) {
> > > +			fprintf(stderr, "Invalid UUID. The UUID should be in "
> > > +				"canonical format. Example: "
> > > +				"8c628557-6987-42b2-ba16-b7cc79ddfb43\n");
> > > +			return 1;
> > > +		}
> > > +
> > > +		memcpy(&fsuuid->fu_uuid, uuid, sizeof(uuid));
> > > +		fsuuid->fu_flags = EXT4_IOC_SETFSUUID_FLAG_BLOCKING;
> > > +		if (ioctl(fd, EXT4_IOC_SETFSUUID, fsuuid)) {
> > > +			fprintf(stderr, "%s while trying to set fs uuid\n",
> > > +				strerror(errno));
> > > +			return 1;
> > > +		}
> > > +	} else {
> > > +		fprintf(stderr, "Invalid command\n");
> > > +		return 1;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > diff --git a/tests/ext4/056 b/tests/ext4/056
> > > new file mode 100755
> > > index 00000000..ebefb136
> > > --- /dev/null
> > > +++ b/tests/ext4/056
> > > @@ -0,0 +1,55 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# Test the set/get UUID ioctl.
> > > +#
> > > +
> > > +. ./common/preamble
> > > +_begin_fstest auto ioctl
> > > +
> > > +# Import common functions.
> > > +. ./common/filter
> > > +
> > > +# real QA test starts here
> > > +_supported_fs ext4
> > > +_require_scratch
> > > +_require_test_program uuid_ioctl
> > > +_require_command $UUIDGEN_PROG uuidgen
> > > +
> > > +UUID_IOCTL=$here/src/uuid_ioctl
> > > +
> > > +# if the ioctl is not supported by the kernel, then skip test.
> > > +current_uuid=$($UUID_IOCTL get $SCRATCH_MNT 2>&1)
> > > +if [[ "$current_uuid" =~ ^Inappropriate[[:space:]]ioctl ]]; then
> > > +        _notrun "UUID ioctls are not supported by kernel."
> > > +fi
> > > +
> > > +# Create filesystem and mount
> > 
> > Rather than this such obvious comment description, explain why the below
> > "metadata_csum_seed" is necessary?
> > 
> > > +_scratch_mkfs_ext4 -O metadata_csum_seed >> $seqres.full 2>&1
> > > +_scratch_mount >> $seqres.full
> > > +
> > > +# Begin fsstress while modifying UUID
> > > +fsstress_args=$(_scale_fsstress_args -d $SCRATCH_MNT -p 15 -n 999999)
> > > +$FSSTRESS_PROG $fsstress_args > /dev/null 2>&1 &
> > > +fsstress_pid=$!
> > > +
> > > +for n in $(seq 1 20); do
> > > +        new_uuid=$($UUIDGEN_PROG)
> > > +
> > > +        echo "Setting UUID to ${new_uuid}" >> $seqres.full 2>&1
> > > +        $UUID_IOCTL set $SCRATCH_MNT $new_uuid
> > > +
> > > +        current_uuid=$($UUID_IOCTL get $SCRATCH_MNT)
> > > +        echo "$UUID_IOCTL get $SCARTCH_MNT: $current_uuid" >> $seqres.full 2>&1
> > > +        if [[ "$current_uuid" != "$new_uuid" ]]; then
> > > +                echo "Current UUID ($current_uuid) does not equal what "
> > > +                "was sent with the ioctl ($new_uuid)"
> > 
> > Can these two lines really be printed?
> 
> Let's hope not.
> 
> > > +        fi
> > > +done
> > > +
> > > +# success, all done
> > > +echo "Silence is golden"
> > > +kill $fsstress_pid >/dev/null 2>&1
> > > +wait
> > 
> > We can't make sure the testing will exit normally, so better to make sure the
> > fsstress processes are killed in _cleanup(). You can refer to generic/390.
> 
> Might be time to turn that (run fsstress/fsx in the background and kill it
> later) into a set of common helper functions?
> 
> (Or just implement this fix now and we'll revisit it whenever I get
> around to submitting the "fsstress vs. online fsck" series[1].)

I remember Dave tried to clean up the _cleanup() things in a patchset named:

  [RFC PATCH 0/8] fstests: _cleanup() overrides are a mess

it contains a patch named:

  [PATCH 5/8] fstests: use a common fsstress cleanup function

I think Dave is busy recently, I don't know if he's still working on that.
(JFYI, to avoid you might take time to do reduplicate work)

Thanks,
Zorro

> 
> --D
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=refactor-fsmap-stress
> 
> > Thanks,
> > Zorro
> > 
> > > +status=0
> > > +exit
> > > diff --git a/tests/ext4/056.out b/tests/ext4/056.out
> > > new file mode 100644
> > > index 00000000..6142fcd2
> > > --- /dev/null
> > > +++ b/tests/ext4/056.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 056
> > > +Silence is golden
> > > -- 
> > > 2.37.0.rc0.161.g10f37bed90-goog
> > > 
> > 
> 

