Return-Path: <linux-ext4+bounces-9341-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8426AB22EC9
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Aug 2025 19:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2654F163B72
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Aug 2025 17:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6450B2FD1C7;
	Tue, 12 Aug 2025 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3UKfnuU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEC91A9FA8;
	Tue, 12 Aug 2025 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018980; cv=none; b=JZinmcKJUKzoxyv2uGKWQhgul58RiFjL3+0I7f5bk8BFrX8AdzggP+OCMBJLqRqOdY4IXbEb8XEC3wdz4D0HwO0hnICA5jWNiPIOkxbmjZHhomPjGw1JdrdN1RPf7O/5UWXT/tLFzDabGeBRF2BheAtWqbCAHywvJeUgxbUhnNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018980; c=relaxed/simple;
	bh=1mDeEuCRCUoO/MKB/AEbGFw8HAfQXdnAVzoiB5lEbQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPPzjOwUZqgLdOUs7amVZNGMkqIn4jG7D2QWAT4JaWwra9hGl08GIJLNcW5/DBYZGRKzIiDjXRlSJMPOsS8Z9TafK4HBiiU5kRvMOgBhs72fmQCTo/w7/JurpiB1yBwbqAfALbKO4fPBvtpcpa3TgMcsYUrVJyjslffbS6GUHcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3UKfnuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DE1C4CEF0;
	Tue, 12 Aug 2025 17:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755018978;
	bh=1mDeEuCRCUoO/MKB/AEbGFw8HAfQXdnAVzoiB5lEbQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I3UKfnuUWiZiif3PdKTjdz7rEtzwKYBC0qKF3F/Eveu6xzhc7ynsKY+sM45TCfcJC
	 d4qrbCSvC7iv0nJ8Je+lw07HoJK1Pnsqbvabe35NOSL7WcQIFIqG0zoRRTYHQYs2ez
	 XcRmZMHhALRYClJHC2+X6MufIj0t6gLhgHjWCItv+1ELSCRwv6f3h7/HuRqK7sNga3
	 9rj95bPMY8GvpGaYk1kEi/k7HIhG5I+NdpjUnD+W78doxJmJXz40HPKoGXPl3jeetX
	 RH1+b1KG2xAdIJKcMkVGvdX/6dcBOm0ip9WCP/k9y8b9xjCwvuKvQ4aCioE4mh/O/i
	 CPBgtMDUs6MFA==
Date: Tue, 12 Aug 2025 10:16:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 04/11] generic: Add atomic write test using fio crc
 check verifier
Message-ID: <20250812171617.GA7938@frogsfrogsfrogs>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <783e950d8b5ad80672a359a19ede4faeb64e3dd7.1754833177.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <783e950d8b5ad80672a359a19ede4faeb64e3dd7.1754833177.git.ojaswin@linux.ibm.com>

On Sun, Aug 10, 2025 at 07:11:55PM +0530, Ojaswin Mujoo wrote:
> This adds atomic write test using fio based on it's crc check verifier.
> fio adds a crc for each data block. If the underlying device supports
> atomic write then it is guaranteed that we will never have a mix data from
> two threads writing on the same physical block.
> 
> Avoid doing overlapping parallel atomic writes because it might give
> unexpected results. Use offset_increment=, size= fio options to achieve
> this behavior.
> 
> Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

John had the most opinions about the last iteration of this test, but it
looks reasonable enough to me...

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/1226     | 107 +++++++++++++++++++++++++++++++++++++++++
>  tests/generic/1226.out |   2 +
>  2 files changed, 109 insertions(+)
>  create mode 100755 tests/generic/1226
>  create mode 100644 tests/generic/1226.out
> 
> diff --git a/tests/generic/1226 b/tests/generic/1226
> new file mode 100755
> index 00000000..efc360e1
> --- /dev/null
> +++ b/tests/generic/1226
> @@ -0,0 +1,107 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 1226
> +#
> +# Validate FS atomic write using fio crc check verifier.
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +
> +_begin_fstest auto aio rw atomicwrites
> +
> +_require_scratch_write_atomic
> +_require_odirect
> +_require_aio
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +_require_xfs_io_command "falloc"
> +
> +touch "$SCRATCH_MNT/f1"
> +awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
> +awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
> +
> +blocksize=$(_max "$awu_min_write" "$((awu_max_write/2))")
> +threads=$(_min "$(($(nproc) * 2 * LOAD_FACTOR))" "100")
> +filesize=$((blocksize * threads * 100))
> +depth=$threads
> +io_size=$((filesize / threads))
> +io_inc=$io_size
> +testfile=$SCRATCH_MNT/test-file
> +
> +fio_config=$tmp.fio
> +fio_out=$tmp.fio.out
> +
> +fio_aw_config=$tmp.aw.fio
> +fio_verify_config=$tmp.verify.fio
> +
> +function create_fio_configs()
> +{
> +	create_fio_aw_config
> +	create_fio_verify_config
> +}
> +
> +function create_fio_verify_config()
> +{
> +cat >$fio_verify_config <<EOF
> +	[verify-job]
> +	direct=1
> +	ioengine=libaio
> +	rw=read
> +	bs=$blocksize
> +	filename=$testfile
> +	size=$filesize
> +	iodepth=$depth
> +	group_reporting=1
> +
> +	verify_only=1
> +	verify=crc32c
> +	verify_fatal=1
> +	verify_state_save=0
> +	verify_write_sequence=0
> +EOF
> +}
> +
> +function create_fio_aw_config()
> +{
> +cat >$fio_aw_config <<EOF
> +	[atomicwrite-job]
> +	direct=1
> +	ioengine=libaio
> +	rw=randwrite
> +	bs=$blocksize
> +	filename=$testfile
> +	size=$io_inc
> +	offset_increment=$io_inc
> +	iodepth=$depth
> +	numjobs=$threads
> +	group_reporting=1
> +	atomic=1
> +
> +	verify_state_save=0
> +	verify=crc32c
> +	do_verify=0
> +EOF
> +}
> +
> +create_fio_configs
> +_require_fio $fio_aw_config
> +
> +cat $fio_aw_config >> $seqres.full
> +cat $fio_verify_config >> $seqres.full
> +
> +$XFS_IO_PROG -fc "falloc 0 $filesize" $testfile >> $seqres.full
> +
> +$FIO_PROG $fio_aw_config >> $seqres.full
> +ret1=$?
> +$FIO_PROG $fio_verify_config >> $seqres.full
> +ret2=$?
> +
> +[[ $ret1 -eq 0 && $ret2 -eq 0 ]] || _fail "fio with atomic write failed"
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/generic/1226.out b/tests/generic/1226.out
> new file mode 100644
> index 00000000..6dce0ea5
> --- /dev/null
> +++ b/tests/generic/1226.out
> @@ -0,0 +1,2 @@
> +QA output created by 1226
> +Silence is golden
> -- 
> 2.49.0
> 
> 

