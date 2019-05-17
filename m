Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 157DE2129D
	for <lists+linux-ext4@lfdr.de>; Fri, 17 May 2019 05:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfEQDm5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 May 2019 23:42:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34998 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfEQDm5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 May 2019 23:42:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id g5so2670681plt.2;
        Thu, 16 May 2019 20:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5iP545AgQCgaGGAv0oOLLIrrv4tC3nnx8nSFIGlTWXk=;
        b=Fq0PZU4o2CRakOX8822+7+/EctNpG/LAHIOcrh9ww5a/PoAUi7EMlYp/z7fAydyZgl
         KRRvALvJMWjWMXlHVR2/kwWB5Mi88GZcvfgf04ZdQqdHRaxSLVzBcKkOHUmav0GAWL44
         EGi2ceQPQUxy6YrNqdHm7P2Sevly+hSVTUDTr7T37IN023VsRzjXHiCPEAvLwamH2cNM
         tt6Otobz1UizKheYEXUhJ0dMSShrd/X47bOGWhULc4LrNpQAIUNJsm2S/Wcy3a2nYMVZ
         UBZt5lCH/Lo1r8zNgQDHy5OEmdYyQ4V+pEqOZYDGrxOEwq9/cAMvaJljU2qMT0mwaKQ8
         QaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5iP545AgQCgaGGAv0oOLLIrrv4tC3nnx8nSFIGlTWXk=;
        b=Lc1Y139e100n6jQQP+8D84oHq2IGLMq6qNJDukynSbQJNJifluGXcAO6qGKsp1MERF
         cP423xrqI5aP2R6ZrYyzvhReFfV6QMTUtpWyt8UHNQjWUoKpZFdb4LITYtCCsNMr5gGz
         P/hsOdPSUv46x89zKl2QJoKpMOVant3r9FaJsY2SwKQ4TNlIEPJQPEYE3T13QcdegcQT
         2Q8776Phuyg+7Zxsw2tCNpRB9plBRyk7DtcO1KP8OcB7KbRwy1IZfIfOfZQIUQtje5WY
         h/UlvXGUc+NoroTAskrtdv4hfVEClVNktW+y3jSwyPnyVWz3Lhz2m6nKWxyzeukWGwcX
         C4PA==
X-Gm-Message-State: APjAAAUTo2T/BAA0z6DoxbOlTdBXz/ufA1Aqpkog5Vycnnfe3S9+ff/n
        b9mUqYzqtUyoMkDkls/Llgw/qOsVrUs=
X-Google-Smtp-Source: APXvYqwGO/piSeywYWH0CuWYFTmSqmwZJmVdog8uCpID9Enm3pb7XeWq3gJ+4/uiV0nlQKlj4Ah1DA==
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr52252009plo.32.1558064576099;
        Thu, 16 May 2019 20:42:56 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id a7sm12685883pgj.42.2019.05.16.20.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 20:42:55 -0700 (PDT)
Date:   Fri, 17 May 2019 11:42:49 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jack@suse.cz,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fstests: generic, fsync fuzz tester with fsstress
Message-ID: <20190517034249.GM15846@desktop>
References: <20190515150221.16647-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515150221.16647-1-fdmanana@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 15, 2019 at 04:02:21PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Run fsstress, fsync every file and directory, simulate a power failure and
> then verify the all files and directories exist, with the same data and
> metadata they had before the power failure.
> 
> This tes has found already 2 bugs in btrfs, that caused mtime and ctime of
> directories not being preserved after replaying the log/journal and loss
> of a directory's attributes (such a UID and GID) after replaying the log.
> The patches that fix the btrfs issues are titled:
> 
>   "Btrfs: fix wrong ctime and mtime of a directory after log replay"
>   "Btrfs: fix fsync not persisting changed attributes of a directory"
> 
> Running this test 1000 times:
> 
> - on xfs, no issues were found
> 
> - on ext4 it has resulted in about a dozen journal checksum errors (on a
>   5.0 kernel) that resulted in failure to mount the filesystem after the
>   simulated power failure with dmflakey, which produces the following
>   error in dmesg/syslog:
> 
>     [Mon May 13 12:51:37 2019] JBD2: journal checksum error
>     [Mon May 13 12:51:37 2019] EXT4-fs (dm-0): error loading journal
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/generic/547     | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/547.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 75 insertions(+)
>  create mode 100755 tests/generic/547
>  create mode 100644 tests/generic/547.out
> 
> diff --git a/tests/generic/547 b/tests/generic/547
> new file mode 100755
> index 00000000..577b0e9b
> --- /dev/null
> +++ b/tests/generic/547
> @@ -0,0 +1,72 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test No. 547
> +#
> +# Run fsstress, fsync every file and directory, simulate a power failure and
> +# then verify the all files and directories exist, with the same data and
> +# metadata they had before the power failure.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/dmflakey
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch

As we save fssum file to $TEST_DIR, it'd be better to _require_test too.

> +_require_fssum
> +_require_dm_target flakey
> +
> +rm -f $seqres.full
> +
> +fssum_files_dir=$TEST_DIR/generic-test-$seq
> +rm -fr $fssum_files_dir
> +mkdir $fssum_files_dir
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +mkdir $SCRATCH_MNT/test
> +args=`_scale_fsstress_args -p 4 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/test`
> +args="$args -f mknod=0 -f symlink=0"
> +echo "Running fsstress with arguments: $args" >>$seqres.full
> +$FSSTRESS_PROG $args >>$seqres.full
> +
> +# Fsync every file and directory.
> +find $SCRATCH_MNT/test -type f,d -exec $XFS_IO_PROG -c "fsync" {} \;

My 'find' on Fedora 29 vm (find (GNU findutils) 4.6.0) doesn't support
"-type f,d" syntax

find: Arguments to -type should contain only one letter

I have to change this to

find $SCRATCH_MNT/test \( -type f -o -type d \) -exec $XFS_IO_PROG -c "fsync" {} \;

Otherwise looks good to me, thanks!

Eryu

> +# Compute a digest of the filesystem (using the test directory only, to skip
> +# fs specific directories such as "lost+found" on ext4 for example).
> +$FSSUM_PROG -A -f -w $fssum_files_dir/fs_digest $SCRATCH_MNT/test
> +
> +# Simulate a power failure and mount the filesystem to check that all files and
> +# directories exist and have all data and metadata preserved.
> +_flakey_drop_and_remount
> +
> +# Compute a new digest and compare it to the one we created previously, they
> +# must match.
> +$FSSUM_PROG -r $fssum_files_dir/fs_digest $SCRATCH_MNT/test
> +
> +_unmount_flakey
> +
> +status=0
> +exit
> diff --git a/tests/generic/547.out b/tests/generic/547.out
> new file mode 100644
> index 00000000..0f6f1131
> --- /dev/null
> +++ b/tests/generic/547.out
> @@ -0,0 +1,2 @@
> +QA output created by 547
> +OK
> diff --git a/tests/generic/group b/tests/generic/group
> index 47e81d96..49639fc9 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -549,3 +549,4 @@
>  544 auto quick clone
>  545 auto quick cap
>  546 auto quick clone enospc log
> +547 auto quick log
> -- 
> 2.11.0
> 
