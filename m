Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB1D590FB5
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Aug 2022 12:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbiHLKxH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Aug 2022 06:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiHLKxF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Aug 2022 06:53:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A689BB4C;
        Fri, 12 Aug 2022 03:53:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D727E3F795;
        Fri, 12 Aug 2022 10:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660301582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ksMK+v7c9pFYj4V3LWZUwU7PmRNjkBHqL7qOAp0N0NQ=;
        b=ktx0oOds6rrv8vfXHZttNxW9m5jJvHfvSgid++5zVjK0ht4eB7ozePe3o09Asck2Z9OAD1
        1TQEr5I/rkGorT82OVxT7ShQI0qOYZxDftXDSaKKjrliM1pD+f95vyq4XA9+NdlUtS6uzj
        yOi1fSxmRK53x1q4umF0Fnyo/DjYFVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660301582;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ksMK+v7c9pFYj4V3LWZUwU7PmRNjkBHqL7qOAp0N0NQ=;
        b=2iRH7sJthwiI2W+spiWLPPxnVwovM/kUmtDfJoMACCfLBaDGWkFGBppie+2YYP8taU66zl
        fFEhBT7FtN0eX8Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A5F713305;
        Fri, 12 Aug 2022 10:53:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NFwhEw4x9mKnZgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 12 Aug 2022 10:53:02 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id f69ccade;
        Fri, 12 Aug 2022 10:53:48 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     wenqingliu0120@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>,
        Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v2] ext4: fix bug in extents parsing when eh_entries == 0 and eh_depth > 0
Date:   Fri, 12 Aug 2022 11:53:47 +0100
Message-Id: <20220812105347.2251-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When walking through an inode extents, the ext4_ext_binsearch_idx() function
assumes that the extent header has been previously validated.  However, there
are no checks that verify that the number of entries (eh->eh_entries) is
non-zero when depth is > 0.  And this will lead to problems because the
EXT_FIRST_INDEX() and EXT_LAST_INDEX() will return garbage and result in this:

[  135.245946] ------------[ cut here ]------------
[  135.247579] kernel BUG at fs/ext4/extents.c:2258!
[  135.249045] invalid opcode: 0000 [#1] PREEMPT SMP
[  135.250320] CPU: 2 PID: 238 Comm: tmp118 Not tainted 5.19.0-rc8+ #4
[  135.252067] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
[  135.255065] RIP: 0010:ext4_ext_map_blocks+0xc20/0xcb0
[  135.256475] Code:
[  135.261433] RSP: 0018:ffffc900005939f8 EFLAGS: 00010246
[  135.262847] RAX: 0000000000000024 RBX: ffffc90000593b70 RCX: 0000000000000023
[  135.264765] RDX: ffff8880038e5f10 RSI: 0000000000000003 RDI: ffff8880046e922c
[  135.266670] RBP: ffff8880046e9348 R08: 0000000000000001 R09: ffff888002ca580c
[  135.268576] R10: 0000000000002602 R11: 0000000000000000 R12: 0000000000000024
[  135.270477] R13: 0000000000000000 R14: 0000000000000024 R15: 0000000000000000
[  135.272394] FS:  00007fdabdc56740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[  135.274510] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  135.276075] CR2: 00007ffc26bd4f00 CR3: 0000000006261004 CR4: 0000000000170ea0
[  135.277952] Call Trace:
[  135.278635]  <TASK>
[  135.279247]  ? preempt_count_add+0x6d/0xa0
[  135.280358]  ? percpu_counter_add_batch+0x55/0xb0
[  135.281612]  ? _raw_read_unlock+0x18/0x30
[  135.282704]  ext4_map_blocks+0x294/0x5a0
[  135.283745]  ? xa_load+0x6f/0xa0
[  135.284562]  ext4_mpage_readpages+0x3d6/0x770
[  135.285646]  read_pages+0x67/0x1d0
[  135.286492]  ? folio_add_lru+0x51/0x80
[  135.287441]  page_cache_ra_unbounded+0x124/0x170
[  135.288510]  filemap_get_pages+0x23d/0x5a0
[  135.289457]  ? path_openat+0xa72/0xdd0
[  135.290332]  filemap_read+0xbf/0x300
[  135.291158]  ? _raw_spin_lock_irqsave+0x17/0x40
[  135.292192]  new_sync_read+0x103/0x170
[  135.293014]  vfs_read+0x15d/0x180
[  135.293745]  ksys_read+0xa1/0xe0
[  135.294461]  do_syscall_64+0x3c/0x80
[  135.295284]  entry_SYSCALL_64_after_hwframe+0x46/0xb0

This patch simply adds an extra check in __ext4_ext_check(), verifying that
eh_entries is not 0 when eh_depth is > 0.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215941
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216283
Cc: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ext4/extents.c | 5 +++++
 1 file changed, 5 insertions(+)

Hi!

Baokun's feedback showed me that I had a partial understanding of the
problem.  Thus, I'm sending v2 which pretty much uses Baokun's suggestion
and simplifies the solution.  I've also added the link to the 2nd bugzilla
to the commit text.

Cheers,
--
Luís

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 53cfe2c681c4..a5457ac1999c 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -460,6 +460,11 @@ static int __ext4_ext_check(const char *function, unsigned int line,
 		error_msg = "invalid eh_entries";
 		goto corrupted;
 	}
+	if (unlikely((le16_to_cpu(eh->eh_entries) == 0) &&
+		     (le16_to_cpu(eh->eh_depth > 0)))) {
+		error_msg = "eh_entries is 0 but eh_depth is > 0";
+		goto corrupted;
+	}
 	if (!ext4_valid_extent_entries(inode, eh, lblk, &pblk, depth)) {
 		error_msg = "invalid extent entries";
 		goto corrupted;
