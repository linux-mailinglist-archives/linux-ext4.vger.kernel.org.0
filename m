Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C65EFD75E
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2019 08:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfKOHw0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Nov 2019 02:52:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfKOHwZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 15 Nov 2019 02:52:25 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B27320728;
        Fri, 15 Nov 2019 07:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573804345;
        bh=PQfPR+FZ6jihkmna027uut6XxBFhD/ojnqO3rcro98o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5BgGa9t7DmBavNl7EHZG0ZjGRdUFa4/0Rkpnu7vYWvfqdp4pRVEwyzdXf85C6eMZ
         gX+QAaWJUvkle1M47HPJqbCo5pEnk/AHmvPqfOI8kuT7KtX75czCxusGYM0D/FScf2
         8fP52OgPDI5xUn7xMaf5D3WHTmcd057JVoJ1G8Kc=
Date:   Thu, 14 Nov 2019 23:52:23 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 20/25] jbd2: Reserve space for revoke descriptor blocks
Message-ID: <20191115075223.GA152352@sol.localdomain>
Mail-Followup-To: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
References: <20191003215523.7313-1-jack@suse.cz>
 <20191105164437.32602-20-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105164437.32602-20-jack@suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 05, 2019 at 05:44:26PM +0100, Jan Kara wrote:
>  static inline int jbd2_handle_buffer_credits(handle_t *handle)
>  {
> -	return handle->h_buffer_credits;
> +	journal_t *journal = handle->h_transaction->t_journal;
> +
> +	return handle->h_buffer_credits -
> +		DIV_ROUND_UP(handle->h_revoke_credits_requested,
> +			     journal->j_revoke_records_per_block);
>  }

This patch is causing a crash with 'kvm-xfstests -c dioread_nolock ext4/024'.
Looks like this code incorrectly assumes that h_transaction is always valid
rather than the other member of the union, h_journal.


BUG: kernel NULL pointer dereference, address: 0000000000000614
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] SMP
CPU: 1 PID: 105 Comm: kworker/u4:3 Not tainted 5.4.0-rc3-00020-gfdc3ef882a5d #18
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20191013_105130-anatol 04/01/2014
Workqueue: ext4-rsv-conversion ext4_end_io_rsv_work
RIP: 0010:jbd2_handle_buffer_credits include/linux/jbd2.h:1656 [inline]
RIP: 0010:__ext4_journal_start_reserved+0x38/0x1f0 fs/ext4/ext4_jbd2.c:122
Code: 83 ec 10 48 81 ff ff 0f 00 00 89 75 d4 89 55 d0 0f 86 f5 00 00 00 48 8b 07 49 89 fc 48 8b 5d 08 4c 8b a8 40 07 00 6
RSP: 0018:ffffc90000457d40 EFLAGS: 00010296
RAX: 0000000000000038 RBX: ffffffff812e68fb RCX: 000000000000000c
RDX: 000000000000000b RSI: 000000000000137f RDI: ffff8880779c5468
RBP: ffffc90000457d78 R08: 0000000000001000 R09: 0000000000001000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880779c5468
R13: ffff88807b726000 R14: ffff8880779ad9e8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88807fd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000614 CR3: 000000007a0dd000 CR4: 00000000003406e0
Call Trace:
 ext4_convert_unwritten_extents+0x8b/0x250 fs/ext4/extents.c:4991
 ext4_end_io fs/ext4/page-io.c:152 [inline]
 ext4_do_flush_completed_IO fs/ext4/page-io.c:226 [inline]
 ext4_end_io_rsv_work+0x11a/0x1f0 fs/ext4/page-io.c:240
 process_one_work+0x227/0x5b0 kernel/workqueue.c:2269
 worker_thread+0x4b/0x3c0 kernel/workqueue.c:2415
 kthread+0x125/0x140 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
CR2: 0000000000000614
---[ end trace d8eaf4e1225480d5 ]---
