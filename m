Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C13F51FCEC
	for <lists+linux-ext4@lfdr.de>; Mon,  9 May 2022 14:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiEIMfi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 May 2022 08:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiEIMfh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 May 2022 08:35:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E5D262653;
        Mon,  9 May 2022 05:31:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C7AA01F948;
        Mon,  9 May 2022 12:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652099501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D3NP2+AfAwypB8dY0Q7Ug6eLsoFCTz9seHAEXMlM3rE=;
        b=ytxhXz4/4X/4ZUocjQYzh7Hr0W6tRQwbt9YKELwp2fkTQy/AbU5PuIOisC6RWWGKXGlIoj
        jP0uhhlOEZkzUXWku7fLVF8BiLEYVIY2ia8rkLziXFx7z1rJU8CWWGlJzjb8GzLsZ9tbn5
        oTHGnOCv2vK/30agcRle8RU5PymF+sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652099501;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D3NP2+AfAwypB8dY0Q7Ug6eLsoFCTz9seHAEXMlM3rE=;
        b=xjCMniOCStfULiGuvDqMybVagZXS58I0G6UrDb7F7bEXtB5AoQt/PKxZwcJvlCbP7xybJM
        JpEPL2tDrpGLqHAA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A99522C141;
        Mon,  9 May 2022 12:31:41 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4BC83A062A; Mon,  9 May 2022 14:31:38 +0200 (CEST)
Date:   Mon, 9 May 2022 14:31:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     yebin <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lczerner@redhat.com
Subject: Re: [PATCH -next] ext4: fix bug_on in ext4_writepages
Message-ID: <20220509123138.n3tmpybh2jf3x2eg@quack3.lan>
References: <20220505135708.2629657-1-yebin10@huawei.com>
 <20220505154713.nig6rj76p2gl5mm7@quack3.lan>
 <6274797D.6050303@huawei.com>
 <20220506085034.akzobmffzosg7rem@quack3.lan>
 <6275192C.5080300@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6275192C.5080300@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 06-05-22 20:48:44, yebin wrote:
> On 2022/5/6 16:50, Jan Kara wrote:
> > On Fri 06-05-22 09:27:25, yebin wrote:
> > > On 2022/5/5 23:47, Jan Kara wrote:
> > > > On Thu 05-05-22 21:57:08, Ye Bin wrote:
> > > > > we got issue as follows:
> > > > > EXT4-fs error (device loop0): ext4_mb_generate_buddy:1141: group 0, block bitmap and bg descriptor inconsistent: 25 vs 31513 free cls
> > > > > ------------[ cut here ]------------
> > > > > kernel BUG at fs/ext4/inode.c:2708!
> > > > > invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> > > > > CPU: 2 PID: 2147 Comm: rep Not tainted 5.18.0-rc2-next-20220413+ #155
> > > > > RIP: 0010:ext4_writepages+0x1977/0x1c10
> > > > > RSP: 0018:ffff88811d3e7880 EFLAGS: 00010246
> > > > > RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff88811c098000
> > > > > RDX: 0000000000000000 RSI: ffff88811c098000 RDI: 0000000000000002
> > > > > RBP: ffff888128140f50 R08: ffffffffb1ff6387 R09: 0000000000000000
> > > > > R10: 0000000000000007 R11: ffffed10250281ea R12: 0000000000000001
> > > > > R13: 00000000000000a4 R14: ffff88811d3e7bb8 R15: ffff888128141028
> > > > > FS:  00007f443aed9740(0000) GS:ffff8883aef00000(0000) knlGS:0000000000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 0000000020007200 CR3: 000000011c2a4000 CR4: 00000000000006e0
> > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > Call Trace:
> > > > >    <TASK>
> > > > >    do_writepages+0x130/0x3a0
> > > > >    filemap_fdatawrite_wbc+0x83/0xa0
> > > > >    filemap_flush+0xab/0xe0
> > > > >    ext4_alloc_da_blocks+0x51/0x120
> > > > >    __ext4_ioctl+0x1534/0x3210
> > > > >    __x64_sys_ioctl+0x12c/0x170
> > > > >    do_syscall_64+0x3b/0x90
> > > > > 
> > > > > It may happen as follows:
> > > > > 1. write inline_data inode
> > > > > vfs_write
> > > > >     new_sync_write
> > > > >       ext4_file_write_iter
> > > > >         ext4_buffered_write_iter
> > > > >           generic_perform_write
> > > > > 	  ext4_da_write_begin
> > > > > 	    ext4_da_write_inline_data_begin -> If inline data size too
> > > > > 	    small will allocate block to write, then mapping will has
> > > > > 	    dirty page
> > > > > 	    	ext4_da_convert_inline_data_to_extent ->clear EXT4_STATE_MAY_INLINE_DATA
> > > > > 2. fallocate
> > > > > do_vfs_ioctl
> > > > >     ioctl_preallocate
> > > > >       vfs_fallocate
> > > > >         ext4_fallocate
> > > > >           ext4_convert_inline_data
> > > > > 	  ext4_convert_inline_data_nolock
> > > > > 	    ext4_map_blocks -> fail will goto restore data
> > > > > 	    ext4_restore_inline_data
> > > > > 	      ext4_create_inline_data
> > > > > 	      ext4_write_inline_data
> > > > > 	      ext4_set_inode_state -> set inode EXT4_STATE_MAY_INLINE_DATA
> > > > > 3. writepages
> > > > > __ext4_ioctl
> > > > >     ext4_alloc_da_blocks
> > > > >       filemap_flush
> > > > >         filemap_fdatawrite_wbc
> > > > >           do_writepages
> > > > > 	  ext4_writepages
> > > > > 	    if (ext4_has_inline_data(inode))
> > > > > 	      BUG_ON(ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
> > > > > 
> > > > > To solved this issue, record origin 'EXT4_STATE_MAY_INLINE_DATA' flag, then pass
> > > > > value to 'ext4_restore_inline_data', 'ext4_restore_inline_data' will
> > > > > decide to if recovery 'EXT4_STATE_MAY_INLINE_DATA' flag according to parameter.
> > > > > 
> > > > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > > > I think this will get also fixed by a patch from your colleague I've
> > > > reviewed here [1], won't it?
> > > > 
> > > > [1] https://lore.kernel.org/all/20220428165725.mvjh6mx7gr5vekqe@quack3.lan
> > > > 
> > > The issue I fixed is not the same as the isuue my colleague fixed.
> > OK, maybe I've jumped to conclusion too early but the fix I've referenced
> > above will protect ext4_convert_inline_data() in ext4_fallocate() with
> > inode->i_rwsem so I think the race you describe with ext4_da_write_begin()
> > cannot happen. The inline conversion path with be entered either from
> > ext4_da_write_begin() or from ext4_fallocate() but not from both. If I'm
> > missing something, please explain how you think the problem happens with
> > the above fix applied... Thanks!
> > 
> > 								Honza
> It's happen as follows:
> step1:
> ext4_file_write_iter
>   ext4_buffered_write_iter
>     generic_perform_write
>       ext4_da_write_begin
>         if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
>           ext4_da_write_inline_data_begin
>             ext4_da_convert_inline_data_to_extent
>               __block_write_begin
>               ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
>             ->clear EXT4_STATE_MAY_INLINE_DATA flag,  If inline data size
> too
>         small will allocate block to write, then mapping will has dirty page
> 
>       ext4_da_write_end
>         generic_write_end
> 
> step2：
> vfs_fallocate
>   ext4_fallocate
>     ext4_convert_inline_data
>       if (ext4_has_inline_data(inode))  -> This condition is satisfied
>         ext4_convert_inline_data_nolock
>           ext4_map_blocks -> fail will goto restore data
>           ext4_restore_inline_data
>            ext4_create_inline_data
>            ext4_write_inline_data
>            ext4_set_inode_state -> set inode EXT4_STATE_MAY_INLINE_DATA
> step3:
> do_writepages
>   ext4_writepages
>     if (ext4_has_inline_data(inode))
>       BUG_ON(ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
> 
> As we call "ext4_destroy_inline_data" to destory inline data when delay
> allocation.  So，if we call fallocate before writepages while
> ext4_map_blocks return failed, will lead to above issue.  This issue does
> not require concurrency conditions.

Aha, I see now. Thanks for explanation and sorry for being a bit dense.
I'll have a look at your original patch.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
