Return-Path: <linux-ext4+bounces-1482-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E186986F5E8
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Mar 2024 16:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E26A1C21C67
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Mar 2024 15:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716F967C51;
	Sun,  3 Mar 2024 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJAHpDuY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB02EB09;
	Sun,  3 Mar 2024 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709480032; cv=none; b=RRNabbtXJkAFcl80m/MnEHZedLtAkCZP1vi7jamd+Rd+9jKvBDsSAkhSOWQyw0pS4W3dUJLx3ahZJsqxx/3e3haIR7YIGeUym3nALHLxSvGJ7n7xsHoZB4JUYzZug3odx2nUJ+PFAC4SRb8B3Uu5ssgxBYNjsgmOlHOgMCeLDIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709480032; c=relaxed/simple;
	bh=9TMtPtZa875t1qWUa0VbNWpX8F+scUMhYBKahdiVd3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mugujRQYcvLw/JQBc2szH4LHmD7HOyNUuPcmUQEWW4MtkiTlbBtpPkoi+Lv+tuF4pr0YhRiC8ARQPaPB4jul3PK4o4ksTAKPmdPnW2YUkVfFptrXC5/Enhv5Tdx8FtUsGvk4aiY9VsBd3OxSKK4tGCMPi+KNeLbO2G92UM6DulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJAHpDuY; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5dc949f998fso2771756a12.3;
        Sun, 03 Mar 2024 07:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709480029; x=1710084829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ohpXBVRypn++tCCdmJAr5wRr6MBH7Rj22h0m89S0UsM=;
        b=AJAHpDuYsBz/RQ/1fbpgfz6sYw8/hF4xCCGq+TBXkaIpNXl397sl6AfmwlBBy4rfz9
         q3nrOyWiTFM6gU3hh58rtTjyXKUmTV9CGfV9UaLLZYzQYclU4OLYSXzUYM63K4lwQelp
         soxrUaNfbqWwe3H9Ck/Ka58+9fmq1M0JPxX8xM4QB+bvKkseaU7hSY4H5z78s4TNK268
         nDFEVgOqqqYfrdQ2XXH+0qhA4UVGkZhL45R/Gsr8sB/C6rsuPhRejFcGMBO4SHbLfHho
         zbQFaSyOhULkRFbY/9NFwl+ChFJHdFotRUMaRUpouYISvvv4lRnvS8+lzJ0efFq4LA5h
         CYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709480029; x=1710084829;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohpXBVRypn++tCCdmJAr5wRr6MBH7Rj22h0m89S0UsM=;
        b=j6LlCfy+VxRuFhFZqIlCQ46gdqmOuHsL5kVblpG6CDWFtVHs7hRAfL/V+WjW6SYaZR
         WZHYMhOZfImq8x5nI+YnHyljch35RDtFATefFa9/E9E8+NH38Ab/KUE6GGSljap7HLPj
         oxoeTE2VE+BSG2Xsxed/wcSZG2wQVjJ/08z7zRL6Qc8GcCukrxenM3W6zuuNDhW5VVW1
         H0/DBVgzot4L91LsySgvcRDlzt38d1PGm2/qs/rkfwpFj9f4+GhJw2FTZHxzXJevuWQ3
         uffNauA5oKSrvGywAVBE1NNW5fOclEiAvnPonlpFjfhkrBcVL8qCT1o5Zs6uiFgJ+YD0
         6lxw==
X-Forwarded-Encrypted: i=1; AJvYcCU2QokMknbOL4O4R4nJ+Yaj4W90hP0iQSJyDC0YKsrCRC8Y0Qbpn9zSEW9TOFdXCJWhkyLZtWZy/cOfMBE9qz/4pF1jUu2OeNaVqwAC
X-Gm-Message-State: AOJu0Yz6vBVMAXQZCXmKTUsiRjOgpN7axcN8K3mmKZ4lBvBGHUgL5XaK
	N20D6KNoqMyq7ul46PTLWLMtx08kL2J3v1kcuwrnk0TlNQghlXSG
X-Google-Smtp-Source: AGHT+IFX9lDfrPj15XZiVaScxHvQVmym0s01iObRV4uyB5oWNEwAwRv8Zh3n0vBHg5JuZlIJNeo7ag==
X-Received: by 2002:a17:90a:8c89:b0:29b:242d:b123 with SMTP id b9-20020a17090a8c8900b0029b242db123mr4591761pjo.33.1709480029191;
        Sun, 03 Mar 2024 07:33:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id iq10-20020a17090afb4a00b0029ab73a80a2sm6329453pjb.22.2024.03.03.07.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 07:33:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <77c5b612-83f1-40b6-95f2-f3962bb2de5c@roeck-us.net>
