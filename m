Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A32438AA5
	for <lists+linux-ext4@lfdr.de>; Sun, 24 Oct 2021 18:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhJXQdv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 24 Oct 2021 12:33:51 -0400
Received: from out20-229.mail.aliyun.com ([115.124.20.229]:46724 "EHLO
        out20-229.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJXQdv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 24 Oct 2021 12:33:51 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;BR=01201311R221S93rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0955627-0.00782703-0.89661;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Lh2rLKF_1635093088;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Lh2rLKF_1635093088)
          by smtp.aliyun-inc.com(10.147.43.230);
          Mon, 25 Oct 2021 00:31:28 +0800
Date:   Mon, 25 Oct 2021 00:31:28 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4: add test for all ext4/ext3/ext2 mount options
Message-ID: <YXWKYG7gluz62MNb@desktop>
References: <20211018130001.6440-1-lczerner@redhat.com>
 <20211020121226.15236-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020121226.15236-1-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 20, 2021 at 02:12:26PM +0200, Lukas Czerner wrote:
> Add test to validate that all the ext4, ext3 and ext2 are properly
> recognized, validate and applied to avoid regressions as ext4 moves to
> the new mount API.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
> v2: Move minimum kernel version requirement up to 5.12
>     Rewrite kernel_gte() to work correctly

fstests doesn't do version check but only actually try it and see if the
wanted feature is supported, so I want to avoid this kernel version
check as much as possible.

OTOH, I understand that there's no good way to tell if a mount option is
supported by current kernel, and it's not clear a mount failure is
caused by a regression or an unsupported mount option.

I'd like to see if anyone else has better ideas/suggestions.

Some minor issues below.

