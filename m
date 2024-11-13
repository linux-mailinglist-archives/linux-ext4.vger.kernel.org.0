Return-Path: <linux-ext4+bounces-5139-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6887C9C7AF8
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Nov 2024 19:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E2CCB31C77
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Nov 2024 17:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A20F2076C3;
	Wed, 13 Nov 2024 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="KNWay5a1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2A6374C4
	for <linux-ext4@vger.kernel.org>; Wed, 13 Nov 2024 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520582; cv=none; b=RyHM2BaEH7665vIyIB9S7nYULCGhm0WdR4leuD3kWkpXcfpCwPy6eBzNjzMQ8BkGwRIL0zLuq2iRs3HNItPueu7Og47Q6T9bN+6+daoFAWbl+T32mEwWIRcfrBYj3y++ZdOz6kpl0Kw30JcW0x0iXr1X5P5DBy7Bn7Z1YOHwJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520582; c=relaxed/simple;
	bh=Nex7Zeg72PuYNv+hm6hFVE6glDn0PfzQ31r3OA3yWKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqJ1yTHTp+MsdeiB2skeTIy59FjfK5hXLRu91bcDqGlZeQV4umLGiBJe4yQon+gXgtH9k5chDDUuLiJ+Hy/au4CVDBS5pl3/Ug0oiLDg0bT96rVjzMzT8qu6g+RX66w32YFDzldRuIko3NZX31oUZBkUMK7K57jLFQK4Khmeuas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=KNWay5a1; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-117-59.bstnma.fios.verizon.net [173.48.117.59])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4ADHtoma028165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 12:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1731520554; bh=Svb2fKI98Sd3KdODxRInt7eHvOUvoi1YSJ5TUvj2dYw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=KNWay5a1VzoyntFkXQMrEJBX23twPLZFo8SXj+OB5XZzcz5IOW2zXpR9mgBGX0hsH
	 KPNWNsbPO/7VnOf50yrFT2TwuJIZx4WHSNxTICSVkp2daABW0z6kx/nu0UPDTB5ty0
	 iiaV9zsOBax5Ke8Fgk0cX0ExrbCwEmA1IQl5DjbhCnSbv0500N/yyFt/mDzvoCLNFF
	 f8KjhG3LM0VP1vgrEapef3c2x2H3YunhcJvG3qPgBA38iTs0HxPxVdTM6N74dXu5SM
	 x6FChQQYWzN6nj2a+R6SVrZwnqPtgS2W3pwq8rmIFfV7XhYVAXGUqdImXTnk4uM051
	 tYz6Jzz46MUIw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 5230715C0317; Wed, 13 Nov 2024 12:55:50 -0500 (EST)
Date: Wed, 13 Nov 2024 12:55:50 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>,
        Zhi Long <longzhi@sangfor.com.cn>
Subject: Re: [PATCH v3] ext4: Make sure BH_New bit is cleared in ->write_end
 handler
Message-ID: <20241113175550.GA462442@mit.edu>
References: <20241018145901.2086-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018145901.2086-1-jack@suse.cz>

On Fri, Oct 18, 2024 at 04:59:01PM +0200, Jan Kara wrote:
> Currently we clear BH_New bit in case of error and also in the standard
> ext4_write_end() handler (in block_commit_write()). However
> ext4_journalled_write_end() misses this clearing and thus we are leaving
> stale BH_New bits behind. Generally ext4_block_write_begin() clears
> these bits before any harm can be done but in case blocksize < pagesize
> and we hit some error when processing a page with these stale bits,
> we'll try to zero buffers with these stale BH_New bits and jbd2 will
> complain (as buffers were not prepared for writing in this transaction).
> Fix the problem by clearing BH_New bits in ext4_journalled_write_end()
> and WARN if ext4_block_write_begin() sees stale BH_New bits.
> 
> Reported-and-tested-by: Baolin Liu <liubaolin@kylinos.cn>
> Reported-and-tested-by: Zhi Long <longzhi@sangfor.com.cn>
> Fixes: 3910b513fcdf ("ext4: persist the new uptodate buffers in ext4_journalled_zero_new_buffers")
> Signed-off-by: Jan Kara <jack@suse.cz>

