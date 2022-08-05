Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2466C58AB4D
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Aug 2022 15:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240812AbiHENHj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Aug 2022 09:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240879AbiHENHi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Aug 2022 09:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A2391ADB1
        for <linux-ext4@vger.kernel.org>; Fri,  5 Aug 2022 06:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659704856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lUrjF/MAixi7Bh8/ayeTczijWfCC7xeP+l/HtT9IEjI=;
        b=NAdngT+HFeItj7jOQq5DNjA71ili0dK0PIXz28c8MSSGgrxnGlIikSZ0uIiAaNirGmF9Zp
        9gWc/sFSKp23Vcc5Kn21AiKneLYirkS4s33BeYmLf5Vle3PK09P5PEZpPHb49F/Vq+vrEF
        vRohzHMn2lexzFYVeKVd7ogNQk+ar/Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-e5sA7g74PgCA1DfCoTzntg-1; Fri, 05 Aug 2022 09:07:31 -0400
X-MC-Unique: e5sA7g74PgCA1DfCoTzntg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE136381A08C;
        Fri,  5 Aug 2022 13:07:30 +0000 (UTC)
Received: from fedora (unknown [10.40.193.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 352F040CFD0A;
        Fri,  5 Aug 2022 13:07:28 +0000 (UTC)
Date:   Fri, 5 Aug 2022 15:07:26 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        enwlinux@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: fix null-ptr-deref in ext4_write_info
Message-ID: <20220805130726.a3otpkbrjv3ijumd@fedora>
References: <20220805123947.565152-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805123947.565152-1-libaokun1@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 05, 2022 at 08:39:47PM +0800, Baokun Li wrote:
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
> Above issue may happen as follows:
> -------------------------------------
> exit_to_user_mode_prepare
>  task_work_run
>   __cleanup_mnt
>    cleanup_mnt
>     deactivate_super
>      deactivate_locked_super
>       kill_block_super
>        generic_shutdown_super
>         shrink_dcache_for_umount
>          dentry = sb->s_root
>          sb->s_root = NULL              <--- Here set NULL
>         sync_filesystem
>          __sync_filesystem
>           sb->s_op->sync_fs > ext4_sync_fs
>            dquot_writeback_dquots
>             sb->dq_op->write_info > ext4_write_info
>              ext4_journal_start(d_inode(sb->s_root), EXT4_HT_QUOTA, 2)
>               d_inode(sb->s_root)
>                s_root->d_inode          <--- Null pointer dereference
> 
> To solve this problem, we use ext4_journal_start_sb directly
> to avoid s_root being used.

Are we syncing the file system after the superblock shutdown and getting
away with it? This does not look good. Do you have a reproducer?

Thanks!
-Lukas

> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9a66abcca1a8..0ce4565422f6 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6653,7 +6653,7 @@ static int ext4_write_info(struct super_block *sb, int type)
>  	handle_t *handle;
>  
>  	/* Data block + inode block */
> -	handle = ext4_journal_start(d_inode(sb->s_root), EXT4_HT_QUOTA, 2);
> +	handle = ext4_journal_start_sb(sb, EXT4_HT_QUOTA, 2);
>  	if (IS_ERR(handle))
>  		return PTR_ERR(handle);
>  	ret = dquot_commit_info(sb, type);
> -- 
> 2.31.1
> 

