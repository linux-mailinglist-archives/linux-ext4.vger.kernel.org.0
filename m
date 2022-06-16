Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7960D54D91A
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jun 2022 06:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344862AbiFPEIw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jun 2022 00:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358588AbiFPEIf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jun 2022 00:08:35 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9470456F86;
        Wed, 15 Jun 2022 21:08:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso402931pja.2;
        Wed, 15 Jun 2022 21:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vd0bN/XPx9OiHy3gzLV4Y4YAjktoSbcYs2uZYZ3e/rE=;
        b=ibewHG8NBpBVeqDL2HqfKHkpvwh+DszHHVNyZXtLa3L1tM0mm0Gio1zpSmomvTLjb8
         7Msk/fcArYrHM20BU112m31sFDNSJypd6MrOo2vPSPdy3csxD0vuUk9xgrZ/zkRtiOpB
         EVjaiMpDJKUEbqV+uIzQld389AHFq8TEZ1CtmzfBOswLF6PMcgpH7uhN894Yve78gPS8
         xggBKy+PDeUdYXseShdI9t1TxCAXgq4gv52eO2aui2wXZADd19PCnxcWaoAzO9yO30r8
         OSCvfeEh8PgzkRFB1xmL1PARFsqLH6eA/JRskTTr1CrJr0EuBPAk+orAF+d38eA3cFB1
         +jUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vd0bN/XPx9OiHy3gzLV4Y4YAjktoSbcYs2uZYZ3e/rE=;
        b=n2//GmKd+J5brIs9fLaiecffMW2ytoUZ5UlfDNNA5OUU9UqDGKXlfd8jXPTMqqKWyn
         1pdSexw8KAKWb5hRjdztDSFELZWTQ+0C81+tgRy1qmmdf1OrnVcRLh0Lha5/0wcosUrk
         Vem5VGHnf0KqihOy6SrgKlfllWNkdKcrUtm1HNHjhjtmIve9BiU5OvqALhFy9RDfvwoj
         fk33j/emaV/4oyAN90D4qhnohScbvnp8lRAiEl9Pe7XPhT5FB95V68sNvyhJyQ00W4iV
         R1Vl3DcmzUwJ3BJfFQTjRwLzV1MIMVIjITgsFTz/SHRwwilTo9BX2CJ1ojdBIwx8RqbK
         jb4w==
X-Gm-Message-State: AJIora8qqqmrymnHO1cyRkRKofaoGpGzshevfUR0a+cj3GFXTJSJC8Wr
        iKu/PhmhTMtPjvHhADJF1jw=
X-Google-Smtp-Source: AGRyM1vpVH9mYKbCmmwnS4lz+GWa53yJrZpou5g2IhEW3/j+pwcP71PaEzDsfNyilqvzTau4LnYyhw==
X-Received: by 2002:a17:902:8a91:b0:167:621f:9749 with SMTP id p17-20020a1709028a9100b00167621f9749mr2871786plo.9.1655352513997;
        Wed, 15 Jun 2022 21:08:33 -0700 (PDT)
Received: from localhost ([2406:7400:63:5d34:e6c2:4c64:12ae:aa11])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902784800b00163d76696e1sm456561pln.102.2022.06.15.21.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 21:08:33 -0700 (PDT)
Date:   Thu, 16 Jun 2022 09:38:29 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, lczerner@redhat.com,
        enwlinux@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 4/4] ext4: correct the misjudgment in
 ext4_iget_extra_inode
Message-ID: <20220616040829.kb66mg2dnitnlkau@riteshh-domain>
References: <20220616021358.2504451-1-libaokun1@huawei.com>
 <20220616021358.2504451-5-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616021358.2504451-5-libaokun1@huawei.com>
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
> Use the EXT4_INODE_HAS_XATTR_SPACE macro to more accurately
> determine whether the inode have xattr space.

Right. I also noticed there are few places in fs/ext4/xattr.c
and in fs/ext4/inline.c where sizeof(__u32) is being used which (I think)
should be EXT4_XATTR_PAD. But that need not be part of this patch series.

Looks good to me. Feel free to add -
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 53877ffe3c41..ae463cd9b405 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4687,8 +4687,7 @@ static inline int ext4_iget_extra_inode(struct inode *inode,
>  	__le32 *magic = (void *)raw_inode +
>  			EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize;
>
> -	if (EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize + sizeof(__le32) <=
> -	    EXT4_INODE_SIZE(inode->i_sb) &&
> +	if (EXT4_INODE_HAS_XATTR_SPACE(inode)  &&
>  	    *magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
>  		ext4_set_inode_state(inode, EXT4_STATE_XATTR);
>  		return ext4_find_inline_data_nolock(inode);
> --
> 2.31.1
>
