Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06708583908
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Jul 2022 08:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiG1Gye (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Jul 2022 02:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiG1Gyd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Jul 2022 02:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 101145C96F
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 23:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658991271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l+70inD/0eDqE7YP+CInia/k6qJaVaSuXf8b8WY0ijM=;
        b=Q8gDDiLU9zH5rGiDwq9bqoRGmg95aardaaGse1pL3JNHT4wjA8N8T6fFEwgyZ8mrZGoU89
        77DagG/AuSalXh92EgYCKa2YUALOkUPTB2EQcmMN58ZmQ3YucVUmMYOzVotM7W5t/Zw0WV
        aIV7c1giX/jguoW6/FFKxvodY5PnIuk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-A_pNsxNbOJiIM6IwvkWG8Q-1; Thu, 28 Jul 2022 02:54:27 -0400
X-MC-Unique: A_pNsxNbOJiIM6IwvkWG8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E60785A584;
        Thu, 28 Jul 2022 06:54:27 +0000 (UTC)
Received: from fedora (unknown [10.40.193.52])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CE78C28100;
        Thu, 28 Jul 2022 06:54:25 +0000 (UTC)
Date:   Thu, 28 Jul 2022 08:54:23 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        syzbot+bd13648a53ed6933ca49@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: Avoid crash when inline data creation follows DIO
 write
Message-ID: <20220728065423.wzbpa7ce35qxbxet@fedora>
References: <20220727155753.13969-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727155753.13969-1-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 27, 2022 at 05:57:53PM +0200, Jan Kara wrote:
> When inode is created and written to using direct IO, there is nothing
> to clear the EXT4_STATE_MAY_INLINE_DATA flag. Thus when inode gets
> truncated later to say 1 byte and written using normal write, we will
> try to store the data as inline data. This confuses the code later
> because the inode now has both normal block and inline data allocated
> and the confusion manifests for example as:
> 
> kernel BUG at fs/ext4/inode.c:2721!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 359 Comm: repro Not tainted 5.19.0-rc8-00001-g31ba1e3b8305-dirty #15
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
> RIP: 0010:ext4_writepages+0x363d/0x3660
> RSP: 0018:ffffc90000ccf260 EFLAGS: 00010293
> RAX: ffffffff81e1abcd RBX: 0000008000000000 RCX: ffff88810842a180
> RDX: 0000000000000000 RSI: 0000008000000000 RDI: 0000000000000000
> RBP: ffffc90000ccf650 R08: ffffffff81e17d58 R09: ffffed10222c680b
> R10: dfffe910222c680c R11: 1ffff110222c680a R12: ffff888111634128
> R13: ffffc90000ccf880 R14: 0000008410000000 R15: 0000000000000001
> FS:  00007f72635d2640(0000) GS:ffff88811b000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000565243379180 CR3: 000000010aa74000 CR4: 0000000000150eb0
> Call Trace:
>  <TASK>
>  do_writepages+0x397/0x640
>  filemap_fdatawrite_wbc+0x151/0x1b0
>  file_write_and_wait_range+0x1c9/0x2b0
>  ext4_sync_file+0x19e/0xa00
>  vfs_fsync_range+0x17b/0x190
>  ext4_buffered_write_iter+0x488/0x530
>  ext4_file_write_iter+0x449/0x1b90
>  vfs_write+0xbcd/0xf40
>  ksys_write+0x198/0x2c0
>  __x64_sys_write+0x7b/0x90
>  do_syscall_64+0x3d/0x90
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>  </TASK>
> 
> Fix the problem by clearing EXT4_STATE_MAY_INLINE_DATA when we are doing
> direct IO write to a file.

Looks good, thanks.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Reported-by: Tadeusz Struk <tadeusz.struk@linaro.org>
> Reported-by: syzbot+bd13648a53ed6933ca49@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=a1e89d09bbbcbd5c4cb45db230ee28c822953984
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/file.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 109d07629f81..cab5dfed1cd6 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -528,6 +528,12 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		ret = -EAGAIN;
>  		goto out;
>  	}
> +	/*
> +	 * Make sure inline data cannot be created anymore since we are going
> + 	 * to allocate blocks for DIO. We know the inode does not have any
> +	 * inline data now because ext4_dio_supported() checked for that.
> +	 */
> +	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
>  
>  	offset = iocb->ki_pos;
>  	count = ret;
> -- 
> 2.35.3
> 

