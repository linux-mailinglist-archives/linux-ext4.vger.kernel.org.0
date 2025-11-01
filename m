Return-Path: <linux-ext4+bounces-11394-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFDAC27A6D
	for <lists+linux-ext4@lfdr.de>; Sat, 01 Nov 2025 10:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8385C4E634E
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Nov 2025 09:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB642BDC34;
	Sat,  1 Nov 2025 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrOmzwgY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqJqYtHB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1442741CD
	for <linux-ext4@vger.kernel.org>; Sat,  1 Nov 2025 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761987658; cv=none; b=Du7MrVNNU+N6BPmaTNM4e2oRMdYUVK5ekIqvecFMtRoKbTcPGkNP+lA2+T75FrS5JxrxJJgsoLiM4gBCGDeQTKTiXt1oHbewSoRSUS8sOA7oRC4xjiJpItkM32cf/Vpu7L4kv487VFq94dq1dBisoa714WDfHF/ca3iR0p1kd04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761987658; c=relaxed/simple;
	bh=erZlZwmG67hxS99lC1J1OI9uGWwNY/GeBgK/oj0OKmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyOA6O24ylaB/xZb+sjwTjLZfUyUqf0+LkTWKrDs9wp9pCaqtNSc1eZScXwU/s6Z8pzWKeWsYAiFY4/QZtm54C9F5ygvTrgQgvNGdyFbCEOdFOAuQoKQZ8ACyDSUluX7+PWDQzgV5B7lOKeA/0f8u+rNbsRLdxvad7BYtzi0HmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IrOmzwgY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BqJqYtHB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761987655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zn+afpMdtbihpSuxES9QlBr4zxqcZucnzgZEXoXLmqk=;
	b=IrOmzwgYHyPrDcfnOJcoYd6mOSnhrKB7KsmTXy2PfPqft3dwgACehBjviQNPZBcx8LsGsM
	Ugw9gBqPXT5uK7EbLIsjV9XvnEd6CutiFvffqfEKRy1ovqL0tGLipDjUf+ek4dKmwU71pn
	tJp5C94LS7fIMX6hTYmZWd37VWeaHZg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-LkcA1RpAOE2nv_haCTkPhw-1; Sat, 01 Nov 2025 05:00:52 -0400
X-MC-Unique: LkcA1RpAOE2nv_haCTkPhw-1
X-Mimecast-MFC-AGG-ID: LkcA1RpAOE2nv_haCTkPhw_1761987651
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2956cdcdc17so555715ad.3
        for <linux-ext4@vger.kernel.org>; Sat, 01 Nov 2025 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1761987651; x=1762592451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn+afpMdtbihpSuxES9QlBr4zxqcZucnzgZEXoXLmqk=;
        b=BqJqYtHBo0K3/Yebe9js8QB1MQ/hilprORdLWSmggPgNXOILC1SfIKUljvuZjsCRnM
         Af3yyqZR3TuLBsrEDK5eni8/cfvzpQ+ebxPkdlXOyrfZtVT5l8Mu0d0r3scg6zOIvO0x
         q+R+uVA27NCHfLYJ9z4Fxa86pNzv0fLIzE53iRKGsBJ33dUyFnJOw5AYB1ZV9BD4w1ke
         q8bbh+F1APh24XXB8+6R9DwDoNZPIydBBzPczQPWuqTZPSgEWMI08BJ3iUG+oCRTVdMs
         6umWOZgJu/M8AB3VzcTxeJBG5no7BalNdu2gbg5mqVkaVCQY4tsj9AwTB/b951on03cR
         VA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761987651; x=1762592451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn+afpMdtbihpSuxES9QlBr4zxqcZucnzgZEXoXLmqk=;
        b=WBJu76o6glwyAsiceCfBV3/hSq/GCI5Sp9L93YZKQ7lBEQMxZ8qaaxQM/UJHhc7j/T
         L+CoAiv+qXfbZ8v/vTB/jVonQTydKqdW5/JScTOkzzjefYSDFFeqIEsPUGGK7kdyM09i
         oRzwo0+asVNZk51OfCTwT/2DqP6Po2M0y4M17RXoTzKbaIJFx1rJ8iYTkxkIBflKDbzG
         odYkkUWqw+q8L38WolAvLBGm7CJ/+PUzobHxPGQcR/dK4sJhaDYqobiZcd9QmQXAF3S7
         y7RqA1ZUAEKpJE10V3BUDYq7fC1DZwV6dmQONVOXMKkumNyB+kywHY1e5BqGy/Zit+Gc
         iUdg==
