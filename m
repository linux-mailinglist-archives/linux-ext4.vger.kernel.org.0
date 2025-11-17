Return-Path: <linux-ext4+bounces-11875-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FB7C65E8C
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 20:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1856E4EE31E
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 19:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D900F335579;
	Mon, 17 Nov 2025 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="WAJ34Y9d"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68B832B983
	for <linux-ext4@vger.kernel.org>; Mon, 17 Nov 2025 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406850; cv=none; b=RGjoma6Ifpk24M4yYUJUUk9vybkn+cjv97iotph1rkR7Bkv8Dt6j+uUnwMKXU0XQIwyY3d8jqDo9685bTHd1FKSRic/3vcwuGSBzYRyKd+CcTVxgWm4ZQNks5/8MMEsew6FKduKVQ/t/3fFioJptVM6YKXtnfWu6J+bJ4RJSFFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406850; c=relaxed/simple;
	bh=v/AM8lu1Hd0e3k8IdaKj2+LYJrB5hdATwG1mMe61YUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IB4n3mxvf0kFjAwm/UK/J5AXsEOJWwuPsO4OrSava5GRnXHt4Kn8lDcz14S3J+H+U8T3ZlVjLtpqc129Yse03C1185ITbwd+7Yn7Xl1fve/EZFG15RYvxf70E+W+bw4ZrmXYXHIH41hHEczKoL/pFFZcK9XtcYf6Ff9NsTR7Slg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=WAJ34Y9d; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-69.bstnma.fios.verizon.net [173.48.114.69])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AHJDrZ8020646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 14:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1763406835; bh=tlTfq5iaexxKtq8zI6sEHw1fINOzvwE2AJLyAcQp7Hc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=WAJ34Y9dCIgn+2t9X5Q0a5g88QYMgU8wDEXbNx0213CIadorgAD22sknoeBnHg0A6
	 ZGfskQnj1PxtDFL0/5ZvnPsgR03smurpAXex9IYaFudrLs0ru6uExMV/HXWDJpxRC0
	 3HVrzWkpNmclm6kZDvK2vJ6qkX0b2kO1PHCOfExXswgUHZ/QlgoGgzGzRM6D+yVSaF
	 mN4Eud6JQSQ1t+4vQj77N4qaELjjM82jQbqIjatbXAeG7Rsp0HcuQiXXYBLKMIDim1
	 sUUasJ7wf/Lvdq2Oh8SxpwrO+dGmY39tL5KNMC7ZpxUjrWZYHMVye7dkqoCoYwomqm
	 CvGg0LaoDtsNA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 4E2E92E00E1; Mon, 17 Nov 2025 14:13:50 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Ye Bin <yebin@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz
Subject: Re: [PATCH] jbd2: avoid bug_on in jbd2_journal_get_create_access() when file system corrupted
Date: Mon, 17 Nov 2025 14:13:38 -0500
Message-ID: <176340680643.138575.8219491937585883167.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025072657.307851-1-yebin@huaweicloud.com>
References: <20251025072657.307851-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 25 Oct 2025 15:26:57 +0800, Ye Bin wrote:
> There's issue when file system corrupted:
> ------------[ cut here ]------------
> kernel BUG at fs/jbd2/transaction.c:1289!
> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 5 UID: 0 PID: 2031 Comm: mkdir Not tainted 6.18.0-rc1-next
> RIP: 0010:jbd2_journal_get_create_access+0x3b6/0x4d0
> RSP: 0018:ffff888117aafa30 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: ffff88811a86b000 RCX: ffffffff89a63534
> RDX: 1ffff110200ec602 RSI: 0000000000000004 RDI: ffff888100763010
> RBP: ffff888100763000 R08: 0000000000000001 R09: ffff888100763028
> R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff88812c432000 R14: ffff88812c608000 R15: ffff888120bfc000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f91d6970c99 CR3: 00000001159c4000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  __ext4_journal_get_create_access+0x42/0x170
>  ext4_getblk+0x319/0x6f0
>  ext4_bread+0x11/0x100
>  ext4_append+0x1e6/0x4a0
>  ext4_init_new_dir+0x145/0x1d0
>  ext4_mkdir+0x326/0x920
>  vfs_mkdir+0x45c/0x740
>  do_mkdirat+0x234/0x2f0
>  __x64_sys_mkdir+0xd6/0x120
>  do_syscall_64+0x5f/0xfa0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [...]

Applied, thanks!

[1/1] jbd2: avoid bug_on in jbd2_journal_get_create_access() when file system corrupted
      commit: 7b44f6f9e12a97bf3456bf8ad789ee495c820884

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

