Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF1724316C
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 01:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHLXZ2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Aug 2020 19:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHLXZ2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Aug 2020 19:25:28 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127D8C061384
        for <linux-ext4@vger.kernel.org>; Wed, 12 Aug 2020 16:25:27 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kr4so1883339pjb.2
        for <linux-ext4@vger.kernel.org>; Wed, 12 Aug 2020 16:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=HCiT/3CDbNI9aIJOTz7EDVPduvKVs7ah1aIkPM2JRgg=;
        b=MrjBEGCRg2RySnsBpzJfu6sNHOLYVfUeu+C6jX//LMyCpjBcZUwgfMZwMCwuM1EzRS
         n4zEZgA30Y8ighbnAVSsbQi5WRMbCaU9s39qiDkV7IanblZGomCneraCbb3YJ6roZ2EV
         CrfhxDTwkJ6JhQ0N0675SjN8+d8IY/Mzgdcw1ljN2K9FOqY8kaZ+iW59saYLKCU7F7GT
         nULICk1+W2DpunZwIY7Sv0h9dAYeXHV3gANq33xV/I1r6qdTpxtNM/wI6VWwgeHLt5sx
         RIcs+6djrLLVQuBfx9AqQ3aB2H6zJ4peff2j4rrCjNYwkj9hVXPw/T5Es8p9Ia9to09K
         QZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=HCiT/3CDbNI9aIJOTz7EDVPduvKVs7ah1aIkPM2JRgg=;
        b=B25K6nMPLX59GQMuyg4o7sU/7jMNqSVftoJTrAU1B0yRdyyKVdkT/RnazTQa5NChfD
         jj8y6EbwU+JigKo+DfIlJwx5byimY34M1ut5XEIL+hZqQSDmtNJVn5Y0lnOmDbW3NRoz
         vwAiCpYc2SwRcXoPWu+JFDDRT6oIsQCgJ4rG4FjHR6c/8Pr2UG7rF6Spllds3dSxNxUj
         nqSQ0ArW9DS55fN8G9E3UnilGzIVrgTxGkN1J4avDLMe2PiZ8WwPW1EPxnsbpq65sXEu
         Ls5kbc2SJLz065yhMeUUNYYxHXZSMhGIpWveLOgpJp3ETd9OHGSI3uMU512BXWFLdKWU
         skGw==
X-Gm-Message-State: AOAM532reJh/TbEdowLiooQXj1hCV7oON9Gz73aPhkPlhvJptWTkQ4rV
        bekwh40xot/5/6F4mtt5o5bY8A==
X-Google-Smtp-Source: ABdhPJxhwPI643OHxWHnwa4sZ4/SzFnNgR4ugyfDW0SATPqiT3j7ptCE1KXJ9Gd/QB2WF+H07oAFmQ==
X-Received: by 2002:a17:90b:1254:: with SMTP id gx20mr2456702pjb.117.1597274727296;
        Wed, 12 Aug 2020 16:25:27 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 13sm3584420pfp.3.2020.08.12.16.25.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 16:25:26 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <A2F1D05C-92DA-4D45-9428-B5ED0B089A5C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_046EF5B0-51AC-4C13-9AAF-D8BBB1FBC443";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] chattr/lsattr: Support dax attribute
