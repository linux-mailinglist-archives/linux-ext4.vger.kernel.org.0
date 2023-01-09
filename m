Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AD86623A4
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Jan 2023 12:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbjAILB0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Jan 2023 06:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbjAILBT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Jan 2023 06:01:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7624FE0E6;
        Mon,  9 Jan 2023 03:01:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9E7D276939;
        Mon,  9 Jan 2023 11:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673262076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6MDWNp0AMcrL6idSGaksqL52u7D4Q2OpZyCw/c718Pc=;
        b=oVCXnAswBKvptpC9XXNMCtovKLm+0X/MizAtRuI6AWnorBVWa6jrZdZyjd180xnahsu5se
        /2YKtxMwNrfia5s2mG7iMv8hY9Os6AYd+b4OL/sDC3O242+BGnmaU9UwIDc9ex5RQEQcP/
        jhWVq6mWuk1Jo65KYLNnIoeUH7hDX9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673262076;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6MDWNp0AMcrL6idSGaksqL52u7D4Q2OpZyCw/c718Pc=;
        b=qlkIGn5VW39hQPycRla3m0CVNjv5uuxVX4ZJ7dCjbvGrcVdtE0P4cJ535Y6McVHoHthv+n
        zhLjWrbOi7fDU0Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D9F7134AD;
        Mon,  9 Jan 2023 11:01:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4bGGIvzzu2PTMAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 09 Jan 2023 11:01:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 12E8EA0749; Mon,  9 Jan 2023 12:01:16 +0100 (CET)
Date:   Mon, 9 Jan 2023 12:01:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com,
        =?utf-8?B?THXDrXM=?= Henriques <lhenriques@suse.de>
Subject: Re: [PATCH v2 1/2] ext4: fail ext4_iget if special inode unallocated
Message-ID: <20230109110116.5haxgzrwiqila25h@quack3>
References: <20230107032126.4165860-1-libaokun1@huawei.com>
 <20230107032126.4165860-2-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230107032126.4165860-2-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 07-01-23 11:21:25, Baokun Li wrote:
> In ext4_fill_super(), EXT4_ORPHAN_FS flag is cleared after
> ext4_orphan_cleanup() is executed. Therefore, when __ext4_iget() is
> called to get an inode whose i_nlink is 0 when the flag exists, no error
> is returned. If the inode is a special inode, a null pointer dereference
> may occur. If the value of i_nlink is 0 for any inodes (except boot loader
> inodes) got by using the EXT4_IGET_SPECIAL flag, the current file system
> is corrupted. Therefore, make the ext4_iget() function return an error if
> it gets such an abnormal special inode.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199179
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216541
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216539
> Reported-by: Luís Henriques <lhenriques@suse.de>
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> V1->V2:
> 	-EFSCORRUPTED is returned instead of -ESTALE for special inode
> 	errors, and the extra parentheses are removed.
> 
>  fs/ext4/inode.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 9d9f414f99fe..ed7598127e7c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4872,13 +4872,6 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  		goto bad_inode;
>  	raw_inode = ext4_raw_inode(&iloc);
>  
> -	if ((ino == EXT4_ROOT_INO) && (raw_inode->i_links_count == 0)) {
> -		ext4_error_inode(inode, function, line, 0,
> -				 "iget: root inode unallocated");
> -		ret = -EFSCORRUPTED;
> -		goto bad_inode;
> -	}
> -
>  	if ((flags & EXT4_IGET_HANDLE) &&
>  	    (raw_inode->i_links_count == 0) && (raw_inode->i_mode == 0)) {
>  		ret = -ESTALE;
> @@ -4951,11 +4944,16 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  	 * NeilBrown 1999oct15
>  	 */
>  	if (inode->i_nlink == 0) {
> -		if ((inode->i_mode == 0 ||
> +		if ((inode->i_mode == 0 || flags & EXT4_IGET_SPECIAL ||
>  		     !(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_ORPHAN_FS)) &&
>  		    ino != EXT4_BOOT_LOADER_INO) {
> -			/* this inode is deleted */
> -			ret = -ESTALE;
> +			/* this inode is deleted or unallocated */
> +			if (flags & EXT4_IGET_SPECIAL) {
> +				ext4_error_inode(inode, function, line, 0,
> +						 "iget: special inode unallocated");
> +				ret = -EFSCORRUPTED;
> +			} else
> +				ret = -ESTALE;
>  			goto bad_inode;
>  		}
>  		/* The only unlinked inodes we let through here have
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
