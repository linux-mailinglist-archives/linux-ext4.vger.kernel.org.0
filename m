Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E51C1C49EF
	for <lists+linux-ext4@lfdr.de>; Tue,  5 May 2020 01:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgEDXAG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 May 2020 19:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728153AbgEDXAG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 May 2020 19:00:06 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAC2C061A0E
        for <linux-ext4@vger.kernel.org>; Mon,  4 May 2020 16:00:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id v63so6330523pfb.10
        for <linux-ext4@vger.kernel.org>; Mon, 04 May 2020 16:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=bt08R2vyRxjj23aO8o7g9yV6v7WszrAUCzY1p418un8=;
        b=yAIhKpOofDwJ9zISLTDAUH5tB6JnlV4ICc950AvAZnRB/E3W4mEraBJZNymEidslvY
         iPWZ1izRRbY085ywzovD80RYJBYtVOCY58P04S7n+iOCQLFspP2MzuFAXbU6EXY3HsPe
         RY2bXw0kWowQiyxO9WdKn+GCwP7llV/NvtRymXuz54FgTgKxZ26hqNBn8J608rvYw9ql
         O7IvZNWhcoB9QSX4JQVz3gNz+7sjZtRq/xzcPU96K/VUxBJefLGlX0eFS/cPiEyvmkSI
         rHjjMYHDa4Ayhy599JSJdekZleTwdE+C2KEEnjShgfYZ5kIciEQnL//8J5ufoijDDJVS
         +emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=bt08R2vyRxjj23aO8o7g9yV6v7WszrAUCzY1p418un8=;
        b=ZUSsiJ2R1CsBGB/R4w7vijIE2QX3b/Ng3A7fzzJX8+pEjWhgSF50Qrt3yBXY5FBHOO
         /Tu1safSYI9hlMEKZhFPMtaKZrgDnb2xart4b3wd34296vyq3rRsT2pyKECvei2QP4e4
         4G6p+qDRTibXH8Bmhwws2taiHXbPLUaFUS7T6kgfBqldZu/ENSrd2diHPUg8Xdf5zey+
         qrzY3n1ZRluHHFa4CDFsyh4IeSmOjppQb/3Fy6PHyUI14xbm7Q0ezB2zuGwpTAGhDLM2
         D7O2QibcRhcEPqDhN/O9I3yLsqTYd7TbSRuzXYgpM+hew2J3pCiKDhI+eDyretICuhz8
         SH7w==
X-Gm-Message-State: AGi0PuZk1AwR11seir10v7OOZj+Lc84CFpRNelj1MUado8r9J6yN7tdv
        2C7m6O+K/aaxvZav9nQto9GVOBfOkZzNeP24
X-Google-Smtp-Source: APiQypKjF9rB0wnFAko+BPO6QzX6HP5admcSBa5aGcZUadhFGK12H2skBiWMukOA4w1z3fcy4M9QeA==
X-Received: by 2002:a63:742:: with SMTP id 63mr481967pgh.33.1588633205582;
        Mon, 04 May 2020 16:00:05 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id d2sm149864pfc.7.2020.05.04.16.00.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 16:00:04 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <0FC238E1-59D7-448B-BD72-C2794A3BD99E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_276E3F35-881D-4FCA-A735-A8DEA28D9F23";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: /fs/ext4/ext4.h add a comment to ext4_dir_entry_2