Date:   Wed, 12 Aug 2020 17:25:22 -0600
In-Reply-To: <20200807160305.GQ1573827@iweiny-DESK2.sc.intel.com>
Cc:     Xiao Yang <yangx.jy@cn.fujitsu.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Ira Weiny <ira.weiny@intel.com>
References: <20200728053321.12892-1-yangx.jy@cn.fujitsu.com>
 <20200807160305.GQ1573827@iweiny-DESK2.sc.intel.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_046EF5B0-51AC-4C13-9AAF-D8BBB1FBC443
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 7, 2020, at 10:03 AM, Ira Weiny <ira.weiny@intel.com> wrote:
>=20
> On Tue, Jul 28, 2020 at 01:33:21PM +0800, Xiao Yang wrote:
>> Use the letter 'x' to set/get dax attribute on a directory/file.
>>=20
>> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> ---
>>=20
>> V1->V2:
>> 1) Define FS_DAX_FL in order and add missing 'x' letter in manpage.
>> 2) Add more detailed description about 'x' attribute.
>> 3) 'x' is a separate attribute and doesn't always affect S_DAX(i.e.
>>   pagecache bypass) so remove the related info.
>>=20
>> lib/e2p/pf.c         |  1 +
>> lib/ext2fs/ext2_fs.h |  1 +
>> misc/chattr.1.in     | 15 ++++++++++++---
>> misc/chattr.c        |  3 ++-
>> 4 files changed, 16 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/lib/e2p/pf.c b/lib/e2p/pf.c
>> index 0c6998c4..e59cccff 100644
>> --- a/lib/e2p/pf.c
>> +++ b/lib/e2p/pf.c
>> @@ -44,6 +44,7 @@ static struct flags_name flags_array[] =3D {
>> 	{ EXT2_TOPDIR_FL, "T", "Top_of_Directory_Hierarchies" },
>> 	{ EXT4_EXTENTS_FL, "e", "Extents" },
>> 	{ FS_NOCOW_FL, "C", "No_COW" },
>> +	{ FS_DAX_FL, "x", "Dax" },
>> 	{ EXT4_CASEFOLD_FL, "F", "Casefold" },
>> 	{ EXT4_INLINE_DATA_FL, "N", "Inline_Data" },
>> 	{ EXT4_PROJINHERIT_FL, "P", "Project_Hierarchy" },
>> diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
>> index 6c20ea77..88f510a3 100644
>> --- a/lib/ext2fs/ext2_fs.h
>> +++ b/lib/ext2fs/ext2_fs.h
>> @@ -335,6 +335,7 @@ struct ext2_dx_tail {
>> /* EXT4_EOFBLOCKS_FL 0x00400000 was here */
>> #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
>> #define EXT4_SNAPFILE_FL		0x01000000  /* Inode is a =
snapshot */
>> +#define FS_DAX_FL			0x02000000 /* Inode is DAX */
>=20
> Per-file support is not supported on ext2...
>=20
> So I'm suspicious of this change.  It is probably not an issue but I =
just
> wanted to check if you are trying to test on ext2?

It is up to the kernel to handle the various flags, definitely the =
chattr
command should not be trying to guess which flags are supported, since
this can definitely change between kernels and the underlying =
filesystems.

Note that the headers in e2fsprogs are all using "ext2" in the name,
regardless of the fact that the flags apply to ext3 and ext4.

Cheers, Andreas

>> #define EXT4_SNAPFILE_DELETED_FL	0x04000000  /* Snapshot is being =
deleted */
>> #define EXT4_SNAPFILE_SHRUNK_FL		0x08000000  /* Snapshot =
shrink has completed */
>> #define EXT4_INLINE_DATA_FL		0x10000000 /* Inode has inline =
data */
>> diff --git a/misc/chattr.1.in b/misc/chattr.1.in
>> index ff2fcf00..5a4928a5 100644
>> --- a/misc/chattr.1.in
>> +++ b/misc/chattr.1.in
>> @@ -23,13 +23,13 @@ chattr \- change file attributes on a Linux file =
system
>> .B chattr
>> changes the file attributes on a Linux file system.
>> .PP
>> -The format of a symbolic mode is +-=3D[aAcCdDeFijPsStTu].
>> +The format of a symbolic mode is +-=3D[aAcCdDeFijPsStTux].
>> .PP
>> The operator '+' causes the selected attributes to be added to the
>> existing attributes of the files; '-' causes them to be removed; and =
'=3D'
>> causes them to be the only attributes that the files have.
>> .PP
>> -The letters 'aAcCdDeFijPsStTu' select the new attributes for the =
files:
>> +The letters 'aAcCdDeFijPsStTux' select the new attributes for the =
files:
>> append only (a),
>> no atime updates (A),
>> compressed (c),
>> @@ -45,7 +45,8 @@ secure deletion (s),
>> synchronous updates (S),
>> no tail-merging (t),
>> top of directory hierarchy (T),
>> -and undeletable (u).
>> +undeletable (u),
>> +and direct access for files (x).
>> .PP
>> The following attributes are read-only, and may be listed by
>> .BR lsattr (1)
>> @@ -210,6 +211,14 @@ saved.  This allows the user to ask for its =
undeletion.  Note: please
>> make sure to read the bugs and limitations section at the end of this
>> document.
>> .TP
>> +.B x
>> +The 'x' attribute can be set on a directory or file.  If the =
attribute
>> +is set on an existing directory, it will be inherited by all files =
and
>> +subdirectories that are subsequently created in the directory.  If =
an
>> +existing directory has contained some files and subdirectories, =
modifying
>> +the attribute on the parent directory doesn't change the attributes =
on
>> +these files and subdirectories.
>> +.TP
>> .B V
>> A file with the 'V' attribute set has fs-verity enabled.  It cannot =
be
>> written to, and the filesystem will automatically verify all data =
read
>> diff --git a/misc/chattr.c b/misc/chattr.c
>> index a5d60170..c0337f86 100644
>> --- a/misc/chattr.c
>> +++ b/misc/chattr.c
>> @@ -86,7 +86,7 @@ static unsigned long sf;
>> static void usage(void)
>> {
>> 	fprintf(stderr,
>> -		_("Usage: %s [-pRVf] [-+=3DaAcCdDeijPsStTuF] [-v =
version] files...\n"),
>> +		_("Usage: %s [-pRVf] [-+=3DaAcCdDeijPsStTuFx] [-v =
version] files...\n"),
>> 		program_name);
>> 	exit(1);
>> }
>> @@ -112,6 +112,7 @@ static const struct flags_char flags_array[] =3D =
{
>> 	{ EXT2_NOTAIL_FL, 't' },
>> 	{ EXT2_TOPDIR_FL, 'T' },
>> 	{ FS_NOCOW_FL, 'C' },
>> +	{ FS_DAX_FL, 'x' },
>> 	{ EXT4_CASEFOLD_FL, 'F' },
>> 	{ 0, 0 }
>> };
>> --
>> 2.21.0
>>=20
>>=20
>>=20


Cheers, Andreas






--Apple-Mail=_046EF5B0-51AC-4C13-9AAF-D8BBB1FBC443
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl80emIACgkQcqXauRfM
H+A1qg/9GprYyaIJvV4XGJa8xv9VLnfOaWrC5sF0VLsljzGbXdERRhKgNtmGlo41
oPu9hP0NHTOMCSzAzwjZYLAWOqAuDRx8mqVER7dUwNyNrnxfgIfF9Ga7TKEj53kP
1p604zz1UiG5p1RSaEvX9ZLYoa5c2BvSjvKg+1bd5SdvKOpTYrj+9FUEYcOnTHh4
E6ARk/aRvfDV8uM7cTnrV+lr3kzC9MZ7IsShlD0sv5V3JPuK9pHAxCEH23IAnNUE
VOTGgkBYef3ILhqKPJMWjijBhKq448iYCDbmFlfa85v2myfhm0zAvsLKq646uQ8O
TfwWKOswQlL3dsG8UThR5RhFJlpMMX3PAxeB1GgMw5By/lK+loye+bF1CzIy3iWT
SsW+1UKWuE5s71AWOyOwM7uSA3uLEG1g5vt760ZmvoUXPk9U5myIiFahkceQxqrl
3rbqP3+KOnIVPLyIDfigNp+Dh4KdWLg3Xlei++KLD0CnoTUp3BBF4fecCuwaRSYY
j5mNydRiJlnA25Rmu6D2pay9BDEnK5/6B0rsEaqHYprk1TTW6faHzmG/qyeUUUL5
N6ehXiyFGE6rBnhNxyrjQJ1OqzfkvnWxGzgmavKjZ+Qbl0L+05+mSzQSG3M30wF3
qv0BI7G03q6SRMgIeyu9atwLcuDlplqJ8komU+4duJKJfVJc5pk=
=mqBo
-----END PGP SIGNATURE-----

--Apple-Mail=_046EF5B0-51AC-4C13-9AAF-D8BBB1FBC443--
