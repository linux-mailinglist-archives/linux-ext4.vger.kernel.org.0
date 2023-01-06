Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4D7660220
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Jan 2023 15:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjAFO3P (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Jan 2023 09:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbjAFO2w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Jan 2023 09:28:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FF98098A;
        Fri,  6 Jan 2023 06:28:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 74F2F26DCA;
        Fri,  6 Jan 2023 14:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673015327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jWhwBmc6jVqlji7XjoDlLyMjVrvx0Sf4cvF9Ig+aKjQ=;
        b=h6Lf5cQxd6aGyHLpIohwFGSPGVvZiiS6Pd3WPPEb/VoI+ywPu8pNScQCPgEA58we8EftPL
        Vv9Hs+FWYq+dFzf6U3GQ02xIwm4HgFSskA8uNlkl6EtRLJZe1HhF9pNXvdA5XKd4M01wI0
        Kp2sk+zBSZd+r38NN2Gw4Tcm4dm1DJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673015327;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jWhwBmc6jVqlji7XjoDlLyMjVrvx0Sf4cvF9Ig+aKjQ=;
        b=H248v/4nact9OFjsRurZp0rqotrrHcw+VHY18i7xMr4TvbQ0kywd3X1Jpujp+qTKPBAzB8
        l+8Vq+WB3qJr6QAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67A5A13596;
        Fri,  6 Jan 2023 14:28:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MPYyGR8wuGM5egAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 06 Jan 2023 14:28:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C7A26A0742; Fri,  6 Jan 2023 15:28:46 +0100 (CET)
Date:   Fri, 6 Jan 2023 15:28:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com,
        =?utf-8?B?THXDrXM=?= Henriques <lhenriques@suse.de>
Subject: Re: [PATCH 1/2] ext4: fail ext4_iget if special inode unallocated
Message-ID: <20230106142846.rzkflbdedv2oyrro@quack3>
References: <20230106104706.2410740-1-libaokun1@huawei.com>
 <20230106104706.2410740-2-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230106104706.2410740-2-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 06-01-23 18:47:05, Baokun Li wrote:
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

Thanks for the patch! A few comments below.

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 9d9f414f99fe..3f7cfa91ba89 100644
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
> @@ -4951,10 +4944,13 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  	 * NeilBrown 1999oct15
>  	 */
>  	if (inode->i_nlink == 0) {
> -		if ((inode->i_mode == 0 ||
> +		if ((inode->i_mode == 0 || (flags & EXT4_IGET_SPECIAL) ||
					   ^ extra parenthesis here  ^
>  		     !(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_ORPHAN_FS)) &&
>  		    ino != EXT4_BOOT_LOADER_INO) {
>  			/* this inode is deleted */
> +			if (flags & EXT4_IGET_SPECIAL)
> +				ext4_error_inode(inode, function, line, 0,
> +						 "iget: special inode unallocated");

I think it would be better to return -EFSCORRUPTED and not -ESTALE in this
case.

>  			ret = -ESTALE;
>  			goto bad_inode;
>  		}

Otherwise the patch looks good to me.

									Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
