Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D8465BE09
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jan 2023 11:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbjACK2Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Jan 2023 05:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjACK1o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Jan 2023 05:27:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658016460
        for <linux-ext4@vger.kernel.org>; Tue,  3 Jan 2023 02:27:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DACF738486;
        Tue,  3 Jan 2023 10:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672741661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WLq0fRV8ljacm4vpvcLnUuskYoWaivxA5Z976CGKjHg=;
        b=LohvyU/7ZgsmBhEBEpiv1Yab6vDEzBxojZyMb30+lV3j+F/cMKiUav5r7DEpsRiB7Fi+fn
        XUdySdMGHdx6QfeVw1j/6/b7CA5RDuMChipRJowTXtBsyxW8/dojEeD7kw7nWKKou97R7a
        lQeTBEppgLvso0l0GSgLChzX0/gu+AY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672741661;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WLq0fRV8ljacm4vpvcLnUuskYoWaivxA5Z976CGKjHg=;
        b=lS0fysPfUPHU6K7D03hOIdda23UAPfN4UmnzBUq31a16rcZo1TpqMOOgFAJWaPSBtY06dI
        OmZXJ61BtZDTC3Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4ECD1392B;
        Tue,  3 Jan 2023 10:27:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PWkjLB0DtGP5QgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 03 Jan 2023 10:27:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C1877A0742; Tue,  3 Jan 2023 11:27:40 +0100 (CET)
Date:   Tue, 3 Jan 2023 11:27:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        yi.zhang@huawei.com, yebin10@huawei.com, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com
Subject: Re: [PATCH] ext4: fix inode tree inconsistency caused by ENOMEM
Message-ID: <20230103102740.y2dvtif4gdbmrbg2@quack3>
References: <20230103022812.130603-1-zhanchengbin1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103022812.130603-1-zhanchengbin1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 03-01-23 10:28:12, zhanchengbin wrote:
> If ENOMEM fails when the extent is splitting, we need to restore the length
> of the split extent.
> In the ext4_split_extent_at function, only in ext4_ext_create_new_leaf will
> it alloc memory and change the shape of the extent tree,even if an ENOMEM
> is returned at this time, the extent tree is still self-consistent, Just
> restore the split extent lens in the function ext4_split_extent_at.
> 
> ext4_split_extent_at
>  ext4_ext_insert_extent
>   ext4_ext_create_new_leaf
>    1)ext4_ext_split
>      ext4_find_extent
>    2)ext4_ext_grow_indepth
>      ext4_find_extent
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>

Yeah that should work. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Another solution is to add the __GFP_NOFAIL flag when allocating memory.
> 
>  fs/ext4/extents.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 9de1c9d1a13d..3559ea6b0781 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3251,7 +3251,7 @@ static int ext4_split_extent_at(handle_t *handle,
>  		ext4_ext_mark_unwritten(ex2);
>  
>  	err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
> -	if (err != -ENOSPC && err != -EDQUOT)
> +	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
>  		goto out;
>  
>  	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
