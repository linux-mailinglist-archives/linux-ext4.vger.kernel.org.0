Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1231C49C8
	for <lists+linux-ext4@lfdr.de>; Tue,  5 May 2020 00:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgEDWw2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 May 2020 18:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726773AbgEDWw1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 May 2020 18:52:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A57C061A0E
        for <linux-ext4@vger.kernel.org>; Mon,  4 May 2020 15:52:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z6so374516plk.10
        for <linux-ext4@vger.kernel.org>; Mon, 04 May 2020 15:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=bi03AhfVI7mMElmuor/2J4B9GK1nAL+zpDv3NYKYj4Q=;
        b=J+xDVUiIwx7A2b6J348Et+XNFHpihFCpmP36ZRSY9IzyO0nLo0/mcBMsorRmL2JLUD
         l6I4Z0y+CuRSQbTeq596GKAbIek4kq4IGQ+s/wsC9afXcfecBoadRB0WZXtvZea/Xikx
         15rlhulGCjl35WnPQUqwPI/u3KBnMWBv5RVB84XZuQ85wKPbHvjSFRcxnVqjR+4LkKrR
         wfQB1QhiId/CTGigO5szloB8owllh/VS3Tc7JESgxdNrrQvqflwQoefx3Hn23Og2ZQL3
         uAaEXZP3QP4+WS0Zt1rIzNI44Zf4ywwa0zcup7TH9eMesaYBqPTHpFRmy7ZuaCCz9ZfY
         Zp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=bi03AhfVI7mMElmuor/2J4B9GK1nAL+zpDv3NYKYj4Q=;
        b=L8gJdriP8zEd7KjwdV21LW7DyVA03aLs8MguIoLjU6roI5xQqbh2/C5V9C/WPMoBtk
         S/x0QbxRqMiBX4NvgK+9Wx2cq6e5+g9xdvZgsY652FLnOLM7cl6GEYBXk8QjzdHcZdL8
         KHbAbp+Y53Sz753VU8LEttMM+c2qmXU8OQbCqApRm9M6KJrYaxwa4hUk2LVe1EERvoeU
         Z64wtCAhZ2BkaZOSZ3cTdIH0N9a7QqcdXT2ukHj6pdzYgy94kT1S55Z0DyOkw3CTrIg3
         QXydv4+M8tzytJbBMZzxm/9k0jFeW3tNtEJ+uu3tgE3tcilxNdptTqYHPtSFvZome76s
         3JHQ==
X-Gm-Message-State: AGi0PuZTf/ft4Bd6t37PG1uiAE0VwscJA+FW+XoSQ/b0k9Igm7Gi3gJC
        JBpeE2Vj5uaZKhNVYf8zBo6zUh+FDHlQ/vON
X-Google-Smtp-Source: APiQypL4hW2bzWD43Z07iX6f8YH5ODf7i+zLUMjl385s7rQz54Hzv6cVLYz9ou78hWWFZDnsujYSsg==
X-Received: by 2002:a17:90a:db53:: with SMTP id u19mr86645pjx.41.1588632746128;
        Mon, 04 May 2020 15:52:26 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id j26sm106358pgm.20.2020.05.04.15.52.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 15:52:25 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E3491268-9F7F-446D-91A9-18699B650FFA@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_983BB280-0628-48F2-BD35-2BFAD107480E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Inline data with 128-byte inodes?
Date:   Mon, 4 May 2020 16:52:23 -0600
In-Reply-To: <20200423004033.GA161058@localhost>
Cc:     Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Josh Triplett <josh@joshtriplett.org>
References: <20200414070207.GA170659@localhost>
 <20200422160045.GC20756@quack2.suse.cz>
 <331CEA49-83E0-462C-A70D-479F17A4FAB2@dilger.ca>
 <20200423004033.GA161058@localhost>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_983BB280-0628-48F2-BD35-2BFAD107480E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 22, 2020, at 6:40 PM, Josh Triplett <josh@joshtriplett.org> =
