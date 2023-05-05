Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17B46F870A
	for <lists+linux-ext4@lfdr.de>; Fri,  5 May 2023 18:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjEEQvA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 May 2023 12:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjEEQu7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 May 2023 12:50:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAA113843;
        Fri,  5 May 2023 09:50:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8F41C228C4;
        Fri,  5 May 2023 16:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683305457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zPT0GNbrLPn2WOzHVENqDErkuUZ+X4IxxxJ3W2ZkErM=;
        b=cSVFEnb94dbwMgOTFX4MBhewNl2CKXGBZKtc/sXNdVmwvJNCkCHjoy6dW+dnR3UOjS8ys4
        pbe0EcJpkahfcEdoudxVWOr8eVvpf4eexIcQ7LpCjF8Cp7Gk+6A0BNc+h7IP11qsLs10FM
        jjs7yAS+YBOuUHQNfNM2qyv+RKmFi8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683305457;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zPT0GNbrLPn2WOzHVENqDErkuUZ+X4IxxxJ3W2ZkErM=;
        b=L5BgV2ruVzmdMQT02Xefv5VEnPbF3ZweHV39ppuRF1TjxykM4KSpUKRg4rMduaU8CKGpys
        0P0FjWt+cJauaPDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B81913513;
        Fri,  5 May 2023 16:50:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XQEZHvEzVWSCNAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 05 May 2023 16:50:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 034F3A0729; Fri,  5 May 2023 18:50:56 +0200 (CEST)
Date:   Fri, 5 May 2023 18:50:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com,
        syzbot+08106c4b7d60702dbc14@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: check iomap type only if ext4_iomap_begin() does
 not fail
Message-ID: <20230505165056.7yjsh5nlaf4blvh5@quack3>
References: <20230505132429.714648-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505132429.714648-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 05-05-23 21:24:29, Baokun Li wrote:
> When ext4_iomap_overwrite_begin() calls ext4_iomap_begin() map blocks may
> fail for some reason (e.g. memory allocation failure, bare disk write), and
> later because "iomap->type ! = IOMAP_MAPPED" triggers WARN_ON(). When ext4
> iomap_begin() returns an error, it is normal that the type of iomap->type
> may not match the expectation. Therefore, we only determine if iomap->type
> is as expected when ext4_iomap_begin() is executed successfully.
> 
> Reported-by: syzbot+08106c4b7d60702dbc14@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/00000000000015760b05f9b4eee9@google.com
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 0d5ba922e411..19c884abe52b 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3375,7 +3375,7 @@ static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
>  	 */
>  	flags &= ~IOMAP_WRITE;
>  	ret = ext4_iomap_begin(inode, offset, length, flags, iomap, srcmap);
> -	WARN_ON_ONCE(iomap->type != IOMAP_MAPPED);
> +	WARN_ON_ONCE(!ret && iomap->type != IOMAP_MAPPED);
>  	return ret;
>  }
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
