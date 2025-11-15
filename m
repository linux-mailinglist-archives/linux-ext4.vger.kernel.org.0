Return-Path: <linux-ext4+bounces-11867-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD982C5FE6D
	for <lists+linux-ext4@lfdr.de>; Sat, 15 Nov 2025 03:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51E4434F3F8
	for <lists+linux-ext4@lfdr.de>; Sat, 15 Nov 2025 02:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D6D1946DF;
	Sat, 15 Nov 2025 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmEGMy/s"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CEE2A1C7;
	Sat, 15 Nov 2025 02:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763173971; cv=none; b=tOIZlMJPpxjsfziLqBvV1WO3SszYbavpTK6ubQjS1RxvxXECKKSfFouWkUgo7SCAaPpwRHTCiKQenm8VgWtq43ETBSGm5LjmYWFZXsh10T2toM0sCXtLeC/deNTm4tgpzvV52lok+mUE7DvelerxaNJJaBfPcULaackSwg/XXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763173971; c=relaxed/simple;
	bh=otAQ7a26ss8k30fOohTALHF2V8L26CcuE722HUM3was=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+Ziv0e8FSRxvcObRjnWrjc26nRyahAZ7Pp63IlGJcmGy0pJkAU6odsMSxmPNW1/qCI2Jcvfx2tDn6MLWd0tetJtlYALzHgtQw82eLpy81v3xZGIc0MyRugVsmW4Se+gJiNq4BGMcK2g5bHOrc7LHJ0hwNLv376Ev9gyRPN6kcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmEGMy/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D99FC19425;
	Sat, 15 Nov 2025 02:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763173971;
	bh=otAQ7a26ss8k30fOohTALHF2V8L26CcuE722HUM3was=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PmEGMy/sxVncRM8QqEX+igsmaAuU2T9zFlUybAXHkolC1xVpLbpzAfJunQMyUgoGw
	 yusIrLyeSSRgmCXKqgEd9Ubydp6Rn9xX1GkM/hGswXXoHwH70FWsDaFhURca4XdQi9
	 LtuH1YrQ3cI0eKDTQbVQcLaZZ435xHAJcA9fAQMLAUSBK450TbIGEwTiJu44Ob0rAY
	 CQBEkQpJTBCzrugncmChMBi6I6PMzyU3FBR6OYS1Rm7igSRcE4pBmVcGXEwGCGUTti
	 roaKKibvbkFEFVgr0gNAcNt3HYv5C8EDlD/ZCkh5NRC/xTw8BcQ5IgHpV5cs8lLV+Y
	 1FTRVqoxqrZuw==
Date: Fri, 14 Nov 2025 18:32:51 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/7] generic/778: fix severe performance problems
Message-ID: <20251115023251.GI196366@frogsfrogsfrogs>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
 <176279909041.605950.16815410156483574567.stgit@frogsfrogsfrogs>
 <aRXGyR9kj0kPirIE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRXGyR9kj0kPirIE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Thu, Nov 13, 2025 at 05:23:45PM +0530, Ojaswin Mujoo wrote:
> On Mon, Nov 10, 2025 at 10:26:32AM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > This test takes 4800s to run, which is horrible.  AFAICT it starts out
> > by timing how much can be written atomically to a new file in 0.2
> > seconds, then scales up the file size by 3x.  On not very fast storage,
> 
> Hi Darrick,
> 
> So 250MB in 0.2s is like 1.2GBps which seems pretty fast. Did you mean
> "On fast storage ..." ?

No, I have even faster storage. ;)

> > this can result in file_size being set to ~250MB on a 4k fsblock
> > filesystem.  That's about 64,000 blocks.
> > 
> > The next thing this test does is try to create a file of that size
> > (250MB) of alternating written and unwritten blocks.  For some reason,
> > it sets up this file by invoking xfs_io 64,000 times to write small
> > amounts of data, which takes 3+ minutes on the author's system because
> > exec overhead is pretty high when you do that.
> 
> > 
> > As a result, one loop through the test takes almost 4 minutes.  The test
> > loops 20 times, so it runs for 80 minutes(!!) which is a really long
> > time.
> > 
> > So the first thing we do is observe that the giant slow loop is being
> > run as a single thread on an empty filesystem.  Most of the time the
> > allocator generates a mostly physically contiguous file.  We could
> > fallocate the whole file instead of fallocating one block every other
> > time through the loop.  This halves the setup time.
> > 
> > Next, we can also stuff the remaining pwrite commands into a bash array
> > and only invoke xfs_io once every 128x through the loop.  This amortizes
> > the xfs_io startup time, which reduces the test loop runtime to about 20
> > seconds.
> 
> Oh right, this is very bad. Weirdly I never noticed the test taking such
> a huge time while testing on scsi_debug and also on an enterprise SSD.

It doesn't help that xfs supports much larger awu_max than (say) ext4.

> Thanks for fixing this up though, I will start using maybe dm-delay
> while stressing the tests in the future to avoid such issues.

fork() is a bit expensive.

