Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9D96C10AA
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Mar 2023 12:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjCTLVT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Mar 2023 07:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjCTLU4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Mar 2023 07:20:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFA9A2;
        Mon, 20 Mar 2023 04:20:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 982421F86C;
        Mon, 20 Mar 2023 11:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679311238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=txOGnZ8/Pa5itReU7gFMvzIp1cdxXBCMH8CKi+tOGU4=;
        b=fVGfqRUEesqYmxQkLjSGwURYl8kf83Bhyqo6FTw/ZsE9N+UI2mQs6bR7vVnmyeqCaqU0Yb
        fxAM7tFXoZcwEZ7cR8F64w775iDYZOKwZchU8SxrFh6fLb3nrlc54e+IZr5uVk7gEM/YN2
        oCIN+t4SRVBMAtiubQ+ajTKCrOhc7/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679311238;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=txOGnZ8/Pa5itReU7gFMvzIp1cdxXBCMH8CKi+tOGU4=;
        b=9xOas0vAFYpzlxKucsUCTDzYGtpbMx4Szkl6TA04NsjqRgAEAnxBIOXdA5a+MWqABn5M6k
        fVX5BxGlisiAHdBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A51813416;
        Mon, 20 Mar 2023 11:20:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nhq2IYZBGGQXMgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 20 Mar 2023 11:20:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 18346A0719; Mon, 20 Mar 2023 12:20:38 +0100 (CET)
Date:   Mon, 20 Mar 2023 12:20:38 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.com, tudor.ambarus@linaro.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] ext4: Fix i_disksize exceeding i_size problem in
 paritally written case
Message-ID: <20230320112038.3q2eqpv6xsmj22br@quack3>
References: <20230317013553.1009553-1-chengzhihao1@huawei.com>
 <20230317124513.drx3wywcjnap5jme@quack3>
 <884950ac-e60a-d331-9f68-310ab81ee595@huawei.com>
 <71990726-c677-34df-d29b-a0fec1a6f68c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71990726-c677-34df-d29b-a0fec1a6f68c@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 18-03-23 16:51:00, Zhihao Cheng wrote:
> > Hi, Jan
> > > On Fri 17-03-23 09:35:53, Zhihao Cheng wrote:
> > > > Following process makes i_disksize exceed i_size:
> > > > 
> > > > generic_perform_write
> > > >   copied = iov_iter_copy_from_user_atomic(len) // copied < len
> > > >   ext4_da_write_end
> > > >   | ext4_update_i_disksize
> > > >   |  new_i_size = pos + copied;
> > > >   |  WRITE_ONCE(EXT4_I(inode)->i_disksize, newsize) // update i_disksize
> > > >   | generic_write_end
> > > >   |  copied = block_write_end(copied, len) // copied = 0
> > > >   |   if (unlikely(copied < len))
> > > >   |    if (!PageUptodate(page))
> > > >   |     copied = 0;
> > > >   |  if (pos + copied > inode->i_size) // return false
> > > >   if (unlikely(copied == 0))
> > > >    goto again;
> > > >   if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
> > > >    status = -EFAULT;
> > > >    break;
> > > >   }
> > > > 
> > > > We get i_disksize greater than i_size here, which could trigger WARNING
> > > > check 'i_size_read(inode) < EXT4_I(inode)->i_disksize' while doing dio:
> > > > 
> > > > ext4_dio_write_iter
> > > >   iomap_dio_rw
> > > >    __iomap_dio_rw // return err, length is not aligned to 512
> > > >   ext4_handle_inode_extension
> > > >    WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize) // Oops
> > > > 
> > > >   WARNING: CPU: 2 PID: 2609 at fs/ext4/file.c:319
> > > >   CPU: 2 PID: 2609 Comm: aa Not tainted 6.3.0-rc2
> > > >   RIP: 0010:ext4_file_write_iter+0xbc7
> > > >   Call Trace:
> > > >    vfs_write+0x3b1
> > > >    ksys_write+0x77
> > > >    do_syscall_64+0x39
> > > > 
> > > > Fix it by putting block_write_end() before i_disksize updating just
> > > > like ext4_write_end() does.
> > > > 
> > > > Fetch a reproducer in [Link].
> > > > 
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=217209
> > > > Fixes: 64769240bd07f ("ext4: Add delayed allocation support in
> > > > data=writeback mode")
> > > > Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> > > 
> > > Good catch (although practically this will hardly have any negative
> > > effect). But rather than opencoding generic_write_end() I'd do:
> > > 
> > >          if (unlikely(copied < len) && !PageUptodate(page))
> > >                  copied = 0;
> > > 
> > > at the beginning of ext4_da_write_end() and that should solve these
> > > problems as well?
> > > 
> > 
> > Yes, your suggestion looks good, and I think we can put the checking
> > just after ext4_write_inline_data_end(Line 3150)? On the one hand, we
> > can pass original 'copied' value in trace_ext4_da_write_end(), one the
> > other hand, ext4_write_inline_data_end() already has this checking.
> > .
> 
> BTW, I want send another patch as follows:
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index bf0b7dea4900..570a687ae847 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3149,7 +3149,7 @@ static int ext4_da_write_end(struct file *file,
>                 return ext4_write_inline_data_end(inode, pos, len, copied,
> page);
> 
>         start = pos & (PAGE_SIZE - 1);
> -       end = start + copied - 1;
> +       end = start + (copied ? copied - 1 : copied);
> 
>         /*
>          * Since we are holding inode lock, we are sure i_disksize <=
> @@ -3167,7 +3167,7 @@ static int ext4_da_write_end(struct file *file,
>          * ext4_da_write_inline_data_end().
>          */
>         new_i_size = pos + copied;
> -       if (copied && new_i_size > inode->i_size &&
> +       if (new_i_size > inode->i_size &&
>             ext4_da_should_update_i_disksize(page, end))
>                 ext4_update_i_disksize(inode, new_i_size);
> 
> This modification handle unconsistent i_size and i_disksize imported by
> ea51d132dbf9 ("ext4: avoid hangs in ext4_da_should_update_i_disksize()").
> 
> Paritially written may display a fake inode size for user, for example:
> 
> 
> 
> i_disksize=1
> 
> generic_perform_write
> 
>  copied = iov_iter_copy_from_user_atomic(len) // copied = 0
> 
>  ext4_da_write_end // skip updating i_disksize
> 
>  generic_write_end
> 
>   if (pos + copied > inode->i_size) {  // 10 + 0 > 1, true
> 
>    i_size_write(inode, pos + copied);  // i_size = 10
> 
>   }
> 
> 
> 
>    0 1      10                4096
> 
>    |_|_______|_________..._____|
> 
>      |       |
> 
>     i_size  pos
> 
> 
> 
> Now, user see the i_size is 10 (i_disksize is still 1). After inode
> 
> destroyed, user will get the i_size is 1 read from disk.

OK, but shouldn't we rather change generic_write_end() to not increase
i_size if no write happened? Because that is what seems somewhat
problematic...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
