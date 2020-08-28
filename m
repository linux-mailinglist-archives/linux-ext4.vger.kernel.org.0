Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33553255650
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Aug 2020 10:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgH1IXH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Aug 2020 04:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgH1IXC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Aug 2020 04:23:02 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F350FC061264
        for <linux-ext4@vger.kernel.org>; Fri, 28 Aug 2020 01:23:01 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m34so100321pgl.11
        for <linux-ext4@vger.kernel.org>; Fri, 28 Aug 2020 01:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=GYTMe1U8vae/CUnTiLz5iOn/xQhCwWXRtNEKQ3dszj4=;
        b=BaniK2wzo7vRJI+uCG2MOi1EhI3llunNErLr6qVS8jL1VW8KfWMBMHs2/h0p/IsXHN
         NIFddgKXyYD/MYllNHzMJJahnpOu4P0qZYgTk1oRaFKIu9EwkipDwJAU01QwN12+8HuP
         U22Y1Pa8ohV5odMCEb5dHMoKv73cjjLjCZUQaEO28ImFBiT/ssoQdXWFPdraOuayPtr3
         bhF1vIowBxZRX0UpLcwSbu/hra0En/40SMkyaFEisJVGW7ODSsPBl1xM8Y31d3GI7Lhf
         1jyfMPbZc3BOPbICJvL8cKDjqToRQNwiiZdQB85ML+27tySSJt4p30UDqVPt9lcya2yo
         an7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=GYTMe1U8vae/CUnTiLz5iOn/xQhCwWXRtNEKQ3dszj4=;
        b=SNGgJ9Fi3vE+nTYCFVN8h4Kutdh3cEdu4U/y6KJuMaLTS3kakQkCujtCjNLkehbdXL
         GfwTOEFrsNo1aKSzc0s2Oahc4QvH8OJBOXybXUtCt6QLT7lIX5LhvB1blvBEIA2lBi1n
         y2WZrunZJ3tdp2JP5GFvyMd9DcDIXAnk2tv6cB1G3PfR7bVtpDFwPzzKVGrl85yK1eLc
         QFp0WwvoFDL9ff2kP/WOOVP7SAh7Iao69P3G5JoiRLES3bj+0+7ApTmpgtFEBaldQ3gl
         oJQ1L1YohyE/tP4SfVuG2a94ieN56YWZ4lRbo8xNC9ZNf5oc+SXye+s0UpI1V1TyDHtZ
         Frbw==
X-Gm-Message-State: AOAM530CVCUwRnPAUWDQl46N/4JLY+Z7VT1WiggdVlcZO6tXcoD9iaKp
        VQCHCiw7aOOjOCy9S3g9Kqv3SA==
X-Google-Smtp-Source: ABdhPJxW/8qEE97LByoisMYC4dp9CHyzQo67cDP+L6pc2obDzwx5sfHDDJTCCJh3tFr1Ii8sUFOd4g==
X-Received: by 2002:a63:3710:: with SMTP id e16mr422572pga.140.1598602981279;
        Fri, 28 Aug 2020 01:23:01 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id m188sm620068pfm.220.2020.08.28.01.22.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 01:23:00 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <305B253D-9A17-4E42-A0BF-016E278FD3B6@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1FAA0EA9-31FB-47E9-84E3-9BDDEECB535A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] chattr/lsattr: Support dax attribute
Date:   Fri, 28 Aug 2020 02:22:57 -0600
In-Reply-To: <5F485ED8.70402@cn.fujitsu.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>, Theodore Ts'o <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
References: <20200728053321.12892-1-yangx.jy@cn.fujitsu.com>
 <9FB1F4E5-7B7C-4E09-A415-3C5C888B321F@dilger.ca>
 <5F349A82.5080007@cn.fujitsu.com> <5F485ED8.70402@cn.fujitsu.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_1FAA0EA9-31FB-47E9-84E3-9BDDEECB535A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 27, 2020, at 7:33 PM, Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
>=20
> Hi,
>=20
> Is there any comment on the patch? :-)

I don't need a v3 for the Dax vs. DAX case, though I think DAX would be
better.  The decision is up to Ted.

Cheers, Andreas

