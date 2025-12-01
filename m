Return-Path: <linux-ext4+bounces-12112-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE55C997F7
	for <lists+linux-ext4@lfdr.de>; Tue, 02 Dec 2025 00:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0053134233D
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Dec 2025 23:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B3C2BE05F;
	Mon,  1 Dec 2025 22:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4W7FtYK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D86292B4B;
	Mon,  1 Dec 2025 22:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629965; cv=none; b=eGLpHj0DDZSzjrnbDHiPJDcJ8ZF372ABBgbaBO4HdG+rMqLQxOxjxxb0d4g08lgMBntKaniDUfZvNQCdB5wMfgSotLmaYQPSOuPvB/lqzPA0M2yHK0IFU9BvcGh5LNdH+Hn5WHkmNBeMXmXz6XZ1OWeiE0QfaFFLZCXhyX66mvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629965; c=relaxed/simple;
	bh=kuXP4O/MyRwYbglg8oo+/Dmlqqm22FmToSbOO1/POMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEBJeF/1HJfrH4EEVpQvhEQH2twqGuRr7EASkv3s0/yC0V2t9mfX6mYfZ1bfF7JXH7tUMtmoxj/rE9YAav4G/EGnYy4boDqcg6AZQtcY1NkbjdvLEBa4Ii53UE+ZhsrckInG+Z5lg/mdgaNC478qLbOwk3Hv1KGO9z4p2n/QEVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4W7FtYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56370C4CEF1;
	Mon,  1 Dec 2025 22:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764629965;
	bh=kuXP4O/MyRwYbglg8oo+/Dmlqqm22FmToSbOO1/POMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e4W7FtYKYSbM7oAVBIgHtRfIJaGzVwtN94Lzps9MPw9QduxFjMFXtpcLcvS8EfzOA
	 UQBH2TRaAxRfrXMoRE7/XOhwlgf9Ie27Q7HZbGMIlEorCEiCdSnbefvMToKfPa+Sxs
	 FRF5dJ1hEez3jDahaBtiYY3lmbh2Cu4JrklN8YCD5tKEOkqeL2BLOQ8MupC3EL3tFt
	 S/zqLiF6Oy24498hogBSsOaaIo6Qop4g6ra25hgxqKcD+6aSsa8PctMY5Xn6LbTOKB
	 ltKn8Ql/ARQfO73RPjqwN36Jx/bK0H9N5HvhtGXMZ1Fma565fciIXj14Xaw+FRrXl+
	 vhfy+ChsrYjkg==
Date: Mon, 1 Dec 2025 14:59:24 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Su Yue <glass.su@suse.com>
Cc: fstests@vger.kernel.org, l@damenly.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] generic: use _qmount_option and _qmount
Message-ID: <20251201225924.GA89454@frogsfrogsfrogs>
References: <20251124132004.23965-1-glass.su@suse.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124132004.23965-1-glass.su@suse.com>

On Mon, Nov 24, 2025 at 09:20:04PM +0800, Su Yue wrote:
> Many generic tests call `_scratch_mount -o usrquota` then
> chmod 777, quotacheck and quotaon.

What does the chmod 777 do, in relation to the quota{check,on} programs?
Is it necessary for the root dir to be world writable (and executable!)
for quota tools to work?

> It can be simpilfied to _qmount_option and _qmount. The later
> function already calls quotacheck, quota and chmod.
> 
> Convertaions can save a few lines. tests/generic/380 is an exception

"Conversions" ?

--D

