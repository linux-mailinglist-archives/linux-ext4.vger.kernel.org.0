Return-Path: <linux-ext4+bounces-9172-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18303B0FF5B
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jul 2025 05:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317291CC25AF
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jul 2025 03:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756E51EB195;
	Thu, 24 Jul 2025 03:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xvb4+9C/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D721A2387;
	Thu, 24 Jul 2025 03:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753329320; cv=none; b=o+pF4tKT6hpO9P/3ynlPxaWTZ8iasMEJTQEoW3VFZBTnaBh7Hs5U6Tn5iXJEHQFZetpIsjr5C+ENMhoceEB9Dolk7TfQ+9hp5rBOc1Ayp1jc8UBaL8UtKfUqmgt+UiWCI/SGMaOwfuaguILU80QdODWN+vr4l3x7MMComIGSC44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753329320; c=relaxed/simple;
	bh=tOqksm82bwOY6xDbNlES4VhEBKhyUKsREkfBERA7D6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUueynQDwq6+D5gtQVOFf9mlrrtRycmr0842xwk01zdnM8HE5kBJFBrri1ggqEvg9njD9VQH9oCKoVEV8L9HqXEvN6QBY0TLMpmBEyzK+yS5DFTmwvYKnNJqQLhqxUAp1QSfv2ByIIzxVUmqU8AUVL8lwh+4iiz1gkKTQOSGxFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xvb4+9C/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2353a2bc210so4175275ad.2;
        Wed, 23 Jul 2025 20:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753329316; x=1753934116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+S3lXqv6O036/tRErg3G3TDN2SOUuUUV1O505/5IKc=;
        b=Xvb4+9C/44HNHXKtJWL2cA8x2IG6RNCzJei2gy9rmlr0Y6aHgu2Sx/XME/ftIKy9iE
         QW1gE0ea8pajX/LEBDtRqh7UPLm40WOcWFWpuWgQJyfD4GU6MX06n/jGmIRB2dcO6xHC
         k973nM9B2uoQPBhesiqf36AoPe4FbtSgANnbWlVyV/DtuDdEVZFndPEpyYxedFrJSPUN
         xs12qmbGyJnX9iNUd4zf84gpPxbmTbJY7UsJaQSgm7G9KEebYp8H/m0xU9OVfHT5k6qq
         hnKzf1HWpc/0KRr9RJS7Uir5KjSWTUf28U3K6qsNJJ5+Z9zGtYpK9AGhOQV11jNEOfDU
         ucDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753329316; x=1753934116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+S3lXqv6O036/tRErg3G3TDN2SOUuUUV1O505/5IKc=;
        b=GzrX/mja56HwcIfnqdMguXlCjYJDkuxjMGpinc9WVyXUqbd/LKhLSkqVOiqH8/ofRl
         JeJLf4AykOsUpSLpckLim2qiLMNgms6dM0OFsWy6uT+0znofOYbEqcH+Sa77IQVUsOcx
         25mpIXVcNL/Y8/WRG+/Kn0voKXvvKPzzyqa7YuLTHmuBKJwPerUKQOev3Zi6iDi11oUO
         QaTxQ16uO0QO30CZXE9SsAbP1a/bTsBCt4nsJfsADkvb8rFsqAT7n18GHuevcuwEu0K8
         DQgQebkSu+lUzc8DwrpD5dkWc4g57uxJlzTcITtrP/NFS+A19qOv4xm8BWZ1dF7kDFb8
         5TMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8c/CY9WTXD4BLzzwSxzv27zEx3kuReFa0wMt4e8wqzOVbdm4afw9xNywXr78ggtUqDlsseWqjyzL3vqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjoFJ563S1laGTodGNIUoGcEUpvWS1rilCLhCTW9c+ZXv3pIBM
	Tj8pwuEh22x6f3uf2Tzb9HKRQkHPD95eSK5+2oI9M7DzaFowLeXb2M4UG9gnkg==
