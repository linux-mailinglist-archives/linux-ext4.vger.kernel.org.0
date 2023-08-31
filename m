Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAA178EFAF
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Aug 2023 16:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238200AbjHaOkg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Aug 2023 10:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbjHaOkg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Aug 2023 10:40:36 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CA61B1
        for <linux-ext4@vger.kernel.org>; Thu, 31 Aug 2023 07:40:30 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76dc77fd024so58609685a.3
        for <linux-ext4@vger.kernel.org>; Thu, 31 Aug 2023 07:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693492830; x=1694097630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NfhEWQoq5dZCj0mxonBcgZmBQ97cTWQFJRkBOAVLN4w=;
        b=V1LcgGck71AY9+Nagd1KWf5fw87m9I5udJFMd78jnb6GXZJP0m747DfsOxKpPePHsd
         GPvvbzqxIiOUAmliLuBjiXg2qsVPE49/3PvOfKoZVk1TtLApzf5AxcgXYSOHWPBRA9QL
         lEds9phpZ2xHAvzIxfsdZ274UIRqt2Zolns3gfRDIkJd0AhfBlTSSHgpXCnOR/h6cP4E
         YmWMBKvVKQLcfljSJNlMi94Vobt/FLVJtIdagvKlJdG2J0cXa7DvqSUfKzzjA+GhDuOF
         1aIm+AiTqTZboh8yrXjsZOFahXVJn8IBUr/IWvG8xrCzf44rp/R4T9VgKBXq9akyJrd6
         UlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693492830; x=1694097630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfhEWQoq5dZCj0mxonBcgZmBQ97cTWQFJRkBOAVLN4w=;
        b=VOTuNqzPLC6L3+mAElv3lu+91L1k+ZmrTdkDKtT1xx0QpgJQ0S9hNkwYSau7VEpHGG
         kupxGJvx4CAcNWapFW9Ec6AQvvysNDR5wcsvSj+a0bJKjTeflHj1JgXzYRkRyhceWAgA
         8jis6SM1M639cCEYAesOhVOJ/wQw5DquMmSC9Kn5yVNjeej37hf3anci2MG8kt5+/3Rg
         iI3irjQMbpUQAsYd7gdVaCeY94LePEg7nrleNbZ4RbxKnI/j6jtVqHcVIMXDd2FKW44q
         PCx/G+KfZeKDIPl+h3F3EmNAGA/a/t9vqtClwRAtOOEide1e5PxiNbMeirz9PUQn44tP
         ooig==
X-Gm-Message-State: AOJu0YxAm+WwYmDIM6Sa6FbfvDK/dAirjFGNFrNAeArKhf0aTRytetnv
        87PQZi02jNeu04CNySQXBRBgDanNbYk=
X-Google-Smtp-Source: AGHT+IFK2HPdcqdxubN6tEHZaU3AE/azjtdMdn8ZtvEm43Dnsw04NhO6F1f4/3rt8Q1EmkuNGol5uQ==
X-Received: by 2002:a05:620a:a17:b0:75b:23a0:deca with SMTP id i23-20020a05620a0a1700b0075b23a0decamr2721249qka.72.1693492829810;
        Thu, 31 Aug 2023 07:40:29 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id w27-20020a05620a149b00b0076ef3e6e6a4sm651875qkj.42.2023.08.31.07.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 07:40:29 -0700 (PDT)
Date:   Thu, 31 Aug 2023 10:40:21 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH] libext2fs: don't truncate the orphan file inode if it is
 newly allocated
Message-ID: <ZPCmVcqiTr6YlZY8@debian-BULLSEYE-live-builder-AMD64>
References: <20230825214551.136149-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825214551.136149-1-tytso@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Theodore Ts'o <tytso@mit.edu>:
> In ext2fs_create_orphan_file(), don't try truncating inode for the
> orphan file if ext2fs_create_orphan_file() allocated the inode.  This
> avoids problems where the newly allocated inode in the inode table
> might contain garbage; if the metadata checksum feature is enabled,
> this will generally result in the function failing with a checksum
> invalid error, but this can cause mke2fs (which calls
> ext2fs_create_orphan_file) to fail.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  lib/ext2fs/orphan.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/ext2fs/orphan.c b/lib/ext2fs/orphan.c
> index e25f20ca2..c2f83567f 100644
> --- a/lib/ext2fs/orphan.c
> +++ b/lib/ext2fs/orphan.c
> @@ -127,22 +127,21 @@ errcode_t ext2fs_create_orphan_file(ext2_filsys fs, blk_t num_blocks)
>  	struct mkorphan_info oi;
>  	struct ext4_orphan_block_tail *ob_tail;
>  
> -	if (!ino) {
> +	if (ino) {
> +		err = ext2fs_read_inode(fs, ino, &inode);
> +		if (err)
> +			return err;
> +		if (EXT2_I_SIZE(&inode)) {
> +			err = ext2fs_truncate_orphan_file(fs);
> +			if (err)
> +				return err;
> +		}
> +	} else {
>  		err = ext2fs_new_inode(fs, EXT2_ROOT_INO, LINUX_S_IFREG | 0600,
>  				       0, &ino);
>  		if (err)
>  			return err;
>  		ext2fs_inode_alloc_stats2(fs, ino, +1, 0);
> -		ext2fs_mark_ib_dirty(fs);
> -	}
> -
> -	err = ext2fs_read_inode(fs, ino, &inode);
> -	if (err)
> -		return err;
> -	if (EXT2_I_SIZE(&inode)) {
> -		err = ext2fs_truncate_orphan_file(fs);
> -		if (err)
> -			return err;
>  	}
>  
>  	memset(&inode, 0, sizeof(struct ext2_inode));
> -- 
> 2.31.0
> 

With this patch to mke2fs, I ran ext4/049 on a 6.5 kernel using kvm-xfstests'
4k test scenario.  It passed 110/110 trials.  Without the patch, it fails
100% of the time.  So, it addresses the failures I've been seeing.

Thanks!

Tested-by: Eric Whitney <enwlinux@gmail.com>

