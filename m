Return-Path: <linux-ext4+bounces-12275-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AB6CB3E9E
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 21:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63C98300D332
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 20:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AFB329E54;
	Wed, 10 Dec 2025 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEJIoN15"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB4B322B97;
	Wed, 10 Dec 2025 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765397151; cv=none; b=jgrzKNFCKdMI8QHiv2hl9El/rERmIYK9001NEbAc43XAcVRdLzH5XsBgu0BFauakIkTncOGx7epD3vviT35d38stuaXVY8U+Wiw8YXEEhBEyXTJtDf4k5I4jqhCixYGOfryr2hjTqoIvGSixgdeGEASEvhQaU21e8immbWgWyL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765397151; c=relaxed/simple;
	bh=lv3NbKgBTkAl4Qv4ffmY0I7beJoLO2jboYBY/LfTyOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1Vf2udU2OVdRJa3cn5SgMYytvB09zjff45GUHxgC5p5KNh40CED3ip6EHfREXfjHmtdKS4Lt1tbr1TPHKS1GYD+9mhrM1XaPLJl5cMrNubep5qVrTJVu1M4Ld9zO7qqCKJHAKctF1nc5n43Nd5sRFH4cPPUzC/PzwxMsE1Vcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEJIoN15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77847C4CEF1;
	Wed, 10 Dec 2025 20:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765397151;
	bh=lv3NbKgBTkAl4Qv4ffmY0I7beJoLO2jboYBY/LfTyOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YEJIoN15ixvnFKLOw308ToLTOeI3VptylolicQgRtQjKFMcXvOtJpwlCblBv2gIwS
	 foLMlnxm7jk5KJTomom76lcw91IHZ6isgakik/cstkAmDlt9ok6JlxkfifdpV+68H8
	 aBbokEGbSjcixFSvdu8cyVOfGdkGP4murxgZzmn0Zj2QmibBKrSjQkrV7XKK6pSSZB
	 UmaX9WKf4zbmyUMwiLZ4w7XydLLg6P8o71c2XEU3F3c62082KNc10yOHV1KZJFSC3K
	 4bMy21S7vmR4RP6egqX0xy7XWHElS1Ys3qU5WvJgOAunoCv06dIMkyyI+CXnkgBGTT
	 YOEiYEM43/PBw==
Date: Wed, 10 Dec 2025 12:05:50 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 06/12] xfs/157: don't override SCRATCH_{,LOG,RT}DEV
Message-ID: <20251210200550.GH94594@frogsfrogsfrogs>
References: <20251210054831.3469261-1-hch@lst.de>
 <20251210054831.3469261-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210054831.3469261-7-hch@lst.de>

