Return-Path: <linux-ext4+bounces-9179-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B81B10E27
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jul 2025 16:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8780E7BF20A
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jul 2025 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72092E8DE0;
	Thu, 24 Jul 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ClxWL9Sv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53FE290BBD
	for <linux-ext4@vger.kernel.org>; Thu, 24 Jul 2025 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368929; cv=none; b=lnnymO8qt8iEs22GYBahMjLpdCA69LBefjNdKF/l4IYwMd9BnkcUoh2BpuVir2mGy6p0+t7tcAmJIV+/7XhugBmVWxLv2/CZgBpdg2PSSgzMh1GlVsZXivCae4GJ7Vg+bgaj1jvKYPP8HTtr64G2psNos9eRYTJqZgSKS2RX5V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368929; c=relaxed/simple;
	bh=sPsGN7Qb/+Y/5sE3AWrCFM2UEus9zyg40K6TGelXcfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alHVeZ2mtJS6Kh/yX1g50SaMTZa704Ilaqg2OB8cTwhoA775TqQJPsT6UL4zZS5iT/6lU5KX0mLAunmhR/HbIe26jvybyN7ohz6shgQfnahnUg+kuILnAR0UF0LboOTdco4MUtaGo3mJkXjl1fQPYBws67EcOrFJxT4kJSl5u9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ClxWL9Sv; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-116-187.bstnma.fios.verizon.net [173.48.116.187])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56OEsbti017097
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 10:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1753368880; bh=xa+rdEp+hMxDZzze8EJ4aixXZoX57nsn9R7KN50m97o=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ClxWL9Sv/tHO42U4dR+pgOdLTcjgsTvXS5tSX6Ad+QOptL93ecyZD1dF9yZ+jRasA
	 GETf+c29Q4XjOE0fWqBncGCFVehnI6rsXZHEl4CdxypwoQTpbPgyUKT8Ijrta/XwZA
	 LijUZYsk4K01GMEIiCD9KjQMfN1z9g7+UXBcfAoOrCtz+7eq0hAujAhJlosKOeV62m
	 32BTKNGqiTJzeMcbAlTmESKh/SeIIACiYE3PYn4kBnf7+IoZdSalCMgkhPT4kmWdjb
	 Hd4p9Ws0QchaQBq+dBX4aZwkIYFpt+yBY1AovuO6C1wMszSTMpUyJTcXiG8zh/451Y
	 ERsVoW41873Kg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B8AA82E00D5; Thu, 24 Jul 2025 10:54:37 -0400 (EDT)
Date: Thu, 24 Jul 2025 10:54:37 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huawei.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Baokun Li <libaokun1@huawei.com>,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        julia.lawall@inria.fr, yangerkun@huawei.com, libaokun@huaweicloud.com
Subject: Re: [PATCH v3 15/17] ext4: convert free groups order lists to xarrays
Message-ID: <20250724145437.GD80823@mit.edu>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-16-libaokun1@huawei.com>
 <b0635ad0-7ebf-4152-a69b-58e7e87d5085@roeck-us.net>
 <20250724045456.GA80823@mit.edu>
 <ef789a81-f326-4af6-8e9b-a13b5b20412b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef789a81-f326-4af6-8e9b-a13b5b20412b@huawei.com>

On Thu, Jul 24, 2025 at 07:14:58PM +0800, Zhang Yi wrote:
> 
> I'm sorry for this regression, we didn't run these tests.

No worries, I didn't run them either.

> Could you please try the following diff? I have tested it on my
> machine, and the issue does not recur. If every thing looks fine, I
> will send out the official patch.

This patch fixes the test bug which was causing the failure of
test_new_blocks_simple.

However, there is still test failure of test_mb_mark_used in the patch
series starting with bbe11dd13a3f ("ext4: fix largest free orders
lists corruption on mb_optimize_scan switch").  The test failure is
fixed by 458bfb991155 ("ext4: convert free groups order lists to
xarrays").  The reason why this is especialy problematic is that
commit which introduced the problem is marked as "cc: stable", which
means it will get back ported to LTS kernels, thus introducing a
potential bug.

One of the advantages of unit tests is that they are light weight
enough that it is tractable to run them against every commit in the
patch series.  So we should strive to add more unit tests, since it
makes easier to detect regressions.

Anyway, here's the stack trace staring with "ext4: fix largest free
orders lists corruption on mb_optimize_scan switch".  Could you
investigate this failure?  Many thanks!!

						- Ted

[09:35:46] ==================== test_mb_mark_used  ====================
[09:35:46] [ERROR] Test: test_mb_mark_used: missing subtest result line!
[09:35:46] 
[09:35:46] Pid: 35, comm: kunit_try_catch Tainted: G        W        N  6.16.0-rc4-00031-gbbe11dd13a3f-dirty
[09:35:46] RIP: 0033:mb_set_largest_free_order+0x5c/0xc0
[09:35:46] RSP: 00000000a0883d98  EFLAGS: 00010206
[09:35:46] RAX: 0000000060aeaa28 RBX: 0000000060a2d400 RCX: 0000000000000008
[09:35:46] RDX: 0000000060aea9c0 RSI: 0000000000000000 RDI: 0000000060864000
[09:35:46] RBP: 0000000060aea9c0 R08: 0000000000000000 R09: 0000000060a2d400
[09:35:46] R10: 0000000000000400 R11: 0000000060a9cc00 R12: 0000000000000006
[09:35:46] R13: 0000000000000400 R14: 0000000000000305 R15: 0000000000000000
[09:35:46] Kernel panic - not syncing: Segfault with no mm
[09:35:46] CPU: 0 UID: 0 PID: 35 Comm: kunit_try_catch Tainted: G        W        N  6.16.0-rc4-00031-gbbe11dd13a3f-dirty #36 NONE
[09:35:46] Tainted: [W]=WARN, [N]=TEST
[09:35:46] Stack:
[09:35:46]  60210c60 00000200 60a9e400 00000400
[09:35:46]  40060300280 60864000 60a9cc00 60a2d400
[09:35:46]  00000400 60aea9c0 60a9cc00 60aea9c0
[09:35:46] Call Trace:
[09:35:46]  [<60210c60>] ? ext4_mb_generate_buddy+0x1f0/0x230
[09:35:46]  [<60215c3b>] ? test_mb_mark_used+0x28b/0x4e0
[09:35:46]  [<601df5bc>] ? ext4_get_group_desc+0xbc/0x150
[09:35:46]  [<600bf1c0>] ? ktime_get_ts64+0x0/0x190
[09:35:46]  [<60086370>] ? to_kthread+0x0/0x40
[09:35:46]  [<602b559b>] ? kunit_try_run_case+0x7b/0x100
[09:35:46]  [<60086370>] ? to_kthread+0x0/0x40
[09:35:46]  [<602b7850>] ? kunit_generic_run_threadfn_adapter+0x0/0x30
[09:35:46]  [<602b7862>] ? kunit_generic_run_threadfn_adapter+0x12/0x30
[09:35:46]  [<60086a51>] ? kthread+0xf1/0x250
[09:35:46]  [<6004a541>] ? new_thread_handler+0x41/0x60
[09:35:46] [ERROR] Test: test_mb_mark_used: 0 tests run!
[09:35:46] ============= [NO TESTS RUN] test_mb_mark_used =============

