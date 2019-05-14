Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBF71CBEB
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2019 17:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfENPcI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 May 2019 11:32:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43417 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfENPcI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 May 2019 11:32:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id i8so15607792oth.10
        for <linux-ext4@vger.kernel.org>; Tue, 14 May 2019 08:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=PR3J6CLUrLgKtBA34UgmHdeEPdyYUGmmRUIztD4e3nY=;
        b=mjxfuSKoY7yiUmv+J7P9Rmi/0raeHsZHlNZyOuHDnSRbCliknJH4QBZqUyU5re12WJ
         4WeC1YiXtHCNJMB9O1WlFdi7faH0YsYFqF4OyX5qUSgVc5O8Zb4na4ABQUMEos90j1+x
         gzKH4zbb5qb8eb23gM2qCh2Bqi1p1X7cyAM9p/97yEDVDJw78I6QGTYsxSPAXcI0NORV
         ilEZBNiVODd6CowgeuDtvqvhuvBgaKaASTci1Sb50Ek1qxKwEfQLU1OuiQFtEmiBTSK0
         7PbbAGckHu8N7PwrzGa7jofiaoiqfWCSm8pYKH7dStpSK1ugrjLxjso7+n2MNKLt62Ji
         XLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=PR3J6CLUrLgKtBA34UgmHdeEPdyYUGmmRUIztD4e3nY=;
        b=Q3v3Gt70uS26GR2p1HouxPdMUThSIB3SV+AfvWIRdP1c7aHd+tiV+0zcRLjfcTTOrT
         JuZoCLcZizSJhvnHUqrw5D262qLkz3vMt/9koOZk5eqxPwUqcquIz4a7j3MJ9frP7L9u
         Oe4CwzNP5NmmlJ986WMXQp7CsgAgpN9AcJrsWYyFNcW99Ke9EClE8oRNBqdpPEHBUIsK
         4iiHmaqk5zzFKADQxsxc6HQ2Ou6UqzmDh2lFb7WBV+f/QBjnyxbmSFbhkOWOev5NT4jK
         MQLKkYZiUH5uBxV7kUTz939M/FdRSvcVUU0NMOuaL9VmGC47F8HqX3I+Ymlg4XeoNNbz
         3q9Q==
X-Gm-Message-State: APjAAAUw1LcIESf0S58u5oq0GBqSSW7VAdrtarxjC9pTix3tlZElk34Q
        BvBMwtOLC3n4ahzr73Vwj1Oll8a2yEoKCA==
X-Google-Smtp-Source: APXvYqzDw+leNzRP5Jv5SYHjfrSxdd9g3QnGe5yVnuRZ2Tx3FXOqkmNPYfIY/Ys48cmDd+CKdIBS3g==
X-Received: by 2002:a9d:6195:: with SMTP id g21mr266888otk.179.1557847927584;
        Tue, 14 May 2019 08:32:07 -0700 (PDT)
Received: from [172.25.180.192] ([129.7.0.180])
        by smtp.gmail.com with ESMTPSA id 33sm3732160otu.26.2019.05.14.08.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 08:32:06 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <3F06FAEE-E534-42A0-A927-A07259070D6A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9E05C5A2-4696-44DD-BFCF-B80D64EEE097";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 1/2] ext2: introduce helper for xattr header validation
