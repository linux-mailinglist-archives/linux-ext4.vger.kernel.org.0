Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A666574DD1
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 14:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbiGNMhY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 08:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239414AbiGNMhV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 08:37:21 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A7E5D0DE
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 05:37:20 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w185so1729024pfb.4
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 05:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i8zRtQX977GM2H+XDtap7gI5zjmoh1Ky3MNAyiJswC8=;
        b=ooVQAaR83+ltPUL9KvjDzm5fB4bJrnyvEiyYP/cprJghA2kJsDePRLiC43x57mdHD1
         0pldAWvf6rn5N88MhjthWs42IuJ08DJvf7o3FcWKaUmN7ja1pe5iBTOTOLjopCvvLYdf
         rXU0QrzGlJ2sq1vDLWj/gXGwtbGjmb5MB6fiIWkolmT7TGy+LMg509AlRhixY0bdhcUW
         4ebANvaqk6kITVCcICnY6/twcEeiadBXgHWAYAGd0k3YH63s1Zwaw7KcBWsyWFkWe8EW
         TlDTush5WkKsABh3EKMsYhNjUT0xCrlihVfKQrKq7/AhBUe/OoiRsjbUEchsEO49/eS7
         MGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i8zRtQX977GM2H+XDtap7gI5zjmoh1Ky3MNAyiJswC8=;
        b=SV/g3JK+Qx2bfb+R//9pQ+AI4VYh581to6OZbIELABN+MK1Vf76OAxya/pLRQrBy2e
         0NImY5CwlkVieFSZaLqcfrj52/cN1X+qpD89wpCRgb7IuNpAPrlSbAR1G9DTLD/t1fRi
         i4WNjpTJIs61UauYKVRDIkXSTWwYwtKHz+/0U1UGfmU0A6P4hvbgHhT1JR1CrhpxYVCy
         DBB/lYRtRnaXop+A3ljVSy182xo44Z477yVIIHsNG+dQM+5NZtmufHtLAzQ6e4/eAfi+
         ZHZ48aDtBspghj0ZrZD1beLA7sNpX9LoBFhGLVryBJ61CCQ0lkqb0bL7buIK55T3pZNI
         1tmA==
X-Gm-Message-State: AJIora8iBfC2twkRqdbjlLn8uNsZavVTYe11Sl5ZiWY/D95lxvhXndBk
        gkD7e0EqCLUCxII2azrVFEag/89z4sY=
X-Google-Smtp-Source: AGRyM1vIubynASS5o1cDFxK5RSvvtnHg1bYudWg4f5pPerXYDRiBzK+4G9mF6DAg/0o/CF8jsrdHeg==
X-Received: by 2002:a63:283:0:b0:412:50b7:e3eb with SMTP id 125-20020a630283000000b0041250b7e3ebmr7307297pgc.29.1657802239977;
        Thu, 14 Jul 2022 05:37:19 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id z128-20020a626586000000b0051c6613b5basm1543579pfb.134.2022.07.14.05.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 05:37:19 -0700 (PDT)
Date:   Thu, 14 Jul 2022 18:07:14 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 06/10] ext2: Factor our freeing of xattr block reference
Message-ID: <20220714123714.xxqo7nnde6xacriu@riteshh-domain>
References: <20220712104519.29887-1-jack@suse.cz>
 <20220712105436.32204-6-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712105436.32204-6-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/07/12 12:54PM, Jan Kara wrote:
> Free of xattr block reference is opencode in two places. Factor it out
> into a separate function and use it.

Looked into the refactoring logic. The patch looks good to me.
Small queries below -

