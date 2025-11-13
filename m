Return-Path: <linux-ext4+bounces-11857-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCDDC57468
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 12:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE09A4E497D
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 11:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7660234AB09;
	Thu, 13 Nov 2025 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TP9cLZdT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C0026299;
	Thu, 13 Nov 2025 11:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034839; cv=none; b=SgPSQ/IOjZZoIVEzqaA6jd9U+BioHCweaZcp7AjqczBmpR6NL4qcG8mwfSY5mbaXKFzu3MGvND7RQYpPk8f1Gj5UR9xxQh6SVr6SrihAbCanwQAoyG3kzVy0RrEXHACiS6JUiWb4dPMZYv3WZ30NgtbdkZ/nTZ5EXrOrQb79V8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034839; c=relaxed/simple;
	bh=64WDtD7uXeYzCDfjeZNPSZiHZwvWHYaGDQd5jdLa70w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aqt4n0d79ZO3Ok8m0Ab4cDfgtpbE9Gp9pLdiVwKw45AH7uesSAoiBznPFy3+tobzygpFHeye6fjwh5hRQP/DLaZHErDGxZKXibp6l0rSAB/QudI6phIUSoFP/mdFH9ey3kNGMCpFmkduEBTcHoVNnmqssDzWD53UB4upwBZ4gBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TP9cLZdT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD2rq9F028450;
	Thu, 13 Nov 2025 11:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=GKI/8jI/p2dAN7lUnIbnNie9FLKP+K
	RiZr/olLktSbA=; b=TP9cLZdTplkS0vkmg2yqQIpT7hBAlFRMMKrqnB4+1NTzz+
	TqSUyUHT3rFt08o5BcrbuNK1iwn3YmtH0RfprXS2s3yX4SB3SleqNG5yCzZC7hrc
	O2Ke9HoeGsyTgeIgVMlKO/GbtAYml2g1RK14piKe2nk/lGKPX/YLgdhqkKHRpoLN
	u9onWWZq+gMDpxl/rv0q4IFXxRrt79EIj8h7C1aPqiJdjggRkm2G1ORWVo7hu+uJ
	lR9f6OBO5G8m6PbgkWLMnvc1S4bdfTrIgk7IT3ZFLIiizgfTE4J1DGq2klrzUxG7
	ZZFs8BkNA2ezbuF9r46hVp3lwlVR0NUv1VqhJMLw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cjej6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 11:53:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD90tOo011428;
	Thu, 13 Nov 2025 11:53:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1n98v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 11:53:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADBroXe40108428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 11:53:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CCEE20043;
	Thu, 13 Nov 2025 11:53:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A459620040;
	Thu, 13 Nov 2025 11:53:48 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.50])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 13 Nov 2025 11:53:48 +0000 (GMT)
Date: Thu, 13 Nov 2025 17:23:45 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/7] generic/778: fix severe performance problems
Message-ID: <aRXGyR9kj0kPirIE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
 <176279909041.605950.16815410156483574567.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176279909041.605950.16815410156483574567.stgit@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=6915c6d1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=fKXWO0R7MBri_iPdQioA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfX9f37TQIX4u8A
 TYb1UhvH77jSBske1HzVQtuaIaJjlsdvEwmYHHcULxKtogWix9yhGfrfsw/7H6mWEQKx8iaTLZ0
 GXi4yB9dvBMCLt3XfXJ0uyNykWifvVHT7Klm6I0Y7CzHkWisKMvHBK+KrokpgV+5vYs4SVgPJ+e
 2hON+eW60CDkVK1Z7qGc6D4Qa4Z8VTxl4wPh1QcUEzo0uDtHNhQ7PfN2qlxExjreq5hSTLypt+R
 LwWhJfPGMVr52taid3UDB4bogQ/UqLRLguHA9BJw00mNp55C6dbOb9BycHGOLfoo0vY0YXWneNF
 PmB/16QGEHMmJ5CyiP23z3aB7N8Y3/11AqdK6yM1/3h2O2/dXrvzYYLsydX7Vs9/MZ7nQjeQezC
 0eTp4vOmrtv9ENN73660PC04odYIFw==
X-Proofpoint-GUID: Syuo0ufitwU2CH6vDYWXyeddI1BABOmG
X-Proofpoint-ORIG-GUID: Syuo0ufitwU2CH6vDYWXyeddI1BABOmG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095

On Mon, Nov 10, 2025 at 10:26:32AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This test takes 4800s to run, which is horrible.  AFAICT it starts out
> by timing how much can be written atomically to a new file in 0.2
> seconds, then scales up the file size by 3x.  On not very fast storage,

Hi Darrick,

So 250MB in 0.2s is like 1.2GBps which seems pretty fast. Did you mean
"On fast storage ..." ?

> this can result in file_size being set to ~250MB on a 4k fsblock
> filesystem.  That's about 64,000 blocks.
> 
> The next thing this test does is try to create a file of that size
> (250MB) of alternating written and unwritten blocks.  For some reason,
> it sets up this file by invoking xfs_io 64,000 times to write small
> amounts of data, which takes 3+ minutes on the author's system because
> exec overhead is pretty high when you do that.

> 
> As a result, one loop through the test takes almost 4 minutes.  The test
> loops 20 times, so it runs for 80 minutes(!!) which is a really long
> time.
> 
> So the first thing we do is observe that the giant slow loop is being
> run as a single thread on an empty filesystem.  Most of the time the
> allocator generates a mostly physically contiguous file.  We could
> fallocate the whole file instead of fallocating one block every other
> time through the loop.  This halves the setup time.
> 
> Next, we can also stuff the remaining pwrite commands into a bash array
> and only invoke xfs_io once every 128x through the loop.  This amortizes
> the xfs_io startup time, which reduces the test loop runtime to about 20
> seconds.

