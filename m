Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8162644DAB
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Dec 2022 22:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLFVCX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Dec 2022 16:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLFVCV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Dec 2022 16:02:21 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8112F028;
        Tue,  6 Dec 2022 13:02:20 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2B6L1sZA001533
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Dec 2022 16:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1670360518; bh=CyOJZXp862wNz1EI0vNPEAyGg1jTpjjZbj17oMWn4Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=mqI5aZ//POVzUKsx3gxcCUfJsYvQ8zriS95KFzdUgtg9w9drshsC3DOBWSY50V8z+
         owWiMPMQ58gX7bQY2l84v67KRnsTD03sgNx9XIW6ks6hqDwHPM6OK7JSt5j+sEzteK
         C8tz0pZcvLjQTNgQe5GZ8oHDba+tceBrUr/5cBBositeMf3IEfu82juCO/PEB19sw5
         eNE0PZ1OtiFjcFKHHWTaLt+UcTNNuwzDfdNCY24np58sIel49k//4PI133w4URUZ5U
         ETLSjQS8gmDsroITw1H0fRP0iPekwDOz6byXaXXnJeV5kqmgw4Vg0X3r3L4eMBwwBx
         Pw7PjcmEZ5Uag==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D553E15C3A23; Tue,  6 Dec 2022 16:01:54 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        ritesh.list@gmail.com, yi.zhang@huawei.com,
        adilger.kernel@dilger.ca, yukuai3@huawei.com, jack@suse.cz
Subject: Re: [PATCH] ext4: fix use-after-free in ext4_orphan_cleanup
Date:   Tue,  6 Dec 2022 16:01:49 -0500
Message-Id: <167036049593.156498.14515627082959738584.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221102080633.1630225-1-libaokun1@huawei.com>
References: <20221102080633.1630225-1-libaokun1@huawei.com>
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

On Wed, 2 Nov 2022 16:06:33 +0800, Baokun Li wrote:
> I caught a issue as follows:
> ==================================================================
>  BUG: KASAN: use-after-free in __list_add_valid+0x28/0x1a0
>  Read of size 8 at addr ffff88814b13f378 by task mount/710
> 
>  CPU: 1 PID: 710 Comm: mount Not tainted 6.1.0-rc3-next #370
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x73/0x9f
>   print_report+0x25d/0x759
>   kasan_report+0xc0/0x120
>   __asan_load8+0x99/0x140
>   __list_add_valid+0x28/0x1a0
>   ext4_orphan_cleanup+0x564/0x9d0 [ext4]
>   __ext4_fill_super+0x48e2/0x5300 [ext4]
>   ext4_fill_super+0x19f/0x3a0 [ext4]
>   get_tree_bdev+0x27b/0x450
>   ext4_get_tree+0x19/0x30 [ext4]
>   vfs_get_tree+0x49/0x150
>   path_mount+0xaae/0x1350
>   do_mount+0xe2/0x110
>   __x64_sys_mount+0xf0/0x190
>   do_syscall_64+0x35/0x80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>   </TASK>
>  [...]
> ==================================================================
> 
> [...]

Applied, thanks!

[1/1] ext4: fix use-after-free in ext4_orphan_cleanup
      commit: ad7ab3c3f740ce379e230d28c6aa8f9550182841

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
