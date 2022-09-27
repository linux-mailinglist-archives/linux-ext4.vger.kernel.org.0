Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2795ECF9C
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Sep 2022 23:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiI0VyN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Sep 2022 17:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiI0VyJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Sep 2022 17:54:09 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C92110ECB;
        Tue, 27 Sep 2022 14:54:08 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28RLrber032590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 17:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664315620; bh=XWBwaflWCMe50tLHFu9wS0TB1bHZETAQDUfIhi7DdQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gfBEZIhPn9IE7yRCdddyN7zNbz9SLSCplzpOEMj1kjd2INWbFcEoDdyYGofh7Qgiv
         /oElyCLnIr6JI0N7X8+6f/2zEb+iKFwz8yq3Q8u+T8lpLAWX0pu1FQsWjZylwHPby6
         8Pl1iYSRRd10+vLhEO9CObN6fo/YbL/kRfi0MtZWs7DclufORkdt0tvUsObWn0eFvN
         G5D/0QFE1VBHuQRQbT8m/OVCXYqYR9/KGLOgSQpeA8S6qb8UcVOiNR97QPtBy9CWjm
         fUIfw2MzpkdlTzVJu7VfFDTKfd0MTN5fKiF32vNdKSFF3OMaKe+9wkc7gc3BXvoCHL
         YZ2iKzZfxCEyg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A4F5615C528D; Tue, 27 Sep 2022 17:53:37 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     libaokun1@huawei.com, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, lczerner@redhat.com,
        yebin10@huawei.com, ritesh.list@gmail.com, yi.zhang@huawei.com,
        jack@suse.cz, linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        adilger.kernel@dilger.ca, enwlinux@gmail.com
Subject: Re: [PATCH] ext4: fix null-ptr-deref in ext4_write_info
Date:   Tue, 27 Sep 2022 17:53:35 -0400
Message-Id: <166431556707.3511882.842144509167145042.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220805123947.565152-1-libaokun1@huawei.com>
References: <20220805123947.565152-1-libaokun1@huawei.com>
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

On Fri, 5 Aug 2022 20:39:47 +0800, Baokun Li wrote:
> I caught a null-ptr-deref bug as follows:
> ==================================================================
> KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
> CPU: 1 PID: 1589 Comm: umount Not tainted 5.10.0-02219-dirty #339
> RIP: 0010:ext4_write_info+0x53/0x1b0
> [...]
> Call Trace:
>  dquot_writeback_dquots+0x341/0x9a0
>  ext4_sync_fs+0x19e/0x800
>  __sync_filesystem+0x83/0x100
>  sync_filesystem+0x89/0xf0
>  generic_shutdown_super+0x79/0x3e0
>  kill_block_super+0xa1/0x110
>  deactivate_locked_super+0xac/0x130
>  deactivate_super+0xb6/0xd0
>  cleanup_mnt+0x289/0x400
>  __cleanup_mnt+0x16/0x20
>  task_work_run+0x11c/0x1c0
>  exit_to_user_mode_prepare+0x203/0x210
>  syscall_exit_to_user_mode+0x5b/0x3a0
>  do_syscall_64+0x59/0x70
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>  ==================================================================
> 
> [...]

Applied, thanks!

[1/1] ext4: fix null-ptr-deref in ext4_write_info
      commit: 647642bf8f326994d7eaf785bba3fa9dad92cff0

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
