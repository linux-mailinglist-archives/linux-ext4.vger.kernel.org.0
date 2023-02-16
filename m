Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C161B699CB1
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Feb 2023 19:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjBPSzy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Feb 2023 13:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBPSzx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Feb 2023 13:55:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEA24AFCF;
        Thu, 16 Feb 2023 10:55:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B456B82501;
        Thu, 16 Feb 2023 18:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FEDC433D2;
        Thu, 16 Feb 2023 18:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676573749;
        bh=cNJMx4XuP7npWr1rxGXhE1NzLjT7BexfPm4jGcNcpLs=;
        h=Date:From:To:Cc:Subject:From;
        b=rD5NU9ruj/FyRMxi7e0J56a0NqSAIGBvtVnPlXp1GDJJbVJVEQLrfJWOMQ7LiOb0/
         C09/veySTi/naR/YI1FfJwZCEiYbCQiT0tt4X18/yGmX3xO1IQ2DpT6HCq5J9a6LOP
         Y8/Xqn1p1kHgVf5T4253rXPP0eyrtDKyFN8iEWnRscdzluFfQ8cw+X7x/xm3ZTLJ8x
         VSBU0vllFMmj6rqhYXLysYx4qsKvgTl9QT0K7ccbrzpPRpAop15Enc3JhI42ohVmf9
         /mVqQK30Jvjt8D8xqnu9V3QtzYkpsVU76w2RA1S43/aFvE1GmvSs0W6uwTLjEq2Ahv
         BAQyb8/9Ir2QA==
Date:   Thu, 16 Feb 2023 10:55:48 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Jun Nie <jun.nie@linaro.org>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <joneslee@google.com>
Subject: [PATCH] ext4: fix another off-by-one fsmap error on 1k block
 filesystems
Message-ID: <Y+58NPTH7VNGgzdd@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Apparently syzbot figured out that issuing this FSMAP call:

struct fsmap_head cmd = {
	.fmh_count	= ...;
	.fmh_keys	= {
		{ .fmr_device = /* ext4 dev */, .fmr_physical = 0, },
		{ .fmr_device = /* ext4 dev */, .fmr_physical = 0, },
	},
...
};
ret = ioctl(fd, FS_IOC_GETFSMAP, &cmd);

Produces this crash if the underlying filesystem is a 1k-block ext4
filesystem:

kernel BUG at fs/ext4/ext4.h:3331!
invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 3 PID: 3227965 Comm: xfs_io Tainted: G        W  O       6.2.0-rc8-achx
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
RIP: 0010:ext4_mb_load_buddy_gfp+0x47c/0x570 [ext4]
RSP: 0018:ffffc90007c03998 EFLAGS: 00010246
RAX: ffff888004978000 RBX: ffffc90007c03a20 RCX: ffff888041618000
RDX: 0000000000000000 RSI: 00000000000005a4 RDI: ffffffffa0c99b11
RBP: ffff888012330000 R08: ffffffffa0c2b7d0 R09: 0000000000000400
R10: ffffc90007c03950 R11: 0000000000000000 R12: 0000000000000001
R13: 00000000ffffffff R14: 0000000000000c40 R15: ffff88802678c398
FS:  00007fdf2020c880(0000) GS:ffff88807e100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd318a5fe8 CR3: 000000007f80f001 CR4: 00000000001706e0
Call Trace:
 <TASK>
 ext4_mballoc_query_range+0x4b/0x210 [ext4 dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
 ext4_getfsmap_datadev+0x713/0x890 [ext4 dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
 ext4_getfsmap+0x2b7/0x330 [ext4 dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
 ext4_ioc_getfsmap+0x153/0x2b0 [ext4 dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
 __ext4_ioctl+0x2a7/0x17e0 [ext4 dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
 __x64_sys_ioctl+0x82/0xa0
 do_syscall_64+0x2b/0x80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fdf20558aff
RSP: 002b:00007ffd318a9e30 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000000200c0 RCX: 00007fdf20558aff
RDX: 00007fdf1feb2010 RSI: 00000000c0c0583b RDI: 0000000000000003
RBP: 00005625c0634be0 R08: 00005625c0634c40 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdf1feb2010
R13: 00005625be70d994 R14: 0000000000000800 R15: 0000000000000000

For GETFSMAP calls, the caller selects a physical block device by
writing its block number into fsmap_head.fmh_keys[01].fmr_device.
To query mappings for a subrange of the device, the starting byte of the
range is written to fsmap_head.fmh_keys[0].fmr_physical and the last
byte of the range goes in fsmap_head.fmh_keys[1].fmr_physical.

IOWs, to query what mappings overlap with bytes 3-14 of /dev/sda, you'd
set the inputs as follows:

	fmh_keys[0] = { .fmr_device = major(8, 0), .fmr_physical = 3},
	fmh_keys[1] = { .fmr_device = major(8, 0), .fmr_physical = 14},

Which would return you whatever is mapped in the 12 bytes starting at
physical offset 3.

The crash is due to insufficient range validation of keys[1] in
ext4_getfsmap_datadev.  On 1k-block filesystems, block 0 is not part of
the filesystem, which means that s_first_data_block is nonzero.
ext4_get_group_no_and_offset subtracts this quantity from the blocknr
argument before cracking it into a group number and a block number
within a group.  IOWs, block group 0 spans blocks 1-8192 (1-based)
instead of 0-8191 (0-based) like what happens with larger blocksizes.

The net result of this encoding is that blocknr < s_first_data_block is
not a valid input to this function.  The end_fsb variable is set from
the keys that are copied from userspace, which means that in the above
example, its value is zero.  That leads to an underflow here:

	blocknr = blocknr - le32_to_cpu(es->s_first_data_block);

The division then operates on -1:

	offset = do_div(blocknr, EXT4_BLOCKS_PER_GROUP(sb)) >>
		EXT4_SB(sb)->s_cluster_bits;

Leaving an impossibly large group number (2^32-1) in blocknr.
ext4_getfsmap_check_keys checked that keys[0].fmr_physical and
keys[1].fmr_physical are in increasing order, but
ext4_getfsmap_datadev adjusts keys[0].fmr_physical to be at least
s_first_data_block.  This implies that we have to check it again after
the adjustment, which is the piece that I forgot.

Fixes: 4a4956249dac ("ext4: fix off-by-one fsmap error on 1k block filesystems")
Link: https://syzkaller.appspot.com/bug?id=79d5768e9bfe362911ac1a5057a36fc6b5c30002
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/ext4/fsmap.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 4493ef0c715e..cdf9bfe10137 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -486,6 +486,8 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 		keys[0].fmr_physical = bofs;
 	if (keys[1].fmr_physical >= eofs)
 		keys[1].fmr_physical = eofs - 1;
+	if (keys[1].fmr_physical < keys[0].fmr_physical)
+		return 0;
 	start_fsb = keys[0].fmr_physical;
 	end_fsb = keys[1].fmr_physical;
 
