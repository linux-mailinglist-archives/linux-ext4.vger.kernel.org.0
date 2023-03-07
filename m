Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4287E6ADB8D
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Mar 2023 11:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCGKPu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 05:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCGKPt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 05:15:49 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FBD51CA4
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 02:15:47 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id s22so16362554lfi.9
        for <linux-ext4@vger.kernel.org>; Tue, 07 Mar 2023 02:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678184146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kIPrOomFPF3BZ8TyURLFE/IfN8UJGe928Gc5eWAUcrw=;
        b=XL2cC23x5XXz9qM6SzuEX18D3bJbqA8j9eXk4FHdyiWqkEMTTULC1EwWHo4Rd35oMj
         f1nwlevJALSbfvpob5K11oj4ONxCzV7HY4UVYZpPgSpA6LnFZ3KhvgaYz91ZmqL4+Qr9
         Ce0dIESQB+hBLF7MlFX1rYGvCFCxLXW8IT/uAhBStszYFKMdePqn+oLD1dKwjzgpvLxB
         8myIbAZFn459k7/pReBMhAn11qOFz4jpiLEyyov5PA/wXB3zgWJ62m/JuJdlf71ITjfc
         vdUhPM8ZPZJ6KqZc3nfQLnSEDytVB4Omwnbh3/r/y6c69rpA/Zw8J1drSIEqr3tsCBjd
         1qJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678184146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIPrOomFPF3BZ8TyURLFE/IfN8UJGe928Gc5eWAUcrw=;
        b=czd4aQWBXz/dQjNGtdM5vTinvg2IODxp6X1o+FbJc8q/4jpMk/F/uiSgDRVP5UevJl
         urFcoqVCdvCqNIMN1TfDyuWhqnmxyxuExMde1H0OJ0cIVCy4AEaB7GmTBuMPxkQm15vi
         kiuycgw4T9ly6SpD9xf3YRqgBsDNsFYqI8fUUoRc4PW92RjjTiM4g/lr1F/bfJ/mpRLy
         ltmrVuXUrnvD4bjopiqWD+OaTsaMCz6tNfbnIzk6p3tY+Z09UiRRGm+vWQi6HiXy/eky
         jpP9N8famtgFpZPv45+6D3EbPJTODUOMlwy4obmz+R9RkS2Z/Ex09JbJYXzCv+JHtLAI
         XJ2Q==
X-Gm-Message-State: AO0yUKWpyNrF2bN9+KQpUe7hkvUoA6Xg81rQ7eyfD5+SosaMM0AIO+fu
        giOLqyPKoVTWZ5z8uAHyhOdEWA==
X-Google-Smtp-Source: AK7set84E6gE0GZNmnd+pY1MvdAFNN5xSImQrvjxjDWdXt6QR4czirAhIoW2NBHNqzCwxeOT5uQXYQ==
X-Received: by 2002:ac2:5dd9:0:b0:4cd:7fe0:24 with SMTP id x25-20020ac25dd9000000b004cd7fe00024mr3205656lfq.27.1678184146106;
        Tue, 07 Mar 2023 02:15:46 -0800 (PST)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id w5-20020a19c505000000b004d8729d4150sm1983492lfe.145.2023.03.07.02.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 02:15:45 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     boyu.mt@taobao.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, leejones@google.com,
        Ye Bin <yebin10@huawei.com>,
        syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com,
        Jun Nie <jun.nie@linaro.org>, stable@kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH][for-stable 5.10, 5.4, 4.19, 4.14] ext4: fix kernel BUG in 'ext4_write_inline_data_end()'
Date:   Tue,  7 Mar 2023 10:15:41 +0000
Message-Id: <20230307101541.2601829-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 5c099c4fdc438014d5893629e70a8ba934433ee8 ]

tudor.ambarus@linaro.org: The patch deviates from original upstream
patch, as it had to be backported. Backport this 3 line patch instead
of carring it's dependency:
'commit 6984aef59814 ("ext4: factor out write end code of inline file")'
The dependency conflicts with
'commit a54c4613dac1 ("ext4: fix race writing to an inline_data file while its xattrs are changing")'
and was fixed in:
'commit 11ef08c9eb52 ("Merge branch 'delalloc-buffer-write' into dev")'
Even if backporting the dependency is straight forward (keep the
contents of the second patch together with the changes from the first)
choose to backport just the fix as the refactoring patch brings little
benefit and high risk. Tested the fix with the reproducer and it no longer
complains on linux-{5.10, 5.4, 4.19, 4.14}.y. The original upstream commit
message follows below.

