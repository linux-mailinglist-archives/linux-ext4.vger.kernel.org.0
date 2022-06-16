Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944E854DE9C
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jun 2022 12:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiFPKGP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jun 2022 06:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359801AbiFPKGO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jun 2022 06:06:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2364F5D187;
        Thu, 16 Jun 2022 03:06:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D104721BF3;
        Thu, 16 Jun 2022 10:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655373972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nXn91AqHZ+792reQac2GKF/qocHMM/A+/6OJYJ8Maxs=;
        b=oTowZ3pMQdN8di8rrcGKhNrFdgb8p/GIEZXJOlUlDiPPkfHkFW0CvWBC7lwUkSYpDnLfaC
        iXT3wIzbkvROV1j1PN4OETzwfMrWW3FXoyeO9dMm+rFIpGOdT5BYxK1UsvAYfcHn0sc7hR
        da9HCBXBWqCMvQha50z1zb/Rf081tgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655373972;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nXn91AqHZ+792reQac2GKF/qocHMM/A+/6OJYJ8Maxs=;
        b=ldVmpCO08mCw4YzaHeGBE/gntNkynqZaPZbrf/99HJbMU/GpCimy4g/43UgJqMN3L8F96C
        LjVoMepCiTBjzXAw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3D6C72C141;
        Thu, 16 Jun 2022 10:06:12 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D7771A062E; Thu, 16 Jun 2022 12:06:10 +0200 (CEST)
Date:   Thu, 16 Jun 2022 12:06:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        lczerner@redhat.com, enwlinux@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 1/4] ext4: add EXT4_INODE_HAS_XATTR_SPACE macro in
 xattr.h
Message-ID: <20220616100610.y36iqovyynckhee7@quack3.lan>
References: <20220616021358.2504451-1-libaokun1@huawei.com>
 <20220616021358.2504451-2-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616021358.2504451-2-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 16-06-22 10:13:55, Baokun Li wrote:
> When adding an xattr to an inode, we must ensure that the inode_size is
> not less than EXT4_GOOD_OLD_INODE_SIZE + extra_isize + pad. Otherwise,
> the end position may be greater than the start position, resulting in UAF.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/xattr.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
> index 77efb9a627ad..f885f362add4 100644
> --- a/fs/ext4/xattr.h
> +++ b/fs/ext4/xattr.h
> @@ -95,6 +95,19 @@ struct ext4_xattr_entry {
>  
>  #define EXT4_ZERO_XATTR_VALUE ((void *)-1)
>  
> +/*
> + * If we want to add an xattr to the inode, we should make sure that
> + * i_extra_isize is not 0 and that the inode size is not less than
> + * EXT4_GOOD_OLD_INODE_SIZE + extra_isize + pad.
> + *   EXT4_GOOD_OLD_INODE_SIZE   extra_isize header   entry   pad  data
> + * |--------------------------|------------|------|---------|---|-------|
> + */
> +#define EXT4_INODE_HAS_XATTR_SPACE(inode)				\
> +	((EXT4_I(inode)->i_extra_isize != 0) &&				\
> +	 (EXT4_GOOD_OLD_INODE_SIZE + EXT4_I(inode)->i_extra_isize +	\
> +	  sizeof(struct ext4_xattr_ibody_header) + EXT4_XATTR_PAD <=	\
> +	  EXT4_INODE_SIZE((inode)->i_sb)))
> +
>  struct ext4_xattr_info {
>  	const char *name;
>  	const void *value;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
