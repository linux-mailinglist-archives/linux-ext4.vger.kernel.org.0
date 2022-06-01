Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D63453A0E8
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Jun 2022 11:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350914AbiFAJmS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Jun 2022 05:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351156AbiFAJlz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Jun 2022 05:41:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82EE5001C
        for <linux-ext4@vger.kernel.org>; Wed,  1 Jun 2022 02:41:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9734D1F946;
        Wed,  1 Jun 2022 09:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654076507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MTT6X8ZokNfCughqToNwYdeIfG+fqAQ2+VL9kR6v78k=;
        b=BzNtuu2Rejd2LyyDfx/2H0oFEzBBlYmLnpVk9Zv2r6qTzoEa/Wsbp0wpLm8vNTLUU7dvIy
        jexfLPG3UDeNHpsw9Ki7zUQEUK+JfmmUD0ht4AZocB8WWdbN3aQnIXOtHXIA2VYmWSHZh7
        aX3eXNnKPLWa8T1LJ8juj0xIZq4zBrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654076507;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MTT6X8ZokNfCughqToNwYdeIfG+fqAQ2+VL9kR6v78k=;
        b=h610cOVZhQV6LaaPsReYZfwh1DSMI+l79B7iImnSHARsUtypNUvQzqWl7MfChUhSSyh2l6
        uWHm3XCVX46VNODQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 550132C141;
        Wed,  1 Jun 2022 09:41:47 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0A1C4A0633; Wed,  1 Jun 2022 11:41:47 +0200 (CEST)
Date:   Wed, 1 Jun 2022 11:41:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2] ext4: add reserved GDT blocks check
Message-ID: <20220601094146.tmmw5ks4jganupc7@quack3.lan>
References: <20220601092717.763694-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601092717.763694-1-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 01-06-22 17:27:17, Zhang Yi wrote:
> We capture a NULL pointer issue when resizing a corrupt ext4 image which
> is freshly clear resize_inode feature (not run e2fsck). It could be
> simply reproduced by following steps. The problem is because of the
> resize_inode feature was cleared, and it will convert the filesystem to
> meta_bg mode in ext4_resize_fs(), but the es->s_reserved_gdt_blocks was
> not reduced to zero, so could we mistakenly call reserve_backup_gdb()
> and passing an uninitialized resize_inode to it when adding new group
> descriptors.
> 
>  mkfs.ext4 /dev/sda 3G
>  tune2fs -O ^resize_inode /dev/sda #forget to run requested e2fsck
>  mount /dev/sda /mnt
>  resize2fs /dev/sda 8G
> 
>  ========
>  BUG: kernel NULL pointer dereference, address: 0000000000000028
>  CPU: 19 PID: 3243 Comm: resize2fs Not tainted 5.18.0-rc7-00001-gfde086c5ebfd #748
>  ...
>  RIP: 0010:ext4_flex_group_add+0xe08/0x2570
>  ...
>  Call Trace:
>   <TASK>
>   ext4_resize_fs+0xbec/0x1660
>   __ext4_ioctl+0x1749/0x24e0
>   ext4_ioctl+0x12/0x20
>   __x64_sys_ioctl+0xa6/0x110
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>  RIP: 0033:0x7f2dd739617b
>  ========
> 
> The fix is simple, add a check in ext4_resize_begin() to make sure that
> the es->s_reserved_gdt_blocks is zero when the resize_inode feature is
> disabled.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good to me. Thanks for the fix. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v2->v1:
>  - move check from ext4_resize_fs() to ext4_resize_begin().
> 
>  fs/ext4/resize.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 90a941d20dff..8b70a4701293 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -53,6 +53,16 @@ int ext4_resize_begin(struct super_block *sb)
>  	if (!capable(CAP_SYS_RESOURCE))
>  		return -EPERM;
>  
> +	/*
> +	 * If the reserved GDT blocks is non-zero, the resize_inode feature
> +	 * should always be set.
> +	 */
> +	if (EXT4_SB(sb)->s_es->s_reserved_gdt_blocks &&
> +	    !ext4_has_feature_resize_inode(sb)) {
> +		ext4_error(sb, "resize_inode disabled but reserved GDT blocks non-zero");
> +		return -EFSCORRUPTED;
> +	}
> +
>  	/*
>  	 * If we are not using the primary superblock/GDT copy don't resize,
>           * because the user tools have no way of handling this.  Probably a
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
