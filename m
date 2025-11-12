Return-Path: <linux-ext4+bounces-11797-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 482A5C5051A
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 03:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 772834E66D6
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 02:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43AC17B50A;
	Wed, 12 Nov 2025 02:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HdaiMBT6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B3E43AA6;
	Wed, 12 Nov 2025 02:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762913956; cv=none; b=IBOYFtEUzi3D1UW3t2Rq0EtlenLz1Zt8mVyjw9CbSC57ovRdjrb4kDheLQdJSQwK/D+D1/2RoUFA0vJL2PgcPL/uqilRmc7oZaUcekSZPG+DYZ2/lDuZ+b5LuBeU2qlD+I0OsTbobYIkwLuyqcW8XZaHnk4g6fOL/A8vsgVwvCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762913956; c=relaxed/simple;
	bh=F8XxUIM3yIy+6z1yNTLw0RnKTrw4OdzsgB708h2dU5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K2LM/mETSyGYMm37Qn7++niMfBpbrr1Tx+LgrNcvK/woZeeN7JG3cRHKTno0DlwGB/r+br7mO8VFeqptwGldaaemsgqMkPqzP/n2TroBucr3dJFGN72xQLvpAGqGEHAP2dxB2DSYzmsieFXFBRpazYCxe+UDAyTlX8uUK1dUkD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HdaiMBT6; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=erUVTco8o2+hBJGvs1apSs9kGKtkqV621pqBIW0ytZQ=;
	b=HdaiMBT6EDnADITFKkJgS5J6D3dUMxPEQ7MXGTtp8xc+TjMfdjSxpM81renDgxNB49Sj7SaMK
	qaojQkzge/HVfNSIzPQ44PZ3+y3lFcItf6inMFyyUHdxACoccAmyQFDnCETCY65f3nnsH/4c9FT
	gK6+t8lZYf2LS+O0+EUqwHc=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d5n9C2hLGzcb01;
	Wed, 12 Nov 2025 10:17:19 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 51386140258;
	Wed, 12 Nov 2025 10:19:08 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 12 Nov
 2025 10:19:07 +0800
Message-ID: <44d3fbd7-1c53-4f94-a4c8-586873a47146@huawei.com>
Date: Wed, 12 Nov 2025 10:19:06 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/24] ext4: enable block size larger than page size
Content-Language: en-GB
To: Theodore Ts'o <tytso@mit.edu>
CC: <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <kernel@pankajraghav.com>,
	<mcgrof@kernel.org>, <ebiggers@kernel.org>, <willy@infradead.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	Baokun Li <libaokun1@huawei.com>, Baokun Li <libaokun@huaweicloud.com>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251111235452.GM2988753@mit.edu>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251111235452.GM2988753@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-12 07:54, Theodore Ts'o wrote:
