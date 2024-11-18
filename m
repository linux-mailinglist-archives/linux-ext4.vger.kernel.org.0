Return-Path: <linux-ext4+bounces-5245-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E349D19A5
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2024 21:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11603B230B5
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2024 20:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97B61E501B;
	Mon, 18 Nov 2024 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwcXHyBx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C1B1E573F;
	Mon, 18 Nov 2024 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961675; cv=none; b=anCzoEf7/4BDWj0VBaVpUW1OEWVRHgRGV/1IDGceNwW2HYMe3B6knMmstkEu1yINdrJikCUyUJAv3PfgzMEgllsFdxLQpdjVI/UvJHs7K3SmgxhULl/PZfCNAqV8M8jG/efehXbt/I5UDKhn8rKViy9bJe7yLDWRDAzpUJ97xe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961675; c=relaxed/simple;
	bh=DlGKWbKUQcZXDFxfCxg5xLcGKIuTVshr7MeAspSZl7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RconGkhPvaeY2oe2jwhZ5TSLFEjdx7V7JySKLyE+GzwxoxXqUw0e+930YgjTXVt0K4tQeDb6Qp9Qv7QVgO5XuG0D8aV88Aci3vYSWmZMTANihGxDfiQ8PH5fPxD/oE7x8JOomzPhXRTvsW+W+HCTzxuf2BHrvJw8mlHqSmFYtB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwcXHyBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA9DC4CED1;
	Mon, 18 Nov 2024 20:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731961674;
	bh=DlGKWbKUQcZXDFxfCxg5xLcGKIuTVshr7MeAspSZl7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwcXHyBxuxIXHhztOVqE6Y2gc/8An/72AIBeG5Kq/tls9wZuUiJ2I6uHV1wdBP0Q9
	 0hlcmgApez7eCUbgvsuF9K+ZafSSboHH3QLpz3loWB2R40IxYna+Z66zvg5Xxbe3SJ
	 OoVVDoHTNTed8b0fJfhlCTOR+5ArFi47hAJ4I9GQUmuUo3pgK1G5vuyxyc2gy7B63N
	 oLQb7i04grwCEK7mBErH8ffFq8abwJOlC1BuYV6nvJ92sZ2t3lgS6/IQSGvn2dz+MM
	 faIw9duruMls+Odbs5F4WhyVNKQAcBccaLvk//kbYOuojA5Gg8cSbGnESc9shCWzt3
	 WGtLYLbpLfe7A==
Date: Mon, 18 Nov 2024 12:27:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Nirjhar Roy <nirjhar@linux.ibm.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH v2 2/2] generic: Addition of new tests for extsize hints
Message-ID: <20241118202754.GR9438@frogsfrogsfrogs>
References: <cover.1731597226.git.nirjhar@linux.ibm.com>
 <373a7e378ba4a76067dc7da5835ac722248144f9.1731597226.git.nirjhar@linux.ibm.com>
 <20241115165054.GF9425@frogsfrogsfrogs>
 <c6ca5784-de55-43ec-ba6a-3afbf6b2aa53@linux.ibm.com>
 <20241118162209.GH9425@frogsfrogsfrogs>
 <87sero8mpy.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sero8mpy.fsf@gmail.com>

