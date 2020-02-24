Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35ECD16A915
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Feb 2020 16:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgBXPCx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Feb 2020 10:02:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42658 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgBXPCx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Feb 2020 10:02:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id 4so5484212pfz.9;
        Mon, 24 Feb 2020 07:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MqdixoOgTkid8+Igi0K+piNqZGtHwUC43IEz9dtWBa8=;
        b=fd9uNPoGcCCgVSBzjhg4rXdj4rAxhm3G+GO/ouItobNPkHfo68yVIKeOwtHQ0Roajy
         BNJ6Km3orPHsL8e+NK+DczL92xtGiefjqbbRr4ea89ydKoYZMsEbRBg/2nh0NfKIyIor
         P/gdjg+/r+unTYDArz+0FrpRMT8cy57rMdvzUhNe3u3CKmYu/UKLHCR/9KxyOFhLgHbF
         d3cqROD10UwMoJ2x+ZEVajnvuHbtRLNQvaeBbf7oEQAeLPtttn8M+JzmDGLautHcmi8O
         C7owb9D/RpasV8Tj5P36XMMvRBy80G24H4K1pXwNhEWhIpSuKek7QNtfjD4t5pmNDyI0
         HbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MqdixoOgTkid8+Igi0K+piNqZGtHwUC43IEz9dtWBa8=;
        b=a1kJ1lhMCs5ggwwUq/bcRHmqb1FTZcKu6Lk3ow/R00M75IieOiO2xDJShfvwO0BO/O
         K/eSWM2qu9iWcofAXzM9lXv9t4p+BswiM0PFDZTz4qlq71qj8HopfZIntA/wHauwdH9n
         QoH/0UoXPlFZpH2fJ0e/sET4ieVcr0QByi8zOHq6BnHFS0VBMxFyvS103xSNy0zTFrgV
         vJHowKEuxQ/ZIHJhyzhhd1Vo44byBYIwH3ZnVTnn3dmB0iVYTWnk+3JEqqoIXYk3a70e
         L/au2is2CqHSe54pVcg7K7wY4dv6K0GcTBTYGLlVSU2AxddzWk4hkgD+NFk/XAV9ONUy
         6a0A==
X-Gm-Message-State: APjAAAWUez6hU1a6yptgNLkRcVRP0qQ9gX4rYKkSDdui6sE1lr+ZWs0b
        FFnEkJ2NHEmNvCnzR+teDvQ=
X-Google-Smtp-Source: APXvYqw2gcWuwuGmlAm4ZLwrGxqdp8YUs0sgM7ic1srb0L85ZcGJXTSFSmFARvunvAtYXvey5HN3ow==
X-Received: by 2002:aa7:9a96:: with SMTP id w22mr34718079pfi.210.1582556570917;
        Mon, 24 Feb 2020 07:02:50 -0800 (PST)
Received: from VM_0_35_centos.localdomain ([150.109.62.251])
        by smtp.gmail.com with ESMTPSA id w2sm12888585pfw.43.2020.02.24.07.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 07:02:50 -0800 (PST)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] ext4: fix a data race at inode->i_disksize
Date:   Mon, 24 Feb 2020 23:02:46 +0800
Message-Id: <1582556566-3909-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

KCSAN find inode->i_disksize could be accessed concurrently.

BUG: KCSAN: data-race in ext4_mark_iloc_dirty / ext4_write_end

write (marked) to 0xffff8b8932f40090 of 8 bytes by task 66792 on cpu 0:
 ext4_write_end+0x53f/0x5b0
 ext4_da_write_end+0x237/0x510
 generic_perform_write+0x1c4/0x2a0
 ext4_buffered_write_iter+0x13a/0x210
 ext4_file_write_iter+0xe2/0x9b0
 new_sync_write+0x29c/0x3a0
 __vfs_write+0x92/0xa0
 vfs_write+0xfc/0x2a0
 ksys_write+0xe8/0x140
 __x64_sys_write+0x4c/0x60
 do_syscall_64+0x8a/0x2a0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffff8b8932f40090 of 8 bytes by task 14414 on cpu 1:
 ext4_mark_iloc_dirty+0x716/0x1190
 ext4_mark_inode_dirty+0xc9/0x360
 ext4_convert_unwritten_extents+0x1bc/0x2a0
 ext4_convert_unwritten_io_end_vec+0xc5/0x150
 ext4_put_io_end+0x82/0x130
 ext4_writepages+0xae7/0x16f0
 do_writepages+0x64/0x120
 __writeback_single_inode+0x7d/0x650
 writeback_sb_inodes+0x3a4/0x860
 __writeback_inodes_wb+0xc4/0x150
 wb_writeback+0x43f/0x510
 wb_workfn+0x3b2/0x8a0
 process_one_work+0x39b/0x7e0
 worker_thread+0x88/0x650
 kthread+0x1d4/0x1f0
 ret_from_fork+0x35/0x40

The plain read is outside of inode->i_data_sem critical section
which results in a data race. Fix it by adding READ_ONCE().

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fa0ff78..c787703 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4982,7 +4982,7 @@ static int ext4_do_update_inode(handle_t *handle,
 		raw_inode->i_file_acl_high =
 			cpu_to_le16(ei->i_file_acl >> 32);
 	raw_inode->i_file_acl_lo = cpu_to_le32(ei->i_file_acl);
-	if (ei->i_disksize != ext4_isize(inode->i_sb, raw_inode)) {
+	if (READ_ONCE(ei->i_disksize) != ext4_isize(inode->i_sb, raw_inode)) {
 		ext4_isize_set(raw_inode, ei->i_disksize);
 		need_datasync = 1;
 	}
-- 
1.8.3.1

