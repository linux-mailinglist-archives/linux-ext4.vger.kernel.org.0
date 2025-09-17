Return-Path: <linux-ext4+bounces-10230-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0337B7EB5C
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 14:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120E21C043BA
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 08:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0AE305E09;
	Wed, 17 Sep 2025 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sS5tGHy1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532724A07C;
	Wed, 17 Sep 2025 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096560; cv=none; b=YO7PPby8pCKnoKb+xuC+8wacd60LxSR94OcOpJmHylAwvHoNciqlv6bADcg5jAkmcwF9Lg6Z3X4LnHL8OOGPDHNbgxVNYoxkecAquB6t1JnoizZITZ+d3UyKtXR+Q0jnhEsiDKviyI5RY0OvXiLYOUhPBkQqyHU8EGVH6Gx03Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096560; c=relaxed/simple;
	bh=Vcy+jDHJHhRD/rmN9QS8IF0pLTLMLCOB8UldY2HzK+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2iAtxFbJt4ItroVKDH9LHvqjR9zzud/CDiPIS4OleW2l/J5d0m6fxFqQILeIv5ElnvfXw+hv75y2UWGwQnXU9uSjHjg6aQ7cXwtSXOy4RkhKs9Jwwxkc25ei7tk6HVN4uLhPzXCIYQ9LpxYG6UT8gaDZfICGG1BQ7rm+8KJf4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sS5tGHy1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLlrCb031198;
	Wed, 17 Sep 2025 08:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2efUd1CwyJUOEJO7ssZYdyFc1hpdDc
	xzzUUYGc0jzLI=; b=sS5tGHy13aHJizpHNKOGKcDkA0+PfpIgCk3z8c1vPTM/e2
	xkdAs8iTpwDpsRdVj0TyQ+d/D8HI48UFE4tLEDlZkU+P62hq3VH6+QymO8TYqnzZ
	73SSHdsvtwVh666qvbY0ZuMBhQgHPycO3U0HWuklR8SMlRF0WbCYG6g0ISiOIQYf
	wNuGO3IoG9R3OgQkjKeC4HTSfUofsXhJ29nRYkMwPL4es3MyjCowo8mZv+zhQJMn
	oE9MTb8rJLJ9dlwXB9U0pftrZaGAzegn2rEGtpJErVc2eBi9WEcmSJSzc5bQQiAB
	JhHjVWvVrDgRSslIl+UBSIyPEjOWO2LBgqb44+NA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hj9q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 08:09:10 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58H89AA9028860;
	Wed, 17 Sep 2025 08:09:10 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hj9q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 08:09:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58H83CRf009486;
	Wed, 17 Sep 2025 08:09:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn3fve0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 08:09:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58H897ch30999012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 08:09:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89D2F20043;
	Wed, 17 Sep 2025 08:09:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2271C20040;
	Wed, 17 Sep 2025 08:09:04 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.21.137])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 17 Sep 2025 08:09:03 +0000 (GMT)
Date: Wed, 17 Sep 2025 13:39:01 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 09/12] generic: Add sudden shutdown tests for multi
 block atomic writes
Message-ID: <aMpsnQEYagLvPOw2@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1757610403.git.ojaswin@linux.ibm.com>
 <25f77aa7ac816e48b5921601e3cf10445db1f36b.1757610403.git.ojaswin@linux.ibm.com>
 <58214139-2e42-4480-a7c3-443dd931fd09@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58214139-2e42-4480-a7c3-443dd931fd09@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9SnjrHcDzl0a84f8J8vTLMttKoGDatuL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXyag6cUd+MZoE
 pncqklP0NnCXuf5/Cxe5aVDz/mYNnnwX0EJGWNSun2/xPP3KraxIuyxxmk0Dhn6Lgcxx9Q1xcbI
 u/zVcCBposR7YaD7QTz+yyhtgeZweO2LTW1GQdsTgV9DQ9WeoILMM2+xFZVSnwxAaudX8s4pXWR
 Iy4gJMTb7YtrL8nNqtvym8ukz6j6n6+gw15+86KnPSrc6SIY9nTYGHQDajgext/tWTlBS8N2/Qv
 TAQ/B1OhX9rmKoLEvGguJ2zRrS67j4+5tpWo6MFTALOCqijDYkievGeX5hNJXHbcL+wOk78td1s
 ldiOjCwBVGm3RhEg/qKCsO9zXw660ZF72ZCUutcLgP3lb6k3gtBhciTqsrGziUsMUk45qQ8FfEP
 bXcqh0aU
X-Proofpoint-GUID: Ld_7u26JiXeUqa0kieLXRmx9cTYe33uQ
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68ca6ca6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=rD5qyBoocmPsG8PDIDIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204

On Mon, Sep 15, 2025 at 02:26:46PM +0100, John Garry wrote:
> On 11/09/2025 18:13, Ojaswin Mujoo wrote:
> > This test is intended to ensure that multi blocks atomic writes
> > maintain atomic guarantees across sudden FS shutdowns.
> > 
> > The way we work is that we lay out a file with random mix of written,
> > unwritten and hole extents. Then we start performing atomic writes
> > sequentially on the file while we parallelly shutdown the FS. Then we
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
> I still have some nits, which are close to being the same as last time. I
> don't want this series to be held up any longer over my nitpicking, so:
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> 
> > ---
> >   tests/generic/1230     | 368 +++++++++++++++++++++++++++++++++++++++++
> >   tests/generic/1230.out |   2 +
> >   2 files changed, 370 insertions(+)
> >   create mode 100755 tests/generic/1230
> >   create mode 100644 tests/generic/1230.out
> > 
> > diff --git a/tests/generic/1230 b/tests/generic/1230
> > new file mode 100755
> > index 00000000..28c2c4f5
> > --- /dev/null
> > +++ b/tests/generic/1230
> > @@ -0,0 +1,368 @@
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
> > +start_atomic_write_and_shutdown() {
> > +	atomic_write_loop &
> > +	awloop_pid=$!
> > +
> > +	local i=0
> > +	# Wait for atleast first write to be recorded or 10s
> 
> at least
> 
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
> > +}
> 
> ...
> 
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
> 
> nit: I think that I mentioned this the last time - I would not use the word
> "expected". We have old data, new data, and actual data. The only thing
> which we expect is that actual data will be either all old or all new.
 
Hey John so I mentioned here [1] that the wording "expected new",
"expected old", "actual" looked more clear to me than "new", "old" and
"actual" and you replied with sure so I though we were good there :)

But no worries I can make this change. I'll keep the wording as 
new, old and actual.

> 
> > +			echo "$expected_data_old"
> > +			echo
> > +			echo "Expected new: "
> > +			echo "$expected_data_new"
> > +			echo
> > +			echo "Actual contents: "
> > +			echo "$actual_data"
> > +
> > +			_fail
> > +		fi
> > +		echo -n "Check at offset $off succeeded! " >> $seqres.full
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
> > +
> > +	start_atomic_write_and_shutdown
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
> > +	# we want to verify all blocks around which the shutdown happened
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
> > +# test data integrity for file with written and unwritten mappings
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
> > +test_data_integrity_written() {
> 
> nit: again, I am not so keen on using the word "integrity" at all.
> "integrity" in storage world relates to T10 PI support in Linux. I know that
> last time I mentioned it's ok to use "integrity" when close to words "atomic
> write", but I still fear some doubt on whether we are talking about T10 PI
> when we mention integrity.

Okay got it, fine then how about using phrases like "test for torn
data for file with completely written mapping" and such?

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
> > +test_data_integrity_unwritten() {
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