> > 
> > Finally, replace the 20x loop with a _soak_loop_running 5x loop because
> > 5 seems like enough.  Anyone who wants more can set TIME_FACTOR or
> > SOAK_DURATION to get more intensive testing.  On my system this cuts the
> > runtime to 75 seconds.
> 
> So about the loops, we were running a modified version of this test,
> which used non atomic writes, to confirm if we are able to catch torn
> writes this way. We noticed that it sometimes took 10+ loops to observe
> the torn write. Hence we kept iters=20. Since catching a torn write is
> critical for working of atomic writes, I think it might make sense to
> leave it at 20. If we feel this is a very high value, we can perhaps
> remove -g auto and keep -g stress -g atomicwrites so only people who
> explicitly want to stress atomic writes will run it.

In that case we ought to limit the awu_max that we feed to the test
because otherwise it starts running a lot of IO.

--D

> > 
> > Cc: <fstests@vger.kernel.org> # v2025.10.20
> > Fixes: ca954527ff9d97 ("generic: Add sudden shutdown tests for multi block atomic writes")
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  tests/generic/778 |   59 ++++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 40 insertions(+), 19 deletions(-)
> > 
> > 
> > diff --git a/tests/generic/778 b/tests/generic/778
> > index 8cb1d8d4cad45d..7cfabc3a47a521 100755
> > --- a/tests/generic/778
> > +++ b/tests/generic/778
> > @@ -42,22 +42,28 @@ atomic_write_loop() {
> >  		# Due to sudden shutdown this can produce errors so just
> >  		# redirect them to seqres.full
> >  		$XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $size $off $size" >> /dev/null 2>>$seqres.full
> > -		echo "Written to offset: $off" >> $tmp.aw
> > -		off=$((off + $size))
> > +		echo "Written to offset: $((off + size))" >> $tmp.aw
> > +		off=$((off + size))
> >  	done
> >  }
> >  
> >  start_atomic_write_and_shutdown() {
> >  	atomic_write_loop &
> >  	awloop_pid=$!
> > +	local max_loops=100
> >  
> >  	local i=0
> > -	# Wait for at least first write to be recorded or 10s
> > -	while [ ! -f "$tmp.aw" -a $i -le 50 ]; do i=$((i + 1)); sleep 0.2; done
> > +	# Wait for at least first write to be recorded or too much time passes
> > +	while [ ! -f "$tmp.aw" -a $i -le $max_loops ]; do
> > +		i=$((i + 1))
> > +		sleep 0.2
> > +	done
> >  
> > -	if [[ $i -gt 50 ]]
> > +	cat $tmp.aw >> $seqres.full
> > +
> > +	if [[ $i -gt $max_loops ]]
> >  	then
> > -		_fail "atomic write process took too long to start"
> > +		_notrun "atomic write process took too long to start"
> >  	fi
> >  
> >  	echo >> $seqres.full
> > @@ -113,21 +119,34 @@ create_mixed_mappings() {
> >  	local off=0
> >  	local operations=("W" "U")
> >  
> > +	test $size_bytes -eq 0 && return
> > +
> > +	# fallocate the whole file once because preallocating single blocks
> > +	# with individual xfs_io invocations is really slow and the allocator
> > +	# usually gives out consecutive blocks anyway
> > +	$XFS_IO_PROG -f -c "falloc 0 $size_bytes" $file
> > +
> > +	local cmds=()
> >  	for ((i=0; i<$((size_bytes / blksz )); i++)); do
> > -		index=$(($i % ${#operations[@]}))
> > -		map="${operations[$index]}"
> > +		if (( i % 2 == 0 )); then
> > +			cmds+=(-c "pwrite -b $blksz $off $blksz")
> > +		fi
> > +
> > +		# batch the write commands into larger xfs_io invocations to
> > +		# amortize the fork overhead
> > +		if [ "${#cmds[@]}" -ge 128 ]; then
> > +			$XFS_IO_PROG "${cmds[@]}" "$file" >> /dev/null
> > +			cmds=()
> > +		fi
> >  
> > -		case "$map" in
> > -		    "W")
> > -			$XFS_IO_PROG -fc "pwrite -b $blksz $off $blksz" $file  >> /dev/null
> > -			;;
> > -		    "U")
> > -			$XFS_IO_PROG -fc "falloc $off $blksz" $file >> /dev/null
> > -			;;
> > -		esac
> >  		off=$((off + blksz))
> >  	done
> >  
> > +	if [ "${#cmds[@]}" -gt 0 ]; then
> > +		$XFS_IO_PROG "${cmds[@]}" "$file" >> /dev/null
> > +		cmds=()
> > +	fi
> > +
> >  	sync $file
> >  }
> >  
> > @@ -336,9 +355,9 @@ echo >> $seqres.full
> >  echo "# Populating expected data buffers" >> $seqres.full
> >  populate_expected_data
> >  
> > -# Loop 20 times to shake out any races due to shutdown
> > -for ((iter=0; iter<20; iter++))
> > -do
> > +# Loop to shake out any races due to shutdown
> > +iter=0
> > +while _soak_loop_running $TIME_FACTOR; do
> >  	echo >> $seqres.full
> >  	echo "------ Iteration $iter ------" >> $seqres.full
> >  
> > @@ -361,6 +380,8 @@ do
> >  	echo >> $seqres.full
> >  	echo "# Starting shutdown torn write test for append atomic writes" >> $seqres.full
> >  	test_append_torn_write
> > +
> > +	iter=$((iter + 1))
> >  done
> >  
> >  echo "Silence is golden"
> > 
> 

