Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42A85E6633
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Sep 2022 16:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIVOxE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Sep 2022 10:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiIVOxD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Sep 2022 10:53:03 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C552B6003;
        Thu, 22 Sep 2022 07:53:02 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28MEqSEn028729
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 10:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1663858350; bh=GDLmN2exUPg23rDOR37my64BAlDSP4XeXzpLjZYrbaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lAiGIRmfYQr6VWl9SHkLt0sQEEcOoGvoNeqcBhuzNn+sTT9SAmEFaQbRIxv/8cc8p
         ywwye2Y67Yhvs48pjdGmVrvrKdSBU8b/TjbKX/mFeTQNEtST1T2B0RNFVk/oLIw3Hl
         VyMHffQ+aTduUXxS17KEMiJ+K24tH1mmq/C1QopFIumTpVfHJ0c2z0bhLtnRHCmHZv
         BeSaXswW2u2/1ad838PZ7qErJ9WBKpuamQwOZJin0Wt1EA15iHbezHNQch6sLY1JH0
         CdIkk9kKQPzifC1jVT9ictUIr2HB2MLIeuv1IfzQ5YAT2f2Wly4tCkpGEBQnK3AF9n
         NqHaDSOuY5DTQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 12D7115C526C; Thu, 22 Sep 2022 10:52:28 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, lhenriques@suse.de
Cc:     "Theodore Ts'o" <tytso@mit.edu>, libaokun1@huawei.com,
        wenqingliu0120@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ext4: fix bug in extents parsing when eh_entries == 0 and eh_depth > 0
Date:   Thu, 22 Sep 2022 10:52:27 -0400
Message-Id: <166385832826.2997827.14384118128769939622.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220822094235.2690-1-lhenriques@suse.de>
References: <20220822094235.2690-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 22 Aug 2022 10:42:35 +0100, Luís Henriques wrote:
> When walking through an inode extents, the ext4_ext_binsearch_idx() function
> assumes that the extent header has been previously validated.  However, there
> are no checks that verify that the number of entries (eh->eh_entries) is
> non-zero when depth is > 0.  And this will lead to problems because the
> EXT_FIRST_INDEX() and EXT_LAST_INDEX() will return garbage and result in this:
> 
> [  135.245946] ------------[ cut here ]------------
> [  135.247579] kernel BUG at fs/ext4/extents.c:2258!
> [  135.249045] invalid opcode: 0000 [#1] PREEMPT SMP
> [  135.250320] CPU: 2 PID: 238 Comm: tmp118 Not tainted 5.19.0-rc8+ #4
> [  135.252067] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
> [  135.255065] RIP: 0010:ext4_ext_map_blocks+0xc20/0xcb0
> [  135.256475] Code:
> [  135.261433] RSP: 0018:ffffc900005939f8 EFLAGS: 00010246
> [  135.262847] RAX: 0000000000000024 RBX: ffffc90000593b70 RCX: 0000000000000023
> [  135.264765] RDX: ffff8880038e5f10 RSI: 0000000000000003 RDI: ffff8880046e922c
> [  135.266670] RBP: ffff8880046e9348 R08: 0000000000000001 R09: ffff888002ca580c
> [  135.268576] R10: 0000000000002602 R11: 0000000000000000 R12: 0000000000000024
> [  135.270477] R13: 0000000000000000 R14: 0000000000000024 R15: 0000000000000000
> [  135.272394] FS:  00007fdabdc56740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
> [  135.274510] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  135.276075] CR2: 00007ffc26bd4f00 CR3: 0000000006261004 CR4: 0000000000170ea0
> [  135.277952] Call Trace:
> [  135.278635]  <TASK>
> [  135.279247]  ? preempt_count_add+0x6d/0xa0
> [  135.280358]  ? percpu_counter_add_batch+0x55/0xb0
> [  135.281612]  ? _raw_read_unlock+0x18/0x30
> [  135.282704]  ext4_map_blocks+0x294/0x5a0
> [  135.283745]  ? xa_load+0x6f/0xa0
> [  135.284562]  ext4_mpage_readpages+0x3d6/0x770
> [  135.285646]  read_pages+0x67/0x1d0
> [  135.286492]  ? folio_add_lru+0x51/0x80
> [  135.287441]  page_cache_ra_unbounded+0x124/0x170
> [  135.288510]  filemap_get_pages+0x23d/0x5a0
> [  135.289457]  ? path_openat+0xa72/0xdd0
> [  135.290332]  filemap_read+0xbf/0x300
> [  135.291158]  ? _raw_spin_lock_irqsave+0x17/0x40
> [  135.292192]  new_sync_read+0x103/0x170
> [  135.293014]  vfs_read+0x15d/0x180
> [  135.293745]  ksys_read+0xa1/0xe0
> [  135.294461]  do_syscall_64+0x3c/0x80
> [  135.295284]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> [...]

Applied, thanks!

[1/1] ext4: fix bug in extents parsing when eh_entries == 0 and eh_depth > 0
      commit: 29a5b8a137ac8eb410cc823653a29ac0e7b7e1b0

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
