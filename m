Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288C164D207
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Dec 2022 23:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiLNWAm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Dec 2022 17:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiLNWAl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Dec 2022 17:00:41 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C906810DF
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 14:00:38 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so718790pjp.1
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 14:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8FpNnOPc5sS3j7iqk2fBcYakjdmIg1vo7RmQml45Yvs=;
        b=ujZ4JgJ/MUjDYOqXKckEiwC6dGSbYWrtWcMqaGWBpomwg9PuAv2P8Yw7RW+jDmwtf2
         BQyjfXc6ju2spo25nFb7qDCm4Pf5K7D/YwcmSf0jzEdSArsorXgzmc0mllK5APD85kqd
         Q87y88grCbvvIUjZJ8oGhLxANNzXRJXnU7T2dx4NJ9cr4Jzq8831PIxs01RTHQEaB6xD
         IQ+iNVXf54dymZhsAkvvbGbmK38ZQxpCCryl1d44m2lH7zhkVrX3W+k8CkqB5X0LtZe9
         2TC2+TN9XOIYe7IFu6M8o5V4hmaNFYg3w1Sj8keD5iqf47yTNLyHee482QncU+40RmbR
         bcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FpNnOPc5sS3j7iqk2fBcYakjdmIg1vo7RmQml45Yvs=;
        b=BP17AdFuYxV3vj+wDve5+pxmN2RLV948ZyMMgQoreGwnmPPKAngxfPTVNJhN79kZnR
         8A5SfXO8fBktXEzKOl+ckZwIdbdfvrehNuhnNdL9iWd8fgyB1T+pBKU3+fhr/W6ipzOY
         o+uUB7cMZVnBTmcjN+psMWl+ClIqC1FxhYR2uC0dAs+N7WCTlEToihQTvOuOPojqCSDw
         lLTcwP6mUHzzwmfRreEy/Iz1nH0awK3/eulFUattymbn+L3TXbeidhhuPDfeRUQluJ+W
         umIjKXCsLqyWoIrZ0coMSeiUOoqL/2/MtSimoeprqJdgy9jXCmPkxlEMoGwwCX7AZone
         HdkQ==
X-Gm-Message-State: ANoB5pmkVJWkzbQiEgVdOqSK2Jl16sGMuySnVD0VnCvfeKWQ2KTkteSs
        L4ROzT0jUKh4vr91h+hQfKhTJJnMxoeMBV+l
X-Google-Smtp-Source: AA0mqf7khqA6Hh94X9toNjX2xMQlfDv8z4BziyJXHgGKMjhxPwg0X/3n1Vqr8beiqyCLc96l/kxQWA==
X-Received: by 2002:a17:902:eb84:b0:189:e6a5:6bf5 with SMTP id q4-20020a170902eb8400b00189e6a56bf5mr29392465plg.4.1671055238165;
        Wed, 14 Dec 2022 14:00:38 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b0017f9db0236asm2337773pln.82.2022.12.14.14.00.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Dec 2022 14:00:37 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <2FEE2257-0486-4C62-8482-731AA796AB2E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C3DF419D-EEF3-4EE1-B844-992BDF0D6B18";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: improve xattr consistency checking and error
 reporting
Date:   Wed, 14 Dec 2022 15:00:34 -0700
In-Reply-To: <20221214200818.870087-1-tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        yebin@huaweicloud.com
To:     Theodore Ts'o <tytso@mit.edu>
References: <20221214200818.870087-1-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_C3DF419D-EEF3-4EE1-B844-992BDF0D6B18
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 14, 2022, at 1:08 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> Refactor the in-inode and xattr block consistency checking, and report
> more fine-grained reports of the consistency problems.  Also add more
> consistency checks for ea_inode number.
>=20
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

A minor nit below, but no reason not to hold up the patch.

