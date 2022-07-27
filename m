Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939D5582A15
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jul 2022 17:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiG0P6B (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 11:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiG0P6A (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 11:58:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6697C4A800
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 08:57:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E90E938CB1;
        Wed, 27 Jul 2022 15:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658937477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=JVqAzEf/D+efO+kouYPigcD9bqdwrgxkHJR6kR5wIbI=;
        b=wtJ9OWX6GMNuyH6wY5jOHdZxBkWNTfuy8F50mR3ZDigLs/caWaEexrGK8KEqW/g9bYr7wx
        mbOaeOyyP0KmSL6g8/GEPgD4wDPYISth2DVGZfaSJ8OtGcrsjerCgmHlK0G9AD7TEs+ehX
        kxcEmW31X6g71V0K0pinK5cw3Ml83HU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658937477;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=JVqAzEf/D+efO+kouYPigcD9bqdwrgxkHJR6kR5wIbI=;
        b=1sZz0iV+O1QmscgcTqSn14A0JUeV33so3Qb1mQdl705FppWjfZjHLtDt4xcuM+ssmvIOP2
        sTNxCc7BxoI8a3Cw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D1B262C141;
        Wed, 27 Jul 2022 15:57:57 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 96F56A0662; Wed, 27 Jul 2022 17:57:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        Jan Kara <jack@suse.cz>,
        syzbot+bd13648a53ed6933ca49@syzkaller.appspotmail.com
Subject: [PATCH] ext4: Avoid crash when inline data creation follows DIO write
Date:   Wed, 27 Jul 2022 17:57:53 +0200
Message-Id: <20220727155753.13969-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2719; h=from:subject; bh=fGCwJZJuDjwMzjZKtbX5AncMqg8uYGbkDaNRnjzNW9A=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBi4WBwBQTIM0wyMEhHFEGL07OvKRWZ/QfyBetBLSop y5MWnuSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYuFgcAAKCRCcnaoHP2RA2eutCA CJ7IF1lDXn0NspVzXse7Yg1rRXT1uIokO9SD1hLBkkaMMljOf3gcAomKGoJXzdjqQLrmAWiYBtg6IX xNohvSKxHm8dRf8TFW/25jua3z8cA0QB6gRFe8Ja4GNPcfOF8/cM+mHcy02PVWzfxBuoXbBDede6HT 7j5YqdtreJOmzPCRK0egb2pIe+OjwEXzOhZPZ0Vhl2D9ToyavHrZtg/INzdHwhQh4OXgq3Y25sQH7w CP7OODRO2Q04VVv7XL+aeBERuPji96v6gzVnrn81Xqeq6WcAu3p/mYeoayZV3KXW0tfkV502QwKZBi mBGROTvQ+EJghXkbgiSsxOnlTI1+TZ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When inode is created and written to using direct IO, there is nothing
to clear the EXT4_STATE_MAY_INLINE_DATA flag. Thus when inode gets
truncated later to say 1 byte and written using normal write, we will
try to store the data as inline data. This confuses the code later
because the inode now has both normal block and inline data allocated
and the confusion manifests for example as:

kernel BUG at fs/ext4/inode.c:2721!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 359 Comm: repro Not tainted 5.19.0-rc8-00001-g31ba1e3b8305-dirty #15
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
RIP: 0010:ext4_writepages+0x363d/0x3660
RSP: 0018:ffffc90000ccf260 EFLAGS: 00010293
RAX: ffffffff81e1abcd RBX: 0000008000000000 RCX: ffff88810842a180
RDX: 0000000000000000 RSI: 0000008000000000 RDI: 0000000000000000
RBP: ffffc90000ccf650 R08: ffffffff81e17d58 R09: ffffed10222c680b
R10: dfffe910222c680c R11: 1ffff110222c680a R12: ffff888111634128
R13: ffffc90000ccf880 R14: 0000008410000000 R15: 0000000000000001
FS:  00007f72635d2640(0000) GS:ffff88811b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000565243379180 CR3: 000000010aa74000 CR4: 0000000000150eb0
Call Trace:
 <TASK>
 do_writepages+0x397/0x640
 filemap_fdatawrite_wbc+0x151/0x1b0
 file_write_and_wait_range+0x1c9/0x2b0
 ext4_sync_file+0x19e/0xa00
 vfs_fsync_range+0x17b/0x190
 ext4_buffered_write_iter+0x488/0x530
 ext4_file_write_iter+0x449/0x1b90
 vfs_write+0xbcd/0xf40
 ksys_write+0x198/0x2c0
 __x64_sys_write+0x7b/0x90
 do_syscall_64+0x3d/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
 </TASK>

Fix the problem by clearing EXT4_STATE_MAY_INLINE_DATA when we are doing
direct IO write to a file.

Reported-by: Tadeusz Struk <tadeusz.struk@linaro.org>
Reported-by: syzbot+bd13648a53ed6933ca49@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=a1e89d09bbbcbd5c4cb45db230ee28c822953984
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 109d07629f81..cab5dfed1cd6 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -528,6 +528,12 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ret = -EAGAIN;
 		goto out;
 	}
+	/*
+	 * Make sure inline data cannot be created anymore since we are going
+ 	 * to allocate blocks for DIO. We know the inode does not have any
+	 * inline data now because ext4_dio_supported() checked for that.
+	 */
+	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 
 	offset = iocb->ki_pos;
 	count = ret;
-- 
2.35.3

