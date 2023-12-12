Return-Path: <linux-ext4+bounces-410-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E04480F0ED
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 16:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E543FB21638
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 15:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154087A208;
	Tue, 12 Dec 2023 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="BErA8lGW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D400116
	for <linux-ext4@vger.kernel.org>; Tue, 12 Dec 2023 07:27:57 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-124-235.bstnma.fios.verizon.net [173.48.124.235])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3BCFRegc007567
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 10:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1702394862; bh=+cZLuddpb7RPMQIeRQtr6kT37n1c6Bs7cOCHk9I94Nc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=BErA8lGW+hsQLm1FAz9zm4XM6vAxb1t0kXnV6sXJ3cU3b+g3rKAnQgWkKcxt8c/If
	 RKsB2f8n2pYjCd8EYGM9t/0dCqk2ZSg/kLF4Cpwerw7RpjeV4NmBxQMBSJE/A1NyFz
	 y1MYvkAWcoXMvPjwnOwbwLrI0HqGAqJaaqNg1lolbp+pX5MHDsz8a1zsALAmLtJgGB
	 CRsUX8BjX4EKOEhF0FpQSKpRLdL6iCrwiw8QQzgv1KVStZ/+xWuULzD3f3YlLB4eTQ
	 pdyduiclMXkknypXDmeGGqxKy7KglTiRGML0KR5poGcAfV3ac5DCnlkWUaMRfQtUta
	 aE8FtdJLDKWlQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 6097715C143C; Tue, 12 Dec 2023 10:27:40 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH] jbd2: fix soft lockup in journal_finish_inode_data_buffers()
Date: Tue, 12 Dec 2023 10:27:36 -0500
Message-ID: <170239485205.146099.16489061724971760698.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211112544.3879780-1-yebin10@huawei.com>
References: <20231211112544.3879780-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 11 Dec 2023 19:25:44 +0800, Ye Bin wrote:
> There's issue when do io test:
> WARN: soft lockup - CPU#45 stuck for 11s! [jbd2/dm-2-8:4170]
> CPU: 45 PID: 4170 Comm: jbd2/dm-2-8 Kdump: loaded Tainted: G  OE
> Call trace:
>  dump_backtrace+0x0/0x1a0
>  show_stack+0x24/0x30
>  dump_stack+0xb0/0x100
>  watchdog_timer_fn+0x254/0x3f8
>  __hrtimer_run_queues+0x11c/0x380
>  hrtimer_interrupt+0xfc/0x2f8
>  arch_timer_handler_phys+0x38/0x58
>  handle_percpu_devid_irq+0x90/0x248
>  generic_handle_irq+0x3c/0x58
>  __handle_domain_irq+0x68/0xc0
>  gic_handle_irq+0x90/0x320
>  el1_irq+0xcc/0x180
>  queued_spin_lock_slowpath+0x1d8/0x320
>  jbd2_journal_commit_transaction+0x10f4/0x1c78 [jbd2]
>  kjournald2+0xec/0x2f0 [jbd2]
>  kthread+0x134/0x138
>  ret_from_fork+0x10/0x18
> 
> [...]

Applied, thanks!

[1/1] jbd2: fix soft lockup in journal_finish_inode_data_buffers()
      commit: 6c02757c936063f0631b4e43fe156f8c8f1f351f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

