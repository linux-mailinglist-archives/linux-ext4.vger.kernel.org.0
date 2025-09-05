Return-Path: <linux-ext4+bounces-9833-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3BCB45F8F
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 19:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8DA1CC60E2
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 17:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A22306B1B;
	Fri,  5 Sep 2025 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pqvBlZNE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5B306B17;
	Fri,  5 Sep 2025 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092002; cv=none; b=hZNFxFWghaKI0bpx3atVvd/P4oG9O1+jd9Za7sbeuGvE2cNPFSPHIkXf26XNsHkO5Dq4413WImsX1WOnWEZ0nIW35RgEhdoS+xBHbUf4RQUkAfUJVfs3W571i6YUuf/IMl5EI74Q9iGw+Uj/TbQLu7LApOYirhvcZzyVRM3MzC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092002; c=relaxed/simple;
	bh=G59bKSS6Bh1zINFsiAQK95HdT0/V/u+a9T032LTcJR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tbbq5ag2qCDh2FI2wet1/1r/If52L/2vS9HpafveqmXnoy1niHk3gplsR1liLTw18zjVj6Z7dlhFHRFslehyxJSM7ypgyuA8yqC1WNBps2bo/N7B5j6dK67HeFYrYaRk6+vpAVxnEzdj+JMeILEaBfDJtdtbuA3px+8ifDx/ixQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pqvBlZNE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585GaVsO016689;
	Fri, 5 Sep 2025 17:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=yv8Y1o4M3vcDqQw8k3BxmLrzNHVmev
	XsbJCpJZb0DmM=; b=pqvBlZNEyEc6OlnbIz0yItm59pBb+oqN/NTKxF/iGPRAau
	XD/qOqTuSeRD+HJacb3YR9P5g7uWumND5kaSKq45z++lMD/8FLDLVQFPmGsCoJs/
	pJFeqJTg2p16dFX+ucUr+rlw1SVtYupvA4doPIyjQryAJLBtPpRYBPdl7JdqW0wX
	WiS7aU87BLw448IyweURqNkp5ndHwcFUXQJB1X8exwVn3KWT4tioBtQGjB4mdg1L
	/el6l8Zlzx4aMNmqJ3I/wfhb7gbldzUxfsg/RcKzSEuiImkbjujGA/C/8TEdCr7Q
	HdClP/QPld3VcrxZ8zx9kLZP8I6gsH80DH/Pcb7w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usvg8y8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 17:06:32 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585H6Ve7029021;
	Fri, 5 Sep 2025 17:06:31 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usvg8y8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 17:06:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 585F5Vpp019963;
	Fri, 5 Sep 2025 17:06:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vbmujqm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 17:06:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585H6SO248955802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 17:06:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4C2320040;
	Fri,  5 Sep 2025 17:06:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A70A2004B;
	Fri,  5 Sep 2025 17:06:26 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.220.13])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Sep 2025 17:06:26 +0000 (GMT)
Date: Fri, 5 Sep 2025 22:36:23 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 09/12] generic: Add sudden shutdown tests for multi
 block atomic writes
Message-ID: <aLsYj1tqEbH5RpAu@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <2b523de842ada3ac7759cedae80485ae201d7e5d.1755849134.git.ojaswin@linux.ibm.com>
 <12281f45-c42f-4d1e-bcff-f14be46483a8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12281f45-c42f-4d1e-bcff-f14be46483a8@oracle.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=behrUPPB c=1 sm=1 tr=0 ts=68bb1898 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=iv51Vn7Z7ULWsfQBPioA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: af16dfBImCfcYdzFmE_crGHOdzd8F-K9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX6s4XJDL/C+Ki
 jyzeB0aXQBnSii32yIRNOtmJvhkd37DXphOfUin3agL4grvjn4xvbK5OZfqZmjxNgGMAR6yZ2F9
 RFAkc+q7Mys+xw4n2hhyxCs7+DT9Hh4DFmT5Y6qdADgqlBDTRX1OKcxRaVU7CohIINbksnl0exD
 t/p0IcIrXF5q5cCMYjuHXK21RltcA57Y7XVNbtgJvD9iL3MovyOrF99L3cYXa/z6bdWdacDLbp7
 C5Z0nN147/XYo435rxvk/m2ueZWEuI/fvwG8UfjvRQONzZ2rM9x+Nq1KpiC0mSxxHSy+FPVcWvU
 s+D84OkpfLjh9nAwQ399eRbkIMzLaekRzsrbMQ8NpWTQISIaBwjB53gCuAZtAuGE/hRm6AsvTkl
 RcZGjJeE