Syzbot report follow issue:
------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:227!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3629 Comm: syz-executor212 Not tainted 6.1.0-rc5-syzkaller-00018-g59d0d52c30d4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:ext4_write_inline_data+0x344/0x3e0 fs/ext4/inline.c:227
RSP: 0018:ffffc90003b3f368 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880704e16c0 RCX: 0000000000000000
RDX: ffff888021763a80 RSI: ffffffff821e31a4 RDI: 0000000000000006
RBP: 000000000006818e R08: 0000000000000006 R09: 0000000000068199
R10: 0000000000000079 R11: 0000000000000000 R12: 000000000000000b
R13: 0000000000068199 R14: ffffc90003b3f408 R15: ffff8880704e1c82
FS:  000055555723e3c0(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffe8ac9080 CR3: 0000000079f81000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 ext4_write_inline_data_end+0x2a3/0x12f0 fs/ext4/inline.c:768
 ext4_write_end+0x242/0xdd0 fs/ext4/inode.c:1313
 ext4_da_write_end+0x3ed/0xa30 fs/ext4/inode.c:3063
 generic_perform_write+0x316/0x570 mm/filemap.c:3764
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:285
 ext4_file_write_iter+0x8bc/0x16e0 fs/ext4/file.c:700
 call_write_iter include/linux/fs.h:2191 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x182/0x700 fs/read_write.c:861
 vfs_iter_write+0x74/0xa0 fs/read_write.c:902
 iter_file_splice_write+0x745/0xc90 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0x114/0x180 fs/splice.c:931
 splice_direct_to_actor+0x335/0x8a0 fs/splice.c:886
 do_splice_direct+0x1ab/0x280 fs/splice.c:974
 do_sendfile+0xb19/0x1270 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
---[ end trace 0000000000000000 ]---

Above issue may happens as follows:
ext4_da_write_begin
  ext4_da_write_inline_data_begin
    ext4_da_convert_inline_data_to_extent
      ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
ext4_da_write_end

ext4_run_li_request
  ext4_mb_prefetch
    ext4_read_block_bitmap_nowait
      ext4_validate_block_bitmap
        ext4_mark_group_bitmap_corrupted(sb, block_group, EXT4_GROUP_INFO_BBITMAP_CORRUPT)
	 percpu_counter_sub(&sbi->s_freeclusters_counter,grp->bb_free);
	  -> sbi->s_freeclusters_counter become zero
ext4_da_write_begin
  if (ext4_nonda_switch(inode->i_sb)) -> As freeclusters_counter is zero will return true
    *fsdata = (void *)FALL_BACK_TO_NONDELALLOC;
    ext4_write_begin
ext4_da_write_end
  if (write_mode == FALL_BACK_TO_NONDELALLOC)
    ext4_write_end
      if (inline_data)
        ext4_write_inline_data_end
	  ext4_write_inline_data
	    BUG_ON(pos + len > EXT4_I(inode)->i_inline_size);
           -> As inode is already convert to extent, so 'pos + len' > inline_size
	   -> then trigger BUG.

To solve this issue, instead of checking ext4_has_inline_data() which
is only cleared after data has been written back, check the
EXT4_STATE_MAY_INLINE_DATA flag in ext4_write_end().

Fixes: f19d5870cbf7 ("ext4: add normal write support for inline data")
Reported-by: syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com
Reported-by: Jun Nie <jun.nie@linaro.org>
Signed-off-by: Ye Bin <yebin10@huawei.com>
Link: https://lore.kernel.org/r/20221206144134.1919987-1-yebin@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 fs/ext4/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 355343cf4609..7ac3fa2863c7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1303,7 +1303,8 @@ static int ext4_write_end(struct file *file,
 	bool verity = ext4_verity_in_progress(inode);
 
 	trace_ext4_write_end(inode, pos, len, copied);
-	if (inline_data) {
+	if (inline_data &&
+	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
 		ret = ext4_write_inline_data_end(inode, pos, len,
 						 copied, page);
 		if (ret < 0) {
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

