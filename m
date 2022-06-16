Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2D254DEAB
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jun 2022 12:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359040AbiFPKI6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jun 2022 06:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358706AbiFPKI6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jun 2022 06:08:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF23338B9;
        Thu, 16 Jun 2022 03:08:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 598771FB38;
        Thu, 16 Jun 2022 10:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655374136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JpdE3UkoDUshgo/C6Wlkao1foIYMNO4hRwg9Tz4rysQ=;
        b=q/KDXP9xHyfqWjdONSy0zA7r9VqaeYEXxXVzugw02TsYb2VBORJhcOezbSmWKung4fmSDm
        M31U+a92DkSq7GUOdlXha9WQbuPhoISBvhv5EGd0t9vBQGDUWgfZVkGqdua0WjA2XodicS
        26FmNSwkdssi0IUkg4jevHtvF5+NgSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655374136;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JpdE3UkoDUshgo/C6Wlkao1foIYMNO4hRwg9Tz4rysQ=;
        b=/mijQOobnRPAHvd/bp8FsYx4MPlj3pU7Bp1KkykitXcEc5Vzt9Ac4Sfgfj6BrTI9zS+sLk
        Hl8DPEHPxzxZJyBA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 209F02C141;
        Thu, 16 Jun 2022 10:08:56 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 49B7AA062E; Thu, 16 Jun 2022 12:08:55 +0200 (CEST)
Date:   Thu, 16 Jun 2022 12:08:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        lczerner@redhat.com, enwlinux@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 3/4] ext4: correct max_inline_xattr_value_size
 computing
Message-ID: <20220616100855.y435wlfr7egwvbpj@quack3.lan>
References: <20220616021358.2504451-1-libaokun1@huawei.com>
 <20220616021358.2504451-4-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616021358.2504451-4-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 16-06-22 10:13:57, Baokun Li wrote:
> If the ext4 inode does not have xattr space, 0 is returned in the
> get_max_inline_xattr_value_size function. Otherwise, the function returns
> a negative value when the inode does not contain EXT4_STATE_XATTR.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inline.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index cff52ff6549d..da5de43623dd 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -35,6 +35,9 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
>  	struct ext4_inode *raw_inode;
>  	int free, min_offs;
>  
> +	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
> +		return 0;
> +
>  	min_offs = EXT4_SB(inode->i_sb)->s_inode_size -
>  			EXT4_GOOD_OLD_INODE_SIZE -
>  			EXT4_I(inode)->i_extra_isize -
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
