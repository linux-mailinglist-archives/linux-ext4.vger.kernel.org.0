Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488E26C460C
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Mar 2023 10:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCVJSU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Mar 2023 05:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjCVJST (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Mar 2023 05:18:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8165BA249;
        Wed, 22 Mar 2023 02:18:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7616020BC7;
        Wed, 22 Mar 2023 09:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679476695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KcgGMOaiMopzycoHQKkkOaB27fDxavS5OQvDM7b0kiw=;
        b=2h8Gjk3zEdriLqd09SvB73X0bmFZWnA+45fPY53CwMJXzyqOS1X7J7Nqvp68jKygiyIyKp
        JREz5NKzwgu5j/veNjtVFR06kRuXHHJldQ2QjS2bziwoeJyQQ+TDdad7fj4J+bL3W0tZpM
        9fMIYhx1ksd6DA4fzEi6CaX8WOQ7+/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679476695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KcgGMOaiMopzycoHQKkkOaB27fDxavS5OQvDM7b0kiw=;
        b=GYHdNaw9hc5K92B6fU89aVU2SpzDNopZQHTZi68OMvPSdObFT31hK9Cnu0dftX7ygX/Qlp
        3wgARzbHbBLK2iDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 331B013416;
        Wed, 22 Mar 2023 09:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aaZ5DNfHGmShXwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 22 Mar 2023 09:18:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1B8F3A071C; Wed, 22 Mar 2023 10:18:13 +0100 (CET)
Date:   Wed, 22 Mar 2023 10:18:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
        tudor.ambarus@linaro.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v2] ext4: Fix i_disksize exceeding i_size problem in
 paritally written case
Message-ID: <20230322091813.hy5t3q4om4mhvw32@quack3>
References: <20230321013721.89818-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321013721.89818-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 21-03-23 09:37:21, Zhihao Cheng wrote:
> Following process makes i_disksize exceed i_size:
> 
> generic_perform_write
>  copied = iov_iter_copy_from_user_atomic(len) // copied < len
>  ext4_da_write_end
>  | ext4_update_i_disksize
>  |  new_i_size = pos + copied;
>  |  WRITE_ONCE(EXT4_I(inode)->i_disksize, newsize) // update i_disksize
>  | generic_write_end
>  |  copied = block_write_end(copied, len) // copied = 0
>  |   if (unlikely(copied < len))
>  |    if (!PageUptodate(page))
>  |     copied = 0;
>  |  if (pos + copied > inode->i_size) // return false
>  if (unlikely(copied == 0))
>   goto again;
>  if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
>   status = -EFAULT;
>   break;
>  }
> 
> We get i_disksize greater than i_size here, which could trigger WARNING
> check 'i_size_read(inode) < EXT4_I(inode)->i_disksize' while doing dio:
> 
> ext4_dio_write_iter
>  iomap_dio_rw
>   __iomap_dio_rw // return err, length is not aligned to 512
>  ext4_handle_inode_extension
>   WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize) // Oops
> 
>  WARNING: CPU: 2 PID: 2609 at fs/ext4/file.c:319
>  CPU: 2 PID: 2609 Comm: aa Not tainted 6.3.0-rc2
>  RIP: 0010:ext4_file_write_iter+0xbc7
>  Call Trace:
>   vfs_write+0x3b1
>   ksys_write+0x77
>   do_syscall_64+0x39
> 
> Fix it by updating 'copied' value before updating i_disksize just like
> ext4_write_inline_data_end() does.
> 
> Fetch a reproducer in [Link].
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217209
> Fixes: 64769240bd07 ("ext4: Add delayed allocation support in data=writeback mode")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  v1->v2: Check and update 'copied' value before updating i_disksize rather
> 	 than opencoding generic_write_end().
>  fs/ext4/inode.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index bf0b7dea4900..41ba1c432844 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3148,6 +3148,9 @@ static int ext4_da_write_end(struct file *file,
>  	    ext4_has_inline_data(inode))
>  		return ext4_write_inline_data_end(inode, pos, len, copied, page);
>  
> +	if (unlikely(copied < len) && !PageUptodate(page))
> +		copied = 0;
> +
>  	start = pos & (PAGE_SIZE - 1);
>  	end = start + copied - 1;
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