On Mon, Nov 18, 2024 at 11:10:09PM +0530, Ritesh Harjani wrote:
> "Darrick J. Wong" <djwong@kernel.org> writes:
> 
> > On Mon, Nov 18, 2024 at 02:54:06PM +0530, Nirjhar Roy wrote:
> >> 
> >> On 11/15/24 22:20, Darrick J. Wong wrote:
> >> > On Fri, Nov 15, 2024 at 09:45:59AM +0530, Nirjhar Roy wrote:
> >> > > This commit adds new tests that checks the behaviour of xfs/ext4
> >> > > filesystems when extsize hint is set on file with inode size as 0, non-empty
> >> > > files with allocated and delalloc extents and so on.
> >> > > Although currently this test is placed under tests/generic, it
> >> > > only runs on xfs and there is an ongoing patch series[1] to enable
> >> > > extsize hints for ext4 as well.
> >> > > 
> >> > > [1] https://lore.kernel.org/linux-ext4/cover.1726034272.git.ojaswin@linux.ibm.com/
> >> > > 
> >> > > Reviewed-by Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >> > > Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> >> > > Suggested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> >> > > Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
> >> > > ---
> >> > >   tests/generic/366     | 172 ++++++++++++++++++++++++++++++++++++++++++
> >> > >   tests/generic/366.out |  26 +++++++
> >> > >   2 files changed, 198 insertions(+)
> >> > >   create mode 100755 tests/generic/366
> >> > >   create mode 100644 tests/generic/366.out
> >> > > 
> >> > > diff --git a/tests/generic/366 b/tests/generic/366
> >> > > new file mode 100755
> >> > > index 00000000..7ff4e8e2
> >> > > --- /dev/null
> >> > > +++ b/tests/generic/366
> >> > > @@ -0,0 +1,172 @@
> >> > > +#! /bin/bash
> >> > > +# SPDX-License-Identifier: GPL-2.0
> >> > > +# Copyright (c) 2024 Nirjhar Roy (nirjhar@linux.ibm.com).  All Rights Reserved.
> >> > > +#
> >> > > +# FS QA Test 366
> >> > > +#
> >> > > +# This test verifies that extent allocation hint setting works correctly on files with
> >> > > +# no extents allocated and non-empty files which are truncated. It also checks that the
> >> > > +# extent hints setting fails with non-empty file i.e, with any file with allocated
> >> > > +# extents or delayed allocation. We also check if the extsize value and the
> >> > > +# xflag bit actually got reflected after setting/re-setting the extsize value.
> >> > > +
> >> > > +. ./common/config
> >> > > +. ./common/filter
> >> > > +. ./common/preamble
> >> > > +
> >> > > +_begin_fstest ioctl quick
> >> > > +
> >> > > +_supported_fs xfs
> >> > Aren't you all adding extsize support for ext4?  I would've expected
> >> > some kind of _require_extsize helper to _notrun on filesystems that
> >> > don't support it.
> >> Yes, this is a good idea. I will try to have something like this. Thank you.
> >> > 
> >> > > +
> >> > > +_fixed_by_kernel_commit "2a492ff66673 \
> >> > > +                        xfs: Check for delayed allocations before setting extsize"
> >> > > +
> >> > > +_require_scratch
> >> > > +
> >> > > +FILE_DATA_SIZE=1M
> >> > > +
> >> > > +get_default_extsize()
> >> > > +{
> >> > > +    if [ -z $1 ] || [ ! -d $1 ]; then
> >> > > +        echo "Missing mount point argument for get_default_extsize"
> >> > > +        exit 1
> >> > > +    fi
> >> > > +    $XFS_IO_PROG -c "extsize" "$1" | sed 's/^\[\([0-9]\+\)\].*/\1/'
> >> > Doesn't this need to check for extszinherit on $SCRATCH_MNT?
> >> 
> >> The above function tries to get the default extsize set on a directory
> >> ($SCRATCH_MNT for this test). Even if there is an extszinherit set or
> >> extsize (with -d extsize=<size> [1]), the function will get the extsize (in
> >> bytes) which is what the function intends to do. In case there is
> >> no extszinherit or extsize set on the directory, it will return 0.  Does
> >> this answer your question, or are you asking something else?
> >> 
> >> [1]
> >> https://lore.kernel.org/all/20230929095342.2976587-7-john.g.garry@oracle.com/
> >
> > Nah, I think I got confused there.  Disregard the question. :(
> >
> >> > 
> >> > > +}
> >> > > +
> >> > > +filter_extsz()
> >> > > +{
> >> > > +    sed "s/\[$1\]/\[EXTSIZE\]/g"
> >> > > +}
> >> > > +
> >> > > +setup()
> >> > > +{
> >> > > +    _scratch_mkfs >> "$seqres.full"  2>&1
> >> > > +    _scratch_mount >> "$seqres.full" 2>&1
> >> > > +    BLKSZ=`_get_block_size $SCRATCH_MNT`
> >> > > +    DEFAULT_EXTSIZE=`get_default_extsize $SCRATCH_MNT`
> >> > > +    EXTSIZE=$(( BLKSZ*2 ))
> >> > > +    # Making sure the new extsize is not the same as the default extsize
> >> > Er... why?
> >> The test behaves a bit differently when the new and old extsizes are equal
> >> and the intention of this test is to check if the kernel behaves as expected
> >> when we are trying to *change* the extsize. Two of the sub-tests
> >> (test_data_delayed(), test_data_allocated()) test whether extsize settting
> >> fails if there are allocated extents or delayed allocation. The failure
> >> doesn't take place when the new and the default extsizes are equal, i.e,
> >> when the extsize is not changing. If the default and the new extsize are
> >> equal, the xfs_io command succeeds, which is not what we want the test to
> >> do. So we are always ensuring that the new extsize is not equal to the
> >> default extsize. Does this answer your question?
> >
> > Yep.  Can you add that ("Make sure the new extsize is not the same as
> > the default extsize so that we can observe it changing") to the comment?
> >
> >> > > +    [[ "$DEFAULT_EXTSIZE" -eq "$EXTSIZE" ]] && EXTSIZE=$(( BLKSZ*4 ))
> >> > > +}
> >> > > +
> >> > > +read_file_extsize()
> >> > > +{
> >> > > +    $XFS_IO_PROG -c "extsize" $1 | _filter_scratch | filter_extsz $2
> >> > > +}
> >> > > +
> >> > > +check_extsz_and_xflag()
> >> > > +{
> >> > > +    local filename=$1
> >> > > +    local extsize=$2
> >> > > +    read_file_extsize $filename $extsize
> >> > > +    _test_fsx_xflags_field $filename "e" && echo "e flag set" || echo "e flag unset"
> >> > I almost asked in the last patch if the _test_fsxattr_flag function
> >> > should be running xfs_io -c 'stat -v' so that you could grep for whole
> >> > words instead of individual letters.
> >> > 
> >> > "extsize flag unset"
> >> > 
> >> > "cowextsize flag set"
> >> > 
> >> > is a bit easier to figure out what's going wrong.
> >> > 
> >> > The rest of the logic looks reasonable to me.
> >> > 
> >> > --D
> >> 
> >> Yes, that makes sense. So do you mean something like the following?
> >> 
> >> # Check whether a fsxattr xflags name ($2) field is set on a given file
> >> ($1).
> >> # e.g, fsxattr.xflags = 0x80000800 [extsize, has-xattr]
> >> _test_fsxattr_flag_field()
> >> {
> >>     grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
> >> }
> >> 
> >> and the call sites can be like
> >> 
> >> _test_fsx_xflags_field $filename "extsize" && echo "e flag set" || echo "e
> >> flag unset"
> >> 
> >> THE OTHER OPTION IS:
> >> 
> >> We can embed the "<flag name> flag set/unset" message, inside the
> >> _test_fsx_xflags_field() function. Something like
> >> 
> >> _test_fsxattr_flag_field()
> >> {
> >>     grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
> >> && echo "$2 flag set" || echo "$2 flag unset"
> >> }
> >> 
> >> Which one do you prefer?
> >
> > You might as well go for this second form since that's how all the
> > callers behave.
> >
> 
> Sorry, I missed reading the rest of the email from Nirjhar or else I
> would have responded earlier.  
> 
> Adding an echo command in the common helper routine for it to go into
> the .out file might become confusing. So if folks don't have a hard
> preference here, then can we please keep the same previous logic of
> returning success or failure from ("_test_fsxattr_xflag" common helper)
> and let the caller decide whatever string it wants to add (or even not)
> for it's .out file please?

That's fine with me. :)

--D

> -ritesh
> 
> > --D
> >
> >> > 
> >> > > +}
> >> > > +
> >> > > +check_extsz_xflag_across_remount()
> >> > > +{
> >> > > +    local filename=$1
> >> > > +    local extsize=$2
> >> > > +    _scratch_cycle_mount
> >> > > +    check_extsz_and_xflag $filename $extsize
> >> > > +}
> >> > > +
> >> > > +# Extsize flag should be cleared when extsize is reset, so this function
> >> > > +# checks that this behavior is followed.
> >> > > +reset_extsz_and_recheck_extsz_xflag()
> >> > > +{
> >> > > +    local filename=$1
> >> > > +    echo "Re-setting extsize hint to 0"
> >> > > +    $XFS_IO_PROG -c "extsize 0" $filename
> >> > > +    check_extsz_xflag_across_remount $filename "0"
> >> > > +}
> >> > > +
> >> > > +check_extsz_xflag_before_and_after_reset()
> >> > > +{
> >> > > +    local filename=$1
> >> > > +    local extsize=$2
> >> > > +    check_extsz_xflag_across_remount $filename $extsize
> >> > > +    reset_extsz_and_recheck_extsz_xflag $filename
> >> > > +}
> >> > > +
> >> > > +test_empty_file()
> >> > > +{
> >> > > +    echo "TEST: Set extsize on empty file"
> >> > > +    local filename=$1
> >> > > +    $XFS_IO_PROG \
> >> > > +        -c "open -f $filename" \
> >> > > +        -c "extsize $EXTSIZE" \
> >> > > +
> >> > > +    check_extsz_xflag_before_and_after_reset $filename $EXTSIZE
> >> > > +    echo
> >> > > +}
> >> > > +
> >> > > +test_data_delayed()
> >> > > +{
> >> > > +    echo "TEST: Set extsize on non-empty file with delayed allocation"
> >> > > +    local filename=$1
> >> > > +    $XFS_IO_PROG \
> >> > > +        -c "open -f $filename" \
> >> > > +        -c "pwrite -q  0 $FILE_DATA_SIZE" \
> >> > > +        -c "extsize $EXTSIZE" | _filter_scratch
> >> > > +
> >> > > +    echo "test for default extsize setting if any"
> >> > > +    read_file_extsize $filename $DEFAULT_EXTSIZE
> >> > > +    echo
> >> > > +}
> >> > > +
> >> > > +test_data_allocated()
> >> > > +{
> >> > > +    echo "TEST: Set extsize on non-empty file with allocated extents"
> >> > > +    local filename=$1
> >> > > +    $XFS_IO_PROG \
> >> > > +        -c "open -f $filename" \
> >> > > +        -c "pwrite -qW  0 $FILE_DATA_SIZE" \
> >> > > +        -c "extsize $EXTSIZE" | _filter_scratch
> >> > > +
> >> > > +    echo "test for default extsize setting if any"
> >> > > +    read_file_extsize $filename $DEFAULT_EXTSIZE
> >> > > +    echo
> >> > > +}
> >> > > +
> >> > > +test_truncate_allocated()
> >> > > +{
> >> > > +    echo "TEST: Set extsize after truncating a file with allocated extents"
> >> > > +    local filename=$1
> >> > > +    $XFS_IO_PROG \
> >> > > +        -c "open -f $filename" \
> >> > > +        -c "pwrite -qW  0 $FILE_DATA_SIZE" \
> >> > > +        -c "truncate 0" \
> >> > > +        -c "extsize $EXTSIZE" \
> >> > > +
> >> > > +    check_extsz_xflag_across_remount $filename $EXTSIZE
> >> > > +    echo
> >> > > +}
> >> > > +
> >> > > +test_truncate_delayed()
> >> > > +{
> >> > > +    echo "TEST: Set extsize after truncating a file with delayed allocation"
> >> > > +    local filename=$1
> >> > > +    $XFS_IO_PROG \
> >> > > +        -c "open -f $filename" \
> >> > > +        -c "pwrite -q  0 $FILE_DATA_SIZE" \
> >> > > +        -c "truncate 0" \
> >> > > +        -c "extsize $EXTSIZE" \
> >> > > +
> >> > > +    check_extsz_xflag_across_remount $filename $EXTSIZE
> >> > > +    echo
> >> > > +}
> >> > > +
> >> > > +setup
> >> > > +echo -e "EXTSIZE = $EXTSIZE DEFAULT_EXTSIZE = $DEFAULT_EXTSIZE BLOCKSIZE = $BLKSZ\n" >> "$seqres.full"
> >> > > +
> >> > > +NEW_FILE_NAME_PREFIX=$SCRATCH_MNT/new-file-
> >> > > +
> >> > > +test_empty_file "$NEW_FILE_NAME_PREFIX"00
> >> > > +test_data_delayed "$NEW_FILE_NAME_PREFIX"01
> >> > > +test_data_allocated "$NEW_FILE_NAME_PREFIX"02
> >> > > +test_truncate_allocated "$NEW_FILE_NAME_PREFIX"03
> >> > > +test_truncate_delayed "$NEW_FILE_NAME_PREFIX"04
> >> > > +
> >> > > +status=0
> >> > > +exit
> >> > > diff --git a/tests/generic/366.out b/tests/generic/366.out
> >> > > new file mode 100644
> >> > > index 00000000..cdd2f5fa
> >> > > --- /dev/null
> >> > > +++ b/tests/generic/366.out
> >> > > @@ -0,0 +1,26 @@
> >> > > +QA output created by 366
> >> > > +TEST: Set extsize on empty file
> >> > > +[EXTSIZE] SCRATCH_MNT/new-file-00
> >> > > +e flag set
> >> > > +Re-setting extsize hint to 0
> >> > > +[EXTSIZE] SCRATCH_MNT/new-file-00
> >> > > +e flag unset
> >> > > +
> >> > > +TEST: Set extsize on non-empty file with delayed allocation
> >> > > +xfs_io: FS_IOC_FSSETXATTR SCRATCH_MNT/new-file-01: Invalid argument
> >> > > +test for default extsize setting if any
> >> > > +[EXTSIZE] SCRATCH_MNT/new-file-01
> >> > > +
> >> > > +TEST: Set extsize on non-empty file with allocated extents
> >> > > +xfs_io: FS_IOC_FSSETXATTR SCRATCH_MNT/new-file-02: Invalid argument
> >> > > +test for default extsize setting if any
> >> > > +[EXTSIZE] SCRATCH_MNT/new-file-02
> >> > > +
> >> > > +TEST: Set extsize after truncating a file with allocated extents
> >> > > +[EXTSIZE] SCRATCH_MNT/new-file-03
> >> > > +e flag set
> >> > > +
> >> > > +TEST: Set extsize after truncating a file with delayed allocation
> >> > > +[EXTSIZE] SCRATCH_MNT/new-file-04
> >> > > +e flag set
> >> > > +
> >> > > -- 
> >> > > 2.43.5
> >> > > 
> >> > > 
> >> -- 
> >> ---
> >> Nirjhar Roy
> >> Linux Kernel Developer
> >> IBM, Bangalore
> >> 
> >> 
> 

