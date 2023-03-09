Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544186B214B
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Mar 2023 11:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjCIKWp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Mar 2023 05:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCIKWb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Mar 2023 05:22:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C40030E97
        for <linux-ext4@vger.kernel.org>; Thu,  9 Mar 2023 02:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678357302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Ir/h645vG7/3e7LKCiTYw/Yo812wpfTRDoEn9ipx+Q=;
        b=SSfl51iTpUMTvP0YVrvoazq8A1v+1og982hdPpMsBX5uYVGdxM/KouRhiOJ+W/CWfGWPQk
        uT29hNO6k/45u4DLj7G4GfH37pNzZPRcRLS8eXpUhUanDGrBukIDNDK5ElCcrx9ziqr+84
        +pXIMcei67ruF1KHqmhEnbjQKd9/MPA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-H_rl-nOQM--BXj_vVuiA0g-1; Thu, 09 Mar 2023 05:21:41 -0500
X-MC-Unique: H_rl-nOQM--BXj_vVuiA0g-1
Received: by mail-pj1-f71.google.com with SMTP id fa21-20020a17090af0d500b00237b14b60a4so816098pjb.6
        for <linux-ext4@vger.kernel.org>; Thu, 09 Mar 2023 02:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678357295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ir/h645vG7/3e7LKCiTYw/Yo812wpfTRDoEn9ipx+Q=;
        b=eCo18zsCcXQNY7MswQ4gSAMKPX1O3Kfi5C9trZ9QA8PGuH4g107ocxhpHLp+Etz//T
         Ul1gDaqtpYmO8GQziB2jRB3eis01uZ9yFb+sY75WQaN3+r2mVUF8tML24LVxebYVnuW1
         xOX6vL9oMUPcwkB+kVNm2dRyRGLB7v+VBO7Y5iAxCxbAam0sepw0F1yrSbYSv5NcpjcJ
         vdFJzbBD748OBzZ4NLw2oTi2s9FlxRCnnlAr8MpR/e38AJmjDQ2ZY79RaTfWRCnCWOwm
         ZH3pDRYevZkvyXkt+jh7BaSQlnsNrWED7nV+xzThPwhfjlFU4jUitKCUS6iBGHOyFv6J
         Kejg==
X-Gm-Message-State: AO0yUKUrtqhhYRnTD4n/kautSPZjFk4rzsF0hmpD8AZ4UUiX+t5NxOYm
        3fLtac0+wfR8Sf4kDDBFBRV0Yo4ObJs0ejHP3Zsbp7sgUzw/YGV97HSw+vQHIpvcxPd51LLHAgn
        VkEARv/cfOAEMRieqzCOHkolCcto3wWQZlg94Vw==
X-Received: by 2002:a17:902:f7c1:b0:19c:a3be:a4f3 with SMTP id h1-20020a170902f7c100b0019ca3bea4f3mr8229334plw.4.1678357295488;
        Thu, 09 Mar 2023 02:21:35 -0800 (PST)
X-Google-Smtp-Source: AK7set9VDTf99mRyC2eJOBxIkMspHxJ2pV++2lzfcL1yIkpa4x+m9xdxgNtT/wUdeXHjX/qKTQaaMK9Wp7kJK/Zrno4=
X-Received: by 2002:a17:902:f7c1:b0:19c:a3be:a4f3 with SMTP id
 h1-20020a170902f7c100b0019ca3bea4f3mr8229321plw.4.1678357295164; Thu, 09 Mar
 2023 02:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20230309094317.69773-1-frank.li@vivo.com>
In-Reply-To: <20230309094317.69773-1-frank.li@vivo.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 9 Mar 2023 11:21:23 +0100
Message-ID: <CAHc6FU7vGD9NGn0phJsLEmcU8O7AaBS+hm=AEwYOc0nFGHS-hQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] fs: add i_blocksize_mask()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 9, 2023 at 10:43=E2=80=AFAM Yangtao Li <frank.li@vivo.com> wrot=
e:
> Introduce i_blocksize_mask() to simplify code, which replace
> (i_blocksize(node) - 1). Like done in commit
> 93407472a21b("fs: add i_blocksize()").

I would call this i_blockmask().

Note that it could be used in ocfs2_is_io_unaligned() as well.

>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  include/linux/fs.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c85916e9f7db..db335bd9c256 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -711,6 +711,11 @@ static inline unsigned int i_blocksize(const struct =
inode *node)
>         return (1 << node->i_blkbits);
>  }
>
> +static inline unsigned int i_blocksize_mask(const struct inode *node)
> +{
> +       return i_blocksize(node) - 1;
> +}
> +
>  static inline int inode_unhashed(struct inode *inode)
>  {
>         return hlist_unhashed(&inode->i_hash);
> --
> 2.25.1
>

Thanks,
Andreas

