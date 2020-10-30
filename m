Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28492A0658
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Oct 2020 14:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgJ3NTS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Oct 2020 09:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31906 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726307AbgJ3NTR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 30 Oct 2020 09:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604063956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MNMgeoRyZngGrsMkBeY+FVhigg852k0h/oZRRCOeEy8=;
        b=R1a8yjXi1elvrjBMTEg78lryl+K/ugYT5K9zHX42R5q0G0dOv0odfAgJhDe4bBl442XE/8
        bjc74VRpNZCO/dyuJHabZRWlibSFZhZnAVfC3dfK24Bn5/xtyh48J5LsJjZslRPe0I6gIi
        iAZpXlNbW8nZyD5u6IVv6a3m2pGbZKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-_ov3KqdkMGeMFm0L1iR8Pg-1; Fri, 30 Oct 2020 09:19:12 -0400
X-MC-Unique: _ov3KqdkMGeMFm0L1iR8Pg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C21C1030984;
        Fri, 30 Oct 2020 13:19:10 +0000 (UTC)
Received: from bfoster (ovpn-113-186.rdu2.redhat.com [10.10.113.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CADDE10023A5;
        Fri, 30 Oct 2020 13:19:09 +0000 (UTC)
Date:   Fri, 30 Oct 2020 09:19:08 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, anju@linux.vnet.ibm.com,
        Eryu Guan <guan@eryu.me>, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/3] shared/001: Verify swapon on fallocated files for
 supported FS
Message-ID: <20201030131908.GC1794672@bfoster>
References: <cover.1604000570.git.riteshh@linux.ibm.com>
 <5750e38bb14440b6357a46470f2cd769cde1a349.1604000570.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5750e38bb14440b6357a46470f2cd769cde1a349.1604000570.git.riteshh@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 30, 2020 at 01:22:52AM +0530, Ritesh Harjani wrote:
> Currently generic/496 tests if swapon works with fallocated files or not
> on the given FS and bails out with _not_run if it doesn't. Due to this
> 2 of the regressions went unnoticed in ext4.
> Hence this test is created specifically for FS (ext4, xfs) which does
> support swap functionality on unwritten extents to report an error
> if it swapon fails with fallocated fils.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  tests/shared/001     | 97 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/shared/001.out |  6 +++
>  tests/shared/group   |  1 +
>  3 files changed, 104 insertions(+)
>  create mode 100755 tests/shared/001
>  create mode 100644 tests/shared/001.out
> 

I could be mistaken, but I thought we were phasing out shared tests in
favor of generic tests..?

> diff --git a/tests/shared/001 b/tests/shared/001
> new file mode 100755
> index 000000000000..ad7285bdb709
> --- /dev/null
> +++ b/tests/shared/001
> @@ -0,0 +1,97 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2018 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 001
> +#
> +# This is similar to generic/472 and generic/496.
> +# Except that generic/496 is modified to focefully verify if
> +# swap works on fallocate files for given supported filesystems
> +# or not instead of bailing out with _not_run, if swapon cmd fails.
> +# Modified by Ritesh Harjani <riteshh@linux.ibm.com>
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	swapoff $swapfile 2> /dev/null
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# Modify as appropriate.
> +_supported_fs ext4 xfs
> +_require_scratch_swapfile
> +_require_test_program mkswap
> +_require_test_program swapon
> +_require_xfs_io_command "falloc"
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount >>$seqres.full 2>&1
> +
> +swapfile=$SCRATCH_MNT/swap
> +len=$((2 * 1048576))
> +page_size=$(get_page_size)
> +
> +swapfile_cycle() {
> +	local swapfile="$1"
> +
> +	if [ $# -eq 2 ]; then
> +		local len="$2"
> +		_pwrite_byte 0x58 0 $len $swapfile >> $seqres.full
> +	fi
> +	"$here/src/mkswap" $swapfile >> $seqres.full
> +	"$here/src/swapon" $swapfile 2>&1 | _filter_scratch
> +	swapoff $swapfile 2>> $seqres.full

It might be a little more readable to define and use per-cmd variables
like $MKSWAP, etc., if we don't have those already.

> +	rm -f $swapfile
> +}
> +
> +# from here similar to generic/472
> +touch $swapfile
> +
> +# Create a regular swap file
> +echo "regular swap" | tee -a $seqres.full
> +swapfile_cycle $swapfile $len
> +
> +# Create a swap file with a little too much junk on the end
> +echo "too long swap" | tee -a $seqres.full
> +swapfile_cycle $swapfile $((len + 3))
> +
> +# Create a ridiculously small swap file.  Each swap file must have at least
> +# two pages after the header page.
> +echo "tiny swap" | tee -a $seqres.full
> +swapfile_cycle $swapfile $(($(get_page_size) * 3))
> +
> +# From here similar to generic/496
> +echo "fallocate swap" | tee -a $seqres.full
> +$XFS_IO_PROG -f -c "falloc 0 $len" $swapfile >> $seqres.full
> +"$here/src/mkswap" $swapfile
> +"$here/src/swapon" $swapfile 2>&1 | _filter_scratch
> +swapoff $swapfile
> +
> +# Create a fallocated swap file and touch every other $PAGE_SIZE to create
> +# a mess of written/unwritten extent records
> +echo "mixed swap" | tee -a $seqres.full
> +$XFS_IO_PROG -f -c "falloc 0 $len" $swapfile >> $seqres.full

We probably want to recreate the file here. It looks like we reuse the
file from the previous test, since it didn't call swapfile_cycle().

I also wonder whether it's really worth duplicating previous test code
just to prevent incorrect _notrun cases that should be considered test
failures. One could argue that's a bug in the original test that could
be fixed. Could we modify those tests to only filter out the btrfs case?

Brian

> +seq $page_size $((page_size * 2)) $len | while read offset; do
> +	_pwrite_byte 0x58 $offset 1 $swapfile >> $seqres.full
> +done
> +swapfile_cycle $swapfile
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/shared/001.out b/tests/shared/001.out
> new file mode 100644
> index 000000000000..2d7655e19422
> --- /dev/null
> +++ b/tests/shared/001.out
> @@ -0,0 +1,6 @@
> +QA output created by 001
> +regular swap
> +too long swap
> +tiny swap
> +fallocate swap
> +mixed swap
> diff --git a/tests/shared/group b/tests/shared/group
> index a8b926d877d2..5a41b23c7010 100644
> --- a/tests/shared/group
> +++ b/tests/shared/group
> @@ -3,6 +3,7 @@
>  # - do not start group names with a digit
>  # - comment line before each group is "new" description
>  #
> +001 auto swap quick
>  002 auto metadata quick log
>  032 mkfs auto quick
>  298 auto trim
> --
> 2.26.2
> 