X-Gm-Gg: ASbGncsQbcL0Mtqi+vCVG6GL+ffjpmjE5HCZ+MnfoTmdiKFXrJMvhNrcQSuF3aNvNmk
	ZIdR5iz3ms8XqcVkqGz/yTgstAx+1qaJ7UChJ+1FQ1NeWOprC2Ab7A1btHILy+XKJhGiJ31z7TV
	dR2WyXpfDjyyNn0V1sQCAT4BjCy/+uvykOAcqZ9AEZOMeCs8rjCKkTADuEZKSXKS0vtKLgFM0d/
	gIzNUurpvRsworyyGw7IezEoqzj0JZhZY3GEErE6p4NGBm7ZxoD/XOlorDBRoMTWOcD5XfnBRIz
	NarD/HNUee65R9e2I7cxmOw5d8km2aoi2Y/DcScWQKHfk2Voj7mIJpaFnoufCoQXxwe2X2PeOwq
	dGc1pRcSLRZ6yr5IbGgtEMgib/GVK/wFMdSI=
X-Google-Smtp-Source: AGHT+IEM/xFb3ChCULrB18y9wndScLgkt1tPlja/tjC3/fjLw9KWtgpq2d1PZ3h+YG1/n7XZYCwjRg==
X-Received: by 2002:a17:903:b87:b0:234:9670:cc73 with SMTP id d9443c01a7336-23f981640cbmr73145385ad.5.1753329315803;
        Wed, 23 Jul 2025 20:55:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa47847c5sm4495815ad.75.2025.07.23.20.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 20:55:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 23 Jul 2025 20:55:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	julia.lawall@inria.fr, yi.zhang@huawei.com, yangerkun@huawei.com,
	libaokun@huaweicloud.com
Subject: Re: [PATCH v3 15/17] ext4: convert free groups order lists to xarrays
Message-ID: <b0635ad0-7ebf-4152-a69b-58e7e87d5085@roeck-us.net>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-16-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714130327.1830534-16-libaokun1@huawei.com>

Hi,

On Mon, Jul 14, 2025 at 09:03:25PM +0800, Baokun Li wrote:
> While traversing the list, holding a spin_lock prevents load_buddy, making
> direct use of ext4_try_lock_group impossible. This can lead to a bouncing
> scenario where spin_is_locked(grp_A) succeeds, but ext4_try_lock_group()
> fails, forcing the list traversal to repeatedly restart from grp_A.
> 

This patch causes crashes for pretty much every architecture when
running unit tests as part of booting.

Example (from x8_64) as well as bisect log attached below.

Guenter

