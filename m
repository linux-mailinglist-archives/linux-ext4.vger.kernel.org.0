Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD33064586F
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 12:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLGLAv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 06:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiLGLA0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 06:00:26 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286D24E681;
        Wed,  7 Dec 2022 03:00:09 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 53C6D1F37E;
        Wed,  7 Dec 2022 11:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670410807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BXRoWMTGPoTeL3TcVSpv7TQfkq1KRaiCSR39v7nfVY4=;
        b=KjQso7GGpZn8QDZNEBRXMoKYDgXDoaag5NEelvcyc2wmxGGW+lVp6l+Rc+nHs+lxgUetL7
        m/UCeNdgKNMSW3fTG5FFlAFHv6A8XAd5JeU5cdrcfFo5bS7nVTPg0GXBs6k+fJvwIrv2nf
        J4fyR0Iaf0gnAlQeqb052EHCQ9qhGY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670410807;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BXRoWMTGPoTeL3TcVSpv7TQfkq1KRaiCSR39v7nfVY4=;
        b=pRTbilr3My9LGiJy2A0S2qAycdi5tV3mLYnHny5++rH99nkMJweUyTtKS5GGJwb/moENBN
        XH0fLmCMPTpAfuAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4678F134CD;
        Wed,  7 Dec 2022 11:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id p442ETdykGMdHgAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 11:00:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E4D2DA0725; Wed,  7 Dec 2022 12:00:06 +0100 (CET)
Date:   Wed, 7 Dec 2022 12:00:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v2 6/6] ext4: fix inode leak in
 'ext4_xattr_inode_create()'
Message-ID: <20221207110006.xuod3seh7zwipsih@quack3>
References: <20221207074043.1286731-1-yebin@huaweicloud.com>
 <20221207074043.1286731-7-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207074043.1286731-7-yebin@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 07-12-22 15:40:43, Ye Bin wrote:
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

I think I've already given my Reviewed-by on this :). Anyway, the patch
looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/xattr.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 5c0476ff62c8..6c19d01ba261 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1465,6 +1465,9 @@ static struct inode *ext4_xattr_inode_create(handle_t *handle,
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
