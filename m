Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B87552C9AE
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 04:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiESCPU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 22:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiESCPT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 22:15:19 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4DA546A8;
        Wed, 18 May 2022 19:15:18 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24J2F1qc022449
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 22:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652926503; bh=igjMvarnb1k3A+zIuWFJEP3NaSDqgkSsgvM/hE55+cY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=p6bNezSfvBK2mgHxW0tUHIsgbAu9Tne30b9DIK+vFxzUAHjJm9u8Zo+uk2/SFeJ0P
         ITdxTMQf0aKPPnMJKURPVkN/S2H9d7gkUgpo4gztL5XW3cFlwlOwh3ExMCQwRdd3aD
         qEQxBbZuEAPGoa6nRn1a3aLopzmSfmHX8Peqv6SdFLXMEtdxhwSgrpJucj8xi4/z6T
         Nca4yvOsUouCIrjVYPumuQrwC1yuckrZRw5h0VmtDKQtV3aNjUBfVYrxSn0HjrJVtl
         7jAYZF3G0UHUG/0QRk179lF6qbibXxyraKh9Gh+ZAFCCBg2J0SOohH3Lx8bqjx/zaw
         puDhnTEprtVeA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DE06915C3EC0; Wed, 18 May 2022 22:15:01 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin10@huawei.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v4] ext4: fix bug_on in ext4_writepages
Date:   Wed, 18 May 2022 22:15:01 -0400
Message-Id: <165292643905.1203195.1245014108401811377.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220516122634.1690462-1-yebin10@huawei.com>
References: <20220516122634.1690462-1-yebin10@huawei.com>
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

On Mon, 16 May 2022 20:26:34 +0800, Ye Bin wrote:
> we got issue as follows:
> EXT4-fs error (device loop0): ext4_mb_generate_buddy:1141: group 0, block bitmap and bg descriptor inconsistent: 25 vs 31513 free cls
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/inode.c:2708!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 2 PID: 2147 Comm: rep Not tainted 5.18.0-rc2-next-20220413+ #155
> RIP: 0010:ext4_writepages+0x1977/0x1c10
> RSP: 0018:ffff88811d3e7880 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff88811c098000
> RDX: 0000000000000000 RSI: ffff88811c098000 RDI: 0000000000000002
> RBP: ffff888128140f50 R08: ffffffffb1ff6387 R09: 0000000000000000
> R10: 0000000000000007 R11: ffffed10250281ea R12: 0000000000000001
> R13: 00000000000000a4 R14: ffff88811d3e7bb8 R15: ffff888128141028
> FS:  00007f443aed9740(0000) GS:ffff8883aef00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020007200 CR3: 000000011c2a4000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  do_writepages+0x130/0x3a0
>  filemap_fdatawrite_wbc+0x83/0xa0
>  filemap_flush+0xab/0xe0
>  ext4_alloc_da_blocks+0x51/0x120
>  __ext4_ioctl+0x1534/0x3210
>  __x64_sys_ioctl+0x12c/0x170
>  do_syscall_64+0x3b/0x90
> 
> [...]

Applied, thanks!

[1/1] ext4: fix bug_on in ext4_writepages
      commit: eed67ff2ad862d1edca9cbba1e4a56c634cb0d46

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
