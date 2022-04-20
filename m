Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E855087ED
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Apr 2022 14:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378443AbiDTMTS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Apr 2022 08:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242236AbiDTMTR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Apr 2022 08:19:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E1C25284;
        Wed, 20 Apr 2022 05:16:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BA26B210F4;
        Wed, 20 Apr 2022 12:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650456990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p3mKrvxIbu8LibPS3UuSRgaTh+XcU6Jc9U1SK1ytPZc=;
        b=SLFbyZ99CoJObP0g9Ep1Sb+iQfkJPZqg86vwl9d9S4I/5KojvITG614cB8v6fOyvWfNQt9
        noUBDSRHFuAH6Q2NkohZOrgNMvsetwDim+9oM3mmYvklNBxW+4JQMiDiiNMt2+oGnIc1x4
        pFz34r0DAtyUbBg8Q3XCqN3AO+0+kDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650456990;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p3mKrvxIbu8LibPS3UuSRgaTh+XcU6Jc9U1SK1ytPZc=;
        b=CgtjQrmNT0B7okUm5pzcriN+HzEImF38XfsVF88gKCn1//J7f2ktgzDuSJtCSnND2mfJ1y
        vFU/+LMWf1nxxeBw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 88C2D2C145;
        Wed, 20 Apr 2022 12:16:30 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 723EEA061E; Wed, 20 Apr 2022 14:16:26 +0200 (CEST)
Date:   Wed, 20 Apr 2022 14:16:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Phi Nguyen <phind.uet@gmail.com>
Cc:     syzbot <syzbot+c7358a3cd05ee786eb31@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: [syzbot] kernel BUG in ext4_es_cache_extent
Message-ID: <20220420121626.edhvfibz4n3trnvg@quack3.lan>
References: <0000000000003d898d05d759c00a@google.com>
 <e58c5085-c351-a7a6-fe97-3da6eb1a804f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e58c5085-c351-a7a6-fe97-3da6eb1a804f@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 14-02-22 02:03:37, Phi Nguyen wrote:
> The non-journal mounted fs is corrupted, syzbot was able to mount it because
> a [fast commit] patch exclude its inodes from verification process.
> 
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> master

This patch seems to have fallen through the cracks. Phi, care to submit it
properly with your Signed-off-by etc?

								Honza

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 01c9e4f743ba..385f4ae71573 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4912,7 +4912,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  		goto bad_inode;
>  	} else if (!ext4_has_inline_data(inode)) {
>  		/* validate the block references in the inode */
> -		if (!(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY) &&
> +		if (!(journal && EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY) &&
>  			(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
>  			(S_ISLNK(inode->i_mode) &&
>  			!ext4_inode_is_fast_symlink(inode)))) {

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
