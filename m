Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 306941A650
	for <lists+linux-ext4@lfdr.de>; Sat, 11 May 2019 04:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfEKCmQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 May 2019 22:42:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33382 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfEKCmQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 May 2019 22:42:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so3880959pgv.0
        for <linux-ext4@vger.kernel.org>; Fri, 10 May 2019 19:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=S5SU7ltNr5gHnrdqbpgmMlTnpHdX0llJzHoXBlkG8j0=;
        b=NTwImWj9253fBsVeK0TrgBWKCjJc1RQMBjYgBCnqivTjfcCzTkxnUn3O/st5/E0vUE
         NutP3S72hMCajkIoUw7Xm+oZyiT/WdrAHOg4BEp3QaK5b1Asp0gEMkrR1xb9r6FlA96l
         PfR+PK6Zf2NuIOoiovBHR3HtA03EECUY9xBGYJKdW+4U0tj9+OV+BRa2Huk74QM9oo9E
         XzAbDlo6hOFewDPVD0HChjVAR2K2m88+SfCCLH78YL+Bi/+8zeXHzt6fjLiWyjmIv/6b
         NTBzRO5UyuclZtHePu7x2rYMQIrOPjXpc4J2B59Pb+OdgbapV8OrmVt1RgsTuwjBC+5K
         wrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=S5SU7ltNr5gHnrdqbpgmMlTnpHdX0llJzHoXBlkG8j0=;
        b=snIMPl1x1/k7NAHRVD5bpaZI/1tkGn0Fh4ZU3DvWLb6Ob5e8qchXJ0z2x5/E16U461
         kc3Lbd6n3ohBAjbgyGX4VFqW4xy9iqAiR/2tWdr4riHX4qPkjfrWO+ltF5It9IK+z6w6
         V8NLEdKhox51V3SyM/WZ+sXl8dXv421hcIIifN+oDDSMpmx06tKQKyRnZXCxK0Ni6yws
         cRiqGB7p26UKXZQEo2Jl+nQExI/pl72UfDmFHFM2+pO/uVnqFPE2cGVEX5hYB6T97dQB
         reFW9p6uz+yASddcYNF87BSUU4woYCOKjWUy9OY0L3A+hZkhEX0iNc4saJUfESpqu8b6
         Q+Vw==
X-Gm-Message-State: APjAAAVjZCyGXhrfVy+r+YM8Gf1azdVYD81N9u2tTd3ituTBo114yVWd
        gKcMw0kphbfrcOmhUNsVT1xIZR+n0Fc=
X-Google-Smtp-Source: APXvYqyQxGX7EKbAoug1qqdT2Th5e+aglf1EcwzGU1rWo6ILpP28z/yn/SYi7KYJ7uxn3BpXqX3uSw==
X-Received: by 2002:a63:8e4b:: with SMTP id k72mr17853532pge.428.1557542535103;
        Fri, 10 May 2019 19:42:15 -0700 (PDT)
Received: from ?IPv6:2605:8d80:420:3459:4d49:2e8c:9e3:f11d? ([2605:8d80:420:3459:4d49:2e8c:9e3:f11d])
        by smtp.gmail.com with ESMTPSA id 132sm9071300pfw.87.2019.05.10.19.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 19:42:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] ext2: introduce helper for xattr header validation
From:   Andreas Dilger <adilger@dilger.ca>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <1557484666-23562-1-git-send-email-cgxu519@gmail.com>
Date:   Fri, 10 May 2019 20:42:12 -0600
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9B033593-E86D-4B86-97CB-6833BCC340AC@dilger.ca>
References: <1557484666-23562-1-git-send-email-cgxu519@gmail.com>
To:     Chengguang Xu <cgxu519@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It seems like this would be more useful if you passed it the header
like ext2_xattr_header_valid(HDR(bh)).

Cheers, Andreas

