Return-Path: <linux-ext4+bounces-1737-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09373887289
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Mar 2024 19:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF8C1F24369
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Mar 2024 18:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5326168E;
	Fri, 22 Mar 2024 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="F8MHSUun"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCAF61683
	for <linux-ext4@vger.kernel.org>; Fri, 22 Mar 2024 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130732; cv=none; b=XJZAsnFRpylyWEt4ukzECPxFFe9WF5vNhWf8k/VibHGryk6aUpfiaMyAYSVnARfc90KPaLHB7q9s2cuMmkulL5qqE8+UgDlnyyXfhDLNXNiLvc8G0h7wFD6iPwSxJuJkun8oSohopWcW2CG0XPgP5kg1uE05tgmd5rnL8dpjcCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130732; c=relaxed/simple;
	bh=iTvjlJgHljkJ2gRR59MXykSJ+yBhF5x1mieWbvu1FTI=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=qpSXy5eH+gS9d+Lcqo28xp3CdKmpB6wS/P2lzS9X5pDb+IN93W1wdZzAIL9akTWz4DDJsiqVlekVv8Oj4QjThuy3OJFwDafRnWUnBPJGwsaIGE82ugbQvTn4avpTX05Zbb4cTIxqdrq4iyIfCwW+ik8+9WIkNkpAJoEAcpxXgCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=F8MHSUun; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dee5ef2a7bso16489825ad.1
        for <linux-ext4@vger.kernel.org>; Fri, 22 Mar 2024 11:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1711130728; x=1711735528; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=spUPNWJpz9lLsY6HA8C3i9sdz0ECA3/+HZl89+sz6YY=;
        b=F8MHSUunPSvPDgRAYngndey7krUOiWt2cpALDeYbvmQKCYblpN4KDYlSbJKUYsei5m
         nS8r3DVvawWMNSsvghZIT8n1APNgcvbksGFW4U6ZF+9ZhwSUAPHfkt7MdHRhWN9Ipfs3
         NQVmfD2P0qtQgNanUQsQ2nrg4sMvQGaXT1hK/XIPzUdUyeP/8+V+PSmH8EA8AGSl6B0S
         cpr3FYyH55SkN/zi7u2I2hTMxJaGithM3a9hYmfWV/SrsLw1YyjxvAprXq3pRQHrC7H/
         zy1igIukDI/0FyauU8hTD233FyhVmm65iIAsn5v3RvWHQljUvNkFTgWrTjP46zVml4Gm
         mnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711130728; x=1711735528;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spUPNWJpz9lLsY6HA8C3i9sdz0ECA3/+HZl89+sz6YY=;
        b=LJXChgkACZsbXPVNbmYu5ThOfP3YCcQQf67qbsYaiIWF3aEGA8glFSC1eqSclEFOLx
         orYGPPGyfvkPoosgZp33ivJX3CClQIfn1+cY6jqTcPR1IMtlDUmjZZEiNZSwnf3mk7QU
         haTobYZUNiiVtO/jdRuF88zID+k3nG3hZnQlpDUlGWziDkuQJUR2/vCqRPoDm+vh2/6T
         TGvATSfzNhqHvSZmB3C1FgWPLbGC9n0FaKiVYojIPSGYsuy2z3llaoIlvvqSteZScEDc
         ApNyPE/5fUfVDEZdKb4C0FvCmS9q8fqACx+eEEHGBvOfdjposPsFuXtFJ6IRd0lIqO+i
         /NKA==
X-Forwarded-Encrypted: i=1; AJvYcCXw3riG6omEVgqnOO/5ls1NEMVBX3vyHl0PdWV9XPJ60YJ7lm8vazsuWOuRbHIRQSzUV7R5o90mrjqN4ZNH5EkKDoOjnL3dU7kMeQ==
X-Gm-Message-State: AOJu0YwH4QlMZj1jyIuF8hzSvdLadrVJl8hj14Z3ffFzCdLVb0484LSV
	9JMN6qyoDh1aGUqxpn6Y5rgJXSzQ7YnCCNhJyM2ade9l0/E7+r1z3ZCX+J6YqQM=
