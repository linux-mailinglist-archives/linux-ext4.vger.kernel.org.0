Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8347C2AF8C0
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Nov 2020 20:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgKKTN5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Nov 2020 14:13:57 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34862 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725949AbgKKTN4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Nov 2020 14:13:56 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0ABJDpfW010061
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 14:13:52 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 86122420107; Wed, 11 Nov 2020 14:13:51 -0500 (EST)
Date:   Wed, 11 Nov 2020 14:13:51 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Heads up: data corruption with AIO/DIO with unwritten blocks when
 blocksize < page size
Message-ID: <20201111191351.GA3489984@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I noticed that we are occasionally seeing data corruption when block
size is less than page size and we are doing AIO/DIO with unwritten
regions.  Fortunately, in practice most applications which use AIO/DIO
make sure all of the data files are pre-zeroed and initialized --- we
only noticed this because of another bug where the pre-zeroing of the
blocks after fallocate(2) got accidentally skipped.

This can be seen using the following xfstests which I've attached to
this message.  It's not a reliable failure; the test is failing 70% of
the time, and in fact most individual AIO operations don't actually
corrupt data.  When it does fail, the file system is fine, but there
are checksum failures in the data blocks.

verify: bad magic header b587, wanted acca at file /xt-vdc/test-file offset 539779072, length 4198400 (requested block: offset=539779072, length=4198400)
       hdr_fail data dumped as test-file.539779072.hdr_fail
fio: pid=4891, err=84/file:verify.c:1444, func=async_verify, error=Invalid or incomplete multibyte or wide character
crc32c: verify failed at file /xt-vdc/test-file offset 2728620032, length 4198400 (requested block: offset=2728620032, length=4198400, flags=84)
       Expected CRC: e61a5d6a
       Received CRC: e390f0ed
       received data dumped as test-file.2728620032.received
       expected data dumped as test-file.2728620032.expected
crc32c: verify failed at file /xt-vdc/test-file offset 3029954560, length 4198400 (requested block: offset=3029954560, length=4198400, flags=84)
       Expected CRC: b56632a2
       Received CRC: 427982ce
       received data dumped as test-file.3029954560.received
       expected data dumped as test-file.3029954560.expected

Sample run:

TESTRUNID: tytso-20201110144948
KERNEL:    kernel 5.10.0-rc3-xfstests-00032-g91808cd6c243 #2012 SMP Mon Nov 9 21:37:55 EST 2020
x86_64
CMDLINE:   -C 20 generic/999

ext4/4k: 20 tests, 756 seconds
ext4/1k: 20 tests, 14 failures, 808 seconds
  Failures: generic/999 generic/999 generic/999 generic/999
    generic/999 generic/999 generic/999 generic/999 generic/999
    generic/999 generic/999 generic/999 generic/999 generic/999
ext4/ext3: 20 tests, 20 skipped, 83 seconds
ext4/encrypt: 20 tests, 20 skipped, 12 seconds
ext4/nojournal: 20 tests, 756 seconds
ext4/ext3conv: 20 tests, 753 seconds
ext4/adv: 20 tests, 751 seconds
ext4/dioread_nolock: 20 tests, 755 seconds
ext4/data_journal: 20 tests, 20 skipped, 17 seconds
ext4/bigalloc: 20 tests, 1049 seconds
ext4/bigalloc_1k: 20 tests, 762 seconds
Totals: 220 tests, 60 skipped, 14 failures, 0 errors, 6502s

I haven't had a chance to look at this, but I wanted to report this to
the ext4 list.  This is actually much better than before we moved to
using IOMAP for direct I/O, when we were failing this for all
conigurations(!) which support Direct I/O.

TESTRUNID: tytso-20201111100315
KERNEL:    kernel 4.19.84-xfstests #2 SMP Fri Nov 15 13:38:45 EST 2019 x86_64
CMDLINE:   -C 5 generic/999 --kernel gs://gce-xfstests/bzImage-4.19

ext4/4k: 5 tests, 5 failures, 184 seconds
  Failures: generic/999 generic/999 generic/999 generic/999 
    generic/999 
