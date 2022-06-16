Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D6054D915
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jun 2022 06:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349658AbiFPEEU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jun 2022 00:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFPEER (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jun 2022 00:04:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A958C403DC;
        Wed, 15 Jun 2022 21:04:16 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id e11so405159pfj.5;
        Wed, 15 Jun 2022 21:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EBsCfC8tb7+VRmR4uxZN/fE3y4thkUkKWOj8JXNyy+g=;
        b=WYfGsOEBWAiYj75J6GKjXBriS615QdJQM56UXhmjNBj4dVQWPdbTAdvXoJgl12L5CP
         HA8tDeGwkXMovPCxUc51p8i4MsqlS+MBZf011uJipIn/wmXlazQa5wutuj/7+djtSDx9
         xFxPie59kZDH/MndCtZDCcTufPhnvo15fHA0LyTltop1U/qELKOgSalYVSZftdv1+Gmm
         +OAYjaeZw5zBSnxOMyvI+GEd2fVQisNZ0muCkz3BZsJP1kKKZyPlzs+CpSmKA5BqmEno
         XZhaTXmbyMr3HrJNxmibvlowNEGyMASbaXC11gpiT6QQ/Q7GbyOSolDwGrA6VWDT7dlR
         YYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EBsCfC8tb7+VRmR4uxZN/fE3y4thkUkKWOj8JXNyy+g=;
        b=Q1+uO0cdp5TrMkEUVnMPxstefrX/rVP73N8Y+yvAqfmDGEl7iDhNCGQDpk2u9UmRfc
         rZvdiMW34TcLWa32X6eiFF2tebO3yiiZxXyqWG/v/ly/XuomwpdTB8GcKJLvw5D2jUva
         yw4ZhmnKW1RjwF9+UzFTYCtyZ34kMzWauRD1H65ul1A6n2oyoRIWmIC6ikzaax2yVAx0
         jtqUHH+c2U9E/sqUjKNsBHFqwhGjZaijj5DiBs2ZS5AFP5BQKmCA1o35QSPGcJ+vpZXU
         di0bJe2XAw1IJF/YCQzZCLepQa2dMM5ORfZRMPmlJk0i8GDQTvBSAvvvpMM9YNgLftfE
         /PAg==
X-Gm-Message-State: AJIora+VZ/V83QjWaLOc+FB4LL8JDmOuZOASzxJTfOMt7tQAW70n6Z0Z
        sG+AWgk28F6SYHF49lBJuKg=
X-Google-Smtp-Source: AGRyM1sPDZL+FbDkRT64NbubG8JmSPcOdo+aN/qnrQCfjkiWzgw4rxYdSoCA4vmzhG+JDygnWJg8XA==
X-Received: by 2002:a05:6a00:23c6:b0:51b:f8e3:2e5c with SMTP id g6-20020a056a0023c600b0051bf8e32e5cmr2897544pfc.43.1655352256180;
        Wed, 15 Jun 2022 21:04:16 -0700 (PDT)
Received: from localhost ([2406:7400:63:5d34:e6c2:4c64:12ae:aa11])
        by smtp.gmail.com with ESMTPSA id 72-20020a17090a0fce00b001e310303275sm384123pjz.54.2022.06.15.21.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 21:04:15 -0700 (PDT)
Date:   Thu, 16 Jun 2022 09:34:11 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, lczerner@redhat.com,
        enwlinux@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 3/4] ext4: correct max_inline_xattr_value_size
 computing
Message-ID: <20220616040411.5vsnxz5fc4yq4zri@riteshh-domain>
References: <20220616021358.2504451-1-libaokun1@huawei.com>
 <20220616021358.2504451-4-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616021358.2504451-4-libaokun1@huawei.com>
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
> If the ext4 inode does not have xattr space, 0 is returned in the
> get_max_inline_xattr_value_size function. Otherwise, the function returns
> a negative value when the inode does not contain EXT4_STATE_XATTR.

Yes, this looks good to me.

Feel free to add -
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/inline.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index cff52ff6549d..da5de43623dd 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -35,6 +35,9 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
>  	struct ext4_inode *raw_inode;
>  	int free, min_offs;
>
> +	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
> +		return 0;
> +
>  	min_offs = EXT4_SB(inode->i_sb)->s_inode_size -
>  			EXT4_GOOD_OLD_INODE_SIZE -
>  			EXT4_I(inode)->i_extra_isize -
> --
> 2.31.1
>
