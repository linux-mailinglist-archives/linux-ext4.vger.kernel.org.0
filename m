Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58848511EBF
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Apr 2022 20:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241342AbiD0QF4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Apr 2022 12:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243213AbiD0QFg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Apr 2022 12:05:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DC017FBDE
        for <linux-ext4@vger.kernel.org>; Wed, 27 Apr 2022 09:02:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AE0CD1F37F;
        Wed, 27 Apr 2022 16:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651075326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L5vTUanWsKPlOJsN/BDsIkrXDb1hhhLYOpNUCOVkBSM=;
        b=jK5n8fKrRuWt4xlfRr3l96fwVnP7TB5Ih9kBd31JaFGRgBg0+iblAH5ShSEpM/5fdCJEFp
        u6uO2GmEILjxUyJbLP/6Dns2LxhxsLpeCPx0W/syDwriQI4vsCjrEEExmrNXxuQl8V6MPS
        TisYvho7iH3C3vQkYrz15+oiuOWiLfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651075326;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L5vTUanWsKPlOJsN/BDsIkrXDb1hhhLYOpNUCOVkBSM=;
        b=Z7ISKZyGQqQpqbvdiSceUSHRKVaRyKrKC8U50R/IQrW9wj0QWW5N+s03VXzt6mpzizlSYQ
        ACf2cu4r8TutGsCQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9FB2E2C142;
        Wed, 27 Apr 2022 16:02:06 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5F62DA061C; Wed, 27 Apr 2022 18:02:06 +0200 (CEST)
Date:   Wed, 27 Apr 2022 18:02:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, riteshh@linux.ibm.com, jack@suse.cz,
        tytso@mit.edu
Subject: Re: [PATCH v3 3/6] ext4: mark inode dirty before grabbing i_data_sem
 in ext4_setattr
Message-ID: <20220427160206.icjjrhqlsf42bega@quack3.lan>
References: <20220419173143.3564144-1-harshads@google.com>
 <20220419173143.3564144-4-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419173143.3564144-4-harshads@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 19-04-22 10:31:40, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> Mark inode dirty first and then grab i_data_sem in ext4_setattr().
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e88940251afd..6eae0804c6fd 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5455,11 +5455,12 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>  					(attr->ia_size > 0 ? attr->ia_size - 1 : 0) >>
>  					inode->i_sb->s_blocksize_bits);
>  
> -			down_write(&EXT4_I(inode)->i_data_sem);
> -			EXT4_I(inode)->i_disksize = attr->ia_size;
>  			rc = ext4_mark_inode_dirty(handle, inode);
>  			if (!error)
>  				error = rc;
> +			down_write(&EXT4_I(inode)->i_data_sem);
> +			EXT4_I(inode)->i_disksize = attr->ia_size;
> +

Hum, this isn't going to fly because ext4_mark_inode_dirty() copies data
from ext4_inode_info to the on-disk buffer and thus new i_disksize will not
be stored on the disk after your change.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