Date:   Mon, 4 May 2020 17:00:03 -0600
In-Reply-To: <20200504223900.GA5691@magnolia>
Cc:     Jonny Grant <jg@jguk.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
References: <bf50e54f-2a0c-17a4-89c3-4afcc298daeb@jguk.org>
 <1B91A6E6-7F4A-4C58-93E7-394217C1631C@dilger.ca>
 <20200504223900.GA5691@magnolia>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_276E3F35-881D-4FCA-A735-A8DEA28D9F23
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On May 4, 2020, at 4:39 PM, Darrick J. Wong <darrick.wong@oracle.com> =
wrote:
>=20
> On Mon, May 04, 2020 at 04:26:35PM -0600, Andreas Dilger wrote:
>>=20
>>> On May 3, 2020, at 6:52 AM, Jonny Grant <jg@jguk.org> wrote:
>>>=20
>>> Hello
>>>=20
>>> Could a comment be added to clarify 'file_type' ?
>>>=20
>>> struct ext4_dir_entry_2 {
>>>   __le32    inode;            /* Inode number */
>>>   __le16    rec_len;        /* Directory entry length */
>>>   __u8    name_len;        /* Name length */
>>>   __u8    file_type;
>>>   char    name[EXT4_NAME_LEN];    /* File name */
>>> };
>>>=20
>>>=20
>>>=20
>>> This what I am proposing to add:
>>>=20
>>>   __u8    file_type;        /* See directory file type macros below =
*/
>>=20
>> For this kind of structure field, it makes sense to reference the =
macro
>> names directly, like:
>>=20
>> 	__u8	file_type;	/* See EXT4_FT_* type macros below */
>>=20
>> since "macros below" may be ambiguous as the header changes over =
time.
>>=20
>>=20
>> Even better (IMHO) is to use a named enum for this, like:
>>=20
>>        enum ext4_file_type file_type:8; /* See EXT4_FT_ types below =
*/
>>=20
>> /*
>> * Ext4 directory file types.  Only the low 3 bits are used.  The
>> * other bits are reserved for now.
>> */
>> enum ext4_file_type {
>> 	EXT4_FT_UNKNOWN		=3D 0,
>> 	EXT4_FT_REG_FILE	=3D 1,
>> 	EXT4_FT_DIR		=3D 2,
>> 	EXT4_FT_CHRDEV		=3D 3,
>> 	EXT4_FT_BLKDEV		=3D 4,
>> 	EXT4_FT_FIFO		=3D 5,
>> 	EXT4_FT_SOCK		=3D 6,
>> 	EXT4_FT_SYMLINK		=3D 7,
>> 	EXT4_FT_MAX,
>> 	EXT4_FT_DIR_CSUM	=3D 0xDE
>> };
>>=20
>> so that the allowed values for this field are clear from the =
definition.
>> However, the use of a fixed-with bitfield (enum :8) is a GCC-ism and =
Ted
>> may be against that for portability reasons, since the kernel and
>> userspace headers should be as similar as possible.
>=20
> This is an on-disk structure.  Do /not/ make this an enum because that
> would replace a __u8 with an int, which will break directories.

No, that is what the fixed bitfield declaration "enum ... :8" would do -
declare this enum to be an 8-bit integer.  I've verified that this works
as expected with GCC, to allow an enum with a specific size, like :8 or
:32 or :64.  Obviously, if you specify a bitfield size that doesn't =
align
with the start of the next structure field, there would be padding added
so that the next field is properly aligned, but that isn't the case =
here.

Since e2fsprogs needs to be portable to other compilers/OS, I'm not sure
if Ted would want the kernel header declaration to be different than the
e2fsprogs header.  I've grown to like using enum for these kind of =
"flags"
definitions, since they are much more concrete than a bare "int flags"
declaration, and still better than "int flags; /* see EXT4_FT_* below =
*/"
since the enum is a hard compiler linkage vs. just a comment, for the
same reasons that static inline functions are better than CPP macros.

Cheers, Andreas






--Apple-Mail=_276E3F35-881D-4FCA-A735-A8DEA28D9F23
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6wnnMACgkQcqXauRfM
H+CpsA//bLfIXPj0SYQT9WujSn1aXkCf5/mTbA4PMrGohtSEZ2ehxjcnA27Losip
KFSV1Fpx+C40XbvLFfPTX7o3Y5VKsYxanu1JG3B6ZA2ku6JHvqzuoePvrEP8L6HV
K9301YhfOsv5oSRkG2aHFiSC8fSo+n/F6a1Cn8FoHcF0QIKLJQK3v7PaS9UH5QBd
kr66Esc1rdFKDhe8rtVtlL+5DO7CfXeClEPGwgNmaEztmEUiTbmgQaxE1Vz2pPC5
rHX7PyvxZJJ2Qi63abamDxWoAGspcBIfcubSJFHj8t/w1aPcUixKMpHZ2pJyeV/1
mnkOXZ5Zy0l8T3axsSocANiucTjIvsCKIuv1Nt1FvIZ7nFceVoBmwwJ5kPM05gH6
ftNwYvUi00HH8lNnOB8rKfyNYIMUOjoBjkkVaKcs+cdcoBZws1VFf+M7R8xO4Uh9
tCWvAlkzwrQspWkQi3wixjjXLAhj1gxxKxFwZn6nNR4QmXg/NGiSARLyPvtvSxIg
tl5H8UyKKDWE9AYTviHqZYLYvUlLVHpTRfBkZPqcqjUBMTsp7gY7lWRW2jdlzq1+
HPA4PKcendc7y73BlKHCRayFWAN0BG3fBcQEaJGfysSu4+UCOsT6aXeBgm6zXjjp
32FEy+CLk3kfYvWCtBjg+OHA3Jy1lMQO6wxqAmOVlairSCNQl1Q=
=O1hy
-----END PGP SIGNATURE-----

--Apple-Mail=_276E3F35-881D-4FCA-A735-A8DEA28D9F23--