>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext2/xattr.c | 90 +++++++++++++++++++++----------------------------
>  1 file changed, 38 insertions(+), 52 deletions(-)
>
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index 841fa6d9d744..9885294993ef 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -651,6 +651,42 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
>  	return error;
>  }
>
> +static void ext2_xattr_release_block(struct inode *inode,
> +				     struct buffer_head *bh)
> +{
> +	struct mb_cache *ea_block_cache = EA_BLOCK_CACHE(inode);
> +
> +	lock_buffer(bh);
> +	if (HDR(bh)->h_refcount == cpu_to_le32(1)) {
> +		__u32 hash = le32_to_cpu(HDR(bh)->h_hash);
> +
> +		/*
> +		 * This must happen under buffer lock for
> +		 * ext2_xattr_set2() to reliably detect freed block
> +		 */
> +		mb_cache_entry_delete(ea_block_cache, hash,
> +				      bh->b_blocknr);
> +		/* Free the old block. */
> +		ea_bdebug(bh, "freeing");
> +		ext2_free_blocks(inode, bh->b_blocknr, 1);
> +		/* We let our caller release bh, so we
> +		 * need to duplicate the buffer before. */
> +		get_bh(bh);
> +		bforget(bh);
> +		unlock_buffer(bh);
> +	} else {
> +		/* Decrement the refcount only. */
> +		le32_add_cpu(&HDR(bh)->h_refcount, -1);
> +		dquot_free_block(inode, 1);
> +		mark_buffer_dirty(bh);
> +		unlock_buffer(bh);
> +		ea_bdebug(bh, "refcount now=%d",
> +			le32_to_cpu(HDR(bh)->h_refcount));
> +		if (IS_SYNC(inode))
> +			sync_dirty_buffer(bh);
> +	}
> +}
> +
>  /*
>   * Second half of ext2_xattr_set(): Update the file system.
>   */
> @@ -747,34 +783,7 @@ ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
>  		 * If there was an old block and we are no longer using it,
>  		 * release the old block.
>  		 */
> -		lock_buffer(old_bh);
> -		if (HDR(old_bh)->h_refcount == cpu_to_le32(1)) {
> -			__u32 hash = le32_to_cpu(HDR(old_bh)->h_hash);
> -
> -			/*
> -			 * This must happen under buffer lock for
> -			 * ext2_xattr_set2() to reliably detect freed block
> -			 */
> -			mb_cache_entry_delete(ea_block_cache, hash,
> -					      old_bh->b_blocknr);
> -			/* Free the old block. */
> -			ea_bdebug(old_bh, "freeing");
> -			ext2_free_blocks(inode, old_bh->b_blocknr, 1);
> -			mark_inode_dirty(inode);

^^^ this is not needed because ext2_free_blocks() will take care of it.
Hence you have dropped this in ext2_xattr_release_block()

> -			/* We let our caller release old_bh, so we
> -			 * need to duplicate the buffer before. */
> -			get_bh(old_bh);
> -			bforget(old_bh);
> -		} else {
> -			/* Decrement the refcount only. */
> -			le32_add_cpu(&HDR(old_bh)->h_refcount, -1);
> -			dquot_free_block_nodirty(inode, 1);
> -			mark_inode_dirty(inode);

Quick qn -> Don't we need mark_inode_dirty() here?

> -			mark_buffer_dirty(old_bh);
> -			ea_bdebug(old_bh, "refcount now=%d",
> -				le32_to_cpu(HDR(old_bh)->h_refcount));
> -		}
> -		unlock_buffer(old_bh);
> +		ext2_xattr_release_block(inode, old_bh);
>  	}
>
>  cleanup:
> @@ -828,30 +837,7 @@ ext2_xattr_delete_inode(struct inode *inode)
>  			EXT2_I(inode)->i_file_acl);
>  		goto cleanup;
>  	}
> -	lock_buffer(bh);
> -	if (HDR(bh)->h_refcount == cpu_to_le32(1)) {
> -		__u32 hash = le32_to_cpu(HDR(bh)->h_hash);
> -
> -		/*
> -		 * This must happen under buffer lock for ext2_xattr_set2() to
> -		 * reliably detect freed block
> -		 */
> -		mb_cache_entry_delete(EA_BLOCK_CACHE(inode), hash,
> -				      bh->b_blocknr);
> -		ext2_free_blocks(inode, EXT2_I(inode)->i_file_acl, 1);
> -		get_bh(bh);
> -		bforget(bh);
> -		unlock_buffer(bh);
> -	} else {
> -		le32_add_cpu(&HDR(bh)->h_refcount, -1);
> -		ea_bdebug(bh, "refcount now=%d",
> -			le32_to_cpu(HDR(bh)->h_refcount));
> -		unlock_buffer(bh);
> -		mark_buffer_dirty(bh);
> -		if (IS_SYNC(inode))
> -			sync_dirty_buffer(bh);
> -		dquot_free_block_nodirty(inode, 1);
> -	}
> +	ext2_xattr_release_block(inode, bh);
>  	EXT2_I(inode)->i_file_acl = 0;
>
>  cleanup:
> --
> 2.35.3
>