> static int
> -ext4_xattr_check_entries(struct ext4_xattr_entry *entry, void *end,
> -			 void *value_start)
> +check_xattrs(struct inode *inode, struct buffer_head *bh,
> +	     struct ext4_xattr_entry *entry, void *end, void =
*value_start,
> +	     const char *function, unsigned int line)
> {
> 	struct ext4_xattr_entry *e =3D entry;

"e" isn't a great variable name (though it predates the patch), maybe =
"last"
or "last_entry" is better since that is what it is used for later?

> +	int err =3D -EFSCORRUPTED;
> +	char *err_str;
> +
> +	if (bh) {
> +		if (BHDR(bh)->h_magic !=3D cpu_to_le32(EXT4_XATTR_MAGIC) =
||
> +		    BHDR(bh)->h_blocks !=3D cpu_to_le32(1)) {
> +			err_str =3D "invalid header";
> +			goto errout;
> +		}
> +		if (buffer_verified(bh))
> +			return 0;
> +		if (!ext4_xattr_block_csum_verify(inode, bh)) {
> +			err =3D -EFSBADCRC;
> +			err_str =3D "invalid checksum";
> +			goto errout;
> +		}
> +	} else {
> +		struct ext4_xattr_ibody_header *header =3D value_start;
> +
> +		header -=3D 1;
> +		if (end - (void *)header < sizeof(*header) + =
sizeof(u32)) {
> +			err_str =3D "in-inode xattr block too small";
> +			goto errout;
> +		}
> +		if (header->h_magic !=3D cpu_to_le32(EXT4_XATTR_MAGIC)) =
{
> +			err_str =3D "bad magic number in in-inode =
xattr";
> +			goto errout;
> +		}
> +	}
>=20
> 	/* Find the end of the names list */
> 	while (!IS_LAST_ENTRY(e)) {
> 		struct ext4_xattr_entry *next =3D EXT4_XATTR_NEXT(e);
> -		if ((void *)next >=3D end)
> -			return -EFSCORRUPTED;
> -		if (strnlen(e->e_name, e->e_name_len) !=3D =
e->e_name_len)
> -			return -EFSCORRUPTED;
> +		if ((void *)next >=3D end) {
> +			err_str =3D "e_name out of bounds";
> +			goto errout;
> +		}
> +		if (strnlen(e->e_name, e->e_name_len) !=3D =
e->e_name_len) {
> +			err_str =3D "bad e_name length";
> +			goto errout;
> +		}
> 		e =3D next;
> 	}
>=20
> 	/* Check the values */
> 	while (!IS_LAST_ENTRY(entry)) {
> 		u32 size =3D le32_to_cpu(entry->e_value_size);
> +		unsigned long ea_ino =3D =
le32_to_cpu(entry->e_value_inum);
>=20
> -		if (size > EXT4_XATTR_SIZE_MAX)
> -			return -EFSCORRUPTED;
> +		if (!ext4_has_feature_ea_inode(inode->i_sb) && ea_ino) {
> +			err_str =3D "ea_inode specified without ea_inode =
feature enabled";
> +			goto errout;
> +		}
> +		if (ea_ino && ((ea_ino =3D=3D EXT4_ROOT_INO) ||
> +			       !ext4_valid_inum(inode->i_sb, ea_ino))) {
> +			err_str =3D "invalid ea_ino";
> +			goto errout;
> +		}
> +		if (size > EXT4_XATTR_SIZE_MAX) {
> +			err_str =3D "e_value size too large";
> +			goto errout;
> +		}
>=20
> 		if (size !=3D 0 && entry->e_value_inum =3D=3D 0) {
> 			u16 offs =3D le16_to_cpu(entry->e_value_offs);
> @@ -214,66 +260,54 @@ ext4_xattr_check_entries(struct ext4_xattr_entry =
*entry, void *end,
> 			 * the padded and unpadded sizes, since the size =
may
> 			 * overflow to 0 when adding padding.
> 			 */
> -			if (offs > end - value_start)
> -				return -EFSCORRUPTED;
> +			if (offs > end - value_start) {
> +				err_str =3D "e_value out of bounds";
> +				goto errout;
> +			}
> 			value =3D value_start + offs;
> 			if (value < (void *)e + sizeof(u32) ||
> 			    size > end - value ||
> -			    EXT4_XATTR_SIZE(size) > end - value)
> -				return -EFSCORRUPTED;
> +			    EXT4_XATTR_SIZE(size) > end - value) {
> +				err_str =3D "overlapping e_value ";
> +				goto errout;
> +			}
> 		}
> 		entry =3D EXT4_XATTR_NEXT(entry);
> 	}
> -
> +	if (bh)
> +		set_buffer_verified(bh);
> 	return 0;
> +
> +errout:
> +	if (bh)
> +		__ext4_error_inode(inode, function, line, 0, -err,
> +				   "corrupted xattr block %llu: %s",
> +				   (unsigned long long) bh->b_blocknr,
> +				   err_str);
> +	else
> +		__ext4_error_inode(inode, function, line, 0, -err,
> +				   "corrupted in-inode xattr: %s", =
err_str);
> +	return err;
> }
>=20
> static inline int
> __ext4_xattr_check_block(struct inode *inode, struct buffer_head *bh,
> 			 const char *function, unsigned int line)
> {
> -	int error =3D -EFSCORRUPTED;
> -
> -	if (BHDR(bh)->h_magic !=3D cpu_to_le32(EXT4_XATTR_MAGIC) ||
> -	    BHDR(bh)->h_blocks !=3D cpu_to_le32(1))
> -		goto errout;
> -	if (buffer_verified(bh))
> -		return 0;
> -
> -	error =3D -EFSBADCRC;
> -	if (!ext4_xattr_block_csum_verify(inode, bh))
> -		goto errout;
> -	error =3D ext4_xattr_check_entries(BFIRST(bh), bh->b_data + =
bh->b_size,
> -					 bh->b_data);
> -errout:
> -	if (error)
> -		__ext4_error_inode(inode, function, line, 0, -error,
> -				   "corrupted xattr block %llu",
> -				   (unsigned long long) bh->b_blocknr);
> -	else
> -		set_buffer_verified(bh);
> -	return error;
> +	return check_xattrs(inode, bh, BFIRST(bh), bh->b_data + =
bh->b_size,
> +			    bh->b_data, function, line);
> }
>=20
> #define ext4_xattr_check_block(inode, bh) \
> 	__ext4_xattr_check_block((inode), (bh),  __func__, __LINE__)
>=20
>=20
> -static int
> +static inline int
> __xattr_check_inode(struct inode *inode, struct =
ext4_xattr_ibody_header *header,
> 			 void *end, const char *function, unsigned int =
line)
> {
> -	int error =3D -EFSCORRUPTED;
> -
> -	if (end - (void *)header < sizeof(*header) + sizeof(u32) ||
> -	    (header->h_magic !=3D cpu_to_le32(EXT4_XATTR_MAGIC)))
> -		goto errout;
> -	error =3D ext4_xattr_check_entries(IFIRST(header), end, =
IFIRST(header));
> -errout:
> -	if (error)
> -		__ext4_error_inode(inode, function, line, 0, -error,
> -				   "corrupted in-inode xattr");
> -	return error;
> +	return check_xattrs(inode, NULL, IFIRST(header), end, =
IFIRST(header),
> +			    function, line);
> }
>=20
> #define xattr_check_inode(inode, header, end) \
> --
> 2.31.0
>=20


