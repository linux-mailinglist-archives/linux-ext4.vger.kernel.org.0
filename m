Return-Path: <linux-ext4+bounces-9830-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF1AB45E31
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 18:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7E9188F105
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 16:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0382F7AC3;
	Fri,  5 Sep 2025 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JZm/eol/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5E220330;
	Fri,  5 Sep 2025 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089890; cv=none; b=kqIxOO3WuRbmWrEdghg3cPxFcbevIKtkt6q1YOXnjLJFKgJkrmUKnnxiuMI/FG1vECN4TlZSlfo/wuMxogvClvsNOklmT1M8BvVyuto5B4atbtWKEIj9Xjncf2TpApe5yT47yHrm9/4I//Ff23I1/PJRqDKL6IeYafQmTpU+y/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089890; c=relaxed/simple;
	bh=aiBB7X+SXY1vXe49wd3dO4fkY8oXbd0uzthqQidjsiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltUzSU4CuOg6r7iuZOWV2ZB/XOx1YXYGIF4TBMKSP2eTVgyBSKojeo1t0TUYPRAK711RbCFD4bS+LfX55ijHabZkcb95/xCmqY6epwd0fSCFwOmOmABttKqbEPps5oPGCLkeWNQGQHXa0vxe4FGiErmT5JnmDKdroK92rXOJP5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JZm/eol/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5859Vcih005211;
	Fri, 5 Sep 2025 16:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tZ1MfzohTsfsyZnG1Zpl25uQCKPMyV
	BNoUzdJ6jzWSM=; b=JZm/eol/yvAVeagNZ3XcAj5BKrj1ohnwcP2/1ddWg6t14p
	pDvHUf9rgqfFz1Nspz/q3y9hcdhQZjTXs+xAZZbaBZwHti4fMY35mbKnF3gkObJ2
	2bGsVU0akHgvHe1xPrglTzefGeW1kr3Ksyxc2ab8WjpAbnIJsRHWIFZhHHECkPKg
	wwajADq1v/YDDRA67Snmx6G9bRlpX1JJhrbUyIr6Fp7aPyIDdaygLzU3XUDGE+ju
	0cuRGdLBWS47nUmGhJ7MEGw6BrjnEZfrpE86TcvMUxpEiu2XsUA722qLgyxixusV
	3VWo/feApygB9eFpJHHM3oEh0ZdAiWiFjfSB4qkg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usv3hscm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 16:31:10 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585GTFh4007733;
	Fri, 5 Sep 2025 16:31:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usv3hscf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 16:31:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 585CoCAR021420;
	Fri, 5 Sep 2025 16:31:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vcmq2b26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 16:31:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585GV1Mp52560218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 16:31:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 941A620043;
	Fri,  5 Sep 2025 16:31:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A21B20040;
	Fri,  5 Sep 2025 16:30:59 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.220.13])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Sep 2025 16:30:59 +0000 (GMT)
Date: Fri, 5 Sep 2025 22:00:57 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 07/12] generic: Add atomic write multi-fsblock
 O_[D]SYNC tests
Message-ID: <aLsQQQlq_j3ziajp@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <55583acdfb6cb69bcea84a56cbc20754e1d2f4f4.1755849134.git.ojaswin@linux.ibm.com>
 <842675da-1927-47a6-a612-4cc9eb8db8c0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <842675da-1927-47a6-a612-4cc9eb8db8c0@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nrA6EOHSVwRKQLO_f6tRkYMVsrMde-Ol