ext4/1k: 5 tests, 5 failures, 192 seconds
  Failures: generic/999 generic/999 generic/999 generic/999 
    generic/999 
ext4/ext3: 5 tests, 5 skipped, 13 seconds
ext4/encrypt: 5 tests, 5 skipped, 4 seconds
ext4/nojournal: 5 tests, 5 failures, 184 seconds
  Failures: generic/999 generic/999 generic/999 generic/999 
    generic/999 
ext4/ext3conv: 5 tests, 5 failures, 185 seconds
  Failures: generic/999 generic/999 generic/999 generic/999 
    generic/999 
ext4/adv: 5 tests, 5 failures, 182 seconds
  Failures: generic/999 generic/999 generic/999 generic/999 
    generic/999 
ext4/dioread_nolock: 5 tests, 5 failures, 184 seconds
  Failures: generic/999 generic/999 generic/999 generic/999 
    generic/999 
ext4/data_journal: 5 tests, 5 skipped, 5 seconds
ext4/bigalloc: 5 tests, 5 failures, 254 seconds
  Failures: generic/999 generic/999 generic/999 generic/999 
    generic/999 
ext4/bigalloc_1k: 5 tests, 5 failures, 186 seconds
  Failures: generic/999 generic/999 generic/999 generic/999 
    generic/999 
Totals: 55 tests, 15 skipped, 40 failures, 0 errors, 1573s

	   	     	      	 	   - Ted

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=999

#! /bin/bash
# SPDX-License-Identifier: GPL-2.0

#
# FSQA Test No. 999
#
# AIO/DIO stress test
# Run random AIO/DIO activity on an file system with unwritten regions
#
seq=`basename $0`
seqres=$RESULT_DIR/$seq
echo "QA output created by $seq"

here=`pwd`
tmp=/tmp/$$
fio_config=$tmp.fio
status=1	# failure is the default!
trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15

# get standard environment, filters and checks
. ./common/rc
. ./common/filter

# real QA test starts here
_supported_fs generic
_supported_os Linux
_require_test
_require_scratch
_require_odirect
_require_block_device $SCRATCH_DEV

NUM_JOBS=$((4*LOAD_FACTOR))
BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
FILE_SIZE=$(((BLK_DEV_SIZE * 512) * 3 / 4))

max_file_size=$((5 * 1024 * 1024 * 1024))
if [ $max_file_size -lt $FILE_SIZE ]; then
	FILE_SIZE=$max_file_size
fi
SIZE=$((FILE_SIZE / 2))

cat >$fio_config <<EOF
###########
# $seq test fio activity
# Filenames derived from jobsname and jobid like follows:
# ${JOB_NAME}.${JOB_ID}.${ITERATION_ID}
[global]
ioengine=libaio
bs=128k
directory=${SCRATCH_MNT}
filesize=${FILE_SIZE}
size=${SIZE}
iodepth=$((128*$LOAD_FACTOR))
fallocate=native

# Perform direct aio and verify data
# This test case should check use-after-free issues
[aio-dio-verifier]
numjobs=1
verify=crc32c-intel
verify_fatal=1
verify_dump=1
verify_backlog=1024
verify_async=4
direct=1
blocksize_range=4100k-8200k
blockalign=4k
rw=randwrite
filename=test-file

EOF

rm -f $seqres.full

_require_fio $fio_config
_require_xfs_io_command "falloc"

_workout()
{
	echo ""
	echo "Run fio with random aio-dio pattern"
	echo ""
	cat $fio_config >>  $seqres.full
	run_check $FIO_PROG $fio_config
}

_scratch_mkfs >> $seqres.full 2>&1
_scratch_mount

if ! _workout; then
	_scratch_unmount 2>/dev/null
	exit
fi

if ! _scratch_unmount; then
	echo "failed to umount"
	status=1
	exit
fi
status=0
exit

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="999.out"

QA output created by 999

Run fio with random aio-dio pattern


--BOKacYhQ+x31HxR3--
