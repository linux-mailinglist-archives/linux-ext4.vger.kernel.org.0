Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB956442F9
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Dec 2022 13:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiLFMK5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Dec 2022 07:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbiLFMK4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Dec 2022 07:10:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFA420BF3;
        Tue,  6 Dec 2022 04:10:55 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1FB0A1FE51;
        Tue,  6 Dec 2022 12:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670328654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DXe2oCAGCB1QuKMT0B/IEQZzxBKGZgUxTzHZkMGRNaE=;
        b=TAITO9YXL+oVhSg5pkLXsufsbCoEusfzsOwR6Zzq6I4E2AQH6HRBO+ity5hFWMnT2qOpmJ
        93iUx+WTOxX/GFLm1Pdl6M/kJZPyWz2dVoX5lWxFjl0Y0/aaJLPOfoXfl9bVKLezi3fSMP
        y96om/19+3j2LHWxoWXmwvakI8bBsr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670328654;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DXe2oCAGCB1QuKMT0B/IEQZzxBKGZgUxTzHZkMGRNaE=;
        b=BRwlAaQ6HnEnKgwHK6DWQoORB6GA7h4APCYCSaU5gR1Sqeug7J3UyCI3Hgksh2qTm79qMs
        v3801FgH3uECW1BQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 12B65132F3;
        Tue,  6 Dec 2022 12:10:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id doaFBE4xj2PjXQAAGKfGzw
        (envelope-from <jack@suse.cz>); Tue, 06 Dec 2022 12:10:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8B998A0725; Tue,  6 Dec 2022 13:10:53 +0100 (CET)
Date:   Tue, 6 Dec 2022 13:10:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH -next 6/6] ext4: fix inode leak in
 'ext4_xattr_inode_create()'
Message-ID: <20221206121053.ksylcq5ag6yn6yct@quack3>
References: <20221206015806.3420321-1-yebin@huaweicloud.com>
 <20221206015806.3420321-7-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206015806.3420321-7-yebin@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 06-12-22 09:58:06, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There is issue as follows when do setxattr with inject fault:
> [localhost]#fsck.ext4  -fn  /dev/sda
> e2fsck 1.46.6-rc1 (12-Sep-2022)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Unattached zero-length inode 15.  Clear? no
> 
> Unattached inode 15
> Connect to /lost+found? no
> 
> Pass 5: Checking group summary information
> 
> /dev/sda: ********** WARNING: Filesystem still has errors **********
> 
> /dev/sda: 15/655360 files (0.0% non-contiguous), 66755/2621440 blocks
> 
> Above issue occur in 'ext4_xattr_inode_create()', if 'ext4_mark_inode_dirty()'
> failed need to drop inode's i_nlink. Or will lead to inode leak.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

The change looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

I'm just slightly wondering if there is ever a situation when
ext4_mark_inode_dirty() fails but the following cleanup would succeed...

								Honza 

> ---
>  fs/ext4/xattr.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 003fe1f2d6a8..734f787ae7ed 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1464,6 +1464,9 @@ static struct inode *ext4_xattr_inode_create(handle_t *handle,
>  		if (!err)
>  			err = ext4_inode_attach_jinode(ea_inode);
>  		if (err) {
> +			if (ext4_xattr_inode_dec_ref(handle, ea_inode))
> +				ext4_warning_inode(ea_inode,
> +					"cleanup dec ref error %d", err);
>  			iput(ea_inode);
>  			return ERR_PTR(err);
>  		}
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