On Wed, Dec 10, 2025 at 06:46:52AM +0100, Christoph Hellwig wrote:
> This tests wants to test various difference device configurations,
> and does so by overriding SCRATCH_{,LOG,RT}DEV.  This has two downside:
> 
>  1) the actual SCRATCH_{,LOG,RT}DEV configuration is still injected by
>     default, thus making the test dependent on that configuration
>  2) the MKFS_OPTIONS might not actually be compatible with the
>     configuration created
> 
> Fix this by open coding the mkfs, db, admin and repair calls and always
> run them on the specific configuration.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Interesting solution to that...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/xfs/157 | 104 +++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 78 insertions(+), 26 deletions(-)
> 
> diff --git a/tests/xfs/157 b/tests/xfs/157
> index e102a5a10abe..31f05db25724 100755
> --- a/tests/xfs/157
> +++ b/tests/xfs/157
> @@ -50,53 +50,105 @@ fake_rtfile=$TEST_DIR/$seq.scratch.rt
>  rm -f $fake_rtfile
>  truncate -s $fs_size $fake_rtfile
>  
> -# Save the original variables
> -orig_ddev=$SCRATCH_DEV
> -orig_external=$USE_EXTERNAL
> -orig_logdev=$SCRATCH_LOGDEV
> -orig_rtdev=$SCRATCH_RTDEV
> -
>  scenario() {
>  	echo "$@" | tee -a $seqres.full
>  
> -	SCRATCH_DEV=$orig_ddev
> -	USE_EXTERNAL=$orig_external
> -	SCRATCH_LOGDEV=$orig_logdev
> -	SCRATCH_RTDEV=$orig_rtdev
> +	dev=$SCRATCH_DEV
> +	logdev=
> +	rtdev=
> +}
> +
> +_fake_mkfs()
> +{
> +	OPTIONS="$*"
> +	if [ -n "$logdev" ]; then
> +		OPTIONS="$OPTIONS -l logdev=$logdev"
> +	fi
> +	if [ -n "$rtdev" ]; then
> +		OPTIONS="$OPTIONS -r rtdev=$rtdev"
> +	fi
> +	$MKFS_XFS_PROG -f $OPTIONS $dev || _fail "mkfs failed"
> +}
> +
> +_fake_xfs_db_options()
> +{
> +	OPTIONS=""
> +	if [ ! -z "$logdev" ]; then
> +		OPTIONS="-l $logdev"
> +	fi
> +	if [ ! -z "$rtdev" ]; then
> +		if [ $XFS_DB_PROG --help 2>&1 | grep -q -- '-R rtdev']; then
> +			OPTIONS="$OPTIONS -R $rtdev"
> +		fi
> +	fi
> +	echo $OPTIONS $* $dev
> +}
> +
> +_fake_xfs_db()
> +{
> +	$XFS_DB_PROG "$@" $(_fake_xfs_db_options)
> +}
> +
> +_fake_xfs_admin()
> +{
> +	local options=("$dev")
> +	local rt_opts=()
> +	if [ -n "$logdev" ]; then
> +		options+=("$logdev")
> +	fi
> +	if [ -n "$rtdev" ]; then
> +		$XFS_ADMIN_PROG --help 2>&1 | grep -q 'rtdev' || \
> +			_notrun 'xfs_admin does not support rt devices'
> +		rt_opts+=(-r "$rtdev")
> +	fi
> +
> +	# xfs_admin in xfsprogs 5.11 has a bug where an external log device
> +	# forces xfs_db to be invoked, potentially with zero command arguments.
> +	# When this happens, xfs_db will wait for input on stdin, which causes
> +	# fstests to hang.  Since xfs_admin is not an interactive tool, we
> +	# can redirect stdin from /dev/null to prevent this issue.
> +	$XFS_ADMIN_PROG "${rt_opts[@]}" "$@" "${options[@]}" < /dev/null
> +}
> +
> +
> +_fake_xfs_repair()
> +{
> +	OPTIONS=""
> +	if [ -n "$logdev" ]; then
> +		OPTIONS="-l $logdev"
> +	fi
> +	if [ -n "$rtdev" ]; then
> +		OPTIONS="$OPTIONS -r $rtdev"
> +	fi
> +	$XFS_REPAIR_PROG $OPTIONS $* $dev
>  }
>  
>  check_label() {
> -	_scratch_mkfs_sized "$fs_size" "" -L oldlabel >> $seqres.full 2>&1
> -	_scratch_xfs_db -c label
> -	_scratch_xfs_admin -L newlabel "$@" >> $seqres.full
> -	_scratch_xfs_db -c label
> -	_scratch_xfs_repair -n &>> $seqres.full || echo "Check failed?"
> +	_fake_mkfs -L oldlabel >> $seqres.full 2>&1
> +	_fake_xfs_db -c label
> +	_fake_xfs_admin -L newlabel "$@" >> $seqres.full
> +	_fake_xfs_db -c label
> +	_fake_xfs_repair -n &>> $seqres.full || echo "Check failed?"
>  }
>  
>  scenario "S1: Check that label setting with file image"
> -SCRATCH_DEV=$fake_datafile
> +dev=$fake_datafile
>  check_label -f
>  
>  scenario "S2: Check that setting with logdev works"
> -USE_EXTERNAL=yes
> -SCRATCH_LOGDEV=$fake_logfile
> +logdev=$fake_logfile
>  check_label
>  
>  scenario "S3: Check that setting with rtdev works"
> -USE_EXTERNAL=yes
> -SCRATCH_RTDEV=$fake_rtfile
> +rtdev=$fake_rtfile
>  check_label
>  
>  scenario "S4: Check that setting with rtdev + logdev works"
> -USE_EXTERNAL=yes
> -SCRATCH_LOGDEV=$fake_logfile
> -SCRATCH_RTDEV=$fake_rtfile
> +logdev=$fake_logfile
> +rtdev=$fake_rtfile
>  check_label
>  
>  scenario "S5: Check that setting with nortdev + nologdev works"
> -USE_EXTERNAL=
> -SCRATCH_LOGDEV=
> -SCRATCH_RTDEV=
>  check_label
>  
>  scenario "S6: Check that setting with bdev incorrectly flagged as file works"
> -- 
> 2.47.3
> 
> 