Cheers, Andreas






--Apple-Mail=_C3DF419D-EEF3-4EE1-B844-992BDF0D6B18
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmOaR4IACgkQcqXauRfM
H+AarQ/+LMhkNlIpR7HMTo8eKEJJ9C7wxVhJ0UL2HdPivrXUg0DDfu177HL57P89
6tCd8AcTWRnvHp9Qpq0+r0aSbQvXYH+ATMi919fYW6wdIXDRIF4G7Jv3AKP4RAzP
4pSq5nvipa6rrW9JuJLpdDX39wKZaAYTCtwf9442RilaO9rEx/IdypLkIkXyRPuC
qHiHRtfFEBDFUDFCGdLgS+sIFzOpcAvoBkbodzo8H8y1cksqIY1DaYHz2kf5sTOA
RNxfyMJKIgj8AnpDcNSl9lb9CloFux4DuqqYEGOOGC+RQ5BDg8+G0bfCICzp43jX
rM5kXL/UvZCoB0bc4L4KGH+/RQMOEO3zVeEZhlmP597av4Bv+8PAl4zSw69XFQwO
i8kcsCke242MDA72KGy5RSJsAkKA0/dSYoMfxkJ6n07B4tqOxk6Goylw4Me+HPH0
QndrCAOY0tfAznejHCbg2kpJmwuOjWgP/L1DcNc2KmvW/+nTE7dXtt+P3boDlbsE
nkWuTq2AFOn8zMvYnteJK/xp2j7jRiUt4EfBN2EAlq5Khj8sQeAP1puzB2OAOiW7
gfGhp2RcDAhKfxiefpCeWBgeMzQwfE9IFo+yo8AVnq4YXXCsSlcXPYNoEbyjns18
eBnZ3CvyJvUF10zRUHfVWJ4G7j5XGF2IXrZbSsm5zFSCmEFprY0=
=DsKs
-----END PGP SIGNATURE-----

--Apple-Mail=_C3DF419D-EEF3-4EE1-B844-992BDF0D6B18--
