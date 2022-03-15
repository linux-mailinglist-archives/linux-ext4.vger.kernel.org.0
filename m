Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945B04DA336
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Mar 2022 20:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348839AbiCOTWs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Mar 2022 15:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345783AbiCOTWs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Mar 2022 15:22:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693903A5CA
        for <linux-ext4@vger.kernel.org>; Tue, 15 Mar 2022 12:21:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso332750pjo.5
        for <linux-ext4@vger.kernel.org>; Tue, 15 Mar 2022 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=3revWy2NpK6ECbDnOYqVuF2tDXXbaFT1az+SZDuKnXU=;
        b=mJNattGinkcwvZjVRyzMU6hajqM8uOVCgCqfl4fj+Uehs0jA57xZClA9dRJN4jzQVp
         cST26+DKNnbMUwvtKFq4uOsqjJnPC5c/NVbbbHNNSf18ACYIwq2Zmea8MjvcmlNSYr85
         drUxZlaPKbKG+rS5Ij4ffcfcg98BtLPuWqZlvcI35QKD6k/g0tJnhybaWeYG7A1ZoaEX
         nhnVoULZGsrVlY8WS5KEHfc9uQ8OzJaI71H9BqTH78f+2FJXtRivkzjrZGloYT6nWoYH
         Rvqgj6GA6+eY5NSn7yfpbrxpoyIHhX2P16BZM6hMoouVNX955vckgZfOnPVq+oC4RCgl
         dgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=3revWy2NpK6ECbDnOYqVuF2tDXXbaFT1az+SZDuKnXU=;
        b=dWcNUmWam7nzCkOGRRwtr0TulqvoiqobTQSGCrxdbi5Edx7+Fqv8R8RaM0WcCTxO5F
         VeQhUFNuekNo3GvIqJ0P6f8tMvNHOD2WKuMqoVqRF67G7QmyhsU6l1G7I7Avww9o+4bu
         oFeW5CHr9Qya5SQI5nSDuwNTnxqMavLT0DHXFQqqfyk1jSCDdnyWCrVGmVTE6HfNgF+n
         A/cXiGUCOw+dqLSUof1vbG+eyJVmvNQqe1Y7Mhgl0TL2Z6bqvVyM03qmsQNL8DsyoifL
         zVcMANsFhrQHUqFDDJqpDKNGaIeIMV4mp5hqx39zOHT5J099iuBNKDQVQIGD7B7PBkzo
         sR1g==
X-Gm-Message-State: AOAM531Eof33cqaAdrk2E8XwSAt3GGZZQsOtUCUqjKV9TOaAR7drnDIK
        qeSWO1GhVMAQ5XELuCVBkdLl2w==
X-Google-Smtp-Source: ABdhPJw0EWEyUaTKRFCaOPzmM4AYdRJyyM9sZkmo4COwVEjE6+Uir81YQZ8DajOnMS+ZHr771xgIXA==
X-Received: by 2002:a17:90a:77c9:b0:1c5:d5e5:a459 with SMTP id e9-20020a17090a77c900b001c5d5e5a459mr6280428pjs.191.1647372094928;
        Tue, 15 Mar 2022 12:21:34 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id c18-20020a056a000ad200b004cdccd3da08sm26254928pfl.44.2022.03.15.12.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 12:21:34 -0700 (PDT)
