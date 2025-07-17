Return-Path: <linux-ext4+bounces-9051-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01205B091E7
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 18:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B36617599F
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 16:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910042FCE28;
	Thu, 17 Jul 2025 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEe+XWHG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B391F9F73;
	Thu, 17 Jul 2025 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769945; cv=none; b=s1mudJHhgEDfS0iYfq8A8/lWRUOY1eV7h9hbX5bWs3daiRJyBn+KJ9s47NX5sODF7psF85uodm8FwUp733X88Xstcv9uYPrvfx2Mz27q59VrbRZuOyH+qOFyDHAbLqlaiU2uEl3hGimxHTD3CY79t+KrCtOgP2MOPeCdGDBTsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769945; c=relaxed/simple;
	bh=FEK51UhPxeBBWXkkPXC93D/okFcWTsS4YiHNKO8OB30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/QrXhvwG1IRqR9O6uvNjPWYNZPEzYvIM6LwQeOqSB5CAyN+GuXijzcVb4OhP6qLG4QB9Lc2LDQ1r4ar9lH3+1MiVvpbW7hdaMsUEvF7urF98D0drLHnnHwUEe4mjLJGk4ijQcIW7fCf3lbO7Wyt+vvDDY2n7Oqdq8DoluVuHgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEe+XWHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6F1C4CEED;
	Thu, 17 Jul 2025 16:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752769944;
	bh=FEK51UhPxeBBWXkkPXC93D/okFcWTsS4YiHNKO8OB30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UEe+XWHGQfXRIMM0ofUSnW5AlQdI0kqh32jfgsGkCAxK04+Ohu9T4fpUtSNH4Zf1k
	 UbmyMsoJmwJZDo6MSFuQrZ0A728KEyFKGklb3Bh0amVI9sclzlLxe8DTFVHurV2zeg
	 vk/zzA3fAycaC/HAgENS7/YVgxJNaVosVoCkY+aWieMMCiUywpBku2udsKiDwf87x+
	 O71LUNaRJVJ4j/JLl9u2YLbo+C1eR4CLPZwN+I39x7GMASVSVn5djzw+omOLpOpYUv
	 Y+/QIaYftIcyzhwVEe7rfmpBDuffx7TF5qL4oSUcNfqJfEAGKVDfwyR+f0zBKhVfb1
	 vbNNdfxNkRFQQ==
Date: Thu, 17 Jul 2025 09:32:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 06/13] generic/1227: Add atomic write test using fio
 verify on file mixed mappings
Message-ID: <20250717163224.GI2672039@frogsfrogsfrogs>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <f2d4a366f32ca56e1d47897dc5cf6cc8d85328b4.1752329098.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2d4a366f32ca56e1d47897dc5cf6cc8d85328b4.1752329098.git.ojaswin@linux.ibm.com>

On Sat, Jul 12, 2025 at 07:42:48PM +0530, Ojaswin Mujoo wrote:
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> 
> This tests uses fio to first create a file with mixed mappings. Then it
> does atomic writes using aio dio with parallel jobs to the same file
> with mixed mappings. This forces the filesystem allocator to allocate
> extents over mixed mapping regions to stress FS block allocators.
> 
> Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Seems reasonable to me...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/1227     | 123 +++++++++++++++++++++++++++++++++++++++++
>  tests/generic/1227.out |   2 +
>  2 files changed, 125 insertions(+)
>  create mode 100755 tests/generic/1227
>  create mode 100644 tests/generic/1227.out
> 
> diff --git a/tests/generic/1227 b/tests/generic/1227
> new file mode 100755
> index 00000000..cfdc54ec
> --- /dev/null
> +++ b/tests/generic/1227
> @@ -0,0 +1,123 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 1227
> +#
> +# Validate FS atomic write using fio crc check verifier on mixed mappings
> +# of a file.
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +
> +_begin_fstest auto aio rw atomicwrites
> +
> +_require_scratch_write_atomic_multi_fsblock
> +_require_odirect
> +_require_aio
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +touch "$SCRATCH_MNT/f1"
> +awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
> +awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
> +aw_bsize=$(_max "$awu_min_write" "$((awu_max_write/4))")
> +
> +fsbsize=$(_get_block_size $SCRATCH_MNT)
> +
> +fio_prep_config=$tmp.prep.fio
> +fio_aw_config=$tmp.aw.fio
> +fio_verify_config=$tmp.verify.fio
> +fio_out=$tmp.fio.out
> +
> +FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
> +SIZE=$((128 * 1024 * 1024))
> +
> +cat >$fio_prep_config <<EOF
> +# prep file to have mixed mappings
> +[global]
> +ioengine=libaio
> +fallocate=none
> +filename=$SCRATCH_MNT/test-file
> +filesize=$SIZE
> +bs=$fsbsize
> +direct=1
> +group_reporting=1
> +
> +# Create written extents
> +[prep_written_blocks]
> +ioengine=libaio
> +rw=randwrite
> +io_size=$((SIZE/3))
> +random_generator=lfsr
> +
> +# Create unwritten extents
> +[prep_unwritten_blocks]
> +ioengine=falloc
> +rw=randwrite
> +io_size=$((SIZE/3))
> +random_generator=lfsr
> +EOF
> +
> +cat >$fio_aw_config <<EOF
> +# atomic write to mixed mappings of written/unwritten/holes
> +[atomic_write_job]
> +ioengine=libaio
> +rw=randwrite
> +direct=1
> +atomic=1
> +random_generator=lfsr
> +group_reporting=1
> +
> +filename=$SCRATCH_MNT/test-file
> +size=$SIZE
> +bs=$aw_bsize
> +iodepth=$FIO_LOAD
> +numjobs=$FIO_LOAD
> +
> +verify_state_save=0
> +verify=crc32c
> +do_verify=0
> +EOF
> +
> +cat >$fio_verify_config <<EOF
> +# verify atomic writes done by previous job
> +[verify_job]
> +ioengine=libaio
> +rw=randwrite
> +random_generator=lfsr
> +group_reporting=1
> +
> +filename=$SCRATCH_MNT/test-file
> +size=$SIZE
> +bs=$aw_bsize
> +iodepth=$FIO_LOAD
> +
> +verify_state_save=0
> +verify_only=1
> +verify=crc32c
> +verify_fatal=1
> +verify_write_sequence=0
> +EOF
> +
> +_require_fio $fio_aw_config
> +_require_fio $fio_verify_config
> +
> +cat $fio_prep_config >> $seqres.full
> +cat $fio_aw_config >> $seqres.full
> +cat $fio_verify_config >> $seqres.full
> +
> +#prepare file with mixed mappings
> +$FIO_PROG $fio_prep_config >> $seqres.full
> +
> +# do atomic writes without verifying
> +$FIO_PROG $fio_aw_config >> $seqres.full
> +
> +# verify data is not torn
> +$FIO_PROG $fio_verify_config >> $seqres.full
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/generic/1227.out b/tests/generic/1227.out
> new file mode 100644
> index 00000000..2605d062
> --- /dev/null
> +++ b/tests/generic/1227.out
> @@ -0,0 +1,2 @@
> +QA output created by 1227
> +Silence is golden
> -- 
> 2.49.0
> 
> 