X-Forwarded-Encrypted: i=1; AJvYcCVgl6pboiza/PglY79qysiEpKieQWmzgHL9/O5z/m94jAp1Eogsgdjv2o9IBEUv8Dq/vfd9oh9eJ36q@vger.kernel.org
X-Gm-Message-State: AOJu0YzqUw9UN7sPLzQE8VlCXejxifiJzKUXVYmH74LvP00MDYXXLWB/
	K2WnBVhvmGXWtlzTn1GnqlVItuWXywaHOKzSGHl0Wdzwg6daN3V7yUbMUdfJY6fCSokac3qEKJr
	iQw+hwKQJM8p2OwjyP1tKpeXti8DpPKGGfW0uubNACpIyOc47k9P2sz4UXTZRjAc=
X-Gm-Gg: ASbGncvNTciRm/6vMIz8bFUXcWgFa0olemVhN1kigV137JV9lPjVX8ojpep5NmU4CFT
	n+UKQvdVBYtDUm3IQcu/6obE3jKGrY3vQ6jEHBTtjnI5D9aVJ0i2ejNVw+tTVQssVhpJ4/O/od1
	vSfHYvOyN0tlhoyiulmJRnK7MUL7bORRcz4aW+823O3KojRqfTF6pWy+/HECh5ZVRicZW+WiHO1
	YryW/mtAA95dDOU4NxifvDWsTvFxYzICoLsgXNSCKHNTxqFVLTL3eyW+Ig/yxtEj9dEYEEW5ZS2
	bGVDDZU98fX6fo3KkcYypt+FqJ6YNaUF6mXasi78tvkE5CsIRfKcqmVOmyhGLD0iyN4+8G+gnXl
	Vt0i5eF4dI6zoOj2QZ8+OHr5Mey1/6EjGYd8tqdI=
X-Received: by 2002:a17:902:c401:b0:295:595c:d002 with SMTP id d9443c01a7336-295595cd1bamr11607025ad.15.1761987647751;
        Sat, 01 Nov 2025 02:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWfYSpqPPKZTWZUIuCP9sZI3ZFUiApsjI7S0Dmb+QGZeLsda0a9cQgrC17lhu6wzKpF6jaeg==
X-Received: by 2002:a17:902:c401:b0:295:595c:d002 with SMTP id d9443c01a7336-295595cd1bamr11606135ad.15.1761987646798;
        Sat, 01 Nov 2025 02:00:46 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29556d61c4dsm16365525ad.56.2025.11.01.02.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:00:46 -0700 (PDT)
Date: Sat, 1 Nov 2025 17:00:40 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 05/12] generic: Add atomic write test using fio crc
 check verifier
Message-ID: <20251101090040.6ukcaal2c55ka7wy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1758264169.git.ojaswin@linux.ibm.com>
 <3c034b2fb5b81b3a043f1851f3905ce6a41c827a.1758264169.git.ojaswin@linux.ibm.com>
 <aQCQFOtjhyzohgnA@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQCQFOtjhyzohgnA@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Tue, Oct 28, 2025 at 03:12:44PM +0530, Ojaswin Mujoo wrote:
> On Fri, Sep 19, 2025 at 12:17:58PM +0530, Ojaswin Mujoo wrote:
> > This adds atomic write test using fio based on it's crc check verifier.
> > fio adds a crc header for each data block, which is verified later to
> > ensure there is no data corruption or torn write.
> > 
> > This test essentially does a lot of parallel RWF_ATOMIC IO on a
> > preallocated file to stress the write and end-io unwritten conversion
> > code paths. The idea is to increase code coverage to ensure RWF_ATOMIC
> > hasn't introduced any issues.
> > 
> > Avoid doing overlapping parallel atomic writes because it might give
> > unexpected results. Use offset_increment=, size= fio options to achieve
> > this behavior.
> > 
> > Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  tests/generic/1226     | 108 +++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/1226.out |   2 +
> >  2 files changed, 110 insertions(+)
> >  create mode 100755 tests/generic/1226
> >  create mode 100644 tests/generic/1226.out
> > 
> > diff --git a/tests/generic/1226 b/tests/generic/1226
> > new file mode 100755
> > index 00000000..7ad74554
> > --- /dev/null
> > +++ b/tests/generic/1226
> > @@ -0,0 +1,108 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> > +#
> > +# FS QA Test 1226
> 
> Hey Zorro,
> 
> Thanks for picking these in for-next. I just noticed that the test
> number for this test has become 773, but we missed changing:
> 
>  # FS QA Test 1226
> 
>  to
> 
>  # FS QA Test 773

