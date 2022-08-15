Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D0E593201
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Aug 2022 17:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiHOPen (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Aug 2022 11:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiHOPeX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Aug 2022 11:34:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456232716C;
        Mon, 15 Aug 2022 08:34:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C32F920494;
        Mon, 15 Aug 2022 15:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660577652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=doQZR9gdgjfRLRr7/LG4CObcQdYg6LUtm7BZea73Nic=;
        b=Xy2Ve+CsIteh2S0VVPfPNWa/WgoguLOqe1ShhkNZKRJFsVL3XxpJr+r93BovKkdm0Iu0+a
        5j4DJnZFGImYON9s3gyDe1GD2xe7RMK7lqHweHMoVe3uvkzXTj/x3XkYG5MI3j4T9YJFpo
        yUkbpRZHLhyQxc9nJHoL37uMRCZq5Sg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660577652;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=doQZR9gdgjfRLRr7/LG4CObcQdYg6LUtm7BZea73Nic=;
        b=sIeNR+4xzwrRbiBayvh4EKGXGS1bpvXmBK5qqzYSmLrl9TqQP1NPYgADsF0DB/91ZpOPJ/
        hoMCsE7KiCDhVdBA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 32C502C1D0;
        Mon, 15 Aug 2022 15:34:11 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A3DC2A066A; Mon, 15 Aug 2022 17:34:10 +0200 (CEST)
Date:   Mon, 15 Aug 2022 17:34:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, enwlinux@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: fix null-ptr-deref in ext4_write_info
Message-ID: <20220815153410.vupcecnlmcjr4fmg@quack3>
References: <20220805123947.565152-1-libaokun1@huawei.com>
 <20220805130726.a3otpkbrjv3ijumd@fedora>
 <c937578b-e7f2-79cb-2e81-3330edf2bf6c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c937578b-e7f2-79cb-2e81-3330edf2bf6c@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 10-08-22 15:20:48, Baokun Li wrote:
> 在 2022/8/5 21:07, Lukas Czerner 写道:
> > On Fri, Aug 05, 2022 at 08:39:47PM +0800, Baokun Li wrote:
> > > I caught a null-ptr-deref bug as follows:
> > > ==================================================================
> > > KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
> > > CPU: 1 PID: 1589 Comm: umount Not tainted 5.10.0-02219-dirty #339
> > > RIP: 0010:ext4_write_info+0x53/0x1b0
> > > [...]
> > > Call Trace:
> > >   dquot_writeback_dquots+0x341/0x9a0
> > >   ext4_sync_fs+0x19e/0x800
> > >   __sync_filesystem+0x83/0x100
> > >   sync_filesystem+0x89/0xf0
> > >   generic_shutdown_super+0x79/0x3e0
> > >   kill_block_super+0xa1/0x110
> > >   deactivate_locked_super+0xac/0x130
> > >   deactivate_super+0xb6/0xd0
> > >   cleanup_mnt+0x289/0x400
> > >   __cleanup_mnt+0x16/0x20
> > >   task_work_run+0x11c/0x1c0
> > >   exit_to_user_mode_prepare+0x203/0x210
> > >   syscall_exit_to_user_mode+0x5b/0x3a0
> > >   do_syscall_64+0x59/0x70
> > >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >   ==================================================================
> > > 
> > > Above issue may happen as follows:
> > > -------------------------------------
> > > exit_to_user_mode_prepare
> > >   task_work_run
> > >    __cleanup_mnt
> > >     cleanup_mnt
> > >      deactivate_super
> > >       deactivate_locked_super
> > >        kill_block_super
> > >         generic_shutdown_super
> > >          shrink_dcache_for_umount
> > >           dentry = sb->s_root
> > >           sb->s_root = NULL              <--- Here set NULL
> > >          sync_filesystem
> > >           __sync_filesystem
> > >            sb->s_op->sync_fs > ext4_sync_fs
> > >             dquot_writeback_dquots
> > >              sb->dq_op->write_info > ext4_write_info
> > >               ext4_journal_start(d_inode(sb->s_root), EXT4_HT_QUOTA, 2)
> > >                d_inode(sb->s_root)
> > >                 s_root->d_inode          <--- Null pointer dereference
> > > 
> > > To solve this problem, we use ext4_journal_start_sb directly
> > > to avoid s_root being used.
> > Are we syncing the file system after the superblock shutdown and getting
> > away with it? This does not look good. Do you have a reproducer?
> > 
> > Thanks!
> > -Lukas
> 
> Hi, Lukas!
> 
> This problem is triggered by a pressure test when I reproduce another
> problem.
> 
> So I didn't have the reproducer.
> 
> I looked at the error stack code and found that it seems there is something
> wrong.
> 
> Moreover, it's really weird to write code like
> "ext4_journal_start(d_inode(sb->s_root), ...)".

I agree. That looks like some leftover from the past. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > > ---
> > >   fs/ext4/super.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > index 9a66abcca1a8..0ce4565422f6 100644
> > > --- a/fs/ext4/super.c
> > > +++ b/fs/ext4/super.c
> > > @@ -6653,7 +6653,7 @@ static int ext4_write_info(struct super_block *sb, int type)
> > >   	handle_t *handle;
> > >   	/* Data block + inode block */
> > > -	handle = ext4_journal_start(d_inode(sb->s_root), EXT4_HT_QUOTA, 2);
> > > +	handle = ext4_journal_start_sb(sb, EXT4_HT_QUOTA, 2);
> > >   	if (IS_ERR(handle))
> > >   		return PTR_ERR(handle);
> > >   	ret = dquot_commit_info(sb, type);
> > > -- 
> > > 2.31.1
> > > 
> > .
> 
> 
> Thanks!
> 
> -- 
> With Best Regards,
> Baokun Li
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