wrote:
>=20
> On Wed, Apr 22, 2020 at 02:15:28PM -0600, Andreas Dilger wrote:
>> On Apr 22, 2020, at 10:00 AM, Jan Kara <jack@suse.cz> wrote:
>>> On Tue 14-04-20 00:02:07, Josh Triplett wrote:
>>>> Is there a fundamental reason that ext4 *can't* or *shouldn't* =
support
>>>> inline data with 128-byte inodes?
>>>=20
>>> Well, where would we put it on disk? ext4 on-disk inode fills =
128-bytes
>>> with 'osd2' union...
>>=20
>> There are 60 bytes in the "i_block" field that can be used by =
inline_data.
>=20
> Exactly. But the Linux ext4 implementation doesn't accept inline data
> unless the system.data xattr exists, even if the file's data fits in =
60
> bytes (in which case system.data must exist and have 0 length).
>=20
>>> Or do you mean we should put inline data in an external xattr block?
>=20
> Definitely not, no. That seems much more complex to deal with.
>=20
> I'm only talking about the case of files or directories <=3D 60 bytes
> fitting in the inode with 128-byte inodes. Effectively, this would =
mean
> accepting inodes with the inline data flag set, whether they have the
> system.data xattr or not.
>=20
>> Maybe there is a bigger win for small directories avoiding 4KB leaf =
blocks?
>>=20
>> That said, I'd be happy to see some numbers to show this is a win, =
and
>> I'm definitely not _against_ allowing this to work if there is a use =
for it.
>=20
> Some statistics, for ext4 with 4k blocks and 128-byte inodes, if =
60-byte
> inline data worked with 128-byte inodes:
>=20
> A filesystem containing the source code of the Linux kernel would
> save about 1508 disk blocks, or around 6032k.
>=20
> A filesystem containing only my /etc directory would save about 650
> blocks, or 2600k, a substantial fraction of the entire directory =
(which
> takes up 9004k total without inline data).

Hi Josh,
I started looking into this, and got half-way through a patch before
getting pulled into something else.  If you are interested to finish
it off, I've included it here, but it definitely isn't ready yet.

Looking at the details, it isn't just an issue of changing a single
threshold to decide whether 128-byte inodes can handle inline data
or not.  The code is intermingled between "have system.data xattr"
as the defining factor and using "inline_off" (which points to the
byte offset of the system.data contents) to determine whether there
is inline data or not.

It _should_ be possible to change to using EXT4_STATE_MAY_INLINE_DATA
and EXT4_INLINE_DATA_FL to determine if there is any inline data in
the inode, and use "inline_off" and i_extra_isize only to detect if
any data is in the xattr or not.  It doesn't need to check the xattrs
if the inode size is EXT4_GOOD_OLD_INODE_SIZE, since we *don't* want
"inline" data in an external xattr block for sanity/efficiency reasons.

Hopefully this patch is useful for you as a starting point - I suspect
it is about 80% finished, but I wouldn't have time to work on it for a
few weeks at least, since 128-byte inodes is not a useful case for me =
(we
are using 1024-byte inodes on our metadata filesystems these days).  On
the flip side, I think inline_data is very interesting, and am happy for
it to gain more widespread usage.  I don't think the 128-byte inode =
support
for inline_data increases complexity, so I wouldn't be against landing =
it.

