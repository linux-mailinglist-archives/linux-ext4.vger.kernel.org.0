Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B0654DEAF
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jun 2022 12:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358706AbiFPKJa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jun 2022 06:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359535AbiFPKJ3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jun 2022 06:09:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483AC5D19C;
        Thu, 16 Jun 2022 03:09:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 087161FB38;
        Thu, 16 Jun 2022 10:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655374168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+caT8QlPQ9S6xpSAdMZVNNe1g04sv7ZRroACjeKdDOc=;
        b=F5/ElkrDLgplFsNtvY5krxF2Pr+QiJEjksGjzpJSByplbixwgkKuQUNl4hD57jKWWVz0ZJ
        u0wt+Cnb/CJJ+4flwIg5G3Zh/ydb5tOuCVXenhygoK1HoE/jzKGf8ftNwh5wnDmQkU6Qa5
        LlMQWppo4lDieCqikbGbt5pRloLzG5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655374168;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+caT8QlPQ9S6xpSAdMZVNNe1g04sv7ZRroACjeKdDOc=;
        b=1f+oYYcu5fNWng70dqZBzNGG3UuDmKoM7EyAOkT3avxPVQgAtqI3zeP/0Kl2WUZHzmdp6a
        p1fHIVG81fHaeyDg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DB58F2C141;
        Thu, 16 Jun 2022 10:09:27 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 49C60A062E; Thu, 16 Jun 2022 12:09:26 +0200 (CEST)
Date:   Thu, 16 Jun 2022 12:09:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        lczerner@redhat.com, enwlinux@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 4/4] ext4: correct the misjudgment in
 ext4_iget_extra_inode
Message-ID: <20220616100926.g5rqt4ls4qlsl7s7@quack3.lan>
References: <20220616021358.2504451-1-libaokun1@huawei.com>
 <20220616021358.2504451-5-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616021358.2504451-5-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 16-06-22 10:13:58, Baokun Li wrote:
> Use the EXT4_INODE_HAS_XATTR_SPACE macro to more accurately
> determine whether the inode have xattr space.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 53877ffe3c41..ae463cd9b405 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4687,8 +4687,7 @@ static inline int ext4_iget_extra_inode(struct inode *inode,
>  	__le32 *magic = (void *)raw_inode +
>  			EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize;
>  
> -	if (EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize + sizeof(__le32) <=
> -	    EXT4_INODE_SIZE(inode->i_sb) &&
> +	if (EXT4_INODE_HAS_XATTR_SPACE(inode)  &&
>  	    *magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
>  		ext4_set_inode_state(inode, EXT4_STATE_XATTR);
>  		return ext4_find_inline_data_nolock(inode);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
