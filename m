Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8439D574D61
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 14:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbiGNMYN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 08:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239053AbiGNMYH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 08:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F5D61E3FB
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 05:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657801436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MrPaXkPo48S62oyKwvoLWRP8ZNCtWIGO5OoUipqtqks=;
        b=XvhGV5mA53S2no5sS/w2tcORSoxldssdTehRBSTKP6bFOnal2FYnhXihGc0ZrrC2Py1cJz
        R/VRN99gGgqJnKKXDaF3CglMMAo05kEVrFa77XF9cx7lZ26ONPsGYohpckFgJVBGgkauSc
        ebw16LVsGM3PSSHYSCXMj8ASe7bVUAk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-rwE3kNxnPQGg9Awn6Uptgg-1; Thu, 14 Jul 2022 08:23:55 -0400
X-MC-Unique: rwE3kNxnPQGg9Awn6Uptgg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40EB038041E1;
        Thu, 14 Jul 2022 12:23:55 +0000 (UTC)
Received: from fedora (unknown [10.40.193.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 17E93906B6;
        Thu, 14 Jul 2022 12:23:53 +0000 (UTC)
Date:   Thu, 14 Jul 2022 14:23:51 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix kernel BUG in ext4_free_blocks
Message-ID: <20220714122351.vtiai34zvrrg2np2@fedora>
References: <20220713185904.64138-1-tadeusz.struk@linaro.org>
 <20220714095300.ffij7re6l5n6ixlg@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714095300.ffij7re6l5n6ixlg@fedora>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 14, 2022 at 11:53:00AM +0200, Lukas Czerner wrote:
> On Wed, Jul 13, 2022 at 11:59:04AM -0700, Tadeusz Struk wrote:
> > Syzbot reported a BUG in ext4_free_blocks.
> > The issue is triggered from ext4_mb_clear_bb(). What happens is the
> > block number passed to ext4_get_group_no_and_offset() is 0 and the
> > es->s_first_data_block is 1. This makes block group number returned
> > from ext4_get_group_no_and_offset equal to -1. This is then passed to
> > ext4_get_group_info() and hits a BUG:
> > BUG_ON(group >= EXT4_SB(sb)->s_groups_count),
> > what can be seen in the trace below.
> > This patch adds an assertion to ext4_get_group_no_and_offset() that
> > checks if block number is not smaller than es->s_first_data_block.
> > 
> > kernel BUG at fs/ext4/ext4.h:3319!
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 337 Comm: repro Not tainted 5.19.0-rc6-00105-g4e8e898e4107-dirty #14
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
> > RIP: 0010:ext4_mb_clear_bb+0x1bd6/0x1be0
> > Call Trace:
> >  <TASK>
> >  ext4_free_blocks+0x9b3/0xc90
> >  ext4_clear_blocks+0x344/0x3b0
> >  ext4_ind_truncate+0x967/0x1050
> >  ext4_truncate+0xb1b/0x1210
> >  ext4_evict_inode+0xf06/0x16f0
> >  evict+0x2a3/0x630
> >  iput+0x618/0x850
> >  ext4_enable_quotas+0x578/0x920
> >  ext4_orphan_cleanup+0x539/0x1200
> >  ext4_fill_super+0x94d8/0x9bc0
> >  get_tree_bdev+0x40c/0x630
> >  ext4_get_tree+0x1c/0x20
> >  vfs_get_tree+0x88/0x290
> >  do_new_mount+0x289/0xac0
> >  path_mount+0x607/0xfd0
> >  __se_sys_mount+0x2c4/0x3b0
> >  __x64_sys_mount+0xbf/0xd0
> >  do_syscall_64+0x3d/0x90
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >  </TASK>
> > 
> > Link: https://syzkaller.appspot.com/bug?id=5266d464285a03cee9dbfda7d2452a72c3c2ae7c
> > Reported-by: syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com
> > Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
> > ---
> >  fs/ext4/balloc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> > index 78ee3ef795ae..1175750ad05f 100644
> > --- a/fs/ext4/balloc.c
> > +++ b/fs/ext4/balloc.c
> > @@ -56,6 +56,9 @@ void ext4_get_group_no_and_offset(struct super_block *sb, ext4_fsblk_t blocknr,
> >  	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
> >  	ext4_grpblk_t offset;
> >  
> > +	if (blocknr < le32_to_cpu(es->s_first_data_block))
> > +		blocknr = le32_to_cpu(es->s_first_data_block);
> > +
> 
> This does not seem right. we should never work with block number smaller
> than s_first_data_block. The first 1024 bytes of the file system are
> unused and in case we have 1k block size, the entire first block is
> unused.
> 
> I guess the image we work here with is corrupted, from the log it seems
> that it was noticed correctly so the question is why did we still ended
> up calling ext4_free_blocks() ? Seems like this should have been stopped
> earlier by ext4_clear_blocks() ?
> 
> I did notice that in ext4_mb_clear_bb() we call
> ext4_get_group_no_and_offset() before ext4_inode_block_valid() but
> again we should have caught this problem earlier.
> 
> Can you link me the file system image that generated this problem?

ok, I got the syzkaller C repro to work. The problem is that it's
bigalloc file system and the 'block' and 'count' to free in
ext4_free_blocks will get adjusted after the ext4_inode_block_valid().

We should make sure that if this happens we also clear the
EXT4_FREE_BLOCKS_VALIDATED. Additonally the ext4_inode_block_valid()
in ext4_mb_clear_bb() should be called *before* the values are taken for
granted. I'll prepare a patch to fix this.

-Lukas

> 
> Thanks!
> -Lukas
> 
> 
> >  	blocknr = blocknr - le32_to_cpu(es->s_first_data_block);
> >  	offset = do_div(blocknr, EXT4_BLOCKS_PER_GROUP(sb)) >>
> >  		EXT4_SB(sb)->s_cluster_bits;
> > -- 
> > 2.36.1
> > 
> 

