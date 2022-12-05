Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D3F642588
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 10:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiLEJOG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 04:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiLEJNi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 04:13:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC75C60
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 01:13:37 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E9EA01FE42;
        Mon,  5 Dec 2022 09:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670231615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FZTe72ZtMhkOhBUPXowTV3lMOQ0Kq2zfS8RbxXUdoEs=;
        b=Or4ZkhEGJFTGOHav6bqLlcVOzV38kUCQqJdPmduqMHr37a8zLm5P7QyCOvm9gzbYCIu6Qy
        JmMVgM52W8qQbKWf+mQZibJt0aSFr2bVYVmTIpRpz+sLQLtTwTueVfD/DbUmq0N8jclMgQ
        E82jzptPkJJsddE0RCDRZL09MVu0z6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670231615;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FZTe72ZtMhkOhBUPXowTV3lMOQ0Kq2zfS8RbxXUdoEs=;
        b=znC+EInCDR9iM/514tyvza68c+U7S6vKdpjbkNjvTEQeQ+LZtsXQC+sVRXJ4U1Ic7r/mrl
        G9LbXiHrVMklDODg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DA03413326;
        Mon,  5 Dec 2022 09:13:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id xL8xNT+2jWOyWQAAGKfGzw
        (envelope-from <jack@suse.cz>); Mon, 05 Dec 2022 09:13:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 64117A0727; Mon,  5 Dec 2022 10:13:35 +0100 (CET)
Date:   Mon, 5 Dec 2022 10:13:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 0/11] ext4: Stop using ext4_writepage() for writeout
 of ordered data
Message-ID: <20221205091335.j2niiws6knrxmjjx@quack3>
References: <20221202163815.22928-1-jack@suse.cz>
 <20221203005256.cqrvojj47blasal7@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203005256.cqrvojj47blasal7@riteshh-domain>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 03-12-22 06:22:56, Ritesh Harjani wrote:
> On 22/12/02 07:39PM, Jan Kara wrote:
> > Hello,
> >
> > this patch series modifies ext4 so that we stop using ext4_writepage() for
> > writeout of ordered data during transaction commit (through
> > generic_writepages() from jbd2_journal_submit_inode_data_buffers()). Instead we
> > directly call ext4_writepages() from the
> > ext4_journal_submit_inode_data_buffers(). This is part of Christoph's effort
> > to get rid of the .writepage() callback in all filesystems.
> >
> > I have also modified ext4_writepages() to use write_cache_pages() instead of
> > generic_writepages() so now we don't expose .writepage hook at all. We still
> > keep ext4_writepage() as a callback for write_cache_pages(). We should refactor
> > that path as well and get rid of ext4_writepage() completely but that is for a
> > separate cleanup. Also note that jbd2 still uses generic_writepages() in its
> > jbd2_journal_submit_inode_data_buffers() helper because it is still used from
> > OCFS2. Again, something to be dealt with in a separate patchset.
> >
> > Changes since v1:
> > * Added Reviewed-by tags from Ritesh
> > * Added patch to get rid of generic_writepages() in ext4_writepages()
> > * Added patch to get rid of .writepage hook
> 
> Oh! And what about the WARN_ON_ONCE in ext4_writepages() while loop,
> which we were discussing here [1]. Do you think that will help in
> catching anything nasty?
> 
> [1]: https://lore.kernel.org/linux-ext4/20221201115500.kbxtteft3v4pzqqx@quack3/T/#mcf7b6cc301062e52a3600194b03a9fd872ba52c5

Ah, right. Forgot about this. Thanks for reminder.

> One thing I guess I missed in my previous review is the fast commit path.

Good point, I didn't think about that one :)

> In my overnight testing of previous patch series I observed this warning.
> 
> WARNING: CPU: 1 PID: 1746936 at fs/ext4/inode.c:1994 ext4_writepage+0x4e6/0x5e0
> RIP: 0010:ext4_writepage+0x4e6/0x5e0
> Call Trace:
>  <TASK>
>  __writepage+0x17/0x70
>  write_cache_pages+0x166/0x3c0
>  ? dirty_background_bytes_handler+0x30/0x30
>  ? finish_task_switch.isra.0+0x8e/0x260
>  ? _raw_spin_lock_irqsave+0x19/0x50
>  ? finish_wait+0x34/0x70
>  ? _raw_spin_unlock_irqrestore+0x1e/0x40
>  generic_writepages+0x4f/0x80
>  jbd2_journal_submit_inode_data_buffers+0x64/0x90
>  ext4_fc_commit+0x2e0/0x830
>  ? file_check_and_advance_wb_err+0x2e/0xd0
>  ? preempt_count_add+0x70/0xa0
>  ext4_sync_file+0x15c/0x380
>  __do_sys_msync+0x1c1/0x2a0
>  do_syscall_64+0x38/0x90
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Yep, that path needs conversion as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
