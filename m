Return-Path: <linux-ext4+bounces-12135-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88761C9DE9A
	for <lists+linux-ext4@lfdr.de>; Wed, 03 Dec 2025 07:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9113A6797
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Dec 2025 06:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD942765C0;
	Wed,  3 Dec 2025 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S79A6TFa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F43720E005;
	Wed,  3 Dec 2025 06:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764742804; cv=none; b=WrZ/8WKpqvH/vWtssQaqxUUoq4gRMZ+zLHa6eAKWiMsxvuxJMOgZNOYCOmWUdiEsupuW/YqLdlaRx2B6DxKS0wG5LUZ7XKOsQbSJlFt1Yn/lnDCIFiwp1C0OBQTx+0t7cn5cRORxBNkvzFg3jIiQvm91s7PKKks6d6EIYdgu5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764742804; c=relaxed/simple;
	bh=UHES+eCxPDoC566kamBpDtiGhlzCmIaxRBKmuvlMdhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXUTJvn1zw5WcIW3nUNR47BQJGRoF/n5l6b/vmSupYg4KznCKTnlffIaRxamcnHoO+XdCB/GAI00xjphOQgmC04Zr9XEWeGf+Q3K6n7zbedo6xqEaBm4GPPkS8fdzfnlPXG8PlU3ljm/9txT3N8UVQgGVIWe2jsmt1FdXhheRsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S79A6TFa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2H7X4g010434;
	Wed, 3 Dec 2025 06:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=JSGO/UO85pvytGenDpXp+xf+3Rz1Ud
	OVByPz+VIjHzU=; b=S79A6TFa3LYjhSzIpD0c0o9/MXyaik/mLOJB/6oGTYyuqE
	z+dV/Xt/SRkXv7DP0s+Jz06sSykv0LnwBmX8fVavdScv0LINNKgvjaYuiVSU7nye
	SQO4rXIP1C9UjKFmG0e6WwLvIC42gGSBf4dgo6u62inIjIrviM4BWtaz7j73Gq1R
	Qs1pGb5fNuxbeD//UrO+rYgCeTJag8Dq9hwrTfi7Ka0p56b8FEsoSFHo0sWpDl2/
	AB3/qrPpoqthR1Rb5giFNQxhjljeCXoedbJAipizOo5hHszflrhXPYR/DlD7hFjj
	B0iA//sT3svWawl7TjWcO9ohd48e29dW7LBX0ABg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh713u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 06:19:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B32GPo4021691;
	Wed, 3 Dec 2025 06:19:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4at8c69rjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 06:19:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B36JqVo15204644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Dec 2025 06:19:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E58E2004E;
	Wed,  3 Dec 2025 06:19:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BCA520040;
	Wed,  3 Dec 2025 06:19:51 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.16.38])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  3 Dec 2025 06:19:50 +0000 (GMT)
Date: Wed, 3 Dec 2025 11:49:48 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/7] generic/778: fix severe performance problems
Message-ID: <aS_WhMSGtfeYN5Tu@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
 <176279909041.605950.16815410156483574567.stgit@frogsfrogsfrogs>
 <aRXGyR9kj0kPirIE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251115023251.GI196366@frogsfrogsfrogs>
 <aSq0OzvJHT1yOdvF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251201231908.GB89492@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201231908.GB89492@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dK+rWeZb c=1 sm=1 tr=0 ts=692fd68b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=ivRTEe9fpwv9iBYWq2IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: u-pl9LWuNFiG93KyQlAGBNZTjVTylDy7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX+lK0pQgueqmL
 eAsQJd/axCf8rCuwgoD4M81p9JZ8Spis6BCzBP3PH58N0N4ayo2UZ049gVFxPRH67ns9VwVjbJ/
 Nt9wMwe2KhSWnhI3kSDqqo7zq4+WZpR//u0n3uEERZ9xhH6B+sC5Dubd8Yku/L6RvVoMe0mQXst
 FL0mhHV8sCki2cREP0nIv1JrL8XcNJAPyOli7S9x1yNL6/D7xE7c1R2wMvuy6v9FErGZKEhzq7t
 Tl8wNSN19VfU8GNLyuzHZkoMsuj0b+PthbQ2osafx65ELoM8C1Klw/Iz2O/9u6d186AA39ibqcZ
 9UYIi9nrcEGWTGawALzrwVYm6KWfhMnv6B/2mSArba7fVSyNtCDFE9ROT7BxmuCUG5xs82nXD17
 T4hZFQ2gHCkcbQ1o+8SmE8ntpt3gaw==