X-Proofpoint-GUID: m6WbNHsb2IBPn8Dbqq7LX7m-gMhry4yn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

On Tue, Sep 02, 2025 at 04:49:26PM +0100, John Garry wrote:
> On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> > This test is intended to ensure that multi blocks atomic writes
> > maintain atomic guarantees across sudden FS shutdowns.
> > 
> > The way we work is that we lay out a file with random mix of written,
> > unwritten and hole extents. Then we start performing atomic writes
> > sequentially on the file while we parallely shutdown the FS. Then we
> > note the last offset where the atomic write happened just before shut
> > down and then make sure blocks around it either have completely old
> > data or completely new data, ie the write was not torn during shutdown.
> > 
> > We repeat the same with completely written, completely unwritten and completely
> > empty file to ensure these cases are not torn either.  Finally, we have a
> > similar test for append atomic writes
> > 
> > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Please check comments, below, thanks!
> 
> > ---
> >   tests/generic/1230     | 397 +++++++++++++++++++++++++++++++++++++++++
> >   tests/generic/1230.out |   2 +
> >   2 files changed, 399 insertions(+)
> >   create mode 100755 tests/generic/1230
> >   create mode 100644 tests/generic/1230.out
> > 
> > diff --git a/tests/generic/1230 b/tests/generic/1230
> > new file mode 100755
> > index 00000000..cff5adc0
> > --- /dev/null
> > +++ b/tests/generic/1230
> > @@ -0,0 +1,397 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> > +#
> > +# FS QA Test No. 1230
> > +#
> > +# Test multi block atomic writes with sudden FS shutdowns to ensure
> > +# the FS is not tearing the write operation
> > +. ./common/preamble
> > +. ./common/atomicwrites
> > +_begin_fstest auto atomicwrites
> > +
> > +_require_scratch_write_atomic_multi_fsblock
> > +_require_atomic_write_test_commands
> > +_require_scratch_shutdown
> > +_require_xfs_io_command "truncate"
> 
> is a similar fallocate test needed?

Hey John, we run the test for the following cases:

- file has mixed mapping
- file has only hole (trucate case)
- file has only unwritten blocks (falloc case)
- file has only written blocks 

So we already do that. It's just that we don't need the
_require_xfs_io_command "falloc" since it is already included in
_require_atomic_write_test_commnads.

> 
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1
> > +_scratch_mount >> $seqres.full
> > +
> > +testfile=$SCRATCH_MNT/testfile
> > +touch $testfile
> > +
> > +awu_max=$(_get_atomic_write_unit_max $testfile)
> > +blksz=$(_get_block_size $SCRATCH_MNT)
> > +echo "Awu max: $awu_max" >> $seqres.full
> > +
> > +num_blocks=$((awu_max / blksz))
> > +# keep initial value high for dry run. This will be
> > +# tweaked in dry_run() based on device write speed.
> > +filesize=$(( 10 * 1024 * 1024 * 1024 ))
> 
> could this cause some out-of-space issue? That's 10GB, right?

Hey John, yes this is just a dummy value. We tune the filesize later
based on how fast the device is. That will usually be around 3 * (bytes
written in 0.2s) (check dry_run function). 

Generally this will be a smaller size. ( 3GB on a 5GB/s SSD.) But yes
I should probably add a _notrun if our ssd fast enough to fill up the
full FS in 0.2s.