Date: Sun, 3 Mar 2024 07:33:47 -0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Fix crashes and warning in ext4 unit test
Content-Language: en-US
To: Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
 adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 naresh.kamboju@linaro.org, daniel.diaz@linaro.org, brauner@kernel.org
References: <20240302181755.9192-1-shikemeng@huaweicloud.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240302181755.9192-1-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/2/24 10:17, Kemeng Shi wrote:
> v2->v3:
> -fix warning that sb->s_umount is still held when unit test finishs
> -fix warning that sbi->s_freeclusters_counter is used before
> initialization.
> 
> v1->v2:
> -properly handle error from sget()
> 
> Previously, the new mballoc unit tests are only tested by running
> "./tools/testing/kunit/kunit.py run ..." in which case only rare configs
> are enabled.
> This series fixes issues when more debug configs are enabled. Fixes are
> tested with and without kunit_tool [1].
> 
> [1] https://docs.kernel.org/dev-tools/kunit/run_manual.html
> 
> Kemeng Shi (3):
>    ext4: alloc test super block from sget
>    ext4: hold group lock in ext4 kunit test
>    ext4: initialize sbi->s_freeclusters_counter before use in kunit test
> 
>   fs/ext4/mballoc-test.c | 77 ++++++++++++++++++++++++++++++++----------
>   1 file changed, 60 insertions(+), 17 deletions(-)
> 

I still see crashes with this version. Some examples below.

Guenter

---
mips:

         KTAP version 1
         # Subtest: test_mark_diskspace_used
CPU 0 Unable to handle kernel paging request at virtual address 00780000, epc == 807a4b28, ra == 807a4c20
Oops[#1]:
CPU: 0 PID: 112 Comm: kunit_try_catch Tainted: G                 N 6.8.0-rc6-next-20240301-11397-g2cd922b7255b #1
Hardware name: mti,malta
$ 0   : 00000000 00000001 00780000 00000000
$ 4   : 811c6de0 00000000 00000001 00000000
$ 8   : 00000005 00000000 82f0cc00 00000001
$12   : ffffffff 00000002 00000000 fff80000
$16   : 82d99558 811c6de0 00000000 00000020
$20   : 811c0000 00000000 00000001 00000000
$24   : 00000000 80415884
$28   : 82f1c000 82f1f9f8 00000000 807a4c20
Hi    : 00000000
Lo    : 00002128
epc   : 807a4b28 percpu_counter_add_batch+0x7c/0x224
ra    : 807a4c20 percpu_counter_add_batch+0x174/0x224
Status: 1000a402	KERNEL EXL
Cause : 00800008 (ExcCode 02)
BadVA : 00780000
PrId  : 00019300 (MIPS 24Kc)
Modules linked in:
Process kunit_try_catch (pid: 112, threadinfo=82f1c000, task=82c2cec0, tls=00000000)
Stack : 82d99400 b332f3f3 00000000 b332f3f3 82f1fb20 811c0000 00000000 00000000
         811c0000 82d99400 82d63800 00000008 00000000 80414ac4 00000000 801a4aa4
         00000001 00000000 00000020 00000001 00000000 82f1fa70 00000000 00000023
         00000080 82f1fb20 82f1fb20 00000380 82c2cec0 00000000 00000000 b332f3f3
         82f1fae0 00000025 82d63800 821bbc08 00000001 00000001 821f12a8 82f0cc00
         ...
Call Trace:
[<807a4b28>] percpu_counter_add_batch+0x7c/0x224
[<80414ac4>] ext4_mb_mark_diskspace_used+0x25c/0x26c
[<80414ba4>] test_mark_diskspace_used+0xd0/0x308
[<806e8fe0>] kunit_try_run_case+0x70/0x204
[<806eb1dc>] kunit_generic_run_threadfn_adapter+0x1c/0x28
[<80162be0>] kthread+0x128/0x150
[<80103038>] ret_from_kernel_thread+0x14/0x1c
Code: 02242021  8c820000  00431021 <8c5e0000> 001e17c3  03d5a021  00523021  029e902b  02469021
---[ end trace 0000000000000000 ]---

Various arm emulations:
[    6.617298]         # Subtest: test_mark_diskspace_used
[    6.620243]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
[    6.622190] 8<--- cut here ---
[    6.622374] Unable to handle kernel paging request at virtual address 0a3f6000 when read
[    6.622549] [0a3f6000] *pgd=00000000
[    6.622960] Internal error: Oops: 5 [#1] SMP ARM
[    6.623138] Modules linked in:
[    6.623342] CPU: 0 PID: 187 Comm: kunit_try_catch Tainted: G                 N 6.8.0-rc6-next-20240301-11397-g2cd922b7255b #1
[    6.623573] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[    6.623738] PC is at percpu_counter_add_batch+0x2c/0x110
[    6.624171] LR is at percpu_counter_add_batch+0xa8/0x110