X-Proofpoint-ORIG-GUID: u-pl9LWuNFiG93KyQlAGBNZTjVTylDy7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

On Mon, Dec 01, 2025 at 03:19:08PM -0800, Darrick J. Wong wrote:
> On Sat, Nov 29, 2025 at 02:22:11PM +0530, Ojaswin Mujoo wrote:
> > On Fri, Nov 14, 2025 at 06:32:51PM -0800, Darrick J. Wong wrote:
> > > On Thu, Nov 13, 2025 at 05:23:45PM +0530, Ojaswin Mujoo wrote:
> > > > On Mon, Nov 10, 2025 at 10:26:32AM -0800, Darrick J. Wong wrote:
> > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > > 
> > > > > This test takes 4800s to run, which is horrible.  AFAICT it starts out
> > > > > by timing how much can be written atomically to a new file in 0.2
> > > > > seconds, then scales up the file size by 3x.  On not very fast storage,
> > > > 
> > > > Hi Darrick,
> > 
> > (Sorry I missed this email somehow)
> > 
> > > > 
> > > > So 250MB in 0.2s is like 1.2GBps which seems pretty fast. Did you mean
> > > > "On fast storage ..." ?
> > > 
> > > No, I have even faster storage. ;)
> > 
> > :O
> > 
> > So that means on an even faster storage this problem would be even more
> > visible because our file size would be >250MB
> > 
> > > 
> > > > > this can result in file_size being set to ~250MB on a 4k fsblock
> > > > > filesystem.  That's about 64,000 blocks.
> > > > > 
> > > > > The next thing this test does is try to create a file of that size
> > > > > (250MB) of alternating written and unwritten blocks.  For some reason,
> > > > > it sets up this file by invoking xfs_io 64,000 times to write small
> > > > > amounts of data, which takes 3+ minutes on the author's system because
> > > > > exec overhead is pretty high when you do that.
> > > > 
> > > > > 
> > > > > As a result, one loop through the test takes almost 4 minutes.  The test
> > > > > loops 20 times, so it runs for 80 minutes(!!) which is a really long
> > > > > time.
> > > > > 
> > > > > So the first thing we do is observe that the giant slow loop is being
> > > > > run as a single thread on an empty filesystem.  Most of the time the
> > > > > allocator generates a mostly physically contiguous file.  We could
> > > > > fallocate the whole file instead of fallocating one block every other
> > > > > time through the loop.  This halves the setup time.
> > > > > 
> > > > > Next, we can also stuff the remaining pwrite commands into a bash array
> > > > > and only invoke xfs_io once every 128x through the loop.  This amortizes
> > > > > the xfs_io startup time, which reduces the test loop runtime to about 20
> > > > > seconds.
> > > > 
> > > > Oh right, this is very bad. Weirdly I never noticed the test taking such
> > > > a huge time while testing on scsi_debug and also on an enterprise SSD.
> > > 
> > > It doesn't help that xfs supports much larger awu_max than (say) ext4.
> > 
> > I did test on xfs as well. But yea maybe my SSD is just not fast enough.
> > 
> > > 
> > > > Thanks for fixing this up though, I will start using maybe dm-delay
> > > > while stressing the tests in the future to avoid such issues.
> > > 
> > > fork() is a bit expensive.
> > > 
> > > > > 
> > > > > Finally, replace the 20x loop with a _soak_loop_running 5x loop because
> > > > > 5 seems like enough.  Anyone who wants more can set TIME_FACTOR or
> > > > > SOAK_DURATION to get more intensive testing.  On my system this cuts the
> > > > > runtime to 75 seconds.
> > > > 
> > > > So about the loops, we were running a modified version of this test,
> > > > which used non atomic writes, to confirm if we are able to catch torn
> > > > writes this way. We noticed that it sometimes took 10+ loops to observe
> > > > the torn write. Hence we kept iters=20. Since catching a torn write is
> > > > critical for working of atomic writes, I think it might make sense to
> > > > leave it at 20. If we feel this is a very high value, we can perhaps
> > > > remove -g auto and keep -g stress -g atomicwrites so only people who
> > > > explicitly want to stress atomic writes will run it.
> > > 
> > > In that case we ought to limit the awu_max that we feed to the test
> > > because otherwise it starts running a lot of IO.
> > 
> > Yes I think that makes sense. Right now we get awu_max of 4M on xfs that
> > means we always end up only testing software atomic writes.  Maybe we
> > can instead cap awu_max at 64K or something. This way, we can test both
> > hw atomic writes (when device supports it) and sw atomic writes (when it
> > doesn't)
> 
> Yeah, capping the testing block size sounds like a good idea.  What do
> you think about using min(awu_max_opt * 2, awu_max) ?

Im thinking that now that we are modifying this, maybe we can improve
coverage by also testing hardware atomic write paths. Right now the
test will mostly be testing SW fallback on XFS because we use awu_max
(usually 4M).

Maybe something like min(awu_max_opt, awu_max) gets us coverage of both
paths?

Also looking at xfs_get_atomic_write_max_opt() there is the caveat that 
awu_max_opt is returned as 0 if awu_max <= blocksize (should be rare
with software atomic writes but yeah) and ext4 always returns it as 0 so
we will need to handle that.

How about (psuedocode):

if (awu_max_opt == 0)
		/* software only, limit to 128k */
    awu_max = min(statx->awu_max, 128K)
else
    awu_max = min(statx->awu_max_opt, statx->awu_max)


Regards,
ojaswin
> 
> --D
> 
> > Regards,
> > ojaswin
> > 
> > > 
> > > --D
> > > 
> > > > > 
> > > > > Cc: <fstests@vger.kernel.org> # v2025.10.20
> > > > > Fixes: ca954527ff9d97 ("generic: Add sudden shutdown tests for multi block atomic writes")
> > > > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > > ---
> > > > >  tests/generic/778 |   59 ++++++++++++++++++++++++++++++++++++-----------------
> > > > >  1 file changed, 40 insertions(+), 19 deletions(-)
> > > > > 
> > > > > 
> > > > > diff --git a/tests/generic/778 b/tests/generic/778
> > > > > index 8cb1d8d4cad45d..7cfabc3a47a521 100755
> > > > > --- a/tests/generic/778
> > > > > +++ b/tests/generic/778
> > > > > @@ -42,22 +42,28 @@ atomic_write_loop() {
> > > > >  		# Due to sudden shutdown this can produce errors so just
> > > > >  		# redirect them to seqres.full
> > > > >  		$XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $size $off $size" >> /dev/null 2>>$seqres.full
> > > > > -		echo "Written to offset: $off" >> $tmp.aw
> > > > > -		off=$((off + $size))
> > > > > +		echo "Written to offset: $((off + size))" >> $tmp.aw
> > > > > +		off=$((off + size))
> > > > >  	done
> > > > >  }
> > > > >  
> > > > >  start_atomic_write_and_shutdown() {
> > > > >  	atomic_write_loop &
> > > > >  	awloop_pid=$!
> > > > > +	local max_loops=100
> > > > >  
> > > > >  	local i=0
> > > > > -	# Wait for at least first write to be recorded or 10s
> > > > > -	while [ ! -f "$tmp.aw" -a $i -le 50 ]; do i=$((i + 1)); sleep 0.2; done
> > > > > +	# Wait for at least first write to be recorded or too much time passes
> > > > > +	while [ ! -f "$tmp.aw" -a $i -le $max_loops ]; do
> > > > > +		i=$((i + 1))
> > > > > +		sleep 0.2
> > > > > +	done
> > > > >  
> > > > > -	if [[ $i -gt 50 ]]
> > > > > +	cat $tmp.aw >> $seqres.full
> > > > > +
> > > > > +	if [[ $i -gt $max_loops ]]
> > > > >  	then
> > > > > -		_fail "atomic write process took too long to start"
> > > > > +		_notrun "atomic write process took too long to start"
> > > > >  	fi
> > > > >  
> > > > >  	echo >> $seqres.full
> > > > > @@ -113,21 +119,34 @@ create_mixed_mappings() {
> > > > >  	local off=0
> > > > >  	local operations=("W" "U")
> > > > >  
> > > > > +	test $size_bytes -eq 0 && return
> > > > > +
> > > > > +	# fallocate the whole file once because preallocating single blocks
> > > > > +	# with individual xfs_io invocations is really slow and the allocator
> > > > > +	# usually gives out consecutive blocks anyway
> > > > > +	$XFS_IO_PROG -f -c "falloc 0 $size_bytes" $file
> > > > > +
> > > > > +	local cmds=()
> > > > >  	for ((i=0; i<$((size_bytes / blksz )); i++)); do
> > > > > -		index=$(($i % ${#operations[@]}))
> > > > > -		map="${operations[$index]}"
> > > > > +		if (( i % 2 == 0 )); then
> > > > > +			cmds+=(-c "pwrite -b $blksz $off $blksz")
> > > > > +		fi
> > > > > +
> > > > > +		# batch the write commands into larger xfs_io invocations to
> > > > > +		# amortize the fork overhead
> > > > > +		if [ "${#cmds[@]}" -ge 128 ]; then
> > > > > +			$XFS_IO_PROG "${cmds[@]}" "$file" >> /dev/null
> > > > > +			cmds=()
> > > > > +		fi
> > > > >  
> > > > > -		case "$map" in
> > > > > -		    "W")
> > > > > -			$XFS_IO_PROG -fc "pwrite -b $blksz $off $blksz" $file  >> /dev/null
> > > > > -			;;
> > > > > -		    "U")
> > > > > -			$XFS_IO_PROG -fc "falloc $off $blksz" $file >> /dev/null
> > > > > -			;;
> > > > > -		esac
> > > > >  		off=$((off + blksz))
> > > > >  	done
> > > > >  
> > > > > +	if [ "${#cmds[@]}" -gt 0 ]; then
> > > > > +		$XFS_IO_PROG "${cmds[@]}" "$file" >> /dev/null
> > > > > +		cmds=()
> > > > > +	fi
> > > > > +
> > > > >  	sync $file
> > > > >  }
> > > > >  
> > > > > @@ -336,9 +355,9 @@ echo >> $seqres.full
> > > > >  echo "# Populating expected data buffers" >> $seqres.full
> > > > >  populate_expected_data
> > > > >  
> > > > > -# Loop 20 times to shake out any races due to shutdown
> > > > > -for ((iter=0; iter<20; iter++))
> > > > > -do
> > > > > +# Loop to shake out any races due to shutdown
> > > > > +iter=0
> > > > > +while _soak_loop_running $TIME_FACTOR; do
> > > > >  	echo >> $seqres.full
> > > > >  	echo "------ Iteration $iter ------" >> $seqres.full
> > > > >  
> > > > > @@ -361,6 +380,8 @@ do
> > > > >  	echo >> $seqres.full
> > > > >  	echo "# Starting shutdown torn write test for append atomic writes" >> $seqres.full
> > > > >  	test_append_torn_write
> > > > > +
> > > > > +	iter=$((iter + 1))
> > > > >  done
> > > > >  
> > > > >  echo "Silence is golden"
> > > > > 
> > > > 

