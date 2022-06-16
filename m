Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097EC54D90E
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jun 2022 06:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiFPEAS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jun 2022 00:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFPEAQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jun 2022 00:00:16 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5698C56C00;
        Wed, 15 Jun 2022 21:00:13 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g186so159951pgc.1;
        Wed, 15 Jun 2022 21:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1kp6HmlDswuyD1yvOBrLR/PtmpgG1dVILvU7RfuoSLs=;
        b=Cd9oqlKOGtgVvEYO1IeARwR1WHNfphEHFpUaKkenlPNdiifbRub1Ur1ju76SbjHkri
         Am787V0AxfnfexSJHdYXiI21CP+uV2vVW9Z4/MGDWk7p6/v3cnebiK/WZ4B0CO1CFz1Z
         JOATogBa1rXy0jfSxCXtwxe5tV87eZLBfV4sq9PeySDW0RbBr8DEcZwyYiBqDrlTYQWy
         MIlN49mtE5VhPPSJYJL+YxJS4/1sLzwzlgvjfe9CUXEOZKZkvHxGPnO+bCuXvsDEBjlJ
         1AV1IJ6MS3v2nRYUc8pOwrSC/m+KI9xqXsoZ/8sF2d3PL/mAXXp1Oqq+QU1aeavBznmT
         ni8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1kp6HmlDswuyD1yvOBrLR/PtmpgG1dVILvU7RfuoSLs=;
        b=weKavhv+WVBNZ9U+13+LhUmm9PiDGjtGjxYWhwByj0TwNTh2tsBaAvitqk3O4iWeBs
         g48Wh+NZONgQd9UD9x4yQfMA+eGbDPW7g9E13IZMSJ7cXw4SP2B3u9K+gwMQAozSR59y
         EVoIcVEKyyUrqvDY1QyDvlszEX31/ZQ/SlUtyewl8SaHyf2IuY8PZ9rYBN3DhfU5TpvR
         6sNhBrujuLuzYEN1n0x604gvkj3Onetjjlp9oKdhJjDiH3ZeL6nUBCFw3NEiVXKxPryH
         Ix/gK2jrOOn4iMpvgr/rN/Wstpy3xd4bJKl0Qeq8tR3+B3L8+ulFD3JVoa8czq1j60nv
         9Tlw==
X-Gm-Message-State: AJIora8o9KMi/ij4OrBKjb750ntuT1okDa3ARU87KPLlu0oymxV8M8Q9
        wM8ML197KV/Kjf7R7P6216E=
X-Google-Smtp-Source: AGRyM1vvMovBLxxtCVtFY48ijVII2qBXZhyDOM44esoAIGlU56YRuzeWv+3Zt3cZBDH2x4nSUIQpIA==
X-Received: by 2002:a05:6a00:813:b0:51c:17b2:60cf with SMTP id m19-20020a056a00081300b0051c17b260cfmr2914896pfk.70.1655352012796;
        Wed, 15 Jun 2022 21:00:12 -0700 (PDT)
Received: from localhost ([2406:7400:63:5d34:e6c2:4c64:12ae:aa11])
        by smtp.gmail.com with ESMTPSA id ms24-20020a17090b235800b001e270cc443dsm2639739pjb.46.2022.06.15.21.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 21:00:12 -0700 (PDT)
Date:   Thu, 16 Jun 2022 09:30:07 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, lczerner@redhat.com,
        enwlinux@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 1/4] ext4: add EXT4_INODE_HAS_XATTR_SPACE macro in
 xattr.h
Message-ID: <20220616040007.e4uehjuluet2mmk2@riteshh-domain>
References: <20220616021358.2504451-1-libaokun1@huawei.com>
 <20220616021358.2504451-2-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616021358.2504451-2-libaokun1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/06/16 10:13AM, Baokun Li wrote:
> When adding an xattr to an inode, we must ensure that the inode_size is
> not less than EXT4_GOOD_OLD_INODE_SIZE + extra_isize + pad. Otherwise,
> the end position may be greater than the start position, resulting in UAF.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
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

Thanks for adding the visual :)
Looks good to me. Feel free to add -

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


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