Hmm...weird, I change the case number by running `./tools/mvtest generic/1226 generic/773`.
The "FS QA Test 1226" should be changed to "FS QA Test No. 773" by:

  sed -e "s/^# FS[[:space:]]*QA.*Test.*[0-9]\+$/# FS QA Test No. ${did}/g" -i "tests/${dest}"

I'm not sure what happened at that time, I'll check if there're more "wrong number" issues,
will correct them in one patch. Thanks for reporting:)

Thanks,
Zorro

> 
> 
> Commit: https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=1499d4ff2365803e97af3279ba3312bba2cc9a80
> 
> Regards,
> Ojaswin
> 
> > +#
> > +# Validate FS atomic write using fio crc check verifier.
> > +#
> > +. ./common/preamble
> > +. ./common/atomicwrites
> > +
> > +_begin_fstest auto aio rw atomicwrites
> > +
> > +_require_scratch_write_atomic
> > +_require_odirect
> > +_require_aio
> > +_require_fio_atomic_writes
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1
> > +_scratch_mount
> > +_require_xfs_io_command "falloc"
> > +
> > +touch "$SCRATCH_MNT/f1"
> > +awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
> > +awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
> > +
> > +blocksize=$(_max "$awu_min_write" "$((awu_max_write/2))")
> > +threads=$(_min "$(($(nproc) * 2 * LOAD_FACTOR))" "100")
> > +filesize=$((blocksize * threads * 100))
> > +depth=$threads
> > +io_size=$((filesize / threads))
> > +io_inc=$io_size
> > +testfile=$SCRATCH_MNT/test-file
> > +
> > +fio_config=$tmp.fio
> > +fio_out=$tmp.fio.out
> > +
> > +fio_aw_config=$tmp.aw.fio
> > +fio_verify_config=$tmp.verify.fio
> > +
> > +function create_fio_configs()
> > +{
> > +	create_fio_aw_config
> > +	create_fio_verify_config
> > +}
> > +
> > +function create_fio_verify_config()
> > +{
> > +cat >$fio_verify_config <<EOF
> > +	[verify-job]
> > +	direct=1
> > +	ioengine=libaio
> > +	rw=read
> > +	bs=$blocksize
> > +	filename=$testfile
> > +	size=$filesize
> > +	iodepth=$depth
> > +	group_reporting=1
> > +
> > +	verify_only=1
> > +	verify=crc32c
> > +	verify_fatal=1
> > +	verify_state_save=0
> > +	verify_write_sequence=0
> > +EOF
> > +}
> > +
> > +function create_fio_aw_config()
> > +{
> > +cat >$fio_aw_config <<EOF
> > +	[atomicwrite-job]
> > +	direct=1
> > +	ioengine=libaio
> > +	rw=randwrite
> > +	bs=$blocksize
> > +	filename=$testfile
> > +	size=$io_inc
> > +	offset_increment=$io_inc
> > +	iodepth=$depth
> > +	numjobs=$threads
> > +	group_reporting=1
> > +	atomic=1
> > +
> > +	verify_state_save=0
> > +	verify=crc32c
> > +	do_verify=0
> > +EOF
> > +}
> > +
> > +create_fio_configs
> > +_require_fio $fio_aw_config
> > +
> > +cat $fio_aw_config >> $seqres.full
> > +cat $fio_verify_config >> $seqres.full
> > +
> > +$XFS_IO_PROG -fc "falloc 0 $filesize" $testfile >> $seqres.full
> > +
> > +$FIO_PROG $fio_aw_config >> $seqres.full
> > +ret1=$?
> > +$FIO_PROG $fio_verify_config >> $seqres.full
> > +ret2=$?
> > +
> > +[[ $ret1 -eq 0 && $ret2 -eq 0 ]] || _fail "fio with atomic write failed"
> > +
> > +# success, all done
> > +echo Silence is golden
> > +status=0
> > +exit
> > diff --git a/tests/generic/1226.out b/tests/generic/1226.out
> > new file mode 100644
> > index 00000000..6dce0ea5
> > --- /dev/null
> > +++ b/tests/generic/1226.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 1226
> > +Silence is golden
> > -- 
> > 2.49.0
> > 
> 