Cheers, Andreas
--

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 61b37a0..ec6f51a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3260,8 +3260,7 @@ extern int ext4_inline_data_fiemap(struct inode =
*inode,

 static inline int ext4_has_inline_data(struct inode *inode)
 {
-	return ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA) &&
-	       EXT4_I(inode)->i_inline_off;
+	return ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA);
 }

 /* namei.c */
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index fad82d0..ea9596a 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -20,7 +20,7 @@

 static int ext4_get_inline_size(struct inode *inode)
 {
-	if (EXT4_I(inode)->i_inline_off)
+	if (ext4_get_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
 		return EXT4_I(inode)->i_inline_size;

 	return 0;
@@ -94,7 +94,7 @@ int ext4_get_max_inline_size(struct inode *inode)
 	struct ext4_iloc iloc;

 	if (EXT4_I(inode)->i_extra_isize =3D=3D 0)
-		return 0;
+		return EXT4_MIN_INLINE_DATA_SIZE;

 	error =3D ext4_get_inode_loc(inode, &iloc);
 	if (error) {
@@ -133,6 +133,11 @@ int ext4_find_inline_data_nolock(struct inode =
*inode)
 	};
 	int error;

+	if (!ext4_has_feature_inline_data(inode))
+		return 0;
+
+	ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
+	EXT4_I(inode)->i_inline_size =3D EXT4_MIN_INLINE_DATA_SIZE;
 	if (EXT4_I(inode)->i_extra_isize =3D=3D 0)
 		return 0;

@@ -153,9 +158,8 @@ int ext4_find_inline_data_nolock(struct inode =
*inode)
 		}
 		EXT4_I(inode)->i_inline_off =3D (u16)((void *)is.s.here =
-
 					(void =
*)ext4_raw_inode(&is.iloc));
-		EXT4_I(inode)->i_inline_size =3D =
EXT4_MIN_INLINE_DATA_SIZE +
+		EXT4_I(inode)->i_inline_size +=3D
 				le32_to_cpu(is.s.here->e_value_size);
-		ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 	}
 out:
 	brelse(is.iloc.bh);
