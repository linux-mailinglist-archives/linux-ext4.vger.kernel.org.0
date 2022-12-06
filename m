Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D976442F0
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Dec 2022 13:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiLFMHo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Dec 2022 07:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiLFMHc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Dec 2022 07:07:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8C410A4;
        Tue,  6 Dec 2022 04:07:29 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F174C1FE5A;
        Tue,  6 Dec 2022 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670328447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0MdoAji2a6ESEr9wOlH0pwNx+hoaZ1RmIAjJL4Ub/Bo=;
        b=nPx8y8QBfODCsA4ZrT4OGwBf/ulZHedx8dFCnNVkrwCHuAuwdXqMGAe7V3TobArrlbw9dX
        1sPYMqiQoRLjXyH19yMjmrVBuLPz6SNcAXtxrAlMLo/TwopKORmDG2TTOsA9PA5v0mAkkF
        L8aIIymFbOQYDmJrP3pkJ90KJD8AtVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670328447;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0MdoAji2a6ESEr9wOlH0pwNx+hoaZ1RmIAjJL4Ub/Bo=;
        b=9ENRE1W35SDZyjMRcfNzHAa4EXzB0ET94ix+aHuAuYB2KOMnvrwE684C2f9gD3Y6GY0S84
        r/ZUsRajGcEam5Cg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E3D4B132F3;
        Tue,  6 Dec 2022 12:07:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 4sqdN38wj2NDXAAAGKfGzw
        (envelope-from <jack@suse.cz>); Tue, 06 Dec 2022 12:07:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 77B85A0725; Tue,  6 Dec 2022 13:07:27 +0100 (CET)
Date:   Tue, 6 Dec 2022 13:07:27 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH -next 5/6] ext4: rename xattr_find_entry() and
 __xattr_check_inode()
Message-ID: <20221206120727.ak2txwu72zomtwxe@quack3>
References: <20221206015806.3420321-1-yebin@huaweicloud.com>
 <20221206015806.3420321-6-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206015806.3420321-6-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 06-12-22 09:58:05, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> xattr_find_entry() and __xattr_check_inode() is in EXT4 xattr module. so
> add 'ext4' prefix to unify name style.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks nice. Just one nit below:

> @@ -1862,7 +1862,7 @@ ext4_xattr_block_find(struct inode *inode, struct ext4_xattr_info *i,
>  		bs->s.first = BFIRST(bs->bh);
>  		bs->s.end = bs->bh->b_data + bs->bh->b_size;
>  		bs->s.here = bs->s.first;
> -		error = xattr_find_entry(inode, &bs->s.here, bs->s.end,
> +		error = ext4_xattr_find_entry(inode, &bs->s.here, bs->s.end,
>  					 i->name_index, i->name, 1);
>  		if (error && error != -ENODATA)
>  			return error;
> @@ -2222,11 +2222,11 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
>  	is->s.here = is->s.first;
>  	is->s.end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
>  	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
> -		error = xattr_check_inode(inode, header, is->s.end);
> +		error = ext4_xattr_check_inode(inode, header, is->s.end);
>  		if (error)
>  			return error;
>  		/* Find the named attribute. */
> -		error = xattr_find_entry(inode, &is->s.here, is->s.end,
> +		error = ext4_xattr_find_entry(inode, &is->s.here, is->s.end,
>  					 i->name_index, i->name, 0);
>  		if (error && error != -ENODATA)
>  			return error;

The indentation of arguments in the above should be updated as well to look
like:

		error = ext4_xattr_find_entry(inode, &is->s.here, is->s.end,
					      i->name_index, i->name, 0);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