> 
>  tests/ext4/053     | 611 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/053.out |   2 +
>  2 files changed, 613 insertions(+)
>  create mode 100755 tests/ext4/053
>  create mode 100644 tests/ext4/053.out
> 
> diff --git a/tests/ext4/053 b/tests/ext4/053
> new file mode 100755
> index 00000000..7163319f
> --- /dev/null
> +++ b/tests/ext4/053
> @@ -0,0 +1,611 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Red Hat, Inc., Lukas Czerner <lczerner@redhat.com>.
> +#
> +# FS QA Test 053
> +#
> +# Sanity check of ext4 mount options
> +#
> +. ./common/preamble
> +_begin_fstest auto mount
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> +	if [ -n "$LOOP_LOGDEV" ];then
> +		_destroy_loop_device $LOOP_LOGDEV 2>/dev/null
> +	fi
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/quota
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +echo "Silence is golden."
> +
> +SIZE=$((1024 * 1024))	# 1GB in KB
> +LOGSIZE=$((10 *1024))	# 10MB in KB
> +
> +_supported_fs ext2 ext3 ext4
> +_require_scratch_size $SIZE
> +_require_quota
> +_require_loop
> +_require_command "$TUNE2FS_PROG" tune2fs
> +MKE2FS_PROG=$(type -P mke2fs)
> +_require_command "$MKE2FS_PROG" mke2fs
> +
> +LOG=""
> +print_log() {
> +	LOG="$LOG $@"
> +}
> +
> +KERNEL_VERSION=`uname -r | cut -d'.' -f1,2`
> +KERNEL_MAJ=${KERNEL_VERSION%.*}
> +KERNEL_MIN=${KERNEL_VERSION#*.}
> +
> +kernel_gte() {
> +	major=${1%.*}
> +	minor=${1#*.}
> +
> +	if [ $KERNEL_MAJ -gt $major ]; then
> +		return 0
> +	elif [[ $KERNEL_MAJ -eq $major && $KERNEL_MIN -ge $minor ]]; then
> +		return 0
> +	fi
> +	return 1
> +}
> +
> +
> +# The aim here is to keep the mount options behaviour stable going forward
> +# so there is not much point in testing older kernels.
> +kernel_gte 5.12 || _notrun "This test is only relevant for kernel versions 5.12 and higher"
> +
> +IGNORED="remount,defaults,ignored,removed"
> +CHECK_MINFO="lazytime,noatime,nodiratime,noexec,nosuid,ro"
> +ERR=0
> +
> +test_mnt() {
> +	findmnt -n $SCRATCH_DEV > /dev/null 2>&1
> +	[ $? -ne 0 ] && return $?
> +
> +	if [ $# -eq 1 ]; then
> +		OPTS=$1
> +	elif [ $# -eq 2 ]; then
> +		OPTS=$2
> +	else
> +		return 0
> +	fi
> +
> +	print_log "checking \"$OPTS\" "
> +	# test options in /proc/fs/ext4/dev/options
> +	(
> +	ret=0
> +	IFS=','
> +	for option in $OPTS; do
> +		if echo $IGNORED | grep -w $option; then
> +			continue
> +		fi
> +
> +		[ $option = "noload" ] && option="norecovery"
> +
> +		if [[ $option = ^* ]]; then
> +			expected=1
> +		else
> +			expected=0
> +		fi
> +		option=${option#^}
> +
> +		if echo $CHECK_MINFO | grep -w $option; then
> +			findmnt -n -o OPTIONS $SCRATCH_DEV | grep $option
> +			ret=$?
> +		else
> +			grep $option /proc/fs/ext4/$(_short_dev $SCRATCH_DEV)/options
> +			ret=$?
> +		fi
> +
> +		if [ $ret -ne $expected ]; then
> +			exit 1
> +		fi
> +	done
> +	) > /dev/null 2>&1
> +	return $?
> +}
> +
> +fail() {
> +	print_log "   FAILED"
> +	ERR=$((ERR+1))
> +	echo $LOG | tee -a $seqres.full
> +	LOG=""
> +}
> +
> +ok() {
> +	print_log "   OK"
> +	echo $LOG >> $seqres.full
> +	LOG=""
> +}
> +
> +simple_mount() {
> +	_mount $* >> $seqres.full 2>&1
> +}
> +
> +# $1 - can hold -n option, if it does argumetns are shifted
> +# $1 - options to test
> +# $2 - if provided it's the option string to check for
> +do_mnt() {
> +	device=$SCRATCH_DEV
> +	# If -n argument is provided do not specify $SCRATCH_DEV
> +	# usefull for remount
> +	if [ "$1" == "-n" ]; then
> +		unset device
> +		shift
> +	fi
> +
> +	if [ -z "$1" ]; then
> +		simple_mount $device $SCRATCH_MNT
> +		ret=$?
> +	else
> +		simple_mount -o $1 $device $SCRATCH_MNT
> +		ret=$?
> +	fi
> +	if [ $ret -eq 0 ]; then
> +		test_mnt $1 $2
> +		ret=$?
> +		[ $ret -ne 0 ] && print_log "(not found)"
> +	else
> +		print_log "(failed mount)"
> +	fi
> +
> +	return $ret
> +}
> +
> +not_mnt() {
> +	# We don't need -t not not_ variant
> +	if [ "$1" == "-t" ]; then
> +		shift
> +	fi
> +
> +	print_log "SHOULD FAIL mounting $fstype \"$1\" "
> +	do_mnt $@
> +	if [ $? -eq 0 ]; then
> +		fail
> +	else
> +		ok
> +	fi
> +	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +}
> +
> +_mnt() {

Local functions don't need the _ prefix, that's for common helpers.

> +	print_log "mounting $fstype \"$1\" "
> +	do_mnt $@
> +	if [ $? -ne 0 ]; then
> +		fail
> +	else
> +		ok
> +	fi
> +}
> +
> +mnt() {
> +	# Do we need to run the tune2fs mount option test ?
> +	t2fs=0
> +	if [ "$1" == "-t" ]; then
> +		t2fs=1
> +		shift
> +	fi
> +
> +	_mnt $*
> +	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +
> +	[ "$t2fs" -eq 0 ] && return
> +
> +	op_set=$1
> +	if [ $# -eq 1 ]; then
> +		check=$1
> +	elif [ $# -eq 2 ]; then
> +		check=$2
> +	else
> +		return 0
> +	fi
> +
> +	# some options need translation for tune2fs
> +	op_set=$(echo $op_set | sed -e 's/data=journal/journal_data/' \
> +				    -e 's/data=ordered/journal_data_ordered/' \
> +				    -e 's/data=writeback/journal_data_writeback/')
> +	$TUNE2FS_PROG -o $op_set $SCRATCH_DEV > /dev/null 2>&1
> +	_mnt "defaults" $check
> +	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +	if [ "$op_set" = ^* ]; then
> +		op_set=${op_set#^}
> +	else
> +		op_set="^${op_set}"
> +	fi
> +	$TUNE2FS_PROG -o $op_set $SCRATCH_DEV > /dev/null 2>&1
> +}
> +
> +# $1 - options to mount with
> +# $2 - options to remount with
> +remount() {
> +	# First do this specifying both dev and mnt
> +	print_log "mounting $fstype \"$1\" "
> +	do_mnt $1
> +	[ $? -ne 0 ] && fail && return
> +	print_log "remounting \"$2\" "
> +	do_mnt remount,$2 $3
> +	if [ $? -ne 0 ]; then
> +		fail
> +		$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +		return
> +	else
> +		ok
> +	fi
> +	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +
> +	# Now just specify mnt
> +	print_log "mounting $fstype \"$1\" "
> +	do_mnt $1
> +	[ $? -ne 0 ] && fail && return
> +	print_log "remounting (MNT ONLY) \"$2\" "
> +	do_mnt -n remount,$2 $3
> +	if [ $? -ne 0 ]; then
> +		fail
> +	else
> +		ok
> +	fi
> +
> +	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +}
> +
> +# $1 - options to mount with, or -r argument
> +# $2 - options to remount with
> +_not_remount() {

Same here.

Thanks,
Eryu

> +	remount_only=0
> +	# If -r is specified we're going to do remount only
> +	if [ "$1" == "-r" ]; then
> +		remount_only=1
> +		# Dont need shift since first argument would
> +		# have been consumed by mount anyway
> +	fi
> +
> +	if [ $remount_only -eq 0 ]; then
> +		print_log "mounting $fstype \"$1\" "
> +		do_mnt $1
> +		[ $? -ne 0 ] && fail && return
> +	fi
> +	print_log "SHOULD FAIL remounting $fstype \"$2\" "
> +	do_mnt remount,$2 $3
> +	if [ $? -eq 0 ]; then
> +		fail
> +	else
> +		ok
> +	fi
> +
> +	# Now just specify mnt
> +	print_log "SHOULD FAIL remounting $fstype (MNT ONLY) \"$2\" "
> +	do_mnt -n remount,$2 $3
> +	if [ $? -eq 0 ]; then
> +		fail
> +	else
> +		ok
> +	fi
> +}
> +
> +not_remount() {
> +	_not_remount $*
> +	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +}
> +
> +
> +do_mkfs() {
> +	$MKE2FS_PROG -T $fstype -Fq $* >> $seqres.full 2>&1 ||
> +	_fail "mkfs failed - $MKFS_EXT4_PROG -Fq $* $SCRATCH_DEV"
> +}
> +
> +not_ext2() {
> +	if [[ $fstype == "ext2" ]]; then
> +		not_$*
> +	else
> +		$*
> +	fi
> +}
> +
> +only_ext4() {
> +	if [[ $fstype == "ext4" ]]; then
> +		$*
> +	else
> +		not_$*
> +	fi
> +}
> +
> +# Create logdev for external journal
> +LOOP_IMG=$tmp.logdev
> +truncate -s ${LOGSIZE}k $LOOP_IMG
> +LOOP_LOGDEV=`_create_loop_device $LOOP_IMG`
> +majmin=`stat -c "%t:%T" $LOOP_LOGDEV`
> +LOGDEV_DEVNUM=`echo "${majmin%:*}*2^8 + ${majmin#*:}" | bc`
> +
> +# Test all the extN file system supported by ext4 driver
> +fstype=
> +for fstype in ext2 ext3 ext4; do
> +
> +	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +	$UMOUNT_PROG $SCRATCH_DEV 2> /dev/null
> +
> +	do_mkfs $SCRATCH_DEV ${SIZE}k
> +
> +	# do we have fstype support ?
> +	do_mnt
> +	if [ $? -ne 0 ]; then
> +		print_log "$fstype not supported. Skipping..."
> +		ok
> +		continue
> +	fi
> +	if [ ! -f /proc/fs/ext4/$(_short_dev $SCRATCH_DEV)/options ]; then
> +		print_log "$fstype not supported. Skipping..."
> +		ok
> +		continue
> +	fi
> +
> +	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +
> +	not_mnt failme
> +	mnt
> +	mnt bsddf
> +	mnt minixdf
> +	mnt grpid
> +	mnt -t bsdgroups grpid
> +	mnt nogrpid
> +	mnt sysvgroups nogrpid
> +	mnt resgid=1001
> +	mnt resuid=1001
> +	mnt sb=131072
> +	mnt errors=continue
> +	mnt errors=panic
> +	mnt errors=remount-ro
> +	mnt nouid32
> +	mnt debug
> +	mnt oldalloc removed
> +	mnt orlov removed
> +	mnt -t user_xattr
> +	mnt nouser_xattr
> +	mnt -t acl
> +	not_ext2 mnt noload norecovery
> +	mnt bh removed
> +	mnt nobh removed
> +	not_ext2 mnt commit=7
> +	mnt min_batch_time=200
> +	mnt max_batch_time=10000
> +	only_ext4 mnt journal_checksum
> +	only_ext4 mnt nojournal_checksum
> +	only_ext4 mnt journal_async_commit,data=writeback
> +	mnt abort ignored
> +	not_ext2 mnt -t data=journal
> +	not_ext2 mnt -t data=ordered
> +	not_ext2 mnt -t data=writeback
> +	not_ext2 mnt data_err=abort
> +	not_ext2 mnt data_err=ignore ignored
> +	mnt usrjquota=aquota.user,jqfmt=vfsv0
> +	not_mnt usrjquota=aquota.user
> +	mnt usrjquota= ignored
> +	mnt grpjquota=aquota.group,jqfmt=vfsv0
> +	not_mnt grpjquota=aquota.group
> +	mnt grpjquota= ignored
> +	mnt jqfmt=vfsold
> +	mnt jqfmt=vfsv0
> +	mnt jqfmt=vfsv1
> +	mnt grpquota
> +	mnt quota
> +	mnt noquota
> +	mnt usrquota
> +	mnt grpquota
> +	mnt barrier
> +	mnt barrier=0 nobarrier
> +	mnt barrier=1 barrier
> +	mnt barrier=99 barrier
> +	mnt -t nobarrier
> +	mnt i_version
> +	mnt stripe=512
> +	only_ext4 mnt delalloc
> +	only_ext4 mnt -t nodelalloc
> +	mnt warn_on_error
> +	mnt nowarn_on_error
> +	not_mnt debug_want_extra_isize=512
> +	mnt debug_want_extra_isize=32 ignored
> +	mnt mblk_io_submit removed
> +	mnt nomblk_io_submit removed
> +	mnt -t block_validity
> +	mnt noblock_validity
> +	mnt inode_readahead_blks=16
> +	not_ext2 mnt journal_ioprio=6 ignored
> +	mnt auto_da_alloc=0 noauto_da_alloc
> +	mnt auto_da_alloc=1 auto_da_alloc
> +	mnt auto_da_alloc=95 auto_da_alloc
> +	mnt auto_da_alloc
> +	mnt noauto_da_alloc
> +	only_ext4 mnt dioread_nolock
> +	only_ext4 mnt nodioread_nolock
> +	only_ext4 mnt dioread_lock nodioread_nolock
> +	mnt -t discard
> +	mnt nodiscard
> +	mnt init_itable=20
> +	mnt init_itable
> +	mnt init_itable=0
> +	mnt noinit_itable
> +	mnt max_dir_size_kb=4096
> +	mnt test_dummy_encryption
> +	mnt test_dummy_encryption=v1
> +	mnt test_dummy_encryption=v2
> +	not_mnt test_dummy_encryption=v3
> +	not_mnt test_dummy_encryption=
> +	mnt inlinecrypt
> +	mnt prefetch_block_bitmaps removed
> +	mnt no_prefetch_block_bitmaps
> +	# We don't currently have a way to know that the option has been
> +	# applied, so comment it out for now. This should be fixed in the
> +	# future.
> +	#mnt mb_optimize_scan=0
> +	#mnt mb_optimize_scan=1
> +	#not_mnt mb_optimize_scan=9
> +	#not_mnt mb_optimize_scan=
> +	mnt nombcache
> +	mnt no_mbcache nombcache
> +	mnt check=none removed
> +	mnt nocheck removed
> +	mnt reservation removed
> +	mnt noreservation removed
> +	mnt journal=20 ignored
> +	not_mnt nonsenseoption
> +	not_mnt nonsenseoption=value
> +
> +	# generic mount options
> +	mnt lazytime
> +	mnt nolazytime ^lazytime
> +	mnt noatime
> +	mnt nodiratime
> +	mnt noexec
> +	mnt nosuid
> +	mnt ro
> +
> +	# generic remount check
> +	remount barrier nobarrier
> +	remount nobarrier barrier
> +	remount discard nodiscard
> +	remount nodiscard discard
> +
> +	# dax mount options
> +	simple_mount -o dax=always $SCRATCH_DEV $SCRATCH_MNT > /dev/null 2>&1
> +	if [ $? -eq 0 ]; then
> +		$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +		mnt dax
> +		mnt dax=always
> +		mnt dax=never
> +		mnt dax=inode
> +
> +		not_remount lazytime dax
> +		not_remount dax=always dax=never
> +
> +		if [[ $fstype != "ext2" ]]; then
> +			not_remount data=journal dax
> +			not_remount data=journal dax=always
> +			not_remount data=journal dax=never
> +			not_remount data=journal dax=inode
> +		fi
> +	fi
> +
> +	# Quota remount check
> +	remount grpquota usrquota
> +	remount usrquota quota
> +	remount usrquota usrjquota=q.u,jqfmt=vfsv0
> +	remount grpquota grpjquota=q.g,jqfmt=vfsv0
> +
> +	not_remount usrquota grpjquota=q.g,jqfmt=vfsv0
> +	not_remount grpquota usrjquota=q.u,jqfmt=vfsv0
> +
> +	remount quota usrjquota=q.u,jqfmt=vfsv0
> +	not_remount quota grpjquota=q.g,jqfmt=vfsv0
> +
> +	remount usrjquota=q.u,jqfmt=vfsv0 grpjquota=q.g
> +	not_remount usrjquota=q.u,jqfmt=vfsv0 usrjquota=q.ua
> +	not_remount grpjquota=q.g,jqfmt=vfsv0 grpjquota=q.ga
> +
> +	remount usrjquota=q.u,jqfmt=vfsv0 usrquota usrjquota=q.u,jqfmt=vfsv0
> +	remount grpjquota=q.g,jqfmt=vfsv0 grpquota grpjquota=q.g,jqfmt=vfsv0
> +	not_remount usrjquota=q.u,jqfmt=vfsv0 grpquota
> +	not_remount grpjquota=q.g,jqfmt=vfsv0 usrquota
> +
> +	remount grpjquota=q.g,jqfmt=vfsv0 grpjquota= ^grpjquota=
> +	remount usrjquota=q.u,jqfmt=vfsv0 usrjquota= ^usrjquota=
> +	remount grpjquota=q.g,usrjquota=q.u,jqfmt=vfsv0 grpjquota=,usrjquota= ^grpjquota=,^usrjquota=
> +
> +	remount jqfmt=vfsv0 grpjquota=q.g
> +	remount jqfmt=vfsv0 usrjquota=q.u
> +
> +	if [[ $fstype != "ext2" ]]; then
> +		remount noload data=journal norecovery
> +		not_remount data=ordered data=journal
> +		not_remount data=journal data=writeback
> +		not_remount data=writeback data=ordered
> +	fi
> +
> +	do_mkfs -O journal_dev $LOOP_LOGDEV ${LOGSIZE}k
> +	do_mkfs -J device=$LOOP_LOGDEV $SCRATCH_DEV ${SIZE}k
> +	mnt defaults
> +	mnt journal_path=$LOOP_LOGDEV ignored
> +	mnt journal_dev=$LOGDEV_DEVNUM ignored
> +	not_mnt journal_path=${LOOP_LOGDEV}_nonexistent ignored
> +	not_mnt journal_dev=123456 ignored
> +	not_mnt journal_dev=999999999999999 ignored
> +
> +	do_mkfs -E quotatype=prjquota $SCRATCH_DEV ${SIZE}k
> +	mnt prjquota
> +
> +	# test clearing/changing journalled quota when enabled
> +	echo "== Testing active journalled quota" >> $seqres.full
> +	_mnt prjquota,grpjquota=aquota.group,usrjquota=aquota.user,jqfmt=vfsv0
> +
> +	# Prepare and enable quota
> +	quotacheck -vugm $SCRATCH_MNT >> $seqres.full 2>&1
> +	quotaon -vug $SCRATCH_MNT >> $seqres.full 2>&1
> +
> +	_not_remount -r grpjquota=
> +	_not_remount -r usrjquota=aaquota.user
> +	_not_remount -r grpjquota=aaquota.group
> +	_not_remount -r jqfmt=vfsv1
> +	_not_remount -r noquota
> +	_mnt remount,usrquota,grpquota ^usrquota,^grpquota
> +	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> +
> +	# test clearing/changing quota when enabled
> +	do_mkfs -E quotatype=^prjquota $SCRATCH_DEV ${SIZE}k
> +	not_mnt prjquota
> +	echo "== Testing active non-journalled quota" >> $seqres.full
> +	_mnt grpquota,usrquota
> +
> +	# Prepare and enable quota
> +	quotacheck -vugm $SCRATCH_MNT >> $seqres.full 2>&1
> +	quotaon -vug $SCRATCH_MNT >> $seqres.full 2>&1
> +
> +	_not_remount -r noquota
> +	_not_remount -r usrjquota=aquota.user
> +	_not_remount -r grpjquota=aquota.group
> +	_not_remount -r jqfmt=vfsv1
> +	_mnt remount,grpjquota= grpquota,^grpjquota
> +	_mnt remount,usrjquota= usrquota,^usrjquota
> +	_mnt remount,usrquota,grpquota usrquota,grpquota
> +	quotaoff -f $SCRATCH_MNT >> $seqres.full 2>&1
> +	_mnt remount,noquota ^usrquota,^grpquota,quota
> +	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> +
> +	# Quota feature
> +	echo "== Testing quota feature " >> $seqres.full
> +	do_mkfs -O quota -E quotatype=prjquota $SCRATCH_DEV ${SIZE}k
> +	mnt usrjquota=aquota.user,jqfmt=vfsv0 ^usrjquota=
> +	mnt grpjquota=aquota.user,jqfmt=vfsv0 ^grpjquota=
> +	mnt jqfmt=vfsv1 ^jqfmt=
> +	mnt prjquota
> +	mnt usrquota
> +	mnt grpquota
> +	not_remount defaults usrjquota=aquota.user
> +	not_remount defaults grpjquota=aquota.user
> +	not_remount defaults jqfmt=vfsv1
> +	remount defaults grpjquota=,usrjquota= ignored
> +
> +done #for fstype in ext2 ext3 ext4; do
> +
> +$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> +echo "$ERR errors encountered" >> $seqres.full
> +
> +status=$ERR
> +exit
> diff --git a/tests/ext4/053.out b/tests/ext4/053.out
> new file mode 100644
> index 00000000..d58db7e4
> --- /dev/null
> +++ b/tests/ext4/053.out
> @@ -0,0 +1,2 @@
> +QA output created by 053
> +Silence is golden.
> -- 
> 2.31.1
