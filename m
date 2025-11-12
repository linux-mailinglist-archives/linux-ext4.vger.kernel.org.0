Return-Path: <linux-ext4+bounces-11798-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90950C505C7
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 03:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402933B2CB3
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 02:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0132BE7B8;
	Wed, 12 Nov 2025 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="M47v9p3D"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57A022370D;
	Wed, 12 Nov 2025 02:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762915768; cv=none; b=AQBvC5wmRe2HkG1Z0etuNiz3qij+wuuxnnWTnDzP2sXhFd93638SIu3MOiYw6KzZYpDlKUaxtAyQgofRXAeUIPtYUwCcHu9UhE3VTAWLJ2yXFVbzcOUz06yiuuduePXisW9G5n7ec3bYLsNWpt5AgsrBLbpZW8w/PD+LbnnEWBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762915768; c=relaxed/simple;
	bh=NfccugIYhndvBb+kuG2+eYbKWwIe8Xj4KA5yc2Be1WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SvSTevMCdEhMAw9vxqm0kMcKqbCmSKPC5fcCp5YW06lnrM3zETqRxvasj+zy/GUh4ukoEuloYlAszDpi84m5VOHNB5Zu5QbD9Va8Gn2pi/zr4oR5WmSfYsHbkGx8taCGoNOzjtfFGjfHkekiI73a7VI4KeJ8uPnQy6aUWkWvVEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=M47v9p3D; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oomezv5sc04wZxicbFNiyan/N9zzELOXB6j+qKWz3nI=;
	b=M47v9p3DYz6SuLAwyRe2U5uCRcQjpCEDcLI6Hnml1M/ZYva8DEIQcZOhkO71mHkqKu9qrnN5g
	Xcpyrq02GQyhNtc897k60U9pNtZGAhRQ4UsxKvkoiNuwNlfwpq9I1B5oGXeXqov5Rk90o0QLldo
	AZ8yFehvDstHJSQjMVuMSY0=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d5nrQ1qCrz12LCr;
	Wed, 12 Nov 2025 10:47:50 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id EB831180495;
	Wed, 12 Nov 2025 10:49:21 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 12 Nov
 2025 10:49:20 +0800
Message-ID: <cd2201c9-ff7f-4cfd-acfc-2bba265b3a29@huawei.com>
Date: Wed, 12 Nov 2025 10:49:19 +0800
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
	<libaokun@huaweicloud.com>, Baokun Li <libaokun1@huawei.com>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251111235452.GM2988753@mit.edu>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251111235452.GM2988753@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

I checked the code of the swapon syscall in mm/swapfile.c, and currently
the swapfile does not support LBS. Therefore, some failing test cases can
be filtered out based on this.

         /*
          * The swap subsystem needs a major overhaul to support this.
          * It doesn't work yet so just disable it for now.
          */
         if (mapping_min_folio_order(mapping) > 0) {
                 error = -EINVAL;
                 goto bad_swap_unlock_inode;
         }

Regards,
Baokun

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