>=20
> Thanks,
> Xiao Yang
> On 2020/8/13 9:42, Xiao Yang wrote:
>> On 2020/8/13 7:29, Andreas Dilger wrote:
>>> On Jul 27, 2020, at 11:33 PM, Xiao Yang<yangx.jy@cn.fujitsu.com>  =
wrote:
>>>> Use the letter 'x' to set/get dax attribute on a directory/file.
>>>>=20
>>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>> One minor nit below, but otherwise looks OK.
>>>=20
>>> Reviewed-by: Andreas Dilger<adilger@dilger.ca>
>>>=20
>>>> diff --git a/lib/e2p/pf.c b/lib/e2p/pf.c
>>>> index 0c6998c4..e59cccff 100644
>>>> --- a/lib/e2p/pf.c
>>>> +++ b/lib/e2p/pf.c
>>>> @@ -44,6 +44,7 @@ static struct flags_name flags_array[] =3D {
>>>>    { EXT2_TOPDIR_FL, "T", "Top_of_Directory_Hierarchies" },
>>>>    { EXT4_EXTENTS_FL, "e", "Extents" },
>>>>    { FS_NOCOW_FL, "C", "No_COW" },
>>>> +    { FS_DAX_FL, "x", "Dax" },
>>> Should this be "DAX" ?  That is how it is commonly used in the =
kernel.
>> Hi Andreas,
>>=20
>> Thanks a lot for your review.
>>=20
>> Either 'Dax' or 'DAX' is fine to me because it is just the output of =
lsattr -v.
>> For example, xfs_io shows 'dax' instead of 'DAX':
>> # xfs_io -c "lsattr -v" file
>> [dax] file
>>=20
>> BTW:
>> I just used 'Dax' to follow the current format of output(i.e. =
capitalize the first letter).
>>=20
>> Do you want me to send v3 patch with the 'DAX'? :-)
>>=20
>> Best Regards,
>> Xiao Yang
>>>>    { EXT4_CASEFOLD_FL, "F", "Casefold" },
>>>>    { EXT4_INLINE_DATA_FL, "N", "Inline_Data" },
>>>>    { EXT4_PROJINHERIT_FL, "P", "Project_Hierarchy" },
>>>> diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
>>>> index 6c20ea77..88f510a3 100644
>>>> --- a/lib/ext2fs/ext2_fs.h
>>>> +++ b/lib/ext2fs/ext2_fs.h
>>>> @@ -335,6 +335,7 @@ struct ext2_dx_tail {
>>>> /* EXT4_EOFBLOCKS_FL 0x00400000 was here */
>>>> #define FS_NOCOW_FL            0x00800000 /* Do not cow file */
>>>> #define EXT4_SNAPFILE_FL        0x01000000  /* Inode is a snapshot =
*/
>>>> +#define FS_DAX_FL            0x02000000 /* Inode is DAX */
>>>> #define EXT4_SNAPFILE_DELETED_FL    0x04000000  /* Snapshot is =
being deleted */
>>>> #define EXT4_SNAPFILE_SHRUNK_FL        0x08000000  /* Snapshot =
shrink has completed */
>>>> #define EXT4_INLINE_DATA_FL        0x10000000 /* Inode has inline =
data */
>>>> diff --git a/misc/chattr.1.in b/misc/chattr.1.in
>>>> index ff2fcf00..5a4928a5 100644
>>>> --- a/misc/chattr.1.in
>>>> +++ b/misc/chattr.1.in
>>>> @@ -23,13 +23,13 @@ chattr \- change file attributes on a Linux =
file system
>>>> .B chattr
>>>> changes the file attributes on a Linux file system.
>>>> .PP
>>>> -The format of a symbolic mode is +-=3D[aAcCdDeFijPsStTu].
>>>> +The format of a symbolic mode is +-=3D[aAcCdDeFijPsStTux].
>>>> .PP
>>>> The operator '+' causes the selected attributes to be added to the
>>>> existing attributes of the files; '-' causes them to be removed; =
and '=3D'
>>>> causes them to be the only attributes that the files have.
>>>> .PP
>>>> -The letters 'aAcCdDeFijPsStTu' select the new attributes for the =
files:
>>>> +The letters 'aAcCdDeFijPsStTux' select the new attributes for the =
files:
>>>> append only (a),
>>>> no atime updates (A),
>>>> compressed (c),
>>>> @@ -45,7 +45,8 @@ secure deletion (s),
>>>> synchronous updates (S),
>>>> no tail-merging (t),
>>>> top of directory hierarchy (T),
>>>> -and undeletable (u).
>>>> +undeletable (u),
>>>> +and direct access for files (x).
>>>> .PP
>>>> The following attributes are read-only, and may be listed by
>>>> .BR lsattr (1)
>>>> @@ -210,6 +211,14 @@ saved.  This allows the user to ask for its =
undeletion.  Note: please
>>>> make sure to read the bugs and limitations section at the end of =
this
>>>> document.
>>>> .TP
>>>> +.B x
>>>> +The 'x' attribute can be set on a directory or file.  If the =
attribute
>>>> +is set on an existing directory, it will be inherited by all files =
and
>>>> +subdirectories that are subsequently created in the directory.  If =
an
>>>> +existing directory has contained some files and subdirectories, =
modifying
>>>> +the attribute on the parent directory doesn't change the =
attributes on
>>>> +these files and subdirectories.
>>>> +.TP
>>>> .B V
>>>> A file with the 'V' attribute set has fs-verity enabled.  It cannot =
be
>>>> written to, and the filesystem will automatically verify all data =
read
>>>> diff --git a/misc/chattr.c b/misc/chattr.c
>>>> index a5d60170..c0337f86 100644
>>>> --- a/misc/chattr.c
>>>> +++ b/misc/chattr.c
>>>> @@ -86,7 +86,7 @@ static unsigned long sf;
>>>> static void usage(void)
>>>> {
>>>>    fprintf(stderr,
>>>> -        _("Usage: %s [-pRVf] [-+=3DaAcCdDeijPsStTuF] [-v version] =
files...\n"),
>>>> +        _("Usage: %s [-pRVf] [-+=3DaAcCdDeijPsStTuFx] [-v version] =
files...\n"),
>>>>        program_name);
>>>>    exit(1);
>>>> }
>>>> @@ -112,6 +112,7 @@ static const struct flags_char flags_array[] =3D =
{
>>>>    { EXT2_NOTAIL_FL, 't' },
>>>>    { EXT2_TOPDIR_FL, 'T' },
>>>>    { FS_NOCOW_FL, 'C' },
>>>> +    { FS_DAX_FL, 'x' },
>>>>    { EXT4_CASEFOLD_FL, 'F' },
>>>>    { 0, 0 }
>>>> };
>>>> --
>>>> 2.21.0
>>>>=20
>>>>=20
>>>>=20
>>>=20
>>> Cheers, Andreas


Cheers, Andreas






--Apple-Mail=_1FAA0EA9-31FB-47E9-84E3-9BDDEECB535A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9IvuEACgkQcqXauRfM
H+DMCBAAtEC2cWQrygh0Q6lQmv3fmZa54vJd4hyNu04200zIEGGL1xOJRd8WYphC
+8LguQylWMGEHiPRoKWfhEpJlOeMD0fl9Z13NPwqaltz2LXyldyxbjht/qLbFcQp
jHp5/1mfQiC3gFA5w4778o3UjZ4EPEAHRuVUcye9+xRaoSEFTlv7OB2mQ0J2PuQJ
1Enx2cOsjWxAleeMKsvsqbRpZnDCTWUx7WxUJ5AkeHFqYa26bWvBJZOX3J7wZBUM
QVO1m5HUjFZ4+YfdT/ow/l8S7aZC7kjxnWrWtFGcf9qkh2umTrDeEdwR2e1s5nWC
4u40dnAtCLJCDPLItCuJz9iDJ8pBh1kbUIoFLLfxyCVPzyIEAKBnmjiedfWafBXk
PCym46HorZCH7erookjhnrss+9c+BMRyd/3qaL6kxGv1q4gjMcals2Ct34h1rQ47
GUup8IeLCgXnLsRQtabJzTF7/UghEHUI86/oWqcORXfttajkmo5zEv5OV/Sm12Kv
PydXKqqKpAoFzdUQsPgIx7nQyXpSITk2/8zAt7QXh18pBh7iQkSHWJ+1NtwAVNd5
iCyZZgKdJ4Ft0onHIFzE1L3hYo++4X8pK8QmpfHBXoO7h0zfVwz31dQKXv0FPiIM
01PxSllBVJGh6vbtYK0hLtel8nKQVHlIDrA5OSYEQsXjSKvGfQ8=
=9H3L
-----END PGP SIGNATURE-----

--Apple-Mail=_1FAA0EA9-31FB-47E9-84E3-9BDDEECB535A--