X-Authority-Analysis: v=2.4 cv=FPMbx/os c=1 sm=1 tr=0 ts=68bb104e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=wfWv8_vxBo6EGRxEekAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: xMXBNXBY3hcKnwvne_pAXmmyEbhlbBhU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX4oYNVxI3v2v0
 orw0qevzDO76x92usHV1oFSsBXz3fEghqOyVYZ3ZyPidBRMsURGkmzR9IdIDTBGnGDyD9Yj25Rv
 yA/NXTiTvd04/Rn+ATTxWUfkmxDWp3PVkX6XoWqLNYuoBZGB7/HdjCzWyttssV+m1WGUBQuR9Pr
 gls4SYqyKgBJQ/5nmbYOw4JE2zajXhw/DS2Dbk3oCanGTF6JZWHR7VpKrEg2rm7SLm7rK9dNg0s
 9AG3wTzZp+a4qnZvgkT0gJ/GwumpW+88pHyLqQlKqvwm1Z3eS0hJp938SdMEpk6EvIMeeur1Eur
 jYf8EfwOgcTFOGw+Pc6shVjwKmEdBQKdcnAUZdYcbwBBGyDrXtMO212DtmSZtF94kZ1Tsu/jfOJ
 NKadbuYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300034

On Tue, Sep 02, 2025 at 04:14:45PM +0100, John Garry wrote:
> On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> > This adds various atomic write multi-fsblock stresst tests
> 
> stress
> 
> > with mixed mappings and O_SYNC, to ensure the data and metadata
> > is atomically persisted even if there is a shutdown.
> > 
> > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Regardless of any comments made (which are minor):
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> 
> > ---
> >   tests/generic/1228     | 137 +++++++++++++++++++++++++++++++++++++++++
> >   tests/generic/1228.out |   2 +
> >   2 files changed, 139 insertions(+)
> >   create mode 100755 tests/generic/1228
> >   create mode 100644 tests/generic/1228.out
> > 
> > diff --git a/tests/generic/1228 b/tests/generic/1228
> > new file mode 100755
> > index 00000000..888599ce
> > --- /dev/null
> > +++ b/tests/generic/1228
> > @@ -0,0 +1,137 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> > +#
> > +# FS QA Test 1228
> > +#
> > +# Atomic write multi-fsblock data integrity tests with mixed mappings
> > +# and O_SYNC
> > +#
> > +. ./common/preamble
> > +. ./common/atomicwrites
> > +_begin_fstest auto quick rw atomicwrites
> > +
> > +_require_scratch_write_atomic_multi_fsblock
> > +_require_atomic_write_test_commands
> > +_require_scratch_shutdown
> > +_require_xfs_io_command "truncate"
> > +
> > +_scratch_mkfs >> $seqres.full
> > +_scratch_mount >> $seqres.full
> > +
> > +check_data_integrity() {
> > +	actual=$(_hexdump $testfile)
> > +	if [[ "$expected" != "$actual" ]]
> > +	then
> > +		echo "Integrity check failed"
> > +		echo "Integrity check failed" >> $seqres.full
> > +		echo "# Expected file contents:" >> $seqres.full
> > +		echo "$expected" >> $seqres.full
> > +		echo "# Actual file contents:" >> $seqres.full
> > +		echo "$actual" >> $seqres.full
> > +
> > +		_fail "Data integrity check failed. The atomic write was torn."
> > +	fi
> > +}
> > +
> > +prep_mixed_mapping() {
> > +	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
> > +	local off=0
> > +	local mapping=""
> > +
> > +	local operations=("W" "H" "U")
> > +	local num_blocks=$((awu_max / blksz))
> > +	for ((i=0; i<num_blocks; i++)); do
> > +		local index=$((RANDOM % ${#operations[@]}))
> > +		local map="${operations[$index]}"
> > +		local mapping="${mapping}${map}"
> > +
> > +		case "$map" in
> > +			"W")
> > +				$XFS_IO_PROG -dc "pwrite -S 0x61 -b $blksz $off $blksz" $testfile > /dev/null
> > +				;;
> > +			"H")
> > +				# No operation needed for hole
> > +				;;
> > +			"U")
> > +				$XFS_IO_PROG -c "falloc $off $blksz" $testfile >> /dev/null
> > +				;;
> > +		esac
> > +		off=$((off + blksz))
> > +	done
> > +
> > +	echo "+ + Mixed mapping prep done. Full mapping pattern: $mapping" >> $seqres.full
> > +
> > +	sync $testfile
> > +}
> > +
> > +verify_atomic_write() {
> > +	test $bytes_written -eq $awu_max || _fail "atomic write len=$awu_max assertion failed"
> > +	check_data_integrity
> > +}
> > +
> > +mixed_mapping_test() {
> > +	prep_mixed_mapping
> > +
> > +	echo -"+ + Performing O_DSYNC atomic write from 0 to $awu_max" >> $seqres.full
> > +	if [[ "$1" == "shutdown" ]]
> > +	then
> > +		bytes_written=$($XFS_IO_PROG -x -dc \
> > +				"pwrite -DA -V1 -b $awu_max 0 $awu_max" \
> > +				-c "shutdown" $testfile | grep wrote | \
> > +				awk -F'[/ ]' '{print $2}')
> > +		_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed"
> > +	else
> > +		bytes_written=$($XFS_IO_PROG -dc \
> > +				"pwrite -DA -V1 -b $awu_max 0 $awu_max" $testfile | \
> > +				grep wrote | awk -F'[/ ]' '{print $2}')
> > +	fi
> > +
> > +	verify_atomic_write
> > +}
> > +
> > +testfile=$SCRATCH_MNT/testfile
> > +touch $testfile
> > +
> > +awu_max=$(_get_atomic_write_unit_max $testfile)
> > +blksz=$(_get_block_size $SCRATCH_MNT)
> > +
> > +# Create an expected pattern to compare with
> > +$XFS_IO_PROG -tc "pwrite -b $awu_max 0 $awu_max" $testfile >> $seqres.full
> > +expected=$(_hexdump $testfile)
> > +echo "# Expected file contents:" >> $seqres.full
> > +echo "$expected" >> $seqres.full
> > +echo >> $seqres.full
> > +
> > +echo "# Test 1: Do O_DSYNC atomic write on random mixed mapping:" >> $seqres.full
> > +echo >> $seqres.full
> > +for ((iteration=1; iteration<=10; iteration++)); do
> > +	echo "=== Mixed Mapping Test Iteration $iteration ===" >> $seqres.full
> > +
> > +	echo "+ Testing without shutdown..." >> $seqres.full
> > +	mixed_mapping_test
> > +	echo "Passed!" >> $seqres.full
> > +
> > +	echo "+ Testing with sudden shutdown..." >> $seqres.full
> > +	mixed_mapping_test "shutdown"
> > +	echo "Passed!" >> $seqres.full
> > +
> > +	echo "Iteration $iteration completed: OK" >> $seqres.full
> > +	echo >> $seqres.full
> > +done
> > +echo "# Test 1: Do O_SYNC atomic write on random mixed mapping (10 iterations): OK" >> $seqres.full
> 
> big nit: you should keep the loop count in a global variable

I believe you mean something like:

  echo " ... ($iters iteration): OK" 

If so, sure I agree. I'll make the changes.

Thanks for the review!

Regards,
ojaswin
> 
> 
> > +
> > +
> > +echo >> $seqres.full
> > +echo "# Test 2: Do extending O_SYNC atomic writes: " >> $seqres.full
> > +bytes_written=$($XFS_IO_PROG -x -dstc "pwrite -A -V1 -b $awu_max 0 $awu_max" \
> > +		-c "shutdown" $testfile | grep wrote | awk -F'[/ ]' '{print $2}')
> > +_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed"
> > +verify_atomic_write
> > +echo "# Test 2: Do extending O_SYNC atomic writes: OK" >> $seqres.full
> > +
> > +# success, all done
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > +
> > diff --git a/tests/generic/1228.out b/tests/generic/1228.out
> > new file mode 100644
> > index 00000000..1baffa91
> > --- /dev/null
> > +++ b/tests/generic/1228.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 1228
> > +Silence is golden
> 