This patch is causing quite a lot of regressions:

ext4/adv: 569 tests, 36 failures, 61 skipped, 6510 seconds
  Failures: ext4/307 generic/069 generic/079 generic/082 generic/130 
    generic/131 generic/219 generic/230 generic/231 generic/232 
    generic/233 generic/234 generic/235 generic/241 generic/244 
    generic/270 generic/280 generic/355 generic/379 generic/381 
    generic/382 generic/400 generic/422 generic/464 generic/566 
    generic/571 generic/572 generic/587 generic/600 generic/601 
    generic/681 generic/682 generic/691

This appears to be caused by inline data, so a quick reproducer for
bisection purposes was:

   kvm-xfststs -c ext4/inline ext4/307

Attached below please find the warning which is triggering the
"_check_dmesg: something found in dmesg" test failure.

I suspect this should be fairly easy to fix, but I'm going to drop it
from my tree for now.

					- Ted

WARNING: CPU: 0 PID: 2473 at fs/ext4/inode.c:1059 ext4_block_write_begin+0x2f9/0x470
CPU: 0 UID: 0 PID: 2473 Comm: md5sum Not tainted 6.12.0-rc4-xfstests-00028-g9af1fa3b363b #437
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:ext4_block_write_begin+0x2f9/0x470
Code: 40 01 89 44 24 34 e9 c4 fe ff ff 49 8b 01 a8 08 0f 84 b9 fe ff ff 48 8b 03 a8 01 0f 85 ae fe ff ff f0 80 0b 01 e9 a5 fe ff ff <0f> 0b f0 80 23 df e9 12 fe ff ff 0f b7 10 66 81 e2 00 f0 66 81 fa
RSP: 0018:ffffc90003187cd8 EFLAGS: 00010202
RAX: 0000000000000133 RBX: ffff888007c70270 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 0000000000001000 RDI: ffff888007d39c88
RBP: 0000000000001000 R08: ffffffff81466c60 R09: ffffea00003b5940
R10: 0000000000000000 R11: 00000000000000c0 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000001000 R15: 0000000000000000
FS:  00007f337bc40740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562a05dff538 CR3: 000000000c9ba005 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? show_trace_log_lvl+0x1a5/0x2e0
 ? show_trace_log_lvl+0x1a5/0x2e0
 ? ext4_da_write_begin+0x153/0x270
 ? ext4_block_write_begin+0x2f9/0x470
 ? __warn.cold+0x8e/0xe8
 ? ext4_block_write_begin+0x2f9/0x470
 ? report_bug+0x123/0x190
 ? handle_bug+0x53/0x90
 ? exc_invalid_op+0x17/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? __pfx_ext4_da_get_block_prep+0x10/0x10
 ? ext4_block_write_begin+0x2f9/0x470
 ? ext4_block_write_begin+0x77/0x470
 ? __pfx_ext4_da_get_block_prep+0x10/0x10
 ext4_da_write_begin+0x153/0x270
 generic_perform_write+0xd7/0x290
 ext4_buffered_write_iter+0x64/0x100
 vfs_write+0x277/0x450
 ksys_write+0x6d/0xf0
 do_syscall_64+0x4b/0x110
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f337bd3b240
Code: 40 00 48 8b 15 c1 9b 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 23 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007fff53588b08 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000043 RCX: 00007f337bd3b240
RDX: 0000000000000043 RSI: 0000562a05df54d0 RDI: 0000000000000001
RBP: 0000562a05df54d0 R08: 00007f337bddd4e0 R09: 0000000000000078
R10: 00007fff53588a86 R11: 0000000000000202 R12: 0000000000000043
R13: 00007f337be16760 R14: 0000000000000043 R15: 00007f337be119e0
 </TASK>
---[ end trace 0000000000000000 ]---