---
...
[    9.353832]         # Subtest: test_new_blocks_simple
[    9.366711] BUG: kernel NULL pointer dereference, address: 0000000000000014
[    9.366931] #PF: supervisor read access in kernel mode
[    9.366993] #PF: error_code(0x0000) - not-present page
[    9.367165] PGD 0 P4D 0
[    9.367305] Oops: Oops: 0000 [#1] SMP PTI
[    9.367686] CPU: 0 UID: 0 PID: 217 Comm: kunit_try_catch Tainted: G                 N  6.16.0-rc7-next-20250722 #1 PREEMPT(voluntary)
[    9.367846] Tainted: [N]=TEST
[    9.367891] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    9.368063] RIP: 0010:ext4_mb_release+0x26e/0x510
[    9.368374] Code: 28 4a cb ff e8 03 5a cf ff 31 db 48 8d 3c 9b 48 83 c3 01 48 c1 e7 04 48 03 bd 60 05 00 00 e8 c9 a6 48 01 48 8b 85 68 03 00 00 <0f> b6 40 14 83 c0 02 39 d8 7f d6 48 8b bd 60 05 00 00 31 db e8 d9
[    9.368581] RSP: 0000:ffffb33b8041fe40 EFLAGS: 00010286
[    9.368659] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[    9.368732] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff9a319e36
[    9.368802] RBP: ffff8b89c3502400 R08: 0000000000000001 R09: 0000000000000000
[    9.368872] R10: 0000000000000001 R11: 0000000000000120 R12: ffff8b89c2f49160
[    9.368941] R13: ffff8b89c2f49158 R14: ffff8b89c2f24000 R15: ffff8b89c2f24000
[    9.369042] FS:  0000000000000000(0000) GS:ffff8b8a3381a000(0000) knlGS:0000000000000000
[    9.369127] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.369194] CR2: 0000000000000014 CR3: 0000000009a9c000 CR4: 00000000003506f0
[    9.369324] Call Trace:
[    9.369440]  <TASK>
[    9.369637]  mbt_kunit_exit+0x47/0xf0
[    9.369745]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
[    9.369813]  kunit_try_run_case_cleanup+0x2f/0x40
[    9.369865]  kunit_generic_run_threadfn_adapter+0x1c/0x40
[    9.369922]  kthread+0x10b/0x230
[    9.369965]  ? __pfx_kthread+0x10/0x10
[    9.370013]  ret_from_fork+0x165/0x1b0
[    9.370057]  ? __pfx_kthread+0x10/0x10
[    9.370099]  ret_from_fork_asm+0x1a/0x30
[    9.370188]  </TASK>
[    9.370250] Modules linked in:
[    9.370428] CR2: 0000000000000014
[    9.370657] ---[ end trace 0000000000000000 ]---
[    9.370791] RIP: 0010:ext4_mb_release+0x26e/0x510
[    9.370847] Code: 28 4a cb ff e8 03 5a cf ff 31 db 48 8d 3c 9b 48 83 c3 01 48 c1 e7 04 48 03 bd 60 05 00 00 e8 c9 a6 48 01 48 8b 85 68 03 00 00 <0f> b6 40 14 83 c0 02 39 d8 7f d6 48 8b bd 60 05 00 00 31 db e8 d9
[    9.370996] RSP: 0000:ffffb33b8041fe40 EFLAGS: 00010286
[    9.371050] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[    9.371112] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff9a319e36
[    9.371174] RBP: ffff8b89c3502400 R08: 0000000000000001 R09: 0000000000000000
[    9.371235] R10: 0000000000000001 R11: 0000000000000120 R12: ffff8b89c2f49160
[    9.371297] R13: ffff8b89c2f49158 R14: ffff8b89c2f24000 R15: ffff8b89c2f24000
[    9.371358] FS:  0000000000000000(0000) GS:ffff8b8a3381a000(0000) knlGS:0000000000000000
[    9.371428] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.371484] CR2: 0000000000000014 CR3: 0000000009a9c000 CR4: 00000000003506f0
[    9.371598] note: kunit_try_catch[217] exited with irqs disabled
[    9.371861]     # test_new_blocks_simple: try faulted: last line seen fs/ext4/mballoc-test.c:452
[    9.372123]     # test_new_blocks_simple: internal error occurred during test case cleanup: -4
[    9.372440]         not ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
[    9.375702] BUG: kernel NULL pointer dereference, address: 0000000000000014
[    9.375782] #PF: supervisor read access in kernel mode
[    9.375832] #PF: error_code(0x0000) - not-present page
[    9.375881] PGD 0 P4D 0 
[    9.375919] Oops: Oops: 0000 [#2] SMP PTI
[    9.375966] CPU: 0 UID: 0 PID: 219 Comm: kunit_try_catch Tainted: G      D          N  6.16.0-rc7-next-20250722 #1 PREEMPT(voluntary) 
[    9.376085] Tainted: [D]=DIE, [N]=TEST
[    9.376123] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    9.376220] RIP: 0010:ext4_mb_release+0x26e/0x510
[    9.376275] Code: 28 4a cb ff e8 03 5a cf ff 31 db 48 8d 3c 9b 48 83 c3 01 48 c1 e7 04 48 03 bd 60 05 00 00 e8 c9 a6 48 01 48 8b 85 68 03 00 00 <0f> b6 40 14 83 c0 02 39 d8 7f d6 48 8b bd 60 05 00 00 31 db e8 d9
[    9.376425] RSP: 0000:ffffb33b803f7e40 EFLAGS: 00010286
[    9.376482] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[    9.376546] RDX: 0000000002000008 RSI: ffffffff9a319e36 RDI: ffffffff9a319e36
[    9.376608] RBP: ffff8b89c352a400 R08: 0000000000000000 R09: 0000000000000000
[    9.376669] R10: 0000000000000000 R11: 0000000058d996d7 R12: ffff8b89c2f49cc0
[    9.376730] R13: ffff8b89c2f49cb8 R14: ffff8b89c3524000 R15: ffff8b89c3524000
[    9.376792] FS:  0000000000000000(0000) GS:ffff8b8a3381a000(0000) knlGS:0000000000000000
[    9.376861] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.376913] CR2: 0000000000000014 CR3: 0000000009a9c000 CR4: 00000000003506f0
[    9.376975] Call Trace:
[    9.377004]  <TASK>
[    9.377040]  mbt_kunit_exit+0x47/0xf0
[    9.377089]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
[    9.377150]  kunit_try_run_case_cleanup+0x2f/0x40
[    9.377207]  kunit_generic_run_threadfn_adapter+0x1c/0x40
[    9.377266]  kthread+0x10b/0x230
[    9.377308]  ? __pfx_kthread+0x10/0x10
[    9.377353]  ret_from_fork+0x165/0x1b0
[    9.377397]  ? __pfx_kthread+0x10/0x10
[    9.377439]  ret_from_fork_asm+0x1a/0x30
[    9.377505]  </TASK>
[    9.377531] Modules linked in:
[    9.377571] CR2: 0000000000000014
[    9.377609] ---[ end trace 0000000000000000 ]---