> because it tests chown.
> 
> Signed-off-by: Su Yue <glass.su@suse.com>
> ---
>  tests/generic/082 |  9 ++-------
>  tests/generic/219 | 11 ++++-------
>  tests/generic/230 | 11 ++++++-----
>  tests/generic/231 |  6 ++----
>  tests/generic/232 |  6 ++----
>  tests/generic/233 |  6 ++----
>  tests/generic/234 |  5 ++---
>  tests/generic/235 |  5 ++---
>  tests/generic/244 |  1 -
>  tests/generic/270 |  6 ++----
>  tests/generic/280 |  5 ++---
>  tests/generic/400 |  2 +-
>  12 files changed, 27 insertions(+), 46 deletions(-)
> 
> diff --git a/tests/generic/082 b/tests/generic/082
> index f078ef2ffff9..6bb9cf2a22ae 100755
> --- a/tests/generic/082
> +++ b/tests/generic/082
> @@ -23,13 +23,8 @@ _require_scratch
>  _require_quota
>  
>  _scratch_mkfs >>$seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -
> -# xfs doesn't need these setups and quotacheck even fails on xfs, so just
> -# redirect the output to $seqres.full for debug purpose and ignore the results,
> -# as we check the quota status later anyway.
> -quotacheck -ug $SCRATCH_MNT >>$seqres.full 2>&1
> -quotaon $SCRATCH_MNT >>$seqres.full 2>&1
> +_qmount_option 'usrquota,grpquota'
> +_qmount "usrquota,grpquota"
>  
>  # first remount ro with a bad option, a failed remount ro should not disable
>  # quota, but currently xfs doesn't fail in this case, the unknown option is
> diff --git a/tests/generic/219 b/tests/generic/219
> index 642823859886..a2eb0b20f408 100755
> --- a/tests/generic/219
> +++ b/tests/generic/219
> @@ -91,25 +91,22 @@ test_accounting()
>  
>  _scratch_unmount 2>/dev/null
>  _scratch_mkfs >> $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> +_qmount_option "usrquota,grpquota"
> +_qmount
>  _force_vfs_quota_testing $SCRATCH_MNT
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon $SCRATCH_MNT 2>/dev/null
>  _scratch_unmount
>  
>  echo; echo "### test user accounting"
> -export MOUNT_OPTIONS="-o usrquota"
> +_qmount_option "usrquota"
>  _qmount
> -quotaon $SCRATCH_MNT 2>/dev/null
>  type=u
>  test_files
>  test_accounting
>  _scratch_unmount 2>/dev/null
>  
>  echo; echo "### test group accounting"
> -export MOUNT_OPTIONS="-o grpquota"
> +_qmount_option "grpquota"
>  _qmount
> -quotaon $SCRATCH_MNT 2>/dev/null
>  type=g
>  test_files
>  test_accounting
> diff --git a/tests/generic/230 b/tests/generic/230
> index a8caf5a808c3..0a680dbc874b 100755
> --- a/tests/generic/230
> +++ b/tests/generic/230
> @@ -99,7 +99,8 @@ grace=2
>  _qmount_option 'defaults'
>  
>  _scratch_mkfs >> $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> +_qmount_option "usrquota,grpquota"
> +_qmount
>  _force_vfs_quota_testing $SCRATCH_MNT
>  BLOCK_SIZE=$(_get_file_block_size $SCRATCH_MNT)
>  quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> @@ -113,8 +114,8 @@ setquota -g -t $grace $grace $SCRATCH_MNT
>  _scratch_unmount
>  
>  echo; echo "### test user limit enforcement"
> -_scratch_mount "-o usrquota"
> -quotaon $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota"
> +_qmount
>  type=u
>  test_files
>  test_enforcement
> @@ -122,8 +123,8 @@ cleanup_files
>  _scratch_unmount 2>/dev/null
>  
>  echo; echo "### test group limit enforcement"
> -_scratch_mount "-o grpquota"
> -quotaon $SCRATCH_MNT 2>/dev/null
> +_qmount_option "grpquota"
> +_qmount
>  type=g
>  test_files
>  test_enforcement
> diff --git a/tests/generic/231 b/tests/generic/231
> index ce7e62ea1886..02910523d0b5 100755
> --- a/tests/generic/231
> +++ b/tests/generic/231
> @@ -47,10 +47,8 @@ _require_quota
>  _require_user
>  
>  _scratch_mkfs >> $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -chmod 777 $SCRATCH_MNT
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota,grpquota"
> +_qmount
>  
>  if ! _fsx 1; then
>  	_scratch_unmount 2>/dev/null
> diff --git a/tests/generic/232 b/tests/generic/232
> index c903a5619045..21375809d299 100755
> --- a/tests/generic/232
> +++ b/tests/generic/232
> @@ -44,10 +44,8 @@ _require_scratch
>  _require_quota
>  
>  _scratch_mkfs > $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -chmod 777 $SCRATCH_MNT
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota,grpquota"
> +_qmount
>  
>  _fsstress
>  _check_quota_usage
> diff --git a/tests/generic/233 b/tests/generic/233
> index 3fc1b63abb24..4606f3bde2ab 100755
> --- a/tests/generic/233
> +++ b/tests/generic/233
> @@ -59,10 +59,8 @@ _require_quota
>  _require_user
>  
>  _scratch_mkfs > $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -chmod 777 $SCRATCH_MNT
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota,grpquota"
> +_qmount
>  setquota -u $qa_user 32000 32000 1000 1000 $SCRATCH_MNT 2>/dev/null
>  
>  _fsstress
> diff --git a/tests/generic/234 b/tests/generic/234
> index 4b25fc6507cc..2c596492a3e0 100755
> --- a/tests/generic/234
> +++ b/tests/generic/234
> @@ -66,9 +66,8 @@ _require_quota
>  
>  
>  _scratch_mkfs >> $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota,grpquota"
> +_qmount
>  test_setting
>  _scratch_unmount
>  
> diff --git a/tests/generic/235 b/tests/generic/235
> index 037c29e806db..7a616650fc8f 100755
> --- a/tests/generic/235
> +++ b/tests/generic/235
> @@ -25,9 +25,8 @@ do_repquota()
>  
>  
>  _scratch_mkfs >> $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota,grpquota"
> +_qmount
>  
>  touch $SCRATCH_MNT/testfile
>  chown $qa_user:$qa_user $SCRATCH_MNT/testfile
> diff --git a/tests/generic/244 b/tests/generic/244
> index b68035129c82..989bb4f5385e 100755
> --- a/tests/generic/244
> +++ b/tests/generic/244
> @@ -66,7 +66,6 @@ done
>  # remount just for kicks, make sure we get it off disk
>  _scratch_unmount
>  _qmount
> -quotaon $SCRATCH_MNT 2>/dev/null
>  
>  # Read them back by iterating based on quotas returned.
>  # This should match what we set, even if we don't directly
> diff --git a/tests/generic/270 b/tests/generic/270
> index c3d5127a0b51..9ac829a7379f 100755
> --- a/tests/generic/270
> +++ b/tests/generic/270
> @@ -62,10 +62,8 @@ _require_command "$SETCAP_PROG" setcap
>  _require_attrs security
>  
>  _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -chmod 777 $SCRATCH_MNT
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota,grpquota"
> +_qmount
>  
>  if ! _workout; then
>  	_scratch_unmount 2>/dev/null
> diff --git a/tests/generic/280 b/tests/generic/280
> index 3108fd23fb70..fae0a02145cf 100755
> --- a/tests/generic/280
> +++ b/tests/generic/280
> @@ -34,9 +34,8 @@ _require_freeze
>  
>  _scratch_unmount 2>/dev/null
>  _scratch_mkfs >> $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota,grpquota"
> +_qmount
>  xfs_freeze -f $SCRATCH_MNT
>  setquota -u root 1 2 3 4 $SCRATCH_MNT &
>  pid=$!
> diff --git a/tests/generic/400 b/tests/generic/400
> index 77970da69a41..ef27c254167c 100755
> --- a/tests/generic/400
> +++ b/tests/generic/400
> @@ -22,7 +22,7 @@ _require_scratch
>  
>  _scratch_mkfs >> $seqres.full 2>&1
>  
> -MOUNT_OPTIONS="-o usrquota,grpquota"
> +_qmount_option "usrquota,grpquota"
>  _qmount
>  _require_getnextquota
>  
> -- 
> 2.48.1
> 
> 

