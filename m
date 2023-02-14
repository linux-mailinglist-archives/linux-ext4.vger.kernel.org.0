Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9276963E9
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Feb 2023 13:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjBNMwQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Feb 2023 07:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjBNMwP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Feb 2023 07:52:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9FF10FC
        for <linux-ext4@vger.kernel.org>; Tue, 14 Feb 2023 04:52:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 75DEB21D82;
        Tue, 14 Feb 2023 12:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676379132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Osg1VyqjofsjGy3y84UHeVrjI9q8Dokh042I6TjmQE=;
        b=Fd6b/iomQl2yw/QPMRZKUxb+24zS+bjPd6diqa1x6NmVea3x9os8XNJYqo2XTN09oFkglI
        RKiLfziYTfsLeiERnosmBXqbiLpjo79JmL7bW3iKvsLscAsv15rlIpbLNjmdbC3DKl8LtJ
        Oli5iPownB4619BnmQ+j5D75VDPx6zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676379132;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Osg1VyqjofsjGy3y84UHeVrjI9q8Dokh042I6TjmQE=;
        b=5ou1Whg65mCMG7sv5YZabtn5TmbGGNjJaVJTWA7Yy0S8t/YxJ3F7aqGMFUtcsT9Rlrcr9Y
        RELg5fsViFGQs4Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61A46138E3;
        Tue, 14 Feb 2023 12:52:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vu7NF/yD62ORJQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 14 Feb 2023 12:52:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BAE94A06D8; Tue, 14 Feb 2023 13:52:11 +0100 (CET)
Date:   Tue, 14 Feb 2023 13:52:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        yi.zhang@huawei.com, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 2/2] ext4: clear the verified flag of the modified
 leaf or idx if error
Message-ID: <20230214125211.o2j3vpkopvas2niq@quack3>
References: <20230213080514.535568-1-zhanchengbin1@huawei.com>
 <20230213080514.535568-3-zhanchengbin1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213080514.535568-3-zhanchengbin1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 13-02-23 16:05:14, zhanchengbin wrote:
> Clear the verified flag from the modified bh when failed in ext4_ext_rm_idx
> or ext4_ext_correct_indexes.
> In this way, the start value of the logical block itself and its
> parents' will be checked in ext4_valid_extent_entries.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202302131414.5RKeHgAZ-lkp@intel.com/
> Link: https://lore.kernel.org/oe-kbuild-all/202302131407.XrieHNuN-lkp@intel.com/

Thanks for the patch! Two comments below:

> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 0f95e857089e..bbf34679e10c 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -1756,6 +1756,8 @@ static int ext4_ext_correct_indexes(handle_t *handle, struct inode *inode,
>  		if (err)
>  			break;
>  	}
> +	while (!(k < 0) && k++ < depth)
> +		clear_buffer_verified(path[k].p_bh);

This would be more understandable as:

	if (k >= 0)
		while (k++ < depth)
			...

Also the loop is IMO wrong because it will run with k == depth as well (due
to post-increment) and that is not initialized. Furthermore it will run
also if we exit the previous loop due to:

                /* change all left-side indexes */
                if (path[k+1].p_idx != EXT_FIRST_INDEX(path[k+1].p_hdr))
                        break;

which is unwanted as well. Which suggests that you didn't test your changes
much (if at all...). So please make sure your changes are tested next time.
Thank you!

								Honza

>  
>  	return err;
>  }
> @@ -2304,6 +2306,7 @@ static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
>  {
>  	int err;
>  	ext4_fsblk_t leaf;
> +	int b_depth = depth;
>  
>  	/* free index block */
>  	depth--;
> @@ -2345,6 +2348,9 @@ static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
>  		if (err)
>  			break;
>  	}
> +	while (!(depth < 0) && depth++ < b_depth - 1)
> +		clear_buffer_verified(path[depth].p_bh);
> +
>  	return err;
>  }
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
