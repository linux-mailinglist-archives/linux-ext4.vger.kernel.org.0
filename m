Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85FDD1CBED
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2019 17:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfENPcx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 May 2019 11:32:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45468 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfENPcw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 May 2019 11:32:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id t24so6914904otl.12
        for <linux-ext4@vger.kernel.org>; Tue, 14 May 2019 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=6FtkXmf+nnF0eQrrjaNN8NvRQOOoEpkE8/BKHxmu4kw=;
        b=sM0JvZvZ/CfDTULf/IjNXB1Xutxi3t+j1kompbxNPQs3SnLf38fZRq7p5B1Z7kzS5Q
         NtK6exkRfbDPP/9MXv9PwILU4VSB1M0qucPE0ofYYmDJrfIOQqwlq3Qz1d80dowbqqSW
         iHFNf97KInQXvkwT6VnjIqTlIEmCW4h9SdMPO20lQbF5dsXV5/SBDfRX7HlpgOy4MFFo
         Dw16G8RjO1Ejlm20KAv2yMIzdUPpb8/1nEMfYLykHqKIH316ejOCf/EfQtD5H3QDdSqz
         WXJ/QS2+A/h7o0vn2/quHz4uO0JKULAEu0ecLRqXXdxtb3g1x9u+Z+/pVmqLkSNz3ITB
         nfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=6FtkXmf+nnF0eQrrjaNN8NvRQOOoEpkE8/BKHxmu4kw=;
        b=GkYXz7zot5jiu2GLD2Kf1Rp/Vk/n/SZoVYLUmJI3sP4ZBe3RQJExJRQD0acA5bvRoW
         EoU4bj0G+uFfmmyUZwbQpBzTqByIk3WrFx63bOXhTT7YjaaN3oHuz6YoW6Kr5Yk66nHY
         Ng0wFei6m0qfUtmhWUo1YM7fWI6BLnYhCoLG2h64YFyRppvkxLYinMdRj3JLkWT38jNf
         G37yO44BFnq3t9R8NUwPoZnQwNeY+irxSpVQnoxCsViIjXtfuq7sk7Q2GL1Ysr1guKs4
         xB2JNInaq2sWiKOkDLrM0uVV9aXRhLWAhpVmkyJOIpSQtvVeo8jHw/8V75X9T6ID0U6S
         nseg==
X-Gm-Message-State: APjAAAWIVR8iWmRcaAvToM55bt37Bd9+zSvxso9r4qLve18sPXiAVwfC
        1WRtZ4EPS2s9TM96EYZZBeh/+g==
X-Google-Smtp-Source: APXvYqwSk0ClLs5QE95Yng0bfnc0xk3cmNRfhO/Kti50JSvqlUhiuqQzMZzBRV0sSlx5psnef6ybfA==
X-Received: by 2002:a9d:6a58:: with SMTP id h24mr19495451otn.190.1557847972267;
        Tue, 14 May 2019 08:32:52 -0700 (PDT)
Received: from [172.25.180.192] ([129.7.0.180])
        by smtp.gmail.com with ESMTPSA id 33sm3732160otu.26.2019.05.14.08.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 08:32:51 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <3D6EA2A3-CC61-4243-982F-E53305EA0231@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_42FFEDA2-898F-48D6-B667-500473C11F3A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 2/2] ext2: introduce helper for xattr entry validation
Date:   Tue, 14 May 2019 09:32:55 -0600
In-Reply-To: <20190513224042.23377-2-cgxu519@zoho.com.cn>
Cc:     Jan Kara <jack@suse.com>, linux-ext4 <linux-ext4@vger.kernel.org>
To:     Chengguang Xu <cgxu519@zoho.com.cn>
References: <20190513224042.23377-1-cgxu519@zoho.com.cn>
 <20190513224042.23377-2-cgxu519@zoho.com.cn>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_42FFEDA2-898F-48D6-B667-500473C11F3A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 13, 2019, at 4:40 PM, Chengguang Xu <cgxu519@zoho.com.cn> wrote:
>=20
> Introduce helper function ext2_xattr_entry_valid()
> for xattr entry validation and clean up the entry
> check ralated code.
>=20
> Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> v1->v2:
> - Pass end offset instead of inode to ext2_xattr_entry_valid()
> - Change signed-off mail address.
>=20
> fs/ext2/xattr.c | 21 +++++++++++++++++----
> 1 file changed, 17 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index db27260d6a5b..d11c83529514 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -144,6 +144,20 @@ ext2_xattr_header_valid(struct ext2_xattr_header =
*header)
> 	return true;
> }
>=20
> +static bool
> +ext2_xattr_entry_valid(struct ext2_xattr_entry *entry, size_t size,
> +		       size_t end_offs)
> +{
> +	if (entry->e_value_block !=3D 0)
> +		return false;
> +
> +	if (size > end_offs ||
> +	    le16_to_cpu(entry->e_value_offs) + size > end_offs)
> +		return false;
> +
> +	return true;
> +}
> +
> /*
>  * ext2_xattr_get()
>  *
> @@ -217,8 +231,7 @@ ext2_xattr_get(struct inode *inode, int =
name_index, const char *name,
> 	if (entry->e_value_block !=3D 0)
> 		goto bad_block;
> 	size =3D le32_to_cpu(entry->e_value_size);
> -	if (size > inode->i_sb->s_blocksize ||
> -	    le16_to_cpu(entry->e_value_offs) + size > =
inode->i_sb->s_blocksize)
> +	if (!ext2_xattr_entry_valid(entry, size, =
inode->i_sb->s_blocksize))
> 		goto bad_block;
>=20
> 	if (ext2_xattr_cache_insert(ea_block_cache, bh))
> @@ -483,8 +496,8 @@ ext2_xattr_set(struct inode *inode, int =
name_index, const char *name,
> 		if (!here->e_value_block && here->e_value_size) {
> 			size_t size =3D le32_to_cpu(here->e_value_size);
>=20
> -			if (le16_to_cpu(here->e_value_offs) + size >
> -			    sb->s_blocksize || size > sb->s_blocksize)
> +			if (!ext2_xattr_entry_valid(here, size,
> +			    inode->i_sb->s_blocksize))
> 				goto bad_block;
> 			free +=3D EXT2_XATTR_SIZE(size);
> 		}
> --
> 2.17.2
>=20
>=20


Cheers, Andreas






--Apple-Mail=_42FFEDA2-898F-48D6-B667-500473C11F3A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlza36cACgkQcqXauRfM
H+BvAw/+MaRM0pu47phQ2+jOZFNGoAwIXHkAzbn/e6BSArL7g5FydnqQ6aCe4rUs
L7i35ZUQtCdNMOu6QCn/vMwbWfZeopqOoAc8M1vBieSKy6FD+pD9nkW7khN/JpzM
C4dqgGjUUJtKrBG3bmmjA2HlshL5LS6unAJ2B086i1TLazEx1VOXyAvwEVX8S8Fk
sCY+Vq0MbNy51/DaZ6V3WNL46tIGgfw8Z1rsOQAsAAtF0awPnsyiHqM3YXgVJcMz
fc5bMofBR69leKN75OA63N0a+08UQcUrtuRMnBtclIB3pdIV2LYEi1S5Mp47semc
apunvIvFDU4MW/90JgL2CGkFEHk43dzweYtbl/sXcKCxXtgmE9TlzweC1G34Wpnh
fGRZ7eaPsCGPIoQWsDRW/Ffz/eLcZwk7HnQc381CW5U+zdlH1OrET5KCKbZGNFSk
YHoPf1OAz/DtrdE4W4rQozXt2CoHucJI+vNNBPskJAjmFYyoogIlWLpQoO0Ak0TF
zg57gcy3mMwVoz+4ABLDzc6auiwmiCOcMx0eWNqsy/ZC4dlT6fYsxBOEMcPttnDR
wSRZbzQk802UaLmWD1I6t8BkN+3ml7jJGzPbIxUWPRpJAAgbNPM8xhyVz8vSAICd
GsLTQYJ5lAz1KZrJXLoYVkrSsiaaaHp4obsBx7yvfWudhZjxZ0c=
=IcEo
-----END PGP SIGNATURE-----

--Apple-Mail=_42FFEDA2-898F-48D6-B667-500473C11F3A--
