Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E98445ED6
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Nov 2021 04:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhKEDsX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Nov 2021 23:48:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231201AbhKEDsW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 4 Nov 2021 23:48:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24A6361139;
        Fri,  5 Nov 2021 03:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636083943;
        bh=17exuJhEzpU1K4acfUKF9UnP0y8JGYz959NUzEGpEnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhyeTlQgJFyy1gd8d3J5LCKc5UnQK7IbeIfYwaguU+vDZUaGR3YMHQyWnRSwTUzOs
         4CX7wAAq7VN+vaGWw/Yje82oKMC8bC8Q4V2D2Gza8b0003OkrziuSayLwK69Umg8/a
         qGMD0+TS7goOy1uj8EeTpNrzt50fhLFJZpjIuxqHml66MS6f8OisOKW89ombBwk3py
         ZC3breKYIVoyYOmK0Sn5ciQU3khzLLYgTGs9FnWtEoIA5ISDOVWCa13D6ljifpuwkc
         N2nDvD3eCEvyGauSQU2pBVcsak/ORoqqSmQQ97Z6dyWIS9zeAS5J86yxwbKIIhyktE
         DLu2KiXp4mR6w==
Date:   Thu, 4 Nov 2021 20:45:42 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     Lukas Czerner <lczerner@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>, "guan@eryu.me" <guan@eryu.me>
Subject: Re: [PATCH v5] ext4: add test for all ext4/ext3/ext2 mount options
Message-ID: <20211105034542.GZ24282@magnolia>
References: <20211102105911.5790-1-lczerner@redhat.com>
 <20211104102450.22965-1-lczerner@redhat.com>
 <20211104171653.GY24282@magnolia>
 <20211104173123.2k3iyhxiy3s6473o@work>
 <61847ED6.3000703@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61847ED6.3000703@fujitsu.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 05, 2021 at 12:45:53AM +0000, xuyang2018.jy@fujitsu.com wrote:
> on 2021/11/5 1:31, Lukas Czerner wrote:
> > On Thu, Nov 04, 2021 at 10:16:53AM -0700, Darrick J. Wong wrote:
> >> On Thu, Nov 04, 2021 at 11:24:50AM +0100, Lukas Czerner wrote:
> >>> Add test to validate that all the ext4, ext3 and ext2 are properly
> >>> recognized, validate and applied to avoid regressions as ext4 moves to
> >>> the new mount API.
> >>>
> >>> Signed-off-by: Lukas Czerner<lczerner@redhat.com>
> >>> ---
> >>> V2: Move minimum kernel version requirement up to 5.12
> >>>      Rewrite kernel_gte() to work correctly
> >>> V3: Rename functions to not start with _
> >>> V4: Check kernel config file to make sure the test works with
> >>>      various kernel configuration
> >>> V5: Check /proc/config.gz for kernel config location first
> >>>
> >>>   tests/ext4/053     | 650 +++++++++++++++++++++++++++++++++++++++++++++
> >>>   tests/ext4/053.out |   2 +
> >>>   2 files changed, 652 insertions(+)
> >>>   create mode 100755 tests/ext4/053
> >>>   create mode 100644 tests/ext4/053.out
> >>>
> >>> diff --git a/tests/ext4/053 b/tests/ext4/053
> >>> new file mode 100755
> >>> index 00000000..c4447623
> >>> --- /dev/null
> >>> +++ b/tests/ext4/053
> >>> @@ -0,0 +1,650 @@
> >>> +#! /bin/bash
> >>> +# SPDX-License-Identifier: GPL-2.0
> >>> +# Copyright (c) 2021Red Hat, Inc., Lukas Czerner<lczerner@redhat.com>.
> >>> +#
> >>> +# FS QA Test 053
> >>> +#
> >>> +# Sanity check of ext4 mount options
> >>> +#
> >>> +. ./common/preamble
> >>> +_begin_fstest auto mount
> >>> +
> >>> +seq=`basename $0`
> >>> +seqres=$RESULT_DIR/$seq
> >>> +
> >>> +here=`pwd`
> >>> +tmp=/tmp/$$
> >>> +status=1	# failure is the default!
> >>> +trap "_cleanup; exit \$status" 0 1 2 3 15
> >>> +
> >>> +_cleanup()
> >>> +{
> >>> +	cd /
> >>> +	$UMOUNT_PROG $SCRATCH_MNT>  /dev/null 2>&1
> >>> +	if [ -n "$LOOP_LOGDEV" ];then
> >>> +		_destroy_loop_device $LOOP_LOGDEV 2>/dev/null
> >>> +	fi
> >>> +	rm -f $tmp.*
> >>> +}
> >>> +
> >>> +_has_kernel_config()
> >>> +{
> >>> +	option=$1
> >>> +	config="/proc/config.gz"
> >>> +	if [ -f $config ]; then
> >>> +		gzip -cd $config | grep -qE "^${option}=[my]"
> >>> +		return
> >>> +	fi
> >>> +	config="/lib/modules/$(uname -r)/build/.config"
> >>> +	grep -qE "^${option}=[my]" $config
> >>
> >> This probably ought to check /boot/config-$(uname -r) also, since that
> >> file seems to exist on RH and Debian.
> >
> > I was thinking about it, but at least on RH the config is in
> > /lib/modules/... which we already check and for custom kernels
> > /boot/config-$(uname -r) does not exist. So it seems redundant, but on
> > the other hand it can't hurt either.
> >
> Don't make wheels repeatedly. LTP has sloutions for this. You can refer 
> to it.
> [1]https://github.com/linux-test-project/ltp/blob/master/lib/tst_kconfig.c#L18

I did not know about this; that is a good suggestion!

--D

> Best Regards
> Yang Xu
> >>
> >> (The rest of the logic looks reasonable, but I've been away from ext4
> >> for so long that I don't really have enough of a clue anymore... :( )
> >
> > Thanks!
> > -Lukas
> >
> >>
> >> --D
> >>
> >>> +}
> >>> +
> >>> +_require_kernel_config()
> >>> +{
> >>> +	_has_kernel_config $1 || _notrun "Installed kernel not built with $1"
> >>> +}
> >>> +
> >>> +# get standard environment, filters and checks
> >>> +. ./common/rc
> >>> +. ./common/filter
> >>> +. ./common/quota
> >>> +
> >>> +# remove previous $seqres.full before test
> >>> +rm -f $seqres.full
> >>> +
> >>> +echo "Silence is golden."
> >>> +
> >>> +SIZE=$((1024 * 1024))	# 1GB in KB
> >>> +LOGSIZE=$((10 *1024))	# 10MB in KB
> >>> +
> >>> +_supported_fs ext2 ext3 ext4
> >>> +_require_scratch_size $SIZE
> >>> +_require_quota
> >>> +_require_loop
> >>> +_require_command "$TUNE2FS_PROG" tune2fs
> >>> +MKE2FS_PROG=$(type -P mke2fs)
> >>> +_require_command "$MKE2FS_PROG" mke2fs
> >>> +_require_kernel_config CONFIG_QFMT_V2
> >>> +
> >>> +LOG=""
> >>> +print_log() {
> >>> +	LOG="$LOG $@"
> >>> +}
> >>> +
> >>> +KERNEL_VERSION=`uname -r | cut -d'.' -f1,2`
> >>> +KERNEL_MAJ=${KERNEL_VERSION%.*}
> >>> +KERNEL_MIN=${KERNEL_VERSION#*.}
> >>> +
> >>> +kernel_gte() {
> >>> +	major=${1%.*}
> >>> +	minor=${1#*.}
> >>> +
> >>> +	if [ $KERNEL_MAJ -gt $major ]; then
> >>> +		return 0
> >>> +	elif [[ $KERNEL_MAJ -eq $major&&  $KERNEL_MIN -ge $minor ]]; then
> >>> +		return 0
> >>> +	fi
> >>> +	return 1
> >>> +}
> >>> +
> >>> +
> >>> +# The aim here is to keep the mount options behaviour stable going forward
> >>> +# so there is not much point in testing older kernels.
> >>> +kernel_gte 5.12 || _notrun "This test is only relevant for kernel versions 5.12 and higher"
> >>> +
> >>> +IGNORED="remount,defaults,ignored,removed"
> >>> +CHECK_MINFO="lazytime,noatime,nodiratime,noexec,nosuid,ro"
> >>> +ERR=0
> >>> +
> >>> +test_mnt() {
> >>> +	findmnt -n $SCRATCH_DEV>  /dev/null 2>&1
> >>> +	[ $? -ne 0 ]&&  return $?
> >>> +
> >>> +	if [ $# -eq 1 ]; then
> >>> +		OPTS=$1
> >>> +	elif [ $# -eq 2 ]; then
> >>> +		OPTS=$2
> >>> +	else
> >>> +		return 0
> >>> +	fi
> >>> +
> >>> +	print_log "checking \"$OPTS\" "
> >>> +	# test options in /proc/fs/ext4/dev/options
> >>> +	(
> >>> +	ret=0
> >>> +	IFS=','
> >>> +	for option in $OPTS; do
> >>> +		if echo $IGNORED | grep -w $option; then
> >>> +			continue
> >>> +		fi
> >>> +
> >>> +		[ $option = "noload" ]&&  option="norecovery"
> >>> +
> >>> +		if [[ $option = ^* ]]; then
> >>> +			expected=1
> >>> +		else
> >>> +			expected=0
> >>> +		fi
> >>> +		option=${option#^}
> >>> +
> >>> +		if echo $CHECK_MINFO | grep -w $option; then
> >>> +			findmnt -n -o OPTIONS $SCRATCH_DEV | grep $option
> >>> +			ret=$?
> >>> +		else
> >>> +			grep $option /proc/fs/ext4/$(_short_dev $SCRATCH_DEV)/options
> >>> +			ret=$?
> >>> +		fi
> >>> +
> >>> +		if [ $ret -ne $expected ]; then
> >>> +			exit 1
> >>> +		fi
> >>> +	done
> >>> +	)>  /dev/null 2>&1
> >>> +	return $?
> >>> +}
> >>> +
> >>> +fail() {
> >>> +	print_log "   FAILED"
> >>> +	ERR=$((ERR+1))
> >>> +	echo $LOG | tee -a $seqres.full
> >>> +	LOG=""
> >>> +}
> >>> +
> >>> +ok() {
> >>> +	print_log "   OK"
> >>> +	echo $LOG>>  $seqres.full
> >>> +	LOG=""
> >>> +}
> >>> +
> >>> +simple_mount() {
> >>> +	_mount $*>>  $seqres.full 2>&1
> >>> +}
> >>> +
> >>> +# $1 - can hold -n option, if it does argumetns are shifted
> >>> +# $1 - options to test
> >>> +# $2 - if provided it's the option string to check for
> >>> +do_mnt() {
> >>> +	device=$SCRATCH_DEV
> >>> +	# If -n argument is provided do not specify $SCRATCH_DEV
> >>> +	# usefull for remount
> >>> +	if [ "$1" == "-n" ]; then
> >>> +		unset device
> >>> +		shift
> >>> +	fi
> >>> +
> >>> +	if [ -z "$1" ]; then
> >>> +		simple_mount $device $SCRATCH_MNT
> >>> +		ret=$?
> >>> +	else
> >>> +		simple_mount -o $1 $device $SCRATCH_MNT
> >>> +		ret=$?
> >>> +	fi
> >>> +	if [ $ret -eq 0 ]; then
> >>> +		test_mnt $1 $2
> >>> +		ret=$?
> >>> +		[ $ret -ne 0 ]&&  print_log "(not found)"
> >>> +	else
> >>> +		print_log "(failed mount)"
> >>> +	fi
> >>> +
> >>> +	return $ret
> >>> +}
> >>> +
> >>> +not_mnt() {
> >>> +	# We don't need -t not not_ variant
> >>> +	if [ "$1" == "-t" ]; then
> >>> +		shift
> >>> +	fi
> >>> +
> >>> +	print_log "SHOULD FAIL mounting $fstype \"$1\" "
> >>> +	do_mnt $@
> >>> +	if [ $? -eq 0 ]; then
> >>> +		fail
> >>> +	else
> >>> +		ok
> >>> +	fi
> >>> +	$UMOUNT_PROG $SCRATCH_MNT 2>  /dev/null
> >>> +}
> >>> +
> >>> +mnt_only() {
> >>> +	print_log "mounting $fstype \"$1\" "
> >>> +	do_mnt $@
> >>> +	if [ $? -ne 0 ]; then
> >>> +		fail
> >>> +	else
> >>> +		ok
> >>> +	fi
> >>> +}
> >>> +
> >>> +mnt() {
> >>> +	# Do we need to run the tune2fs mount option test ?
> >>> +	t2fs=0
> >>> +	if [ "$1" == "-t" ]; then
> >>> +		t2fs=1
> >>> +		shift
> >>> +	fi
> >>> +
> >>> +	mnt_only $*
> >>> +	$UMOUNT_PROG $SCRATCH_MNT 2>  /dev/null
> >>> +
> >>> +	[ "$t2fs" -eq 0 ]&&  return
> >>> +
> >>> +	op_set=$1
> >>> +	if [ $# -eq 1 ]; then
> >>> +		check=$1
> >>> +	elif [ $# -eq 2 ]; then
> >>> +		check=$2
> >>> +	else
> >>> +		return 0
> >>> +	fi
> >>> +
> >>> +	# some options need translation for tune2fs
> >>> +	op_set=$(echo $op_set | sed -e 's/data=journal/journal_data/' \
> >>> +				    -e 's/data=ordered/journal_data_ordered/' \
> >>> +				    -e 's/data=writeback/journal_data_writeback/')
> >>> +	$TUNE2FS_PROG -o $op_set $SCRATCH_DEV>  /dev/null 2>&1
> >>> +	mnt_only "defaults" $check
> >>> +	$UMOUNT_PROG $SCRATCH_MNT 2>  /dev/null
> >>> +	if [ "$op_set" = ^* ]; then
> >>> +		op_set=${op_set#^}
> >>> +	else
> >>> +		op_set="^${op_set}"
> >>> +	fi
> >>> +	$TUNE2FS_PROG -o $op_set $SCRATCH_DEV>  /dev/null 2>&1
> >>> +}
> >>> +
> >>> +# $1 - options to mount with
> >>> +# $2 - options to remount with
> >>> +remount() {
> >>> +	# First do this specifying both dev and mnt
> >>> +	print_log "mounting $fstype \"$1\" "
> >>> +	do_mnt $1
> >>> +	[ $? -ne 0 ]&&  fail&&  return
> >>> +	print_log "remounting \"$2\" "
> >>> +	do_mnt remount,$2 $3
> >>> +	if [ $? -ne 0 ]; then
> >>> +		fail
> >>> +		$UMOUNT_PROG $SCRATCH_MNT 2>  /dev/null
> >>> +		return
> >>> +	else
> >>> +		ok
> >>> +	fi
> >>> +	$UMOUNT_PROG $SCRATCH_MNT 2>  /dev/null
> >>> +
> >>> +	# Now just specify mnt
> >>> +	print_log "mounting $fstype \"$1\" "
> >>> +	do_mnt $1
> >>> +	[ $? -ne 0 ]&&  fail&&  return
> >>> +	print_log "remounting (MNT ONLY) \"$2\" "
> >>> +	do_mnt -n remount,$2 $3
> >>> +	if [ $? -ne 0 ]; then
> >>> +		fail
> >>> +	else
> >>> +		ok
> >>> +	fi
> >>> +
> >>> +	$UMOUNT_PROG $SCRATCH_MNT 2>  /dev/null
> >>> +}
> >>> +
> >>> +# $1 - options to mount with, or -r argument
> >>> +# $2 - options to remount with
> >>> +not_remount_noumount() {
> >>> +	remount_only=0
> >>> +	# If -r is specified we're going to do remount only
> >>> +	if [ "$1" == "-r" ]; then
> >>> +		remount_only=1
> >>> +		# Dont need shift since first argument would
> >>> +		# have been consumed by mount anyway
> >>> +	fi
> >>> +
> >>> +	if [ $remount_only -eq 0 ]; then
> >>> +		print_log "mounting $fstype \"$1\" "
> >>> +		do_mnt $1
> >>> +		[ $? -ne 0 ]&&  fail&&  return
> >>> +	fi
> >>> +	print_log "SHOULD FAIL remounting $fstype \"$2\" "
> >>> +	do_mnt remount,$2 $3
> >>> +	if [ $? -eq 0 ]; then
> >>> +		fail
> >>> +	else
> >>> +		ok
> >>> +	fi
> >>> +
> >>> +	# Now just specify mnt
> >>> +	print_log "SHOULD FAIL remounting $fstype (MNT ONLY) \"$2\" "
> >>> +	do_mnt -n remount,$2 $3
> >>> +	if [ $? -eq 0 ]; then
> >>> +		fail
> >>> +	else
> >>> +		ok
> >>> +	fi
> >>> +}
> >>> +
> >>> +not_remount() {
> >>> +	not_remount_noumount $*
> >>> +	$UMOUNT_PROG $SCRATCH_MNT 2>  /dev/null
> >>> +}
> >>> +
> >>> +
> >>> +do_mkfs() {
> >>> +	$MKE2FS_PROG -T $fstype -Fq $*>>  $seqres.full 2>&1 ||
> >>> +	_fail "mkfs failed - $MKFS_EXT4_PROG -Fq $* $SCRATCH_DEV"
> >>> +}
> >>> +
> >>> +not_ext2() {
> >>> +	if [[ $fstype == "ext2" ]]; then
> >>> +		not_$*
> >>> +	else
> >>> +		$*
> >>> +	fi
> >>> +}
> >>> +
> >>> +only_ext4() {
> >>> +	if [[ $fstype == "ext4" ]]; then
> >>> +		$*
> >>> +	else
> >>> +		not_$*
> >>> +	fi
> >>> +}
> >>> +
> >>> +# Create logdev for external journal
> >>> +LOOP_IMG=$tmp.logdev
> >>> +truncate -s ${LOGSIZE}k $LOOP_IMG
> >>> +LOOP_LOGDEV=`_create_loop_device $LOOP_IMG`
> >>> +majmin=`stat -c "%t:%T" $LOOP_LOGDEV`
> >>> +LOGDEV_DEVNUM=`echo "${majmin%:*}*2^8 + ${majmin#*:}" | bc`
> >>> +
> >>> +# Test all the extN file system supported by ext4 driver
> >>> +fstype=
> >>> +for fstype in ext2 ext3 ext4; do
> >>> +
> >>> +	$UMOUNT_PROG $SCRATCH_MNT 2>  /dev/null
> >>> +	$UMOUNT_PROG $SCRATCH_DEV 2>  /dev/null
> >>> +
> >>> +	do_mkfs $SCRATCH_DEV ${SIZE}k
> >>> +
> >>> +	# do we have fstype support ?
> >>> +	do_mnt
> >>> +	if [ $? -ne 0 ]; then
> >>> +		print_log "$fstype not supported. Skipping..."
> >>> +		ok
> >>> +		continue
> >>> +	fi
> >>> +	if [ ! -f /proc/fs/ext4/$(_short_dev $SCRATCH_DEV)/options ]; then
> >>> +		print_log "$fstype not supported. Skipping..."
> >>> +		ok
> >>> +		continue
> >>> +	fi
> >>> +
> >>> +	$UMOUNT_PROG $SCRATCH_MNT 2>  /dev/null
> >>> +
> >>> +	not_mnt failme
> >>> +	mnt
> >>> +	mnt bsddf
> >>> +	mnt minixdf
> >>> +	mnt grpid
> >>> +	mnt -t bsdgroups grpid
> >>> +	mnt nogrpid
> >>> +	mnt sysvgroups nogrpid
> >>> +	mnt resgid=1001
> >>> +	mnt resuid=1001
> >>> +	mnt sb=131072
> >>> +	mnt errors=continue
> >>> +	mnt errors=panic
> >>> +	mnt errors=remount-ro
> >>> +	mnt nouid32
> >>> +	mnt debug
> >>> +	mnt oldalloc removed
> >>> +	mnt orlov removed
> >>> +	mnt -t user_xattr
> >>> +	mnt nouser_xattr
> >>> +
> >>> +	if _has_kernel_config CONFIG_EXT4_FS_POSIX_ACL; then
> >>> +		mnt -t acl
> >>> +	else
> >>> +		mnt -t acl ^acl
> >>> +	fi
> >>> +
> >>> +	not_ext2 mnt noload norecovery
> >>> +	mnt bh removed
> >>> +	mnt nobh removed
> >>> +	not_ext2 mnt commit=7
> >>> +	mnt min_batch_time=200
> >>> +	mnt max_batch_time=10000
> >>> +	only_ext4 mnt journal_checksum
> >>> +	only_ext4 mnt nojournal_checksum
> >>> +	only_ext4 mnt journal_async_commit,data=writeback
> >>> +	mnt abort ignored
> >>> +	not_ext2 mnt -t data=journal
> >>> +	not_ext2 mnt -t data=ordered
> >>> +	not_ext2 mnt -t data=writeback
> >>> +	not_ext2 mnt data_err=abort
> >>> +	not_ext2 mnt data_err=ignore ignored
> >>> +	mnt usrjquota=aquota.user,jqfmt=vfsv0
> >>> +	not_mnt usrjquota=aquota.user
> >>> +	mnt usrjquota= ignored
> >>> +	mnt grpjquota=aquota.group,jqfmt=vfsv0
> >>> +	not_mnt grpjquota=aquota.group
> >>> +	mnt grpjquota= ignored
> >>> +	mnt jqfmt=vfsold
> >>> +	mnt jqfmt=vfsv0
> >>> +	mnt jqfmt=vfsv1
> >>> +	mnt grpquota
> >>> +	mnt quota
> >>> +	mnt noquota
> >>> +	mnt usrquota
> >>> +	mnt grpquota
> >>> +	mnt barrier
> >>> +	mnt barrier=0 nobarrier
> >>> +	mnt barrier=1 barrier
> >>> +	mnt barrier=99 barrier
> >>> +	mnt -t nobarrier
> >>> +	mnt i_version
> >>> +	mnt stripe=512
> >>> +	only_ext4 mnt delalloc
> >>> +	only_ext4 mnt -t nodelalloc
> >>> +	mnt warn_on_error
> >>> +	mnt nowarn_on_error
> >>> +	not_mnt debug_want_extra_isize=512
> >>> +	mnt debug_want_extra_isize=32 ignored
> >>> +	mnt mblk_io_submit removed
> >>> +	mnt nomblk_io_submit removed
> >>> +	mnt -t block_validity
> >>> +	mnt noblock_validity
> >>> +	mnt inode_readahead_blks=16
> >>> +	not_ext2 mnt journal_ioprio=6 ignored
> >>> +	mnt auto_da_alloc=0 noauto_da_alloc
> >>> +	mnt auto_da_alloc=1 auto_da_alloc
> >>> +	mnt auto_da_alloc=95 auto_da_alloc
> >>> +	mnt auto_da_alloc
> >>> +	mnt noauto_da_alloc
> >>> +	only_ext4 mnt dioread_nolock
> >>> +	only_ext4 mnt nodioread_nolock
> >>> +	only_ext4 mnt dioread_lock nodioread_nolock
> >>> +	mnt -t discard
> >>> +	mnt nodiscard
> >>> +	mnt init_itable=20
> >>> +	mnt init_itable
> >>> +	mnt init_itable=0
> >>> +	mnt noinit_itable
> >>> +	mnt max_dir_size_kb=4096
> >>> +
> >>> +	if _has_kernel_config CONFIG_FS_ENCRYPTION; then
> >>> +		mnt test_dummy_encryption
> >>> +		mnt test_dummy_encryption=v1
> >>> +		mnt test_dummy_encryption=v2
> >>> +		not_mnt test_dummy_encryption=v3
> >>> +		not_mnt test_dummy_encryption=
> >>> +	else
> >>> +		mnt test_dummy_encryption ^test_dummy_encryption
> >>> +		mnt test_dummy_encryption=v1 ^test_dummy_encryption=v1
> >>> +		mnt test_dummy_encryption=v2 ^test_dummy_encryption=v2
> >>> +		not_mnt test_dummy_encryption=v3
> >>> +		not_mnt test_dummy_encryption=
> >>> +	fi
> >>> +
> >>> +	if _has_kernel_config CONFIG_FS_ENCRYPTION_INLINE_CRYPT; then
> >>> +		mnt inlinecrypt
> >>> +	else
> >>> +		mnt inlinecrypt ^inlinecrypt
> >>> +	fi
> >>> +
> >>> +	mnt prefetch_block_bitmaps removed
> >>> +	mnt no_prefetch_block_bitmaps
> >>> +	# We don't currently have a way to know that the option has been
> >>> +	# applied, so comment it out for now. This should be fixed in the
> >>> +	# future.
> >>> +	#mnt mb_optimize_scan=0
> >>> +	#mnt mb_optimize_scan=1
> >>> +	#not_mnt mb_optimize_scan=9
> >>> +	#not_mnt mb_optimize_scan=
> >>> +	mnt nombcache
> >>> +	mnt no_mbcache nombcache
> >>> +	mnt check=none removed
> >>> +	mnt nocheck removed
> >>> +	mnt reservation removed
> >>> +	mnt noreservation removed
> >>> +	mnt journal=20 ignored
> >>> +	not_mnt nonsenseoption
> >>> +	not_mnt nonsenseoption=value
> >>> +
> >>> +	# generic mount options
> >>> +	mnt lazytime
> >>> +	mnt nolazytime ^lazytime
> >>> +	mnt noatime
> >>> +	mnt nodiratime
> >>> +	mnt noexec
> >>> +	mnt nosuid
> >>> +	mnt ro
> >>> +
> >>> +	# generic remount check
> >>> +	remount barrier nobarrier
> >>> +	remount nobarrier barrier
> >>> +	remount discard nodiscard
> >>> +	remount nodiscard discard
> >>> +
> >>> +	# dax mount options
> >>> +	simple_mount -o dax=always $SCRATCH_DEV $SCRATCH_MNT>  /dev/null 2>&1
> >>> +	if [ $? -eq 0 ]; then
> >>> +		$UMOUNT_PROG $SCRATCH_MNT 2>  /dev/null
> >>> +		mnt dax
> >>> +		mnt dax=always
> >>> +		mnt dax=never
> >>> +		mnt dax=inode
> >>> +
> >>> +		not_remount lazytime dax
> >>> +		not_remount dax=always dax=never
> >>> +
> >>> +		if [[ $fstype != "ext2" ]]; then
> >>> +			not_remount data=journal dax
> >>> +			not_remount data=journal dax=always
> >>> +			not_remount data=journal dax=never
> >>> +			not_remount data=journal dax=inode
> >>> +		fi
> >>> +	fi
> >>> +
> >>> +	# Quota remount check
> >>> +	remount grpquota usrquota
> >>> +	remount usrquota quota
> >>> +	remount usrquota usrjquota=q.u,jqfmt=vfsv0
> >>> +	remount grpquota grpjquota=q.g,jqfmt=vfsv0
> >>> +
> >>> +	not_remount usrquota grpjquota=q.g,jqfmt=vfsv0
> >>> +	not_remount grpquota usrjquota=q.u,jqfmt=vfsv0
> >>> +
> >>> +	remount quota usrjquota=q.u,jqfmt=vfsv0
> >>> +	not_remount quota grpjquota=q.g,jqfmt=vfsv0
> >>> +
> >>> +	remount usrjquota=q.u,jqfmt=vfsv0 grpjquota=q.g
> >>> +	not_remount usrjquota=q.u,jqfmt=vfsv0 usrjquota=q.ua
> >>> +	not_remount grpjquota=q.g,jqfmt=vfsv0 grpjquota=q.ga
> >>> +
> >>> +	remount usrjquota=q.u,jqfmt=vfsv0 usrquota usrjquota=q.u,jqfmt=vfsv0
> >>> +	remount grpjquota=q.g,jqfmt=vfsv0 grpquota grpjquota=q.g,jqfmt=vfsv0
> >>> +	not_remount usrjquota=q.u,jqfmt=vfsv0 grpquota
> >>> +	not_remount grpjquota=q.g,jqfmt=vfsv0 usrquota
> >>> +
> >>> +	remount grpjquota=q.g,jqfmt=vfsv0 grpjquota= ^grpjquota=
> >>> +	remount usrjquota=q.u,jqfmt=vfsv0 usrjquota= ^usrjquota=
> >>> +	remount grpjquota=q.g,usrjquota=q.u,jqfmt=vfsv0 grpjquota=,usrjquota= ^grpjquota=,^usrjquota=
> >>> +
> >>> +	remount jqfmt=vfsv0 grpjquota=q.g
> >>> +	remount jqfmt=vfsv0 usrjquota=q.u
> >>> +
> >>> +	if [[ $fstype != "ext2" ]]; then
> >>> +		remount noload data=journal norecovery
> >>> +		not_remount data=ordered data=journal
> >>> +		not_remount data=journal data=writeback
> >>> +		not_remount data=writeback data=ordered
> >>> +	fi
> >>> +
> >>> +	do_mkfs -O journal_dev $LOOP_LOGDEV ${LOGSIZE}k
> >>> +	do_mkfs -J device=$LOOP_LOGDEV $SCRATCH_DEV ${SIZE}k
> >>> +	mnt defaults
> >>> +	mnt journal_path=$LOOP_LOGDEV ignored
> >>> +	mnt journal_dev=$LOGDEV_DEVNUM ignored
> >>> +	not_mnt journal_path=${LOOP_LOGDEV}_nonexistent ignored
> >>> +	not_mnt journal_dev=123456 ignored
> >>> +	not_mnt journal_dev=999999999999999 ignored
> >>> +
> >>> +	do_mkfs -E quotatype=prjquota $SCRATCH_DEV ${SIZE}k
> >>> +	mnt prjquota
> >>> +
> >>> +	# test clearing/changing journalled quota when enabled
> >>> +	echo "== Testing active journalled quota">>  $seqres.full
> >>> +	mnt_only prjquota,grpjquota=aquota.group,usrjquota=aquota.user,jqfmt=vfsv0
> >>> +
> >>> +	# Prepare and enable quota
> >>> +	quotacheck -vugm $SCRATCH_MNT>>  $seqres.full 2>&1
> >>> +	quotaon -vug $SCRATCH_MNT>>  $seqres.full 2>&1
> >>> +
> >>> +	not_remount_noumount -r grpjquota=
> >>> +	not_remount_noumount -r usrjquota=aaquota.user
> >>> +	not_remount_noumount -r grpjquota=aaquota.group
> >>> +	not_remount_noumount -r jqfmt=vfsv1
> >>> +	not_remount_noumount -r noquota
> >>> +	mnt_only remount,usrquota,grpquota ^usrquota,^grpquota
> >>> +	$UMOUNT_PROG $SCRATCH_MNT>  /dev/null 2>&1
> >>> +
> >>> +	# test clearing/changing quota when enabled
> >>> +	do_mkfs -E quotatype=^prjquota $SCRATCH_DEV ${SIZE}k
> >>> +	not_mnt prjquota
> >>> +	echo "== Testing active non-journalled quota">>  $seqres.full
> >>> +	mnt_only grpquota,usrquota
> >>> +
> >>> +	# Prepare and enable quota
> >>> +	quotacheck -vugm $SCRATCH_MNT>>  $seqres.full 2>&1
> >>> +	quotaon -vug $SCRATCH_MNT>>  $seqres.full 2>&1
> >>> +
> >>> +	not_remount_noumount -r noquota
> >>> +	not_remount_noumount -r usrjquota=aquota.user
> >>> +	not_remount_noumount -r grpjquota=aquota.group
> >>> +	not_remount_noumount -r jqfmt=vfsv1
> >>> +	mnt_only remount,grpjquota= grpquota,^grpjquota
> >>> +	mnt_only remount,usrjquota= usrquota,^usrjquota
> >>> +	mnt_only remount,usrquota,grpquota usrquota,grpquota
> >>> +	quotaoff -f $SCRATCH_MNT>>  $seqres.full 2>&1
> >>> +	mnt_only remount,noquota ^usrquota,^grpquota,quota
> >>> +	$UMOUNT_PROG $SCRATCH_MNT>  /dev/null 2>&1
> >>> +
> >>> +	# Quota feature
> >>> +	echo "== Testing quota feature ">>  $seqres.full
> >>> +	do_mkfs -O quota -E quotatype=prjquota $SCRATCH_DEV ${SIZE}k
> >>> +	mnt usrjquota=aquota.user,jqfmt=vfsv0 ^usrjquota=
> >>> +	mnt grpjquota=aquota.user,jqfmt=vfsv0 ^grpjquota=
> >>> +	mnt jqfmt=vfsv1 ^jqfmt=
> >>> +	mnt prjquota
> >>> +	mnt usrquota
> >>> +	mnt grpquota
> >>> +	not_remount defaults usrjquota=aquota.user
> >>> +	not_remount defaults grpjquota=aquota.user
> >>> +	not_remount defaults jqfmt=vfsv1
> >>> +	remount defaults grpjquota=,usrjquota= ignored
> >>> +
> >>> +done #for fstype in ext2 ext3 ext4; do
> >>> +
> >>> +$UMOUNT_PROG $SCRATCH_MNT>  /dev/null 2>&1
> >>> +echo "$ERR errors encountered">>  $seqres.full
> >>> +
> >>> +status=$ERR
> >>> +exit
> >>> diff --git a/tests/ext4/053.out b/tests/ext4/053.out
> >>> new file mode 100644
> >>> index 00000000..d58db7e4
> >>> --- /dev/null
> >>> +++ b/tests/ext4/053.out
> >>> @@ -0,0 +1,2 @@
> >>> +QA output created by 053
> >>> +Silence is golden.
> >>> --
> >>> 2.31.1
> >>>
> >>
> >
> >
> >