X-Google-Smtp-Source: AGHT+IG1QvcW7pHzN++Ntsot5xzd5Iab/lDVKGSmmOr6M4or8IViqbQkilofox1iCHYTYrkVLanzvw==
X-Received: by 2002:a17:902:c20d:b0:1dd:68cd:728b with SMTP id 13-20020a170902c20d00b001dd68cd728bmr524880pll.17.1711130728568;
        Fri, 22 Mar 2024 11:05:28 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id i1-20020a1709026ac100b001dd707d5fe3sm18677plt.43.2024.03.22.11.05.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2024 11:05:27 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <79FE751F-CFA8-4C46-B3D7-507C6A3BCFD3@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F9BC7F43-0FAF-417A-AC80-695B4130F840";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] ext4: Do not create EA inode under buffer lock
Date: Fri, 22 Mar 2024 12:06:16 -0600
In-Reply-To: <20240321162657.27420-2-jack@suse.cz>
Cc: Ted Tso <tytso@mit.edu>,
 linux-ext4@vger.kernel.org,
 syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com
To: Jan Kara <jack@suse.cz>
References: <20240209111418.22308-1-jack@suse.cz>
 <20240321162657.27420-2-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_F9BC7F43-0FAF-417A-AC80-695B4130F840
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 21, 2024, at 10:26 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> ext4_xattr_set_entry() creates new EA inodes while holding buffer lock
> on the external xattr block. This is problematic as it nests all the
> allocation locking (which acquires locks on other buffers) under the
> buffer lock. This can even deadlock when the filesystem is corrupted =
and
> e.g. quota file is setup to contain xattr block as data block. Move =
the
> allocation of EA inode out of ext4_xattr_set_entry() into the callers.

This looks like it will allocate a new inode for every setxattr called,
even if the xattr is small and will likely fit inside the inode itself?
This would seem to add a lot of extra overhead for the 99% of cases when
an external inode is not needed.

The ext4_xattr_inode_lookup_create() call is not just doing an inode
bitmap lookup/allocation, it is also looking up the xattr hash in a hash
table, allocating and initializing an ext4 and VFS inode, quota, writing
it to the journal and using up journal credits (which need to be =
allocated
larger), etc. so it is by no means lightweight vs. memcpy() into the =
inode
buffer for most small xattrs.

It would be better to only preallocate the inode in the case when the
xattr size is large (say value_len > blocksize/2 or > blocksize * 3/4)
when there is a decent chance it will be needed.  Otherwise, do not
preallocate the xattr inode before calling ext4_xattr_set_entry(), and
have it return -EAGAIN if there wasn't enough room in the inode or in
the external xattr block to hold the value, and the caller can jump back
to allocate the xattr inode and try again (once only), something like:


