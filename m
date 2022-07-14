Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805D0574DD5
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 14:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbiGNMiI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 08:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239413AbiGNMiH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 08:38:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D4F5D5A0
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 05:38:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so2936407pjl.4
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 05:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vKxnKRpjaYWVbMEwxVIRqjWvAhVW4DKwVLzP0WXHGV4=;
        b=Q/fJhcoqwxCnITNX8BrTqk4+ukiiYI6KeTwlwBl2WND99BSvJBLcpD8NcbdUoXvXSG
         r4dwIv+Wp8Vgrt+YNnuQ7hDI9wJBfp5VxWL4kMdovKQPqBdS/dvqgz7S1C+pQe/tq+wa
         QNKoX4Jzd1ptOqVx7Bg+4Ny/dNskRGguWnZMMepJD+vjYenM23s4IumRYHScFPe7mLZj
         xyrqHRcsr+DTm2NHQig2/DyAtusKsqS2D843SoQR7woGxX3VTZPMaXejMenfZc9djSuq
         BlTMWiToCCzOZ9NtOWhK0jTs4etAbTlpKfHMhUXYD4WQ9C9P0wQIrsgCciHRdfUjXDph
         MS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vKxnKRpjaYWVbMEwxVIRqjWvAhVW4DKwVLzP0WXHGV4=;
        b=Q2NdLVMugnl8f++4ONdBqBofJwIbTZt1pn9YuZxBEZ+ILvosed3SwFYBX2tX025xDP
         bROwlzZtFwRC46FLTY2NF3dp4IUOqAxLEJuwHn6EUsW45iok68b5kKjLDQ4Qw+jpT9ud
         n2BdCYHMA9NE+xEP5z/HAaSwleouTQJDK3v3ovUflNvCtJftzFaKD73QZY6EDR16HDL8
         yyYkF6GSDJYliEPGqmDXJ6fan/fa+IIV1A+y3BhLw/tYsDWLNhXbVBlXbAowQkxIOubt
         W8tmSdR3Arrt6j9gXy5/Yg9bBw7GuWXANfN15LmqCynZXYkRO6Hhkigv4fJRyjmXWhuz
         sv6A==
X-Gm-Message-State: AJIora/Z5vub526ORq4pU1rW3shbv5F+pNBBrSmIo38dJmA/ZP3RMS52
        MMAgNJ525pQXToVw4b8x7GLa5MhpUZY=
X-Google-Smtp-Source: AGRyM1tRDJbVj3tfJHewKNtqPAv3QEfSg/zFLxEEs+84+yXzwMKVYSetyJcGu7tWso3KHul+w9nEFg==
X-Received: by 2002:a17:903:260e:b0:16b:deaf:970a with SMTP id jd14-20020a170903260e00b0016bdeaf970amr8028401plb.121.1657802285553;
        Thu, 14 Jul 2022 05:38:05 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id h16-20020aa796d0000000b00528999fba99sm1600048pfq.175.2022.07.14.05.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 05:38:05 -0700 (PDT)
Date:   Thu, 14 Jul 2022 18:08:00 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 07/10] ext2: Unindent codeblock in ext2_xattr_set()
Message-ID: <20220714123800.sdrkkidu3yq6uyhh@riteshh-domain>
References: <20220712104519.29887-1-jack@suse.cz>
 <20220712105436.32204-7-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712105436.32204-7-jack@suse.cz>
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
> Replace one else in ext2_xattr_set() with a goto. This makes following
> code changes simpler to follow. No functional changes.

Straight forward refactoring. Looks good to me.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext2/xattr.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index 9885294993ef..37ce495eb279 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -517,7 +517,8 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
>  	/* Here we know that we can set the new attribute. */
>
>  	if (header) {
> -		/* assert(header == HDR(bh)); */
> +		int offset;
> +
>  		lock_buffer(bh);
>  		if (header->h_refcount == cpu_to_le32(1)) {
>  			__u32 hash = le32_to_cpu(header->h_hash);
> @@ -531,22 +532,20 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
>  					      bh->b_blocknr);
>
>  			/* keep the buffer locked while modifying it. */
> -		} else {
> -			int offset;
> -
> -			unlock_buffer(bh);
> -			ea_bdebug(bh, "cloning");
> -			header = kmemdup(HDR(bh), bh->b_size, GFP_KERNEL);
> -			error = -ENOMEM;
> -			if (header == NULL)
> -				goto cleanup;
> -			header->h_refcount = cpu_to_le32(1);
> -
> -			offset = (char *)here - bh->b_data;
> -			here = ENTRY((char *)header + offset);
> -			offset = (char *)last - bh->b_data;
> -			last = ENTRY((char *)header + offset);
> +			goto update_block;
>  		}
> +		unlock_buffer(bh);
> +		ea_bdebug(bh, "cloning");
> +		header = kmemdup(HDR(bh), bh->b_size, GFP_KERNEL);
> +		error = -ENOMEM;
> +		if (header == NULL)
> +			goto cleanup;
> +		header->h_refcount = cpu_to_le32(1);
> +
> +		offset = (char *)here - bh->b_data;
> +		here = ENTRY((char *)header + offset);
> +		offset = (char *)last - bh->b_data;
> +		last = ENTRY((char *)header + offset);
>  	} else {
>  		/* Allocate a buffer where we construct the new block. */
>  		header = kzalloc(sb->s_blocksize, GFP_KERNEL);
> @@ -559,6 +558,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
>  		last = here = ENTRY(header+1);
>  	}
>
> +update_block:
>  	/* Iff we are modifying the block in-place, bh is locked here. */
>
>  	if (not_found) {
> --
> 2.35.3
>
