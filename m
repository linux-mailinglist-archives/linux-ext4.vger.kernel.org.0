Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128836ABF7D
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Mar 2023 13:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjCFMaN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Mar 2023 07:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjCFMaM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Mar 2023 07:30:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D83520076;
        Mon,  6 Mar 2023 04:30:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E65F3223E4;
        Mon,  6 Mar 2023 12:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678105809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bx1jsO/P8097xBEBJpSzCoB7uzE2WNezm82adktscac=;
        b=cuw8vHDl9dJVsL89RgPr/dYxtP3QP/qm6KI6fHmKL4FvbyrgIbN6g4fgNdgo3nr6BdKIbw
        VYBtibSou9Y16RFftXNcgmBWsE4nJh5t0rZbakKLakk7fW3qj83vTZGBdQckr8Mu7K4O/b
        jdURiw/59ehxePqPCwyyywkLwgePKy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678105809;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bx1jsO/P8097xBEBJpSzCoB7uzE2WNezm82adktscac=;
        b=9/EHIWCyCPyEWMT4837eZ9VGVPZEal7tfeqMnIZiOB4P7JbJim8xt6fahR9KSE0Zmw6obZ
        NiHQWGZszxqzWPBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA66E13A66;
        Mon,  6 Mar 2023 12:30:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 27JKNdHcBWTbPgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 06 Mar 2023 12:30:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 64903A064F; Mon,  6 Mar 2023 13:30:09 +0100 (CET)
Date:   Mon, 6 Mar 2023 13:30:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v3 1/2] ext4: remove set 'EXT4_STATE_MAY_INLINE_DATA'
 flag from ext4_find_inline_data_nolock()
Message-ID: <20230306123009.7qxbavnnl2k4lwgx@quack3>
References: <20230304025458.4007825-1-yebin@huaweicloud.com>
 <20230304025458.4007825-2-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230304025458.4007825-2-yebin@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 04-03-23 10:54:57, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> As only ext4_iget_extra_inode() call ext4_find_inline_data_nolock() need
> to set 'EXT4_STATE_MAY_INLINE_DATA' flag. The call in
> ext4_write_inline_data_end() is there only need to update i_inline_off.
> So move set 'EXT4_STATE_MAY_INLINE_DATA' flag from
> ext4_find_inline_data_nolock() to ext4_iget_extra_inode().

I'd just rephrase the changelog to be more comprehensible:

The only caller of ext4_find_inline_data_nolock() that needs setting of
EXT4_STATE_MAY_INLINE_DATA flag is ext4_iget_extra_inode(). In
ext4_write_inline_data_end() we just need to update inode->i_inline_off.
Since we are going to add one more caller that does not need to set
EXT4_STATE_MAY_INLINE_DATA, just move setting of EXT4_STATE_MAY_INLINE_DATA
out to ext4_iget_extra_inode().

Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/inline.c | 1 -
>  fs/ext4/inode.c  | 7 ++++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 2b42ececa46d..1602d74b5eeb 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -159,7 +159,6 @@ int ext4_find_inline_data_nolock(struct inode *inode)
>  					(void *)ext4_raw_inode(&is.iloc));
>  		EXT4_I(inode)->i_inline_size = EXT4_MIN_INLINE_DATA_SIZE +
>  				le32_to_cpu(is.s.here->e_value_size);
> -		ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
>  	}
>  out:
>  	brelse(is.iloc.bh);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d251d705c276..bf0b7dea4900 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4797,8 +4797,13 @@ static inline int ext4_iget_extra_inode(struct inode *inode,
>  
>  	if (EXT4_INODE_HAS_XATTR_SPACE(inode)  &&
>  	    *magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
> +		int err;
> +
>  		ext4_set_inode_state(inode, EXT4_STATE_XATTR);
> -		return ext4_find_inline_data_nolock(inode);
> +		err = ext4_find_inline_data_nolock(inode);
> +		if (!err && ext4_has_inline_data(inode))
> +			ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
> +		return err;
>  	} else
>  		EXT4_I(inode)->i_inline_off = 0;
>  	return 0;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