@@ -1929,9 +1901,21 @@ ext4_xattr_block_set(handle_t *handle, struct =
inode *inode,

+	/* If we need EA inode, prepare it before locking the buffer */
+	if (i->value && i->in_inode && i->value_len > =
i_blocksize(inode)/2) {
+alloc_inode:
+		ea_inode =3D ext4_xattr_inode_lookup_create(handle, =
inode,
+					i->value, i->value_len);
+		if (IS_ERR(ea_inode)) {
+			error =3D PTR_ERR(ea_inode);
+			ea_inode =3D NULL;
+			goto cleanup;
+		}
+	}
+
	if (s->base) {
		int offset =3D (char *)s->here - bs->bh->b_data;

@@ -1966,7 +1951,7 @@ ext4_xattr_block_set(handle_t *handle, struct =
inode *inode,
			}
			ea_bdebug(bs->bh, "modifying in-place");
			error =3D ext4_xattr_set_entry(i, s, handle, =
inode,
-						     true /* is_block =
*/);
+					     ea_inode, true /* is_block =
*/);
			ext4_xattr_block_csum_set(inode, bs->bh);
			unlock_buffer(bs->bh);
+			if (error =3D=3D -EAGAIN && !ea_inode)
+				goto alloc_inode;
			if (error =3D=3D -EFSCORRUPTED)

Cheers, Andreas

> Reported-by: syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> fs/ext4/xattr.c | 113 +++++++++++++++++++++++-------------------------
> 1 file changed, 53 insertions(+), 60 deletions(-)
>=20
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 146690c10c73..04f90df8dbae 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1619,6 +1619,7 @@ static struct inode =
*ext4_xattr_inode_lookup_create(handle_t *handle,
> static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
> 				struct ext4_xattr_search *s,
> 				handle_t *handle, struct inode *inode,
> +				struct inode *new_ea_inode,
> 				bool is_block)
> {
> 	struct ext4_xattr_entry *last, *next;
> @@ -1626,7 +1627,6 @@ static int ext4_xattr_set_entry(struct =
ext4_xattr_info *i,
> 	size_t min_offs =3D s->end - s->base, name_len =3D =
strlen(i->name);
> 	int in_inode =3D i->in_inode;
> 	struct inode *old_ea_inode =3D NULL;
> -	struct inode *new_ea_inode =3D NULL;
> 	size_t old_size, new_size;
> 	int ret;
>=20
> @@ -1711,38 +1711,11 @@ static int ext4_xattr_set_entry(struct =
ext4_xattr_info *i,
> 			old_ea_inode =3D NULL;
> 			goto out;
> 		}
> -	}
> -	if (i->value && in_inode) {
> -		WARN_ON_ONCE(!i->value_len);
> -
> -		new_ea_inode =3D ext4_xattr_inode_lookup_create(handle, =
inode,
> -					i->value, i->value_len);
> -		if (IS_ERR(new_ea_inode)) {
> -			ret =3D PTR_ERR(new_ea_inode);
> -			new_ea_inode =3D NULL;
> -			goto out;
> -		}
> -	}
>=20
> -	if (old_ea_inode) {
> 		/* We are ready to release ref count on the =
old_ea_inode. */
> 		ret =3D ext4_xattr_inode_dec_ref(handle, old_ea_inode);
> -		if (ret) {
> -			/* Release newly required ref count on =
new_ea_inode. */
> -			if (new_ea_inode) {
> -				int err;
> -
> -				err =3D ext4_xattr_inode_dec_ref(handle,
> -							       =
new_ea_inode);
> -				if (err)
> -					ext4_warning_inode(new_ea_inode,
> -						  "dec ref new_ea_inode =
err=3D%d",
> -						  err);
> -				ext4_xattr_inode_free_quota(inode, =
new_ea_inode,
> -							    =
i->value_len);
> -			}
> +		if (ret)
> 			goto out;
> -		}
>=20
> 		ext4_xattr_inode_free_quota(inode, old_ea_inode,
> 					    =
le32_to_cpu(here->e_value_size));
> @@ -1866,7 +1839,6 @@ static int ext4_xattr_set_entry(struct =
ext4_xattr_info *i,
> 	ret =3D 0;
> out:
> 	iput(old_ea_inode);
> -	iput(new_ea_inode);
> 	return ret;
> }
>=20
> @@ -1929,9 +1901,21 @@ ext4_xattr_block_set(handle_t *handle, struct =
inode *inode,
> 	size_t old_ea_inode_quota =3D 0;
> 	unsigned int ea_ino;
>=20
> -
> #define header(x) ((struct ext4_xattr_header *)(x))
>=20
> +	/* If we need EA inode, prepare it before locking the buffer */
> +	if (i->value && i->in_inode) {
> +		WARN_ON_ONCE(!i->value_len);
> +
> +		ea_inode =3D ext4_xattr_inode_lookup_create(handle, =
inode,
> +					i->value, i->value_len);
> +		if (IS_ERR(ea_inode)) {
> +			error =3D PTR_ERR(ea_inode);
> +			ea_inode =3D NULL;
> +			goto cleanup;
> +		}
> +	}
> +
> 	if (s->base) {
> 		int offset =3D (char *)s->here - bs->bh->b_data;
>=20
> @@ -1940,6 +1924,7 @@ ext4_xattr_block_set(handle_t *handle, struct =
inode *inode,
> 						      EXT4_JTR_NONE);
> 		if (error)
> 			goto cleanup;
> +
> 		lock_buffer(bs->bh);
>=20
> 		if (header(s->base)->h_refcount =3D=3D cpu_to_le32(1)) {
> @@ -1966,7 +1951,7 @@ ext4_xattr_block_set(handle_t *handle, struct =
inode *inode,
> 			}
> 			ea_bdebug(bs->bh, "modifying in-place");
> 			error =3D ext4_xattr_set_entry(i, s, handle, =
inode,
> -						     true /* is_block =
*/);
> +					     ea_inode, true /* is_block =
*/);
> 			ext4_xattr_block_csum_set(inode, bs->bh);
> 			unlock_buffer(bs->bh);
> 			if (error =3D=3D -EFSCORRUPTED)
> @@ -2034,29 +2019,13 @@ ext4_xattr_block_set(handle_t *handle, struct =
inode *inode,
> 		s->end =3D s->base + sb->s_blocksize;
> 	}
>=20
> -	error =3D ext4_xattr_set_entry(i, s, handle, inode, true /* =
is_block */);
> +	error =3D ext4_xattr_set_entry(i, s, handle, inode, ea_inode,
> +				     true /* is_block */);
> 	if (error =3D=3D -EFSCORRUPTED)
> 		goto bad_block;
> 	if (error)
> 		goto cleanup;
>=20
> -	if (i->value && s->here->e_value_inum) {
> -		/*
> -		 * A ref count on ea_inode has been taken as part of the =
call to
> -		 * ext4_xattr_set_entry() above. We would like to drop =
this
> -		 * extra ref but we have to wait until the xattr block =
is
> -		 * initialized and has its own ref count on the =
ea_inode.
> -		 */
> -		ea_ino =3D le32_to_cpu(s->here->e_value_inum);
> -		error =3D ext4_xattr_inode_iget(inode, ea_ino,
> -					      =
le32_to_cpu(s->here->e_hash),
> -					      &ea_inode);
> -		if (error) {
> -			ea_inode =3D NULL;
> -			goto cleanup;
> -		}
> -	}
> -
> inserted:
> 	if (!IS_LAST_ENTRY(s->first)) {
> 		new_bh =3D ext4_xattr_block_cache_find(inode, =
header(s->base),
> @@ -2209,17 +2178,16 @@ ext4_xattr_block_set(handle_t *handle, struct =
inode *inode,
>=20
> cleanup:
> 	if (ea_inode) {
> -		int error2;
> -
> -		error2 =3D ext4_xattr_inode_dec_ref(handle, ea_inode);
> -		if (error2)
> -			ext4_warning_inode(ea_inode, "dec ref error=3D%d",=

> -					   error2);
> +		if (error) {
> +			int error2;
>=20
> -		/* If there was an error, revert the quota charge. */
> -		if (error)
> +			error2 =3D ext4_xattr_inode_dec_ref(handle, =
ea_inode);
> +			if (error2)
> +				ext4_warning_inode(ea_inode, "dec ref =
error=3D%d",
> +						   error2);
> 			ext4_xattr_inode_free_quota(inode, ea_inode,
> 						    =
i_size_read(ea_inode));
> +		}
> 		iput(ea_inode);
> 	}
> 	if (ce)
> @@ -2277,14 +2245,38 @@ int ext4_xattr_ibody_set(handle_t *handle, =
struct inode *inode,
> {
> 	struct ext4_xattr_ibody_header *header;
> 	struct ext4_xattr_search *s =3D &is->s;
> +	struct inode *ea_inode =3D NULL;
> 	int error;
>=20
> 	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
> 		return -ENOSPC;
>=20
> -	error =3D ext4_xattr_set_entry(i, s, handle, inode, false /* =
is_block */);
> -	if (error)
> +	/* If we need EA inode, prepare it before locking the buffer */
> +	if (i->value && i->in_inode) {
> +		WARN_ON_ONCE(!i->value_len);
> +
> +		ea_inode =3D ext4_xattr_inode_lookup_create(handle, =
inode,
> +					i->value, i->value_len);
> +		if (IS_ERR(ea_inode))
> +			return PTR_ERR(ea_inode);
> +	}
> +	error =3D ext4_xattr_set_entry(i, s, handle, inode, ea_inode,
> +				     false /* is_block */);
> +	if (error) {
> +		if (ea_inode) {
> +			int error2;
> +
> +			error2 =3D ext4_xattr_inode_dec_ref(handle, =
ea_inode);
> +			if (error2)
> +				ext4_warning_inode(ea_inode, "dec ref =
error=3D%d",
> +						   error2);
> +
> +			ext4_xattr_inode_free_quota(inode, ea_inode,
> +						    =
i_size_read(ea_inode));
> +			iput(ea_inode);
> +		}
> 		return error;
> +	}
> 	header =3D IHDR(inode, ext4_raw_inode(&is->iloc));
> 	if (!IS_LAST_ENTRY(s->first)) {
> 		header->h_magic =3D cpu_to_le32(EXT4_XATTR_MAGIC);
> @@ -2293,6 +2285,7 @@ int ext4_xattr_ibody_set(handle_t *handle, =
struct inode *inode,
> 		header->h_magic =3D cpu_to_le32(0);
> 		ext4_clear_inode_state(inode, EXT4_STATE_XATTR);
> 	}
> +	iput(ea_inode);
> 	return 0;
> }
>=20
> --
> 2.35.3
>=20
>=20


Cheers, Andreas






--Apple-Mail=_F9BC7F43-0FAF-417A-AC80-695B4130F840
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmX9yJgACgkQcqXauRfM
H+B/jA//S9dwmMeK9uhWarwZUV413MRvFV8SNbB2B6f8+PGKsGinR3lcjsIzoYPB
+eKfaaRybJE+ctpgReemeW8QFyZga3y2ykHP9r6HvzC4QVbPdXW4l9xezyPkekiF
osQKuOsDm+vSWUh+SBtfUs4inO4hQ4YSwwMNfitW0A3Vg/sinTiDDKf5aXABcn+X
QwAs4TYHlEHYLbbZXRFvtaYu6OKGfq/UjLEBpLRVVe6mQnIXwlOknDS1Iv+mEPoT
GW2kzKsyGhyhRoVJuajUChhB/fPXyTfEzo0XM5ZwXOujG6CVfmhENkCVWwbDGyWy
+A9jYFw/IBwjya9HuG1r1/u46zTCA3S+YLDlW4vRUnuopuq02GkMe1MjernmjklP
blyPAm6llubx7eCRWC439wlvO+5+iuFpRfZKP4oGhTBxBZFop/9/OPDoTivJmgul
4ogWJHDW8OWQk8URXazubqiLC5LvEp1xtbRaW6X0sxii9AVIwI4fVtJt9A3c9P0R
FHKQAvm5B47+3w+v0U5WeR/riun2kUBvnGaOBv6W8l7ift2KQFE70WGuXMyrj1lH
WDNS+54EHoD7aV2dGDBB6aH1QZ/JbaPCg+ZqGSwUJrm/10MkICD844uHEhOVrPvl
PsmC+LRkG65BH4v2H2usC2Aq1cCQBhmw6RmLFUdPJSEcZuK7TuI=
=y3Gn
-----END PGP SIGNATURE-----

--Apple-Mail=_F9BC7F43-0FAF-417A-AC80-695B4130F840--

