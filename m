Return-Path: <linux-ext4+bounces-6860-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34C9A667A3
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 04:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA173B6FC2
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 03:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C251D54E9;
	Tue, 18 Mar 2025 03:42:14 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74771C760A
	for <linux-ext4@vger.kernel.org>; Tue, 18 Mar 2025 03:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269334; cv=none; b=l1AQC+vQ67wW03G7i5UjMNjbjsYLziuV9MRT70dFbbwcPKlFpxVD6W8ZqKtbadRBFiqCcpPbvX/mpES3sXZPVuEVDsmSYWRVfUa+SkX0sEECHltQSTv2SUk9/BWfhH0Ks60IE/mNRHLaSGkTDh7Ky+883q470tRrQm3yu+DEyWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269334; c=relaxed/simple;
	bh=M02+olF4NJ9yQgaJ2zx5CBVNS7t1wpOOVIBK3+6JIHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDIALiakopSb03+h9oJRfl5RZ/ZROTWLBShWfQS4nXApJ9a0SY6PN5Bt9a/vei5nyI6xWAj7RKWio5wKsPJgrYdZAeTO30vJt6R8o/b+9AXoKnsFSuTNf1mKNQUAnk8RynCiZ/w8X+3A90mBIyOqaL97agUjCkWYga8/VZy4sDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3flCp012128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:48 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id DBC162E0112; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        bfoster@redhat.com, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH] ext4: goto right label 'out_mmap_sem' in ext4_setattr()
Date: Mon, 17 Mar 2025 23:41:20 -0400
Message-ID: <174226639136.1025346.16724513902690237266.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213112247.3168709-1-libaokun@huaweicloud.com>
References: <20250213112247.3168709-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 13 Feb 2025 19:22:47 +0800, libaokun@huaweicloud.com wrote:
> Otherwise, if ext4_inode_attach_jinode() fails, a hung task will
> happen because filemap_invalidate_unlock() isn't called to unlock
> mapping->invalidate_lock. Like this:
> 
> EXT4-fs error (device sda) in ext4_setattr:5557: Out of memory
> INFO: task fsstress:374 blocked for more than 122 seconds.
>       Not tainted 6.14.0-rc1-next-20250206-xfstests-dirty #726
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:fsstress state:D stack:0     pid:374   tgid:374   ppid:373
>                                   task_flags:0x440140 flags:0x00000000
> Call Trace:
>  <TASK>
>  __schedule+0x2c9/0x7f0
>  schedule+0x27/0xa0
>  schedule_preempt_disabled+0x15/0x30
>  rwsem_down_read_slowpath+0x278/0x4c0
>  down_read+0x59/0xb0
>  page_cache_ra_unbounded+0x65/0x1b0
>  filemap_get_pages+0x124/0x3e0
>  filemap_read+0x114/0x3d0
>  vfs_read+0x297/0x360
>  ksys_read+0x6c/0xe0
>  do_syscall_64+0x4b/0x110
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [...]

Applied, thanks!

[1/1] ext4: goto right label 'out_mmap_sem' in ext4_setattr()
      commit: 6b7e17cd4534688c341e900b9a2e42f307a3ff9c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

