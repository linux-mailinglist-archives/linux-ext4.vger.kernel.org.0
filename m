Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D0865D0CB
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 11:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239183AbjADKhI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 05:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238962AbjADKgh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 05:36:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5177BA0
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 02:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672828548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9I6rlDVDzLrFD12MfXYLvaPN8tmVyIaFE2XhSM3XAi4=;
        b=cM9dMYJdQhlGnLW2cTTQJeVKBFG91c90dk9AhNMnwiF8vownVzVDONiYspB5yNX5m4bIJZ
        vN9vhIpzVvxMd6zUVRe78cK8mIefZU133uYQn0o6dhmKvzvzDnkTw5YEJEd8gEuYsCXi/i
        te0KoKD4RqPipqAoDexI5NSzZyKkLQE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-MkmhxuuXNc65a94wuCJ89g-1; Wed, 04 Jan 2023 05:35:46 -0500
X-MC-Unique: MkmhxuuXNc65a94wuCJ89g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0AD1238123A0;
        Wed,  4 Jan 2023 10:35:46 +0000 (UTC)
Received: from fedora (ovpn-192-227.brq.redhat.com [10.40.192.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81CA140C2064;
        Wed,  4 Jan 2023 10:35:45 +0000 (UTC)
Date:   Wed, 4 Jan 2023 11:35:43 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [e2fsprogs PATCH] resize2fs: remove unused variable from
 adjust_superblock()
Message-ID: <20230104103543.bzdpmz4iy7flpmdi@fedora>
References: <20230104090351.276159-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104090351.276159-1-ebiggers@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 04, 2023 at 01:03:51AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> In adjust_superblock(), the 'group_block' variable is declared and set,
> but it is never actually used.  Remove it.
> 
> This addresses the following compiler warning with clang -Wall:
> 
> resize2fs.c:1119:11: warning: variable 'group_block' set but not used [-Wunused-but-set-variable]
>         blk64_t         group_block;

Looks good thanks.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

>                         ^
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  resize/resize2fs.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/resize/resize2fs.c b/resize/resize2fs.c
> index 243cd777..5eeb7d44 100644
> --- a/resize/resize2fs.c
> +++ b/resize/resize2fs.c
> @@ -1116,7 +1116,6 @@ static errcode_t adjust_superblock(ext2_resize_t rfs, blk64_t new_size)
>  	ext2_filsys	fs = rfs->new_fs;
>  	int		adj = 0;
>  	errcode_t	retval;
> -	blk64_t		group_block;
>  	unsigned long	i;
>  	unsigned long	max_group;
>  
> @@ -1181,8 +1180,6 @@ static errcode_t adjust_superblock(ext2_resize_t rfs, blk64_t new_size)
>  		goto errout;
>  
>  	memset(rfs->itable_buf, 0, fs->blocksize * fs->inode_blocks_per_group);
> -	group_block = ext2fs_group_first_block2(fs,
> -						rfs->old_fs->group_desc_count);
>  	adj = rfs->old_fs->group_desc_count;
>  	max_group = fs->group_desc_count - adj;
>  	if (rfs->progress) {
> @@ -1209,7 +1206,6 @@ static errcode_t adjust_superblock(ext2_resize_t rfs, blk64_t new_size)
>  			if (retval)
>  				goto errout;
>  		}
> -		group_block += fs->super->s_blocks_per_group;
>  	}
>  	io_channel_flush(fs->io);
>  	retval = 0;
> -- 
> 2.39.0
> 

