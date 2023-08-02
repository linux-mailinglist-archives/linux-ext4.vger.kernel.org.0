Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A2176C523
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Aug 2023 08:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjHBGHM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Aug 2023 02:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjHBGHL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Aug 2023 02:07:11 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF5A1996
        for <linux-ext4@vger.kernel.org>; Tue,  1 Aug 2023 23:07:09 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686efb9ee0cso6232726b3a.3
        for <linux-ext4@vger.kernel.org>; Tue, 01 Aug 2023 23:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1690956429; x=1691561229;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=89yQo6JvhtkY+bxBvF10uAWWy7qU/ZemUlqRNtERQBU=;
        b=atPdeHatzfegDqTLuTNLAe2U/ht7BeGUbDRdU9BtQ1s0XKN7LGlnsHpQZ8JI+FxSll
         o202Wd5iR6QKo2YIimR5P108FnQQ0vCd86t4pYA6c4J7Ziwf7KQ7otdmsFbvIb+EMUls
         +I/BP0L3xBALA2oQ/ENYYYtH1o5LeC87jsTYuUuRoXMrvqdeT4PXz7R7t8aj+aDNv2eQ
         83I9tjx4B5eVSLWhb7F07mN0lXSgzlXDAp7Fy66St9cZaj53tADeO6dh2TB1sDlmCHyz
         WOBqKmtX6Rpl6mxPDwfi9YG8Y7CSd+aeA0hD/mPTYmW7RR8170nmybcUUFpBOYy0tOhm
         VcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690956429; x=1691561229;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89yQo6JvhtkY+bxBvF10uAWWy7qU/ZemUlqRNtERQBU=;
        b=NIFdjZIGTNqHF4bzxnvTGaeJgqgCdmG1rSEfYKxe+9nX5a8G+PBz3vGO+n7htR3yKl
         BXV4MwDdmgMzAiGujdXVG6mH6xIfGjXGYuTmgHsaW44J06kG+QVLdGZpxGxUlo6Biybi
         LRdtVVJUYD85XIJ6NKKL9xnqVEV0H0QKD9f8Nl0z6RUwpigQ4/wCM2xYj+0pW0psORcZ
         7GoqwgzDVrIQMOV3YyZhbGYMvnykaVPW/F3cGnjq7TbZ8PQ6aeUc3TlPXVfzcpxUYknb
         HEqZZF9+/QFljLiMc1PVztj4y14bjyUyUiPh7D2wpDg2SEQWaDfUpatkRamnskxAhSLB
         9xPQ==
X-Gm-Message-State: ABy/qLZiNbJxe6sD2NcjxjM1twEkBA8Mz6B0wk4zGhAAZrSuwbffTlWW
        gizVCAMXB1FGX1cAyC8K+vrevA==
X-Google-Smtp-Source: APBJJlGG9x3W4mFz1tos4duhMoTyOU5FVdw8Cyr/P86SR8qPD+6wl24zypzl+iJSTt58PvrYcVRq6w==
X-Received: by 2002:a05:6a00:2316:b0:687:535f:6712 with SMTP id h22-20020a056a00231600b00687535f6712mr4525816pfh.14.1690956428586;
        Tue, 01 Aug 2023 23:07:08 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id k5-20020aa78205000000b00682a0184742sm10523132pfi.148.2023.08.01.23.07.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Aug 2023 23:07:07 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <A9ECDF14-95A1-4B1E-A815-4B6ABF4916C6@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_7DC4E546-4390-4370-AF1A-053B5A4A010E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] ext4: Fix rec_len verify error
Date:   Wed, 2 Aug 2023 00:07:04 -0600
In-Reply-To: <20230801151828.GB11332@frogsfrogsfrogs>
Cc:     zhangshida <starzhangzsd@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        Zhang Yi <yi.zhang@huawei.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zhangshida@kylinos.cn, stable@kernel.org
To:     "Darrick J. Wong" <djwong@kernel.org>
References: <20230801112337.1856215-1-zhangshida@kylinos.cn>
 <20230801151828.GB11332@frogsfrogsfrogs>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_7DC4E546-4390-4370-AF1A-053B5A4A010E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 1, 2023, at 9:18 AM, Darrick J. Wong <djwong@kernel.org> wrote:
>=20
> On Tue, Aug 01, 2023 at 07:23:37PM +0800, zhangshida wrote:
>> From: Shida Zhang <zhangshida@kylinos.cn>
>>=20
>> With the configuration PAGE_SIZE 64k and filesystem blocksize 64k,
>> a problem occurred when more than 13 million files were directly =
created
>> under a directory:
>>=20
>> EXT4-fs error (device xx): ext4_dx_csum_set:492: inode #xxxx: comm =
xxxxx: dir seems corrupt?  Run e2fsck -D.
>> EXT4-fs error (device xx): ext4_dx_csum_verify:463: inode #xxxx: comm =
xxxxx: dir seems corrupt?  Run e2fsck -D.
>> EXT4-fs error (device xx): dx_probe:856: inode #xxxx: block 8188: =
comm xxxxx: Directory index failed checksum
>>=20
>> When enough files are created, the fake_dirent->reclen will be =
0xffff.
>> it doesn't equal to the blocksize 65536, i.e. 0x10000.
>>=20
>> But it is not the same condition when blocksize equals to 4k.
>> when enough files are created, the fake_dirent->reclen will be =
0x1000.
>> it equals to the blocksize 4k, i.e. 0x1000.
>>=20
>> The problem seems to be related to the limitation of the 16-bit field
>> when the blocksize is set to 64k.
>> To address this, helpers like ext4_rec_len_{from,to}_disk has already
>> been introduce to complete the conversion between the encoded and the
>> plain form of rec_len.
>>=20
>> So fix this one by using the helper, and all the other
>> le16_to_cpu(ext4_dir_entry{,_2}.rec_len) accesses in this file too.
>>=20
>> Cc: stable@kernel.org
>> Fixes: dbe89444042a ("ext4: Calculate and verify checksums for htree =
nodes")
>> Suggested-by: Andreas Dilger <adilger@dilger.ca>
>> Suggested-by: Darrick J. Wong <djwong@kernel.org>
>> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
>> ---
>> v1->v2:
>> Use the existing helper to covert the rec_len, as suggested by =
Andreas.
>> v2->v3:
>> 1,Covert all the other rec_len if necessary, as suggested by Darrick.
>> 2,Rephrase the commit message.
>>=20
>> fs/ext4/namei.c | 16 ++++++++--------
>> 1 file changed, 8 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
>> index 0caf6c730ce3..8cb377b8ad86 100644
>> --- a/fs/ext4/namei.c
>> +++ b/fs/ext4/namei.c
>> @@ -346,14 +346,14 @@ static struct ext4_dir_entry_tail =
*get_dirent_tail(struct inode *inode,
>>=20
>> #ifdef PARANOID
>> 	struct ext4_dir_entry *d, *top;
>> +	int blocksize =3D EXT4_BLOCK_SIZE(inode->i_sb);
>>=20
>> 	d =3D (struct ext4_dir_entry *)bh->b_data;
>> 	top =3D (struct ext4_dir_entry *)(bh->b_data +
>> -		(EXT4_BLOCK_SIZE(inode->i_sb) -
>> -		 sizeof(struct ext4_dir_entry_tail)));
>> -	while (d < top && d->rec_len)
>> +		(blocksize - sizeof(struct ext4_dir_entry_tail)));
>> +	while (d < top && ext4_rec_len_from_disk(d->rec_len, blocksize))
>> 		d =3D (struct ext4_dir_entry *)(((void *)d) +
>> -		    le16_to_cpu(d->rec_len));
>> +		    ext4_rec_len_from_disk(d->rec_len, blocksize));
>>=20
>> 	if (d !=3D top)
>> 		return NULL;
>=20
> This is sitll missing some pieces; what about this clause at line 367:
>=20
> 	if (t->det_reserved_zero1 ||
> 	    le16_to_cpu(t->det_rec_len) !=3D sizeof(struct =
ext4_dir_entry_tail) ||
> 	    t->det_reserved_zero2 ||
> 	    t->det_reserved_ft !=3D EXT4_FT_DIR_CSUM)
> 		return NULL;
>=20
>> @@ -445,13 +445,13 @@ static struct dx_countlimit =
*get_dx_countlimit(struct inode *inode,
>> 	struct ext4_dir_entry *dp;
>> 	struct dx_root_info *root;
>> 	int count_offset;
>> +	int blocksize =3D EXT4_BLOCK_SIZE(inode->i_sb);
>>=20
>> -	if (le16_to_cpu(dirent->rec_len) =3D=3D =
EXT4_BLOCK_SIZE(inode->i_sb))
>> +	if (ext4_rec_len_from_disk(dirent->rec_len, blocksize) =3D=3D =
blocksize)
>> 		count_offset =3D 8;
>> -	else if (le16_to_cpu(dirent->rec_len) =3D=3D 12) {
>> +	else if (ext4_rec_len_from_disk(dirent->rec_len, blocksize) =3D=3D=
 12) {
>=20
> Why not lift this ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ to =
a
> local variable?  @dirent doesn't change, right?
>=20
>> 		dp =3D (struct ext4_dir_entry *)(((void *)dirent) + 12);
>> -		if (le16_to_cpu(dp->rec_len) !=3D
>> -		    EXT4_BLOCK_SIZE(inode->i_sb) - 12)
>> +		if (ext4_rec_len_from_disk(dp->rec_len, blocksize) !=3D =
blocksize - 12)
>> 			return NULL;
>> 		root =3D (struct dx_root_info *)(((void *)dp + 12));
>> 		if (root->reserved_zero ||
>=20
> What about dx_make_map?
>=20
> Here's all the opencoded access I could find:
>=20
> $ git grep le16.*rec_len fs/ext4/
> fs/ext4/namei.c:356:                le16_to_cpu(d->rec_len));
> fs/ext4/namei.c:367:        le16_to_cpu(t->det_rec_len) !=3D =
sizeof(struct ext4_dir_entry_tail) ||
> fs/ext4/namei.c:449:    if (le16_to_cpu(dirent->rec_len) =3D=3D =
EXT4_BLOCK_SIZE(inode->i_sb))
> fs/ext4/namei.c:451:    else if (le16_to_cpu(dirent->rec_len) =3D=3D =
12) {
> fs/ext4/namei.c:453:            if (le16_to_cpu(dp->rec_len) !=3D
> fs/ext4/namei.c:1338:                   map_tail->size =3D =
le16_to_cpu(de->rec_len);

Not all of these cases are actual bugs.  The ext4_rec_len_from_disk()
function is only different for rec_len >=3D 2^16, so if it is comparing
rec_len against "12" or "sizeof(struct ...)" then the inequality will
be correct regardless of how it is decoded.

That said, it makes sense to use ext4_rec_len_from_disk() to access
rec_len consistently throughout the code, since that avoids potential
bugs in the future.  We know the code will eventually will be copied
some place where rec_len >=3D 2^16 is actually important, and we may as
well avoid that bug before it happens.


One thing this discussion *does* expose is that ext4_rec_len_from_disk()
is hard-coded at compile time to differentiate between PAGE_SIZE > 64k
and PAGE_SIZE =3D 4K, because it was never possible to have blocksize >
PAGE_SIZE, so only ARM/PPC ever had filesystems with blocksize=3D64KiB
(and the Fujitsu Fugaku SPARC system with blocksize=3D256KiB).

However, with the recent advent of the VM and IO layers allowing
blocksize > PAGE_SIZE this function will need to be changed to allow
the same on x86 PAGE_SIZE=3D4KiB systems.  Instead of checking

  #if PAGE_SIZE >=3D 65536

it should handle this based on the filesystem blocksize at runtime:

static inline
unsigned int ext4_rec_len_from_disk(__le16 dlen, unsigned blocksize)
{
        unsigned len =3D le16_to_cpu(dlen);

	if (blocksize < 65536)
		return len;

	if (len =3D=3D EXT4_MAX_REC_LEN || len =3D=3D 0)
		return blocksize;

	return (len & 65532) | ((len & 3) << 16);
}

Strictly speaking, ((len & 65532) | ((len & 3) << 16) should equal "len"
for any filesystem with blocksize < 65536, but IMHO it is more clear if
the code is written this way.

Similarly, the encoding needs to be changed to handle large records at
runtime for when we eventually allow ext4 with blocksize > PAGE_SIZE.

static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned =
blocksize)
{
	BUG_ON(len > blocksize);
	BUG_ON(blocksize > (1 << 18));
	BUG_ON(len & 3);

	if (len < 65536) /* always true for blocksize < 65536 */
		return cpu_to_le16(len);

	if (len =3D=3D blocksize) {
		if (blocksize =3D=3D 65536)
			return cpu_to_le16(EXT4_MAX_REC_LEN);

		return cpu_to_le16(0);
	}

	return cpu_to_le16((len & 65532) | ((len >> 16) & 3));
}


Cheers, Andreas






--Apple-Mail=_7DC4E546-4390-4370-AF1A-053B5A4A010E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmTJ8ogACgkQcqXauRfM
H+CaKA//ajPC+6psxaK1xYxWe6I3WkSIJFKZqJ9wrvxvSZ3IhySoEBBgoQHK4AgB
71TDe4ijq8S8BQ33BHpxTStuIjfoUKz1qbKRvnE5+YHb1oi9w/YwZMnS3II6DxU1
UJCRu4rgl3ZEJmgNDXE9z4Lan8ynUMc/a1wowHSGEoBFrD2D1qzjnpPPfZdldq/r
EV+iBOFNrAu/omzqW7SywaNU67hh8RsJDUBAoL6+JabWnRgRp81NPjccsJnTgGod
J4b2JQHvISv5f7yeKN6KFBs7lg0k2N8YnAoxamTku3pOSQwvhFHYq7A105ydhDg2
KxyeF3daNeFcfCsXFzaDpsoFOHXL0qRxUBLV333g+pd87j0QPTFc3Xzg41LCkggh
rSB6m6J2KMOTHA3Dc+RmaWk/hFPPjqHeuGyXgNO0w9EfuREFDtYBZaNqjChiwgQR
rWsjQRcjfZT5UjKEDTJntShTkQRa1PHyVBz0EhqEsUz7TP7Fd/tNauOcAu4q+9hO
qp/8buY9USPIgx/sou7d/YdLBzvrONYQNSf5lFb/3k7gWG6Qb5UjAV5zwv3Qf/uP
MoX9R0DU4NHbN8uXGkrMWBdAbxfnP5a4bdQ+2H+ps0OSSBMTSt1Ag6UPWV7QGTjv
oyLKQmgId2qtAa0OiTITkTBv1TgppKhZYoadYe171vxJaQ40OWk=
=HuQO
-----END PGP SIGNATURE-----

--Apple-Mail=_7DC4E546-4390-4370-AF1A-053B5A4A010E--