---
Bisect log:

# bad: [a933d3dc1968fcfb0ab72879ec304b1971ed1b9a] Add linux-next specific files for 20250723
# good: [89be9a83ccf1f88522317ce02f854f30d6115c41] Linux 6.16-rc7
git bisect start 'HEAD' 'v6.16-rc7'
# bad: [a56f8f8967ad980d45049973561b89dcd9e37e5d] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect bad a56f8f8967ad980d45049973561b89dcd9e37e5d
# bad: [f6a8dede4030970707e9bae5b3ae76f60df4b75a] Merge branch 'fs-next' of linux-next
git bisect bad f6a8dede4030970707e9bae5b3ae76f60df4b75a
# good: [b863560c5a26fbcf164f5759c98bb5e72e26848d] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
git bisect good b863560c5a26fbcf164f5759c98bb5e72e26848d
# bad: [690056682cc4de56d8de794bc06a3c04bc7f624b] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git
git bisect bad 690056682cc4de56d8de794bc06a3c04bc7f624b
# good: [fea76c3eb7455d1e941fba6fdd89ab41ab7797c8] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
git bisect good fea76c3eb7455d1e941fba6fdd89ab41ab7797c8
# bad: [714a183e8cf1cc1ddddb3318de1694a33f49c694] Merge branch 'dev' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
git bisect bad 714a183e8cf1cc1ddddb3318de1694a33f49c694
# good: [5fb60c0365c4dad347e4958f78976cb733d903f2] f2fs: Pass a folio to __has_merged_page()
git bisect good 5fb60c0365c4dad347e4958f78976cb733d903f2
# bad: [a8a47fa84cc2168b2b3bd645c2c0918eed994fc0] ext4: do not BUG when INLINE_DATA_FL lacks system.data xattr
git bisect bad a8a47fa84cc2168b2b3bd645c2c0918eed994fc0
# good: [a35454ecf8a320c49954fdcdae0e8d3323067632] ext4: use memcpy() instead of strcpy()
git bisect good a35454ecf8a320c49954fdcdae0e8d3323067632
# good: [3772fe7b4225f21a1bfe63e4a338702cc3c153de] ext4: convert sbi->s_mb_free_pending to atomic_t
git bisect good 3772fe7b4225f21a1bfe63e4a338702cc3c153de
# good: [12a5b877c314778ddf9a5c603eeb1803a514ab58] ext4: factor out ext4_mb_might_prefetch()
git bisect good 12a5b877c314778ddf9a5c603eeb1803a514ab58
# bad: [458bfb991155c2e8ba51861d1ef3c81c5a0846f9] ext4: convert free groups order lists to xarrays
git bisect bad 458bfb991155c2e8ba51861d1ef3c81c5a0846f9
# good: [6e0275f6e713f55dd3fc23be317ec11f8db1766d] ext4: factor out ext4_mb_scan_group()
git bisect good 6e0275f6e713f55dd3fc23be317ec11f8db1766d
# first bad commit: [458bfb991155c2e8ba51861d1ef3c81c5a0846f9] ext4: convert free groups order lists to xarrays