Date:   Tue, 14 May 2019 09:32:10 -0600
In-Reply-To: <20190513224042.23377-1-cgxu519@zoho.com.cn>
Cc:     Jan Kara <jack@suse.com>, linux-ext4 <linux-ext4@vger.kernel.org>
To:     Chengguang Xu <cgxu519@zoho.com.cn>
References: <20190513224042.23377-1-cgxu519@zoho.com.cn>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_9E05C5A2-4696-44DD-BFCF-B80D64EEE097
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 13, 2019, at 4:40 PM, Chengguang Xu <cgxu519@zoho.com.cn> wrote:
>=20
> Introduce helper function ext2_xattr_header_valid()
> for xattr header validation and clean up the header
> check ralated code.
>=20
> Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> v1->v2:
> - Pass xattr header to ext2_xattr_header_valid().
> - Change signed-off mail address.
>=20
> fs/ext2/xattr.c | 31 ++++++++++++++++++++-----------
> 1 file changed, 20 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index 1e33e0ac8cf1..db27260d6a5b 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -134,6 +134,16 @@ ext2_xattr_handler(int name_index)
> 	return handler;
> }
>=20
> +static bool
> +ext2_xattr_header_valid(struct ext2_xattr_header *header)
> +{
> +	if (header->h_magic !=3D cpu_to_le32(EXT2_XATTR_MAGIC) ||
> +	    header->h_blocks !=3D cpu_to_le32(1))
> +		return false;
> +
> +	return true;
> +}
> +
> /*
>  * ext2_xattr_get()
>  *
> @@ -176,9 +186,9 @@ ext2_xattr_get(struct inode *inode, int =
name_index, const char *name,
> 	ea_bdebug(bh, "b_count=3D%d, refcount=3D%d",
> 		atomic_read(&(bh->b_count)), =
le32_to_cpu(HDR(bh)->h_refcount));
> 	end =3D bh->b_data + bh->b_size;
> -	if (HDR(bh)->h_magic !=3D cpu_to_le32(EXT2_XATTR_MAGIC) ||
> -	    HDR(bh)->h_blocks !=3D cpu_to_le32(1)) {
> -bad_block:	ext2_error(inode->i_sb, "ext2_xattr_get",
> +	if (!ext2_xattr_header_valid(HDR(bh))) {
> +bad_block:
> +		ext2_error(inode->i_sb, "ext2_xattr_get",
> 			"inode %ld: bad block %d", inode->i_ino,
> 			EXT2_I(inode)->i_file_acl);
> 		error =3D -EIO;
> @@ -266,9 +276,9 @@ ext2_xattr_list(struct dentry *dentry, char =
*buffer, size_t buffer_size)
> 	ea_bdebug(bh, "b_count=3D%d, refcount=3D%d",
> 		atomic_read(&(bh->b_count)), =
le32_to_cpu(HDR(bh)->h_refcount));
> 	end =3D bh->b_data + bh->b_size;
> -	if (HDR(bh)->h_magic !=3D cpu_to_le32(EXT2_XATTR_MAGIC) ||
> -	    HDR(bh)->h_blocks !=3D cpu_to_le32(1)) {
> -bad_block:	ext2_error(inode->i_sb, "ext2_xattr_list",
> +	if (!ext2_xattr_header_valid(HDR(bh))) {
> +bad_block:
> +		ext2_error(inode->i_sb, "ext2_xattr_list",
> 			"inode %ld: bad block %d", inode->i_ino,
> 			EXT2_I(inode)->i_file_acl);
> 		error =3D -EIO;
> @@ -406,9 +416,9 @@ ext2_xattr_set(struct inode *inode, int =
name_index, const char *name,
> 			le32_to_cpu(HDR(bh)->h_refcount));
> 		header =3D HDR(bh);
> 		end =3D bh->b_data + bh->b_size;
> -		if (header->h_magic !=3D cpu_to_le32(EXT2_XATTR_MAGIC) =
||
> -		    header->h_blocks !=3D cpu_to_le32(1)) {
> -bad_block:		ext2_error(sb, "ext2_xattr_set",
> +		if (!ext2_xattr_header_valid(header)) {
> +bad_block:
> +			ext2_error(sb, "ext2_xattr_set",
> 				"inode %ld: bad block %d", inode->i_ino,
> 				   EXT2_I(inode)->i_file_acl);
> 			error =3D -EIO;
> @@ -784,8 +794,7 @@ ext2_xattr_delete_inode(struct inode *inode)
> 		goto cleanup;
> 	}
> 	ea_bdebug(bh, "b_count=3D%d", atomic_read(&(bh->b_count)));
> -	if (HDR(bh)->h_magic !=3D cpu_to_le32(EXT2_XATTR_MAGIC) ||
> -	    HDR(bh)->h_blocks !=3D cpu_to_le32(1)) {
> +	if (!ext2_xattr_header_valid(HDR(bh))) {
> 		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
> 			"inode %ld: bad block %d", inode->i_ino,
> 			EXT2_I(inode)->i_file_acl);
> --
> 2.17.2
>=20
>=20


Cheers, Andreas






--Apple-Mail=_9E05C5A2-4696-44DD-BFCF-B80D64EEE097
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlza33oACgkQcqXauRfM
H+AikQ//fVEVygRGNl+LW+6Sn5dxsHY6M/pivISM/xO2KFoazegpzHdoFOhiwUFK
eHZfvXeI+oLK9c+Oe1NtERngl3M6B1neLSjMv0lvQmwOGqqGgwnHckMKvwwuFZdz
K94zAthvqP4A+o17NgYGO5dc8ofoi921YvaIHnJA7O1vB6PxYyRWhjlXGWQdurok
L6cmaYX6oGJmpDgf6NvciWjQshRRmf8XbJxpeADOdu+P3jsNyUG9ILCTKnFzpqtK
jH31qpRno5p4eCgSJVX1qcVR+0wOU3NRhKalBVqf1PF3/CQuB/5QvaV91aOQPWfB
4LzHmmnv2LniuSj247r/Yrl3QnXzYp+tQTkMHSTEA1fJvjd57zgVOvszN87PqY+C
YMSwJ17wrZl9IiZcvZqlUfIKlxgmONZOE0JZifrf1Jj/i8wkshR0jeKA38B4bvSN
UUNZ2deVT8B1Dtczp/7vXJrccZuE7o4pSBoybqFmoLsy+IO4cI2EXdfbuyXkJQAy
FVnENEP+YYSBJ2xmP6hXbbCIuLLxU8dfBB2Xni5j6AsrGkPWnS0GJTlh5CfttHDQ
AxXxuzTU86eK5Z9pxqvSzc3Ec5cXt8Ah0y68KngVrHMEk6WbN2qB5orjsu5ezLvo
SJKfzu2ftnIaJ/xgGWb7gjGm+3ePcW36wu9FRhiwaRAAxva5dWI=
=ZY6U
-----END PGP SIGNATURE-----

--Apple-Mail=_9E05C5A2-4696-44DD-BFCF-B80D64EEE097--
