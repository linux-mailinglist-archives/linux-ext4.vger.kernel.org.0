Return-Path: <linux-ext4+bounces-9200-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AA9B13716
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Jul 2025 10:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB43D3B7333
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Jul 2025 08:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368D023535A;
	Mon, 28 Jul 2025 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1R5OoAd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342BB2264BF
	for <linux-ext4@vger.kernel.org>; Mon, 28 Jul 2025 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753693145; cv=none; b=N+MFeDdIst7iv62xavrl5EOiFfCVntcHjNvd52N8oK6lmle2tNE34vPqYatsTlZDfkV0rp3Uidezvlk5ZKiVchwXoVJmxMH/l3eRDcwMETtgGczByN14VYVp4fH5BIz7sjp7rFpTMZ0q7KI7b4yKinlSjkBguQWkyKTJKqyGvnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753693145; c=relaxed/simple;
	bh=YsC5pSNo2+8uKmZVqEClllwgubyM526llula6bBH7T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5EgsC+8JpAQmX3DDVcEwHE4qlORQKKNYAmFDi5OP/YnZG5JgLm+RuNVbBxcTgh3otfNxmTkB0FMhBoxnTvNnnZOMu72bTWfimFZP6uAdF3NNgkXKp4PCzycqp/8V4np6bfi82e1yl/bWfTsxRUwrkDicyHkFa4jyEKdibU8qi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1R5OoAd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753693143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nUEIR7WJnZzl7oIEmEa+5NqIiSVYYM4qbIYv3z78KTk=;
	b=R1R5OoAdMjD2cGpZy0KXOkyv6qK87iBMjG2zsSJeSyhnSc01Gmvhh+KjDT31LzoGSpxf4b
	6onPsB8vM+vGqZIzCGZoUD3V3lv2qOvaAuihOwGJCviXFs805CVOLGJ6iGu65Z60B1G1nF
	pJuXW5615DNSOovcVwN/6PXsj2SPAc4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-5Nz-2gsZN7Wc9ydgNXVKWA-1; Mon, 28 Jul 2025 04:58:59 -0400
X-MC-Unique: 5Nz-2gsZN7Wc9ydgNXVKWA-1
X-Mimecast-MFC-AGG-ID: 5Nz-2gsZN7Wc9ydgNXVKWA_1753693138
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b2fcbd76b61so5713173a12.3
        for <linux-ext4@vger.kernel.org>; Mon, 28 Jul 2025 01:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753693138; x=1754297938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUEIR7WJnZzl7oIEmEa+5NqIiSVYYM4qbIYv3z78KTk=;
        b=YyCW3x8la9/x1uOaKBnOnRKOVQ3j911HdVLog2pDqYobhrjK9OB+2ARy2F9Nk0t8Ds
         Qq0N3R3fYio5MdNvZQ7391SuEUttR4LcpdCGqctnoemczba3X68ttLN71Vx61FnmDbvC
         WnarSwi4gg+yWJMLDGc8Ci64cG3e92BNk3lDfpYMHQeLS+z4h6DaIBouyyaTu1US9js8
         WMHDkWFRg3du+nYfskAsPDmHymOBZWnM/jmYa+n7FMceHcHwuXTQWFJ8XjVaoddhWXBi
         FgO1wsF7+B0hcX2M3KEjuyYjqDLkkySxX0pfvitTHCgcD7dXcfqnouUmCbUTYDmFKC0S
         sw+g==
X-Forwarded-Encrypted: i=1; AJvYcCUk9QZHYQolT09EO22d60pAd1pgCOuYKkGjhHwyJv6UhBiV7zTAKhspUuSuyV34etJwnTDSFCVBS3bT@vger.kernel.org
X-Gm-Message-State: AOJu0YyvbxWO9n2rGBRELueMJ6Dz2pDcIQpOm87P/2ELj6rnF63+7ECR
	W9pUd7CorU/gu9InoR1Yz2PDKV+GsI3p2C+qSrPYEPeECR1Rn4iFU0RM8yfIE//qdHpw+NtChfn
	YCWltv5DdmQPYuB7CgNRpTGJKBrdr+c5lCdN7dAWKegOv2WyvEHdjkRxhgL2G0Uo=
X-Gm-Gg: ASbGncukxMrSuDpuzRAvR6offJUjc9/FQXkDuUkc+ED5WhC4v8lqT66Fn7QdlrutSYF
	ptmeZcBI8dpBed1lLGEpHrOe8OEw5R3nLkWcNorDstjvR7uaBRNiUlkl2ZIhHC3w+RnGdXBiofq
	8lME2NtRSka7FhXNsX7TyGwJ+UcMNQCJuKnMI7Zsk/kBzDZZTcEii2jd3ftopIoBHqtzKPFEHa0
	Qjat2ji2noyx/56+ehKqd/2qA4BSYh84P/2qs19GACsdYQj3E0dErElxLqKlU+yblEMcHgq/8Uc
	lqxwEDHw8dzudoPRVrE9AbJXglLfigptwW5vU03fVVsNNDNXNZmsvfFv6mTH4XUXrtek+H6XYhW
	yMhOl
X-Received: by 2002:a17:902:d587:b0:240:1395:320c with SMTP id d9443c01a7336-24013953464mr64775375ad.10.1753693137930;
        Mon, 28 Jul 2025 01:58:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpf57NT+dfadgccMj4Szku5Msa7e1Ss/m0YH0fWaHCzzyP6VnhsZ6Gebhfd7e6D8aknc9OQA==
X-Received: by 2002:a17:902:d587:b0:240:1395:320c with SMTP id d9443c01a7336-24013953464mr64775025ad.10.1753693137433;
        Mon, 28 Jul 2025 01:58:57 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe4fd676sm49353245ad.87.2025.07.28.01.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 01:58:57 -0700 (PDT)
Date: Mon, 28 Jul 2025 16:58:51 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 06/13] generic/1227: Add atomic write test using fio
 verify on file mixed mappings
Message-ID: <20250728085851.i3rqef5zssralmvl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
> ---

This patch looks good to me, just the subject:
 "generic/1227: Add atomic write test using fio verify on file mixed mappings"

generally if we write a new test case, we don't use a temporary case number
in commit subject, you can just write as "generic: add atomic write test using ..."

Other patches (with new test cases) refer to this.

With this change,
Reviewed-by: Zorro Lang <zlang@redhat.com>


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


