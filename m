Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD3152356B
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 16:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiEKO1Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 10:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241417AbiEKO1X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 10:27:23 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD0F66F8A;
        Wed, 11 May 2022 07:27:22 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24BER4kl013498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 10:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652279226; bh=8hgmElPz0t7OufSsTjC6m8Fq4s3uDD1h1JE9Mns8WZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RVOUih5Qajf8B9PG5732u2VscEjQ0g/gRbu9NoeL+w0DPlPSj2zvQwUO76SFWdOc/
         1t0SsPQ2NnRorXMbpiI1reHynmq81gzipa/fx5yMaRER28qmosjrS3mJgW+f8YdNY9
         Eu6zxxTv6L0yrJYVo/arE3Vc6gQTEvW/TFm6Osez0cKFC80SeDHZXL+MM6W+u9C/+L
         AMhdLYNEXvvj2/odi0RQYf4W3dya7DdAeZ6wnimAdttxURtyXqTxiGdC7VkPT/Tgn8
         FCMDQEzmRXlB43iC6gI+y/CEH923b3uAp+qiUPEiKxg53PodZP0oI4ZADvVzMf6gu7
         68neOQZYM8p1w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 51D9D15C3F0C; Wed, 11 May 2022 10:27:04 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        lczerner@redhat.com, jack@suse.cz
Subject: Re: [PATCH -next] ext4: fix warning in ext4_handle_inode_extension
Date:   Wed, 11 May 2022 10:27:02 -0400
Message-Id: <165227918943.390808.17562773461897886007.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220326065351.761952-1-yebin10@huawei.com>
References: <20220326065351.761952-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, 26 Mar 2022 14:53:51 +0800, Ye Bin wrote:
> We got issue as follows:
> EXT4-fs error (device loop0) in ext4_reserve_inode_write:5741: Out of memory
> EXT4-fs error (device loop0): ext4_setattr:5462: inode #13: comm syz-executor.0: mark_inode_dirty error
> EXT4-fs error (device loop0) in ext4_setattr:5519: Out of memory
> EXT4-fs error (device loop0): ext4_ind_map_blocks:595: inode #13: comm syz-executor.0: Can't allocate blocks for non-extent mapped inodes with bigalloc
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 4361 at fs/ext4/file.c:301 ext4_file_write_iter+0x11c9/0x1220
> Modules linked in:
> CPU: 1 PID: 4361 Comm: syz-executor.0 Not tainted 5.10.0+ #1
> RIP: 0010:ext4_file_write_iter+0x11c9/0x1220
> RSP: 0018:ffff924d80b27c00 EFLAGS: 00010282
> RAX: ffffffff815a3379 RBX: 0000000000000000 RCX: 000000003b000000
> RDX: ffff924d81601000 RSI: 00000000000009cc RDI: 00000000000009cd
> RBP: 000000000000000d R08: ffffffffbc5a2c6b R09: 0000902e0e52a96f
> R10: ffff902e2b7c1b40 R11: ffff902e2b7c1b40 R12: 000000000000000a
> R13: 0000000000000001 R14: ffff902e0e52aa10 R15: ffffffffffffff8b
> FS:  00007f81a7f65700(0000) GS:ffff902e3bc80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffff600400 CR3: 000000012db88001 CR4: 00000000003706e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  do_iter_readv_writev+0x2e5/0x360
>  do_iter_write+0x112/0x4c0
>  do_pwritev+0x1e5/0x390
>  __x64_sys_pwritev2+0x7e/0xa0
>  do_syscall_64+0x37/0x50
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> [...]

Applied, thanks!

[1/1] ext4: fix warning in ext4_handle_inode_extension
      commit: f3e076d26874f4d54126c07ba51d8dd407008697

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
