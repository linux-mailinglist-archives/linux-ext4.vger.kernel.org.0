Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F7B6FB0C9
	for <lists+linux-ext4@lfdr.de>; Mon,  8 May 2023 15:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjEHNBi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 May 2023 09:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbjEHNBf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 May 2023 09:01:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F7639193
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 06:01:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 312F121FB6;
        Mon,  8 May 2023 13:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683550891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U2pPHQEs5vuc5rVQp916bvbwMf/lld84n13snyVIL+Q=;
        b=1oKsLxpmVdQYy34Bi467lGw+HnRAzKIcGcjxjQDH4f78zsQe5EaEJ2Mqjs1vQRvL2iAtpK
        T2IcCajnvhlv608RGjysa8iS1GmNaFhMCfS0+mALDxLf3nJGFiJKiwUmkDYJ5JbLo1AGIa
        bv6b+zy9/4m5Hg+jjC3EY6Dhz14qPzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683550891;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U2pPHQEs5vuc5rVQp916bvbwMf/lld84n13snyVIL+Q=;
        b=JPRLzDBMQ0POIE/Cvbtf+R6hrR+9mvpQI8cIA1YnN8a5iM1ow4QAXchMjZtLlOk2HAXjNH
        RRkb+BxIXxqpSQDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0936139F8;
        Mon,  8 May 2023 13:01:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SxKgOqryWGSiXQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 08 May 2023 13:01:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DD96AA0749; Sun,  7 May 2023 20:31:19 +0200 (CEST)
Date:   Sun, 7 May 2023 20:31:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        syzbot+64b645917ce07d89bde5@syzkaller.appspotmail.com,
        syzbot+0d042627c4f2ad332195@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix invalid free tracking in
 ext4_xattr_move_to_block()
Message-ID: <20230507183119.o5hqzh5qduzqdidz@quack3>
References: <20230430160426.581366-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430160426.581366-1-tytso@mit.edu>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 30-04-23 12:04:26, Theodore Ts'o wrote:
> In ext4_xattr_move_to_block(), the value of the extended attribute
> which we need to move to an external block may be allocated by
> kvmalloc() if the value is stored in an external inode.  So at the end
> of the function the code tried to check if this was the case by
> testing entry->e_value_inum.
> 
> However, at this point, the pointer to the xattr entry is no longer
> valid, because it was removed from the original location where it had
> been stored.  So we could end up calling kvfree() on a pointer which
> was not allocated by kvmalloc(); or we could also potentially leak
> memory by not freeing the buffer when it should be freed.  Fix this by
> storing whether it should be freed in a separate variable.
> 
> Link: https://syzkaller.appspot.com/bug?id=5c2aee8256e30b55ccf57312c16d88417adbd5e1
> Link: https://syzkaller.appspot.com/bug?id=41a6b5d4917c0412eb3b3c3c604965bed7d7420b
> Reported-by: syzbot+64b645917ce07d89bde5@syzkaller.appspotmail.com
> Reported-by: syzbot+0d042627c4f2ad332195@syzkaller.appspotmail.com
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Good spotting. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/xattr.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 767454d74cd6..e33a323faf3c 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2615,6 +2615,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
>  		.in_inode = !!entry->e_value_inum,
>  	};
>  	struct ext4_xattr_ibody_header *header = IHDR(inode, raw_inode);
> +	int needs_kvfree = 0;
>  	int error;
>  
>  	is = kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
> @@ -2637,7 +2638,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
>  			error = -ENOMEM;
>  			goto out;
>  		}
> -
> +		needs_kvfree = 1;
>  		error = ext4_xattr_inode_get(inode, entry, buffer, value_size);
>  		if (error)
>  			goto out;
> @@ -2676,7 +2677,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
>  
>  out:
>  	kfree(b_entry_name);
> -	if (entry->e_value_inum && buffer)
> +	if (needs_kvfree && buffer)
>  		kvfree(buffer);
>  	if (is)
>  		brelse(is->iloc.bh);
> -- 
> 2.31.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