@@ -188,6 +192,7 @@ static int ext4_read_inline_data(struct inode =
*inode, void *buffer,
 	if (!len)
 		goto out;

+	BUG_ON(EXT4_I(inode)->i_extra_isize =3D=3D 0);
 	header =3D IHDR(inode, raw_inode);
 	entry =3D (struct ext4_xattr_entry *)((void *)raw_inode +
 					    =
EXT4_I(inode)->i_inline_off);
@@ -219,7 +224,7 @@ static void ext4_write_inline_data(struct inode =
*inode, struct ext4_iloc *iloc,
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return;

-	BUG_ON(!EXT4_I(inode)->i_inline_off);
+	BUG_ON(!ext4_get_inode_state(inode, =
EXT4_STATE_MAY_INLINE_DATA));
 	BUG_ON(pos + len > EXT4_I(inode)->i_inline_size);

 	raw_inode =3D ext4_raw_inode(iloc);
@@ -238,6 +243,7 @@ static void ext4_write_inline_data(struct inode =
*inode, struct ext4_iloc *iloc,
 	if (!len)
 		return;

+	BUG_ON(EXT4_I(inode)->i_extra_isize =3D=3D 0);
 	pos -=3D EXT4_MIN_INLINE_DATA_SIZE;
 	header =3D IHDR(inode, raw_inode);
 	entry =3D (struct ext4_xattr_entry *)((void *)raw_inode +
@@ -269,6 +275,17 @@ static int ext4_create_inline_data(handle_t =
*handle,
 	if (error)
 		goto out;

+	EXT4_I(inode)->i_inline_size =3D EXT4_MIN_INLINE_DATA_SIZE;
+	memset((void *)ext4_raw_inode(&is.iloc)->i_block,
+		0, EXT4_MIN_INLINE_DATA_SIZE);
+	ext4_clear_inode_flag(inode, EXT4_INODE_EXTENTS);
+	ext4_set_inode_flag(inode, EXT4_INODE_INLINE_DATA);
+
+	if (EXT4_I(inode)->i_extra_isize =3D=3D 0) {
+		BUG_ON(len > EXT4_MIN_INLINE_DATA_SIZE);
+		goto out_dirty;
+	}
+
 	if (len > EXT4_MIN_INLINE_DATA_SIZE) {
 		value =3D EXT4_ZERO_XATTR_VALUE;
 		len -=3D EXT4_MIN_INLINE_DATA_SIZE;
@@ -295,14 +312,11 @@ static int ext4_create_inline_data(handle_t =
*handle,
 		goto out;
 	}

-	memset((void *)ext4_raw_inode(&is.iloc)->i_block,
-		0, EXT4_MIN_INLINE_DATA_SIZE);
-
 	EXT4_I(inode)->i_inline_off =3D (u16)((void *)is.s.here -
 				      (void *)ext4_raw_inode(&is.iloc));
-	EXT4_I(inode)->i_inline_size =3D len + =
EXT4_MIN_INLINE_DATA_SIZE;
-	ext4_clear_inode_flag(inode, EXT4_INODE_EXTENTS);
-	ext4_set_inode_flag(inode, EXT4_INODE_INLINE_DATA);
+	EXT4_I(inode)->i_inline_size +=3D len;
+
+out_dirty:
 	get_bh(is.iloc.bh);
 	error =3D ext4_mark_iloc_dirty(handle, inode, &is.iloc);

@@ -804,6 +818,7 @@ static int =
ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 						 void **fsdata)
 {
 	int ret =3D 0, inline_size;
+	bool truncate =3D false;
 	struct page *page;

 	page =3D grab_cache_page_write_begin(mapping, 0, flags);
@@ -811,10 +826,8 @@ static int =
ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 		return -ENOMEM;

 	down_read(&EXT4_I(inode)->xattr_sem);
-	if (!ext4_has_inline_data(inode)) {
-		ext4_clear_inode_state(inode, =
EXT4_STATE_MAY_INLINE_DATA);
-		goto out;
-	}
+	if (!ext4_has_inline_data(inode))
+		goto out_clear;

 	inline_size =3D ext4_get_inline_size(inode);

@@ -827,23 +840,25 @@ static int =
ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 	ret =3D __block_write_begin(page, 0, inline_size,
 				  ext4_da_get_block_prep);
 	if (ret) {
-		up_read(&EXT4_I(inode)->xattr_sem);
-		unlock_page(page);
-		put_page(page);
-		ext4_truncate_failed_write(inode);
-		return ret;
+		truncate =3D true;
+		goto out;
 	}

 	SetPageDirty(page);
 	SetPageUptodate(page);
-	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 	*fsdata =3D (void *)CONVERT_INLINE_DATA;

+out_clear:
+	ext4_clear_inode_flag(inode, EXT4_INODE_INLINE_DATA);
+	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 out:
 	up_read(&EXT4_I(inode)->xattr_sem);
 	if (page) {
+		if (read)
 		unlock_page(page);
 		put_page(page);
+		if (truncate)
+			ext4_truncate_failed_write(inode);
 	}
 	return ret;
 }


--Apple-Mail=_983BB280-0628-48F2-BD35-2BFAD107480E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6wnKcACgkQcqXauRfM
H+Cmkw//flOfdxjgUGiDD/bexm10umOZFu1WnPBo/bWKreF78niqQKeZ8jbbPx5O
Seu3assiWYc75FHRXSISsA4hqcXOwLtlVfqGPGoDd/cLoOC3UxaCu1GT8Qnq7mfc
U9qMtHjMEZyr4VtfkMNL5yFkOEmrO8CB2JTwFxyv8rDe8CXziBTi/0I8Jf50Nbjl
+le6QM398tE7G2wmXM9RQINXJDjd3Kgw83ll2bM4+kh9a0lsHQo+0VigyqOhlu4l
sDbgM7dKC4j//sWGe83UbH93kiXxFy7paw7FZ1AF2fqRPKc7mNVh4eX/+A8Pd4rb
ONGPqRNuBZv/+oHspySGBGc7bpdklh/d50nJErnhBYSsNhmZSX1dE2KyGBrQ9KFR
pD4H/p4zexQvhPQ5mAJ9kZFdvybnXFVSbz/SmPHhl0A8AwGGulM+INzhuWYiQyEb
3zW9nRaFJUR5vp8M1Xo8cLe5gH2ZI3HPjt99eDrDGo24Ak/XhmD6hQ4ecITtWmSo
ywZt2g64vWy+20V9WM+e14LHC02T9srOf/+cZpeyqOfr4CoWBPwjJJirEDDd3eZy
7XnBbqTkIRp5cIdFtAQU0dYUNMwFSDXFXLB7qxXXcfTJ83lUYln+nQjMVR97mAek
eUg24V09iYlzoJNUuFE03U7Jm3V2xYBYMHyi/NwjDkgUlxS/oDM=
=/aRm
-----END PGP SIGNATURE-----

--Apple-Mail=_983BB280-0628-48F2-BD35-2BFAD107480E--
