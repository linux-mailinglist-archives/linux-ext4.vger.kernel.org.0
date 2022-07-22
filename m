Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FC057E2B4
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 15:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiGVN7A (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 09:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiGVN6v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 09:58:51 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58318904D4;
        Fri, 22 Jul 2022 06:58:43 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26MDwUgW016796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 09:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658498311; bh=cyLrSzInH7AFiTBUwcPn+0ryt9qDyhkDUN8qT2vZR/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cr2HSfGBgScgh4O09NBu7B5gWqKPf3WSdAy7yt42ynvWXnGwVppqzSVHXosezljWm
         J0N6juG8Ji5tOCP2yIuSMjUu/f4iE42DDt1IA7EcuqkoDYYG5dlLHM+I427FdKfCPu
         oUUBg4VVMG3/6BIWjeHmtb77/NEcLBi/4PmPuG3jPEhhbRQ8yy1CcGnrqYCn8QlwHj
         2mQTKmpL9SC8xCiVuawTUxS0/a56FzjAcKZLOnQeeB9MDAdH+v1TmVB4vlByaqz/WD
         ZLQ7hwRP3dQlHY3842G5/9WpkczH/BC3qS8o/TRAhTqtFvT/YYubKE8LQYrCFmaXo8
         GAxe1UjLJwtzQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7D60915C3F0D; Fri, 22 Jul 2022 09:58:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Ye Bin <yebin10@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] ext4: fix warning in ext4_iomap_begin as race between bmap and write
Date:   Fri, 22 Jul 2022 09:58:24 -0400
Message-Id: <165849767593.303416.2022399899140738469.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220617013935.397596-1-yebin10@huawei.com>
References: <20220617013935.397596-1-yebin10@huawei.com>
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

On Fri, 17 Jun 2022 09:39:35 +0800, Ye Bin wrote:
> We got issue as follows:
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 9310 at fs/ext4/inode.c:3441 ext4_iomap_begin+0x182/0x5d0
> RIP: 0010:ext4_iomap_begin+0x182/0x5d0
> RSP: 0018:ffff88812460fa08 EFLAGS: 00010293
> RAX: ffff88811f168000 RBX: 0000000000000000 RCX: ffffffff97793c12
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: ffff88812c669160 R08: ffff88811f168000 R09: ffffed10258cd20f
> R10: ffff88812c669077 R11: ffffed10258cd20e R12: 0000000000000001
> R13: 00000000000000a4 R14: 000000000000000c R15: ffff88812c6691ee
> FS:  00007fd0d6ff3740(0000) GS:ffff8883af180000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fd0d6dda290 CR3: 0000000104a62000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  iomap_apply+0x119/0x570
>  iomap_bmap+0x124/0x150
>  ext4_bmap+0x14f/0x250
>  bmap+0x55/0x80
>  do_vfs_ioctl+0x952/0xbd0
>  __x64_sys_ioctl+0xc6/0x170
>  do_syscall_64+0x33/0x40
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> [...]

Applied, thanks!

[1/1] ext4: fix warning in ext4_iomap_begin as race between bmap and write
      commit: b2788f44f61b34468fec945d8ce99b06b7b8b176

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
