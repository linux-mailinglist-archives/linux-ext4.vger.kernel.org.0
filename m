Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84C211A656
	for <lists+linux-ext4@lfdr.de>; Sat, 11 May 2019 04:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfEKCqV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 May 2019 22:46:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36043 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbfEKCqV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 May 2019 22:46:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so3660748plr.3
        for <linux-ext4@vger.kernel.org>; Fri, 10 May 2019 19:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PuqHWwbUC1NSz/HxzJs8gEPDUdL9OSsHw6iGoCx59+g=;
        b=wlgeLqCffWMH2yd9vw4+wx9wjl4LwrzvhgIIvx4QZJ5a0RJhLeOh3o+6N8Stmfg7iX
         v7E6whB+EDmSFwBpLShUgWCOMtbVndDCeG0iBCZgRnBfQj5cNjiI8/I4yLP5amrJVeui
         2FJOvgzBXdzSoWpVKGLsSUDT4bBnIcduVDMQC2PLl5CfeHW4qMzL/InRTkKx5vY7M5a0
         2EDJi1fiyo6RXzPQwyLrBQX2XaqIhZUaCbhSdw5LxZUQ8BRGds3XLlpn1dDUjeqSrTzo
         vAkOgEIyXvFiLS6JndXVvqW6Ns0fUIBDCR57JZqR3+8n2dB6raky2Pi1DbOwODAAsHBk
         ntpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PuqHWwbUC1NSz/HxzJs8gEPDUdL9OSsHw6iGoCx59+g=;
        b=n8cCu02JXKuxeygKrkucbxOJbG6uwDX6QpDuJZjU/Ian3BXXhppJQqnqYNx8ROB3XT
         hSlQY2mxTTB8jPTUa4np9cs2PdBNSAsKqCAXBTUvP4PmVwaYAN7Ijt1y2ec7xKxBfmND
         CoxcWevSZGwpDm1iQvQTys8P0ynlqDo/QjUk6Oqw09uxqzOxlft5oCsLkTiuwsIra46y
         9RLhYxcNDNysp5w9VU9WYBTlnOArv6TByxL7m/QghA1LulXoqwg/LJyXloJineA/edBk
         8UX+AsiZMNvenXTfFty3CQMkHFysBAq+lST6/dUVKbre/hG7lZlvzo09d/2NcTUIf/vq
         xfUw==
X-Gm-Message-State: APjAAAWOkb7gUy6FvXbeDrtyeiYXc6HosQfWWov1BF44z1mo7s6hILy9
        w63BibJ0zvbuP0Hiq7US+gq+24UfcRs=
X-Google-Smtp-Source: APXvYqxRjJuGUkm+QF0Y/AhiueULNqoahqX1A3bzk/lCMn4eEGwZlyl2UA2dihW+PWQXerGB9WaMuw==
X-Received: by 2002:a17:902:2a28:: with SMTP id i37mr16167597plb.47.1557542780434;
        Fri, 10 May 2019 19:46:20 -0700 (PDT)
Received: from ?IPv6:2605:8d80:420:3459:4d49:2e8c:9e3:f11d? ([2605:8d80:420:3459:4d49:2e8c:9e3:f11d])
        by smtp.gmail.com with ESMTPSA id i22sm8203821pfa.127.2019.05.10.19.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 19:46:19 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/2] ext2: introduce helper for xattr entry validation
From:   Andreas Dilger <adilger@dilger.ca>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <1557484666-23562-2-git-send-email-cgxu519@gmail.com>
Date:   Fri, 10 May 2019 20:46:18 -0600
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5648047B-F38D-4246-8C4C-902A44E89108@dilger.ca>
References: <1557484666-23562-1-git-send-email-cgxu519@gmail.com> <1557484666-23562-2-git-send-email-cgxu519@gmail.com>
To:     Chengguang Xu <cgxu519@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Similarly, this would be more useful if it took the blocksize directly as an=

argument rather than the inode. That would allow it to be used to check
entries in the extended inode space or an external inode.=20

Cheers, Andreas

> On May 10, 2019, at 04:37, Chengguang Xu <cgxu519@gmail.com> wrote:
>=20
> Introduce helper function ext2_xattr_entry_valid()
> for xattr entry validation and clean up the entry
> check ralated code.
>=20
> Signed-off-by: Chengguang Xu <cgxu519@gmail.com>
> ---
> fs/ext2/xattr.c | 22 ++++++++++++++++------
> 1 file changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index 6e0b2b0f333f..e40fff8ab543 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -144,6 +144,20 @@ ext2_xattr_header_valid(struct buffer_head *bh)
>   return true;
> }
>=20
> +static bool
> +ext2_xattr_entry_valid(struct inode *inode, struct ext2_xattr_entry *entr=
y,
> +               size_t size)
> +{
> +    if (entry->e_value_block !=3D 0)
> +        return false;
> +
> +    if (size > inode->i_sb->s_blocksize ||
> +        le16_to_cpu(entry->e_value_offs) + size > inode->i_sb->s_blocksiz=
e)
> +        return false;
> +
> +    return true;
> +}
> +
> /*
> * ext2_xattr_get()
> *
> @@ -214,11 +228,8 @@ ext2_xattr_get(struct inode *inode, int name_index, c=
onst char *name,
>   goto cleanup;
> found:
>   /* check the buffer size */
> -    if (entry->e_value_block !=3D 0)
> -        goto bad_block;
>   size =3D le32_to_cpu(entry->e_value_size);
> -    if (size > inode->i_sb->s_blocksize ||
> -        le16_to_cpu(entry->e_value_offs) + size > inode->i_sb->s_blocksiz=
e)
> +    if (!ext2_xattr_entry_valid(inode, entry, size))
>       goto bad_block;
>=20
>   if (ext2_xattr_cache_insert(ea_block_cache, bh))
> @@ -483,8 +494,7 @@ ext2_xattr_set(struct inode *inode, int name_index, co=
nst char *name,
>       if (!here->e_value_block && here->e_value_size) {
>           size_t size =3D le32_to_cpu(here->e_value_size);
>=20
> -            if (le16_to_cpu(here->e_value_offs) + size >=20
> -                sb->s_blocksize || size > sb->s_blocksize)
> +            if (!ext2_xattr_entry_valid(inode, here, size))
>               goto bad_block;
>           free +=3D EXT2_XATTR_SIZE(size);
>       }
> --=20
> 2.20.1
>=20