Oh right, this is very bad. Weirdly I never noticed the test taking such
a huge time while testing on scsi_debug and also on an enterprise SSD.

Thanks for fixing this up though, I will start using maybe dm-delay
while stressing the tests in the future to avoid such issues.

> 
> Finally, replace the 20x loop with a _soak_loop_running 5x loop because
> 5 seems like enough.  Anyone who wants more can set TIME_FACTOR or
> SOAK_DURATION to get more intensive testing.  On my system this cuts the
> runtime to 75 seconds.

So about the loops, we were running a modified version of this test,
which used non atomic writes, to confirm if we are able to catch torn
writes this way. We noticed that it sometimes took 10+ loops to observe
the torn write. Hence we kept iters=20. Since catching a torn write is
critical for working of atomic writes, I think it might make sense to
leave it at 20. If we feel this is a very high value, we can perhaps
remove -g auto and keep -g stress -g atomicwrites so only people who
explicitly want to stress atomic writes will run it.

> 
> Cc: <fstests@vger.kernel.org> # v2025.10.20
> Fixes: ca954527ff9d97 ("generic: Add sudden shutdown tests for multi block atomic writes")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/778 |   59 ++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 40 insertions(+), 19 deletions(-)
> 
> 
> diff --git a/tests/generic/778 b/tests/generic/778
> index 8cb1d8d4cad45d..7cfabc3a47a521 100755
> --- a/tests/generic/778
> +++ b/tests/generic/778
> @@ -42,22 +42,28 @@ atomic_write_loop() {
>  		# Due to sudden shutdown this can produce errors so just
>  		# redirect them to seqres.full
>  		$XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $size $off $size" >> /dev/null 2>>$seqres.full
> -		echo "Written to offset: $off" >> $tmp.aw
> -		off=$((off + $size))
> +		echo "Written to offset: $((off + size))" >> $tmp.aw
> +		off=$((off + size))
>  	done
>  }
>  
>  start_atomic_write_and_shutdown() {
>  	atomic_write_loop &
>  	awloop_pid=$!
> +	local max_loops=100
>  
>  	local i=0
> -	# Wait for at least first write to be recorded or 10s
> -	while [ ! -f "$tmp.aw" -a $i -le 50 ]; do i=$((i + 1)); sleep 0.2; done
> +	# Wait for at least first write to be recorded or too much time passes
> +	while [ ! -f "$tmp.aw" -a $i -le $max_loops ]; do
> +		i=$((i + 1))
> +		sleep 0.2
> +	done
>  
> -	if [[ $i -gt 50 ]]
> +	cat $tmp.aw >> $seqres.full
> +
> +	if [[ $i -gt $max_loops ]]
>  	then
> -		_fail "atomic write process took too long to start"
> +		_notrun "atomic write process took too long to start"
>  	fi
>  
>  	echo >> $seqres.full
> @@ -113,21 +119,34 @@ create_mixed_mappings() {
>  	local off=0
>  	local operations=("W" "U")
>  
> +	test $size_bytes -eq 0 && return
> +
> +	# fallocate the whole file once because preallocating single blocks
> +	# with individual xfs_io invocations is really slow and the allocator
> +	# usually gives out consecutive blocks anyway
> +	$XFS_IO_PROG -f -c "falloc 0 $size_bytes" $file
> +
> +	local cmds=()
>  	for ((i=0; i<$((size_bytes / blksz )); i++)); do
> -		index=$(($i % ${#operations[@]}))
> -		map="${operations[$index]}"
> +		if (( i % 2 == 0 )); then
> +			cmds+=(-c "pwrite -b $blksz $off $blksz")
> +		fi
> +
> +		# batch the write commands into larger xfs_io invocations to
> +		# amortize the fork overhead
> +		if [ "${#cmds[@]}" -ge 128 ]; then
> +			$XFS_IO_PROG "${cmds[@]}" "$file" >> /dev/null
> +			cmds=()
> +		fi
>  
> -		case "$map" in
> -		    "W")
> -			$XFS_IO_PROG -fc "pwrite -b $blksz $off $blksz" $file  >> /dev/null
> -			;;
> -		    "U")
> -			$XFS_IO_PROG -fc "falloc $off $blksz" $file >> /dev/null
> -			;;
> -		esac
>  		off=$((off + blksz))
>  	done
>  
> +	if [ "${#cmds[@]}" -gt 0 ]; then
> +		$XFS_IO_PROG "${cmds[@]}" "$file" >> /dev/null
> +		cmds=()
> +	fi
> +
>  	sync $file
>  }
>  
> @@ -336,9 +355,9 @@ echo >> $seqres.full
>  echo "# Populating expected data buffers" >> $seqres.full
>  populate_expected_data
>  
> -# Loop 20 times to shake out any races due to shutdown
> -for ((iter=0; iter<20; iter++))
> -do
> +# Loop to shake out any races due to shutdown
> +iter=0
> +while _soak_loop_running $TIME_FACTOR; do
>  	echo >> $seqres.full
>  	echo "------ Iteration $iter ------" >> $seqres.full
>  
> @@ -361,6 +380,8 @@ do
>  	echo >> $seqres.full
>  	echo "# Starting shutdown torn write test for append atomic writes" >> $seqres.full
>  	test_append_torn_write
> +
> +	iter=$((iter + 1))
>  done
>  
>  echo "Silence is golden"
> 