> 
> > +
> > +_cleanup() {
> > +	[ -n "$awloop_pid" ] && kill $awloop_pid &> /dev/null
> > +	wait
> > +}
> > +
> > +atomic_write_loop() {
> > +	local off=0
> > +	local size=$awu_max
> > +	for ((i=0; i<$((filesize / $size )); i++)); do
> > +		# Due to sudden shutdown this can produce errors so just
> > +		# redirect them to seqres.full
> > +		$XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $size $off $size" >> /dev/null 2>>$seqres.full
> > +		echo "Written to offset: $off" >> $tmp.aw
> > +		off=$((off + $size))
> > +	done
> > +}
> > +
> > +# This test has the following flow:
> > +# 1. Start doing sequential atomic writes in bg, upto $filesize
> 
> bg?

background*. I'll change it.
> 
> > +# 2. Sleep for 0.2s and shutdown the FS
> > +# 3. kill the atomic write process
> > +# 4. verify the writes were not torn
> > +#
> > +# We ideally want the shutdown to happen while an atomic write is ongoing
> > +# but this gets tricky since faster devices can actually finish the whole
> > +# atomic write loop before sleep 0.2s completes, resulting in the shutdown
> > +# happening after the write loop which is not what we want. A simple solution
> > +# to this is to increase $filesize so step 1 takes long enough but a big
> > +# $filesize leads to create_mixed_mappings() taking very long, which is not
> > +# ideal.
> > +#
> > +# Hence, use the dry_run function to figure out the rough device speed and set
> > +# $filesize accordingly.
> > +dry_run() {
> > +	echo >> $seqres.full
> > +	echo "# Estimating ideal filesize..." >> $seqres.full
> > +	atomic_write_loop &
> > +	awloop_pid=$!
> > +
> > +	local i=0
> > +	# Wait for atleast first write to be recorded or 10s
> > +	while [ ! -f "$tmp.aw" -a $i -le 50 ]; do i=$((i + 1)); sleep 0.2; done
> > +
> > +	if [[ $i -gt 50 ]]
> > +	then
> > +		_fail "atomic write process took too long to start"
> > +	fi
> > +
> > +	echo >> $seqres.full
> > +	echo "# Shutting down filesystem while write is running" >> $seqres.full
> > +	_scratch_shutdown
> > +
> > +	kill $awloop_pid 2>/dev/null  # the process might have finished already
> > +	wait $awloop_pid
> > +	unset $awloop_pid
> > +
> > +	bytes_written=$(tail -n 1 $tmp.aw | cut -d" " -f4)
> > +	echo "# Bytes written in 0.2s: $bytes_written" >> $seqres.full
> > +
> > +	filesize=$((bytes_written * 3))
> > +	echo "# Setting \$filesize=$filesize" >> $seqres.full
> > +
> > +	rm $tmp.aw
> > +	sleep 0.5
> > +
> > +	_scratch_cycle_mount
> > +
> > +}
> > +
> > +create_mixed_mappings() {
> 
> Is this same as patch 08/12?

I believe you mean the [D]SYNC tests, yes it is the same.

> 
> > +	local file=$1
> > +	local size_bytes=$2
> > +
> > +	echo "# Filling file $file with alternate mappings till size $size_bytes" >> $seqres.full
> > +	#Fill the file with alternate written and unwritten blocks
> > +	local off=0
> > +	local operations=("W" "U")
> > +
> > +	for ((i=0; i<$((size_bytes / blksz )); i++)); do
> > +		index=$(($i % ${#operations[@]}))
> > +		map="${operations[$index]}"
> > +
> > +		case "$map" in
> > +		    "W")
> > +			$XFS_IO_PROG -fc "pwrite -b $blksz $off $blksz" $file  >> /dev/null
> 
> does this just write random data? I don't see any pattern being set.

By default pwrite writes 0xcd if no patterns is specified. This helps us
reliably check the data back.

> 
> > +			;;
> > +		    "U")
> > +			$XFS_IO_PROG -fc "falloc $off $blksz" $file >> /dev/null
> > +			;;
> > +		esac
> > +		off=$((off + blksz))
> > +	done
> > +
> > +	sync $file
> > +}
> > +
> > +populate_expected_data() {
> > +	# create a dummy file with expected old data for different cases
> > +	create_mixed_mappings $testfile.exp_old_mixed $awu_max
> > +	expected_data_old_mixed=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_old_mixed)
> > +
> > +	$XFS_IO_PROG -fc "falloc 0 $awu_max" $testfile.exp_old_zeroes >> $seqres.full
> > +	expected_data_old_zeroes=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_old_zeroes)
> > +
> > +	$XFS_IO_PROG -fc "pwrite -b $awu_max 0 $awu_max" $testfile.exp_old_mapped >> $seqres.full
> > +	expected_data_old_mapped=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_old_mapped)
> > +
> > +	# create a dummy file with expected new data
> > +	$XFS_IO_PROG -fc "pwrite -S 0x61 -b $awu_max 0 $awu_max" $testfile.exp_new >> $seqres.full
> > +	expected_data_new=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_new)
> > +}
> > +
> > +verify_data_blocks() {
> > +	local verify_start=$1
> > +	local verify_end=$2
> > +	local expected_data_old="$3"
> > +	local expected_data_new="$4"
> > +
> > +	echo >> $seqres.full
> > +	echo "# Checking data integrity from $verify_start to $verify_end" >> $seqres.full
> > +
> > +	# After an atomic write, for every chunk we ensure that the underlying
> > +	# data is either the old data or new data as writes shouldn't get torn.
> > +	local off=$verify_start
> > +	while [[ "$off" -lt "$verify_end" ]]
> > +	do
> > +		#actual_data=$(xxd -s $off -l $awu_max -p $testfile)
> > +		actual_data=$(od -An -t x1 -j $off -N $awu_max $testfile)
> > +		if [[ "$actual_data" != "$expected_data_new" ]] && [[ "$actual_data" != "$expected_data_old" ]]
> > +		then
> > +			echo "Checksum match failed at off: $off size: $awu_max"
> > +			echo "Expected contents: (Either of the 2 below):"
> > +			echo
> > +			echo "Expected old: "
> > +			echo "$expected_data_old"
> 
> 
> it would be nice if this was deterministic - see comment in
> create_mixed_mappings

Yes, it is. It will be 0xcdcdcdcd
> 
> > +			echo
> > +			echo "Expected new: "
> > +			echo "$expected_data_new"
> 
> nit: I am not sure what is meant by "expected". I would just have "new
> data". We don't know what to expect, as it could be old or new, right?

Yes, so the I was thinking of it this way:

We either expect the data to be the full new (named expected_new) or
fully old (named expected_old). Else renaming it to new vs old vs actual
makese it a bit more confusing imo

> 
> > +			echo
> > +			echo "Actual contents: "
> > +			echo "$actual_data"
> > +
> > +			_fail
> > +		fi
> > +		echo -n "Check at offset $off suceeded! " >> $seqres.full
> > +		if [[ "$actual_data" == "$expected_data_new" ]]
> > +		then
> > +			echo "matched new" >> $seqres.full
> > +		elif [[ "$actual_data" == "$expected_data_old" ]]
> > +		then
> > +			echo "matched old" >> $seqres.full
> > +		fi
> > +		off=$(( off + awu_max ))
> > +	done
> > +}
> > +
> > +# test data integrity for file by shutting down in between atomic writes
> > +test_data_integrity() {
> > +	echo >> $seqres.full
> > +	echo "# Writing atomically to file in background" >> $seqres.full
> > +	atomic_write_loop &
> > +	awloop_pid=$!
> > +
> 
> from here ...
> 
> > +	local i=0
> > +	# Wait for atleast first write to be recorded or 10s
> > +	while [ ! -f "$tmp.aw" -a $i -le 50 ]; do i=$((i + 1)); sleep 0.2; done
> > +
> > +	if [[ $i -gt 50 ]]
> > +	then
> > +		_fail "atomic write process took too long to start"
> > +	fi
> > +
> > +	echo >> $seqres.full
> > +	echo "# Shutting down filesystem while write is running" >> $seqres.full
> > +	_scratch_shutdown
> > +
> > +	kill $awloop_pid 2>/dev/null  # the process might have finished already
> > +	wait $awloop_pid
> > +	unset $awloop_pid
> 
> ... to here looks similar in many functions. Can we factor it out?

Right thats true, I'll factor this out. Thanks for pointing it out.
> 
> > +
> > +	last_offset=$(tail -n 1 $tmp.aw | cut -d" " -f4)
> > +	if [[ -z $last_offset ]]
> > +	then
> > +		last_offset=0
> > +	fi
> > +
> > +	echo >> $seqres.full
> > +	echo "# Last offset of atomic write: $last_offset" >> $seqres.full
> > +
> > +	rm $tmp.aw
> > +	sleep 0.5
> > +
> > +	_scratch_cycle_mount
> > +
> > +	# we want to verify all blocks around which the shutdown happended
> > +	verify_start=$(( last_offset - (awu_max * 5)))
> > +	if [[ $verify_start < 0 ]]
> > +	then
> > +		verify_start=0
> > +	fi
> > +
> > +	verify_end=$(( last_offset + (awu_max * 5)))
> > +	if [[ "$verify_end" -gt "$filesize" ]]
> > +	then
> > +		verify_end=$filesize
> > +	fi
> > +}
> > +
> > +# test data integrity for file wiht written and unwritten mappings
> 
> with
> 
> > +test_data_integrity_mixed() {
> > +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> > +
> > +	echo >> $seqres.full
> > +	echo "# Creating testfile with mixed mappings" >> $seqres.full
> > +	create_mixed_mappings $testfile $filesize
> > +
> > +	test_data_integrity
> > +
> > +	verify_data_blocks $verify_start $verify_end "$expected_data_old_mixed" "$expected_data_new"
> > +}
> > +
> > +# test data integrity for file with completely written mappings
> > +test_data_integrity_writ() {
> 
> please spell "writ" out fully, which I think should be "written"

Yes, will do.

> 
> > +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> > +
> > +	echo >> $seqres.full
> > +	echo "# Creating testfile with fully written mapping" >> $seqres.full
> > +	$XFS_IO_PROG -c "pwrite -b $filesize 0 $filesize" $testfile >> $seqres.full
> > +	sync $testfile
> > +
> > +	test_data_integrity
> > +
> > +	verify_data_blocks $verify_start $verify_end "$expected_data_old_mapped" "$expected_data_new"
> > +}
> > +
> > +# test data integrity for file with completely unwritten mappings
> > +test_data_integrity_unwrit() {
> 
> same as above
> 
> > +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> > +
> > +	echo >> $seqres.full
> > +	echo "# Creating testfile with fully unwritten mappings" >> $seqres.full
> > +	$XFS_IO_PROG -c "falloc 0 $filesize" $testfile >> $seqres.full
> > +	sync $testfile
> > +
> > +	test_data_integrity
> > +
> > +	verify_data_blocks $verify_start $verify_end "$expected_data_old_zeroes" "$expected_data_new"
> > +}
> > +
> > +# test data integrity for file with no mappings
> > +test_data_integrity_hole() {
> > +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> > +
> > +	echo >> $seqres.full
> > +	echo "# Creating testfile with no mappings" >> $seqres.full
> > +	$XFS_IO_PROG -c "truncate $filesize" $testfile >> $seqres.full
> > +	sync $testfile
> > +
> > +	test_data_integrity
> > +
> > +	verify_data_blocks $verify_start $verify_end "$expected_data_old_zeroes" "$expected_data_new"
> > +}
> > +
> > +test_filesize_integrity() {
> > +	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
> > +
> > +	echo >> $seqres.full
> > +	echo "# Performing extending atomic writes over file in background" >> $seqres.full
> > +	atomic_write_loop &
> > +	awloop_pid=$!
> > +
> > +	local i=0
> > +	# Wait for atleast first write to be recorded or 10s
> > +	while [ ! -f "$tmp.aw" -a $i -le 50 ]; do i=$((i + 1)); sleep 0.2; done
> > +
> > +	if [[ $i -gt 50 ]]
> > +	then
> > +		_fail "atomic write process took too long to start"
> > +	fi
> > +
> > +	echo >> $seqres.full
> > +	echo "# Shutting down filesystem while write is running" >> $seqres.full
> > +	_scratch_shutdown
> > +
> > +	kill $awloop_pid 2>/dev/null  # the process might have finished already
> > +	wait $awloop_pid
> > +	unset $awloop_pid
> > +
> > +	local last_offset=$(tail -n 1 $tmp.aw | cut -d" " -f4)
> > +	if [[ -z $last_offset ]]
> > +	then
> > +		last_offset=0
> > +	fi
> > +
> > +	echo >> $seqres.full
> > +	echo "# Last offset of atomic write: $last_offset" >> $seqres.full
> > +	rm $tmp.aw
> > +	sleep 0.5
> > +
> > +	_scratch_cycle_mount
> > +	local filesize=$(_get_filesize $testfile)
> > +	echo >> $seqres.full
> > +	echo "# Filesize after shutdown: $filesize" >> $seqres.full
> > +
> > +	# To confirm that the write went atomically, we check:
> > +	# 1. The last block should be a multiple of awu_max
> > +	# 2. The last block should be the completely new data
> > +
> > +	if (( $filesize % $awu_max ))
> > +	then
> > +		echo "Filesize after shutdown ($filesize) not a multiple of atomic write unit ($awu_max)"
> > +	fi
> > +
> > +	verify_start=$(( filesize - (awu_max * 5)))
> > +	if [[ $verify_start < 0 ]]
> > +	then
> > +		verify_start=0
> > +	fi
> > +
> > +	local verify_end=$filesize
> > +
> > +	# Here the blocks should always match new data hence, for simplicity of
> > +	# code, just corrupt the $expected_data_old buffer so it never matches
> > +	local expected_data_old="POISON"
> > +	verify_data_blocks $verify_start $verify_end "$expected_data_old" "$expected_data_new"
> > +}
> > +
> > +$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> > +
> > +dry_run
> > +
> > +echo >> $seqres.full
> > +echo "# Populating expected data buffers" >> $seqres.full
> > +populate_expected_data
> > +
> > +# Loop 20 times to shake out any races due to shutdown
> > +for ((iter=0; iter<20; iter++))
> > +do
> > +	echo >> $seqres.full
> > +	echo "------ Iteration $iter ------" >> $seqres.full
> > +
> > +	echo >> $seqres.full
> > +	echo "# Starting data integrity test for atomic writes over mixed mapping" >> $seqres.full
> > +	test_data_integrity_mixed
> > +
> > +	echo >> $seqres.full
> > +	echo "# Starting data integrity test for atomic writes over fully written mapping" >> $seqres.full
> > +	test_data_integrity_writ
> > +
> > +	echo >> $seqres.full
> > +	echo "# Starting data integrity test for atomic writes over fully unwritten mapping" >> $seqres.full
> > +	test_data_integrity_unwrit
> > +
> > +	echo >> $seqres.full
> > +	echo "# Starting data integrity test for atomic writes over holes" >> $seqres.full
> > +	test_data_integrity_hole
> > +
> > +	echo >> $seqres.full
> > +	echo "# Starting filesize integrity test for atomic writes" >> $seqres.full
> 
> what does "Starting filesize integrity test" mean?

Basically other tests already truncate the file to a higher value and
then perform the shut down test. Here we actually do append atomic
writes since we want to also stress the i_size update paths during
shutdown to ensure that doesn't cause any tearing with atomic writes.

I can maybe rename it to:


echo "# Starting data integrity test for atomic append writes" >> $seqres.full

Thanks for the review!

Regards,
ojaswin

> 
> > +	test_filesize_integrity
> > +done
> > +
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > diff --git a/tests/generic/1230.out b/tests/generic/1230.out
> > new file mode 100644
> > index 00000000..d01f54ea
> > --- /dev/null
> > +++ b/tests/generic/1230.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 1230
> > +Silence is golden
> 

