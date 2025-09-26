Return-Path: <linux-ext4+bounces-10449-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3589BA541E
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 23:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD07560F53
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 21:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B6329B764;
	Fri, 26 Sep 2025 21:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="iaE6z++8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8473A298CC7
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923309; cv=none; b=dLGlmzvM7htvrxDaiIsuXsgYQ31C89yvDE58/QK0ECTFhCZPsh2Me8nvtrfCZb7MccD5aZO7GdM2PTVlhKC69XeTNJdginS0lyfnizn2rHV+M8AfMnfcGRGn9mU6mSRtBMOPbGr4EcDZQjxgZJN82kiL+shK8zI7ePwH6A25zsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923309; c=relaxed/simple;
	bh=m5/OqLT6x5K24PhOXYBlAZufrp4VWcqji9U2+ddgpxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFzgJGzKs0oUt6V2QctfmeKR6vBT/WxgpvdRd718Mdo3tNXsgXU+C2CSThc1+wSoFae4s83Z3YQ3TjLI+4XDxHiAvp7+TCHBxbA1OBJdztpAbNsmO9lJfk41ovTO7xaAWSmDTKcafEAW1eY3hsXpT102uO7/WO0CbDSSGI6xRvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=iaE6z++8; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58QLltkb014729
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 17:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758923278; bh=22Tu3dHksswvo7GDCKeMq4Nb39dOJqLAhaYHdfeYz4M=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=iaE6z++88ugL4DOY6pzJE4ltuJW0sdMHUKzHjm5fcYAXGCDPCYMIc+33ezKQ0JNjk
	 o1KVoSnDrI7mAQ5btnu+ip4ZPfQ2CDEkt16CB3TSAbElj0NKOOsEibptidjkVnN+YA
	 wAMlrn71T1tUETyQgm8R7EYUZau+OZi/8aFipRPs26fLKulyskJ97ihAsLj10jHiQG
	 gDlqdpTMfMEa+7upENLQNFQngsgUsGnXiET8HHOpKd0gBva+ose7iV3fTuoy8sOHb1
	 kzx4+DQ4oM22W3/z5aiGAlBX+3NtOl93Q/i/Zeo4JXi2ByIPfDZbC+jW+DWFDfRf8w
	 1xMNZPCdXoXCQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E594E2E00E1; Fri, 26 Sep 2025 17:47:53 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, libaokun1@huawei.com,
        syzbot+1713b1aa266195b916c2@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix potential null deref in ext4_mb_init()
Date: Fri, 26 Sep 2025 17:47:42 -0400
Message-ID: <175892300640.128029.5686356472247725279.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250825033830.2230202-1-libaokun@huaweicloud.com>
References: <20250825033830.2230202-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 25 Aug 2025 11:38:30 +0800, libaokun@huaweicloud.com wrote:
> In ext4_mb_init(), ext4_mb_avg_fragment_size_destroy() may be called
> when sbi->s_mb_avg_fragment_size remains uninitialized (e.g., if groupinfo
> slab cache allocation fails). Since ext4_mb_avg_fragment_size_destroy()
> lacks null pointer checking, this leads to a null pointer dereference.
> 
> ==================================================================
> EXT4-fs: no memory for groupinfo slab cache
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> PGD 0 P4D 0
> Oops: Oops: 0002 [#1] SMP PTI
> CPU:2 UID: 0 PID: 87 Comm:mount Not tainted 6.17.0-rc2 #1134 PREEMPT(none)
> RIP: 0010:_raw_spin_lock_irqsave+0x1b/0x40
> Call Trace:
>  <TASK>
>  xa_destroy+0x61/0x130
>  ext4_mb_init+0x483/0x540
>  __ext4_fill_super+0x116d/0x17b0
>  ext4_fill_super+0xd3/0x280
>  get_tree_bdev_flags+0x132/0x1d0
>  vfs_get_tree+0x29/0xd0
>  do_new_mount+0x197/0x300
>  __x64_sys_mount+0x116/0x150
>  do_syscall_64+0x50/0x1c0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> ==================================================================
> 
> [...]

Applied, thanks!

[1/1] ext4: fix potential null deref in ext4_mb_init()
      commit: 3c3fac6bc0a9c00dbe65d8dc0d3a282afe4d3188

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

