Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A036F5A09
	for <lists+linux-ext4@lfdr.de>; Wed,  3 May 2023 16:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjECOab (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 May 2023 10:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjECOaa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 May 2023 10:30:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304901FF6;
        Wed,  3 May 2023 07:30:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DC4F0222BF;
        Wed,  3 May 2023 14:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683124226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vfvp5EAr03RumqMmaXNjAHEK8G4910C+luedX7/5ogo=;
        b=MHNyho4ZHmit7oc6DIdyFVcAJIZiqxVdaBSZ/RwnsjtM5VrFmL2Ze7uhC/HH56UVEGjnh7
        SWE9Rv0Sk5+o5X1kROnG1gnNeF8/QTUgRJgcBZDzksyHx3X/9VVYFeI6pB90mB30EnSRj7
        50j2qWEO+qXwt6z4W67JdpmXNMHBYGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683124226;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vfvp5EAr03RumqMmaXNjAHEK8G4910C+luedX7/5ogo=;
        b=19N6voLnfoHXBAkNTCQNdU/x0F4V5HZe/6MdlST/VYPkfPp4SFjcIsrRzZt1SwwPAk9IUe
        7KNb7zw09X/fQ4DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF3B11331F;
        Wed,  3 May 2023 14:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c7uUMgJwUmSeRQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 03 May 2023 14:30:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 54A23A0744; Wed,  3 May 2023 16:30:26 +0200 (CEST)
Date:   Wed, 3 May 2023 16:30:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v4 06/12] ext4: using nofail preallocation in
 ext4_es_remove_extent()
Message-ID: <20230503143026.md6gtrnkqp2awogd@quack3>
References: <20230424033846.4732-1-libaokun1@huawei.com>
 <20230424033846.4732-7-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424033846.4732-7-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 24-04-23 11:38:40, Baokun Li wrote:
> If __es_remove_extent() returns an error it means that when splitting
> extent, allocating an extent that must be kept failed, where returning
> an error directly would cause the extent tree to be inconsistent. So we
> use GFP_NOFAIL to pre-allocate an extent_status and pass it to
> __es_remove_extent() to avoid this problem.
> 
> In addition, since the allocated memory is outside the i_es_lock, the
> extent_status tree may change and the pre-allocated extent_status is
> no longer needed, so we release the pre-allocated extent_status when
> es->es_len is not initialized.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents_status.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 7219116e0d68..f4d50cd501fc 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -1458,6 +1458,7 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  	ext4_lblk_t end;
>  	int err = 0;
>  	int reserved = 0;
> +	struct extent_status *es = NULL;
>  
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return 0;
> @@ -1472,17 +1473,25 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  	end = lblk + len - 1;
>  	BUG_ON(end < lblk);
>  
> +retry:
> +	if (err && !es)
> +		es = __es_alloc_extent(true);
>  	/*
>  	 * ext4_clear_inode() depends on us taking i_es_lock unconditionally
>  	 * so that we are sure __es_shrink() is done with the inode before it
>  	 * is reclaimed.
>  	 */
>  	write_lock(&EXT4_I(inode)->i_es_lock);
> -	err = __es_remove_extent(inode, lblk, end, &reserved, NULL);
> +	err = __es_remove_extent(inode, lblk, end, &reserved, es);
> +	if (es && !es->es_len)
> +		__es_free_extent(es);
>  	write_unlock(&EXT4_I(inode)->i_es_lock);
> +	if (err)
> +		goto retry;
> +
>  	ext4_es_print_tree(inode);
>  	ext4_da_release_space(inode, reserved);
> -	return err;
> +	return 0;
>  }
>  
>  static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