Message-ID: <a30ec1e7-564f-665b-7c20-54dad6124418@linaro.org>
Date:   Tue, 15 Mar 2022 12:21:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [syzbot] kernel BUG in ext4_ind_remove_space
Content-Language: en-US
To:     syzbot <syzbot+fcc629d1a1ae8d3fe8a5@syzkaller.appspotmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000042d70e05da43401f@google.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <00000000000042d70e05da43401f@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 3/15/22 08:14, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    09688c0166e7 Linux 5.17-rc8
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a8bd61700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d35f9bc6884af6c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=fcc629d1a1ae8d3fe8a5
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1205b189700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dda4fe700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fcc629d1a1ae8d3fe8a5@syzkaller.appspotmail.com
> 
> EXT4-fs warning (device sda1): ext4_block_to_path:105: block 1074791436 > max in inode 1137
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/indirect.c:1244!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 3590 Comm: syz-executor391 Not tainted 5.17.0-rc8-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:ext4_ind_remove_space+0xfde/0x1400 fs/ext4/indirect.c:1244
> Code: 00 0f 85 36 03 00 00 48 8b 0b 4c 89 fe 44 8b 4c 24 20 48 8b 7c 24 10 48 83 c1 04 e8 3c bb ff ff e9 02 f6 ff ff e8 c2 26 66 ff <0f> 0b 4c 8b 7c 24 50 e9 8e f9 ff ff e8 b1 26 66 ff 48 8b 7c 24 10
> RSP: 0018:ffffc90001adfab8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: ffff888021523a00 RSI: ffffffff8212996e RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffffff82128bea R11: 0000000000000000 R12: 0000000000001000
> R13: ffffc90001adfb68 R14: ffffc90001adfb88 R15: ffff8880751fa088
> FS:  00007f69922ff700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000080 CR3: 0000000021605000 CR4: 0000000000350ef0
> Call Trace:
>   <TASK>
>   ext4_punch_hole+0xfe8/0x11d0 fs/ext4/inode.c:4044
>   ext4_fallocate+0x1194/0x3ed0 fs/ext4/extents.c:4694
>   vfs_fallocate+0x48d/0xe10 fs/open.c:308
>   ksys_fallocate fs/open.c:331 [inline]
>   __do_sys_fallocate fs/open.c:339 [inline]
>   __se_sys_fallocate fs/open.c:337 [inline]
>   __x64_sys_fallocate+0xcf/0x140 fs/open.c:337
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f699234cdf9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f69922ff308 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
> RAX: ffffffffffffffda RBX: 0000000000000040 RCX: 00007f699234cdf9
> RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000005
> RBP: 00007f69923d5408 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000ffeffeff000 R11: 0000000000000246 R12: 00000ffeffeff000
> R13: 00007f69923d5400 R14: 00007f69923a3004 R15: 0000000000022000
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:ext4_ind_remove_space+0xfde/0x1400 fs/ext4/indirect.c:1244
> Code: 00 0f 85 36 03 00 00 48 8b 0b 4c 89 fe 44 8b 4c 24 20 48 8b 7c 24 10 48 83 c1 04 e8 3c bb ff ff e9 02 f6 ff ff e8 c2 26 66 ff <0f> 0b 4c 8b 7c 24 50 e9 8e f9 ff ff e8 b1 26 66 ff 48 8b 7c 24 10
> RSP: 0018:ffffc90001adfab8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: ffff888021523a00 RSI: ffffffff8212996e RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffffff82128bea R11: 0000000000000000 R12: 0000000000001000
> R13: ffffc90001adfb68 R14: ffffc90001adfb88 R15: ffff8880751fa088
> FS:  00007f69922ff700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000080 CR3: 0000000021605000 CR4: 0000000000350ef0
> 

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

===========================
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 01c9e4f743ba..dd9c35113efe 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3924,7 +3924,8 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, 
loff_t length)
  	struct super_block *sb = inode->i_sb;
  	ext4_lblk_t first_block, stop_block;
  	struct address_space *mapping = inode->i_mapping;
-	loff_t first_block_offset, last_block_offset;
+	loff_t first_block_offset, last_block_offset, max_length;
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
  	handle_t *handle;
  	unsigned int credits;
  	int ret = 0, ret2 = 0;
@@ -3967,6 +3968,16 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, 
loff_t length)
  		   offset;
  	}

+	/*
+	 * For punch hole the length + offset needs to be at least within
+	 * one block before last
+	 */
+	max_length = sbi->s_bitmap_maxbytes - sbi->s_blocksize;
+	if (offset + length >= max_length) {
+		ret = -ENOSPC;
+		goto out_mutex;
+	}
+
  	if (offset & (sb->s_blocksize - 1) ||
  	    (offset + length) & (sb->s_blocksize - 1)) {
  		/*
--
Thanks,
Tadeusz