> On May 10, 2019, at 04:37, Chengguang Xu <cgxu519@gmail.com> wrote:
>=20
> Introduce helper function ext2_xattr_header_valid()
> for xattr header validation and clean up the header
> check ralated code.
>=20
> Signed-off-by: Chengguang Xu <cgxu519@gmail.com>
> ---
> fs/ext2/xattr.c | 31 ++++++++++++++++++++-----------
> 1 file changed, 20 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index 1e33e0ac8cf1..6e0b2b0f333f 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -134,6 +134,16 @@ ext2_xattr_handler(int name_index)
>    return handler;
> }
>=20
> +static bool
> +ext2_xattr_header_valid(struct buffer_head *bh)
> +{
> +    if (HDR(bh)->h_magic !=3D cpu_to_le32(EXT2_XATTR_MAGIC) ||
> +        HDR(bh)->h_blocks !=3D cpu_to_le32(1))
> +        return false;
> +
> +    return true;
> +}
> +
> /*
>  * ext2_xattr_get()
>  *
> @@ -176,9 +186,9 @@ ext2_xattr_get(struct inode *inode, int name_index, co=
nst char *name,
>    ea_bdebug(bh, "b_count=3D%d, refcount=3D%d",
>        atomic_read(&(bh->b_count)), le32_to_cpu(HDR(bh)->h_refcount));
>    end =3D bh->b_data + bh->b_size;
> -    if (HDR(bh)->h_magic !=3D cpu_to_le32(EXT2_XATTR_MAGIC) ||
> -        HDR(bh)->h_blocks !=3D cpu_to_le32(1)) {
> -bad_block:    ext2_error(inode->i_sb, "ext2_xattr_get",
> +    if (!ext2_xattr_header_valid(bh)) {
> +bad_block:
> +        ext2_error(inode->i_sb, "ext2_xattr_get",
>            "inode %ld: bad block %d", inode->i_ino,
>            EXT2_I(inode)->i_file_acl);
>        error =3D -EIO;
> @@ -266,9 +276,9 @@ ext2_xattr_list(struct dentry *dentry, char *buffer, s=
ize_t buffer_size)
>    ea_bdebug(bh, "b_count=3D%d, refcount=3D%d",
>        atomic_read(&(bh->b_count)), le32_to_cpu(HDR(bh)->h_refcount));
>    end =3D bh->b_data + bh->b_size;
> -    if (HDR(bh)->h_magic !=3D cpu_to_le32(EXT2_XATTR_MAGIC) ||
> -        HDR(bh)->h_blocks !=3D cpu_to_le32(1)) {
> -bad_block:    ext2_error(inode->i_sb, "ext2_xattr_list",
> +    if (!ext2_xattr_header_valid(bh)) {
> +bad_block:
> +        ext2_error(inode->i_sb, "ext2_xattr_list",
>            "inode %ld: bad block %d", inode->i_ino,
>            EXT2_I(inode)->i_file_acl);
>        error =3D -EIO;
> @@ -406,9 +416,9 @@ ext2_xattr_set(struct inode *inode, int name_index, co=
nst char *name,
>            le32_to_cpu(HDR(bh)->h_refcount));
>        header =3D HDR(bh);
>        end =3D bh->b_data + bh->b_size;
> -        if (header->h_magic !=3D cpu_to_le32(EXT2_XATTR_MAGIC) ||
> -            header->h_blocks !=3D cpu_to_le32(1)) {
> -bad_block:        ext2_error(sb, "ext2_xattr_set",
> +        if (!ext2_xattr_header_valid(bh)) {
> +bad_block:
> +            ext2_error(sb, "ext2_xattr_set",
>                "inode %ld: bad block %d", inode->i_ino,=20
>                   EXT2_I(inode)->i_file_acl);
>            error =3D -EIO;
> @@ -784,8 +794,7 @@ ext2_xattr_delete_inode(struct inode *inode)
>        goto cleanup;
>    }
>    ea_bdebug(bh, "b_count=3D%d", atomic_read(&(bh->b_count)));
> -    if (HDR(bh)->h_magic !=3D cpu_to_le32(EXT2_XATTR_MAGIC) ||
> -        HDR(bh)->h_blocks !=3D cpu_to_le32(1)) {
> +    if (!ext2_xattr_header_valid(bh)) {
>        ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
>            "inode %ld: bad block %d", inode->i_ino,
>            EXT2_I(inode)->i_file_acl);
> --=20
> 2.20.1
>=20