> On Fri, Nov 07, 2025 at 10:42:25PM +0800, libaokun@huaweicloud.com wrote:
>> `kvm-xfstests -c ext4/all -g auto` has been executed with no new failures.
>> `kvm-xfstests -c ext4/64k -g auto` has been executed and no Oops was
>> observed, but allocation failures for large folios may trigger warn_alloc()
>> warnings.
> I'm seeing some new failures.  ext4/4k -g auto is running without any
> failures, but when I tried to run ext4/64, I got:
>
> ext4/64k: 607 tests, 16 failures, 101 skipped, 7277 seconds
>   Failures: ext4/033 generic/472 generic/493 generic/494 generic/495
>     generic/496 generic/497 generic/554 generic/569 generic/620
>     generic/636 generic/641 generic/643 generic/759 generic/760
>   Flaky: generic/251: 80% (4/5)
> Totals: 671 tests, 101 skipped, 79 failures, 0 errors, 6782s
>
> Some of the test failures may be because I was only using a 5G test
> and scratch device, and with a 64k block sze, that might be too small.
> But I tried using a 20G test device, and ext3/033 is still failing but
> with a different error signature:
>
>     --- tests/ext4/033.out      2025-11-06 22:04:13.000000000 -0500
>     +++ /results/ext4/results-64k/ext4/033.out.bad      2025-11-11 17:57:31.149710364 -0500
>     @@ -1,6 +1,8 @@
>      QA output created by 033
>      Figure out block size
>      Format huge device
>     +mount: /vdf: fsconfig() failed: Structure needs cleaning.
>     +       dmesg(1) may have more information after failed mount system call.
>
>
> I took a look at the generc/472 and that appears to be a swap on file failure:
>
> root@kvm-xfstests:~# /vtmp/mke2fs.static -t ext4 -b 65536 -Fq /dev/vdc
> Warning: blocksize 65536 not usable on most systems.
> /dev/vdc contains a ext4 file system
>         created on Tue Nov 11 18:02:13 2025
> root@kvm-xfstests:~# mount /dev/vdc /vdc
> root@kvm-xfstests:~# fallocate -l 1G /vdc/swap
> root@kvm-xfstests:~# mkswap /vdc/swap
> mkswap: /vdc/swap: insecure permissions 0644, fix with: chmod 0600 /vdc/swap
> Setting up swapspace version 1, size = 1024 MiB (1073737728 bytes)
> no label, UUID=a6298248-abf1-42a1-b124-2f6b3be7f597
> root@kvm-xfstests:~# swapon /vdc/swap
> swapon: /vdc/swap: insecure permissions 0644, 0600 suggested.
> swapon: /vdc/swap: swapon failed: Invalid argument
> root@kvm-xfstests:~# 
>
> A number of the other tests (generic/493, generic/494, generic/495,
> generic/496, generic/497, generic/554) are all swapfile tests.
>
> I'm not sure why you're not seeing these issues; what version of
> xfstests are you using?  I recently uploaded a new test appliance[1]
> can you try rerunning your tests with the latest test appliance for
> kvm-xfstests?
>
> [1] https://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests;
>
> 					- Ted
>
I am using a slightly older version of xfstests, and when running the
64k tests I also encountered similar failures. The cover letter stated
"no Oops" for the 64k tests rather than "no new failures," meaning that
some cases did fail, but no severe issues such as BUG_ON or softlock
were observed.

I had been traveling frequently and didn’t have time to analyze.
In October, Pankaj asked about ext4 LBS progress and offered to help with
testing/review once the patches were out, so I rebased the existing code
and sent it out.

The analysis of the failing cases has been ongoing, but it keeps getting
interrupted by various high‑priority internal tasks. In the next few days
I will make time to analyze the failing cases and optimize the checksum
performance issues introduced by large blocks.

Below are my previous 64k test results:

-------------------- Summary report
KERNEL:    kernel 6.18.0-rc4-xfstests-00041-g13ad1f4f1378 #1007 SMP
PREEMPT_DYNAMIC Tue Nov 11 16:55:01 CST 2025 x86_64
CPUS:      2
MEM:       7944.36

ext4/64k: 563 tests, 20 failures, 81 skipped, 4992 seconds
  Failures: ext4/033 ext4/048 generic/219 generic/251 generic/436
    generic/472 generic/493 generic/494 generic/495 generic/496
    generic/497 generic/554 generic/563 generic/569 generic/620
    generic/636 generic/641 generic/643
  Flaky: generic/320: 80% (4/5)   generic/347: 60% (3/5)
Totals: 643 tests, 81 skipped, 97 failures, 0 errors, 4652s

FSTESTVER: blktests 698f1a0 (Mon, 27 May 2024 11:30:36 +0900)
FSTESTVER: fio  fio-3.28 (Wed, 8 Sep 2021 08:59:48 -0600)
FSTESTVER: fsverity v1.6 (Wed, 20 Mar 2024 21:21:46 -0700)
FSTESTVER: libaio   libaio-0.3.108-81-g1b18bfa (Mon, 28 Mar 2022 11:30:33
-0400)
FSTESTVER: quota  v4.05-43-gd2256ac (Fri, 17 Sep 2021 14:04:16 +0200)
FSTESTVER: xfsprogs v5.13.0 (Fri, 20 Aug 2021 12:03:57 -0400)
FSTESTVER: xfstests-bld 1bdd10a-dirty (Fri, 3 May 2024 16:14:41 -0400)
FSTESTVER: xfstests v2024.05.12 (Sun, 12 May 2024 20:28:48 +0800)
FSTESTCFG: ext4/64k
FSTESTSET: -g auto
FSTESTOPT: aex
Truncating test artifacts in /results to 31k


Cheers,
Baokun


