Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFEA4B56CC
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 22:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfIQUUY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 16:20:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41286 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfIQUUX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 16:20:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7so2795926pfh.8
        for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2019 13:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=pecCGf/qoSGFtBFHmFbOGcChFgi9MoSCGhsOpPQfOL8=;
        b=HIkaixV5m6rjyyjMraL5GtBynSKr+FhMaSXl5pOU89KhIPNGvz2V9s3JA80lcNgbGq
         KMOCoxDlT0/3pNEbMIBmg4UbmZ2FnzO/SK1MtbLpOi321E4eUdryhaSdo3v5lk5CBCS8
         pG1wHJhCOaeaDNz+z2H/Hxe4kiRdDPSnOqPRv3UIIhpXSFbTDHVZcbSsVpZ/Hi7D8boK
         bk6Bdl1vU6unImX003bXh1jsrNqPQ5EBg4jEX5aWhwU431g29GdkisHZeMm5P5XZlJUH
         tdqdV9Fq6v99iWR/FVguRlvyfFXwWEfrFHpm54WQAKMkVSeAh66hy+jAKPZ+9CHKrbFm
         oqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=pecCGf/qoSGFtBFHmFbOGcChFgi9MoSCGhsOpPQfOL8=;
        b=aMB32C1HTkfj+Yz66lw7zI3+2cQX7Hz8KAWYwJFdC0XSh4f+Z6fRqho3mNc3Ci4AHI
         7z5jQ0qfX2ZTiCH2lPUnOO4hJg+RAy/fX0Zu3V3aCsbCZTxyWoRE0xwf7PT3Oa5hDdoB
         FMsBevz4B6bHUjug48v8oAc6DA76h/EGaoss00YdcqFKCmsXKwnS3oMH17GNnDiCo81E
         j+Q8i24/9sjbz6LyfZx93frmF4ratgyL21rML59Ss0L1hWbRzSxjV9dkSDWWFPfTcKKm
         shqoQj3+QO93eVG2toqvQgZkO0m6oURsRXgOXDpiWdDys8BOrydlz27QMTSavUnlbIq4
         2U1w==
X-Gm-Message-State: APjAAAWhQ0fitBVtObKuBr1Azir+oWCcuMqaiX4HKYY+8p0HzsExdWuy
        QnIrYrpocXWZBnozNZftiR7Ryw==
X-Google-Smtp-Source: APXvYqwP0ZIVSFsNshIt4C84+OoW0aRAWh5iedbVVaX8pWhiU4ZY7Xr6cudkNhJCqRX9p98nfZh+Zw==
X-Received: by 2002:a63:f304:: with SMTP id l4mr666564pgh.66.1568751621229;
        Tue, 17 Sep 2019 13:20:21 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id c8sm2935744pgw.37.2019.09.17.13.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 13:20:20 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C87FF70E-A410-4C92-B012-E5F1F7DC3A0F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_11E832A0-FE2A-4D65-BA1E-3F355BC104C6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext2fs: add ext2fs_read_sb that returns superblock
Date:   Tue, 17 Sep 2019 14:20:16 -0600
In-Reply-To: <490AFB3A-CA8B-41BE-96BF-94EBA93FF5B3@gmail.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
To:     =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
References: <20190905110110.32627-1-c17828@cray.com>
 <490AFB3A-CA8B-41BE-96BF-94EBA93FF5B3@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_11E832A0-FE2A-4D65-BA1E-3F355BC104C6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Sep 17, 2019, at 12:22 PM, =D0=91=D0=BB=D0=B0=D0=B3=D0=BE=D0=B4=D0=B0=
=D1=80=D0=B5=D0=BD=D0=BA=D0=BE =D0=90=D1=80=D1=82=D1=91=D0=BC =
<artem.blagodarenko@gmail.com> wrote:
>=20
> Hello,
>=20
> Should I change anything it this patch?

Looks OK to me:

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

>=20
> Thanks,
> Artem Blagodarenko.
>=20
>> On 5 Sep 2019, at 14:01, Artem Blagodarenko =
<artem.blagodarenko@gmail.com> wrote:
>>=20
>> tune2fs is used to make e2label duties.  ext2fs_open2() reads group
>> descriptors which are not used during disk label obtaining, but takes
>> a lot of time on large partitions.
>>=20
>> This patch adds ext2fs_read_sb(), there only initialized superblock
>> is returned This saves time dramatically.
>>=20
>> Signed-off-by: Artem Blagodarenko <c17828@cray.com>
>> Cray-bug-id: LUS-5777
>> ---
>> lib/ext2fs/ext2fs.h |  2 ++
>> lib/ext2fs/openfs.c | 16 ++++++++++++++++
>> misc/tune2fs.c      | 23 +++++++++++++++--------
>> 3 files changed, 33 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
>> index 59fd9742..3a63b74d 100644
>> --- a/lib/ext2fs/ext2fs.h
>> +++ b/lib/ext2fs/ext2fs.h
>> @@ -1630,6 +1630,8 @@ extern int ext2fs_journal_sb_start(int =
blocksize);
>> extern errcode_t ext2fs_open(const char *name, int flags, int =
superblock,
>> 			     unsigned int block_size, io_manager =
manager,
>> 			     ext2_filsys *ret_fs);
>> +extern errcode_t ext2fs_read_sb(const char *name, io_manager =
manager,
>> +				struct ext2_super_block * super);
>> extern errcode_t ext2fs_open2(const char *name, const char =
*io_options,
>> 			      int flags, int superblock,
>> 			      unsigned int block_size, io_manager =
manager,
>> diff --git a/lib/ext2fs/openfs.c b/lib/ext2fs/openfs.c
>> index 51b54a44..95f45d84 100644
>> --- a/lib/ext2fs/openfs.c
>> +++ b/lib/ext2fs/openfs.c
>> @@ -99,6 +99,22 @@ static void block_sha_map_free_entry(void *data)
>> 	return;
>> }
>>=20
>> +errcode_t ext2fs_read_sb(const char *name, io_manager manager,
>> +			 struct ext2_super_block * super)
>> +{
>> +	io_channel	io;
>> +	errcode_t	retval =3D 0;
>> +
>> +	retval =3D manager->open(name, 0, &io);
>> +	if (!retval) {
>> +		retval =3D io_channel_read_blk(io, 1, -SUPERBLOCK_SIZE,
>> +				     super);
>> +		io_channel_close(io);
>> +	}
>> +
>> +	return retval;
>> +}
>> +
>> /*
>> *  Note: if superblock is non-zero, block-size must also be non-zero.
>> * 	Superblock and block_size can be zero to use the default size.
>> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
>> index 7d2d38d7..fea607e1 100644
>> --- a/misc/tune2fs.c
>> +++ b/misc/tune2fs.c
>> @@ -2879,6 +2879,21 @@ int tune2fs_main(int argc, char **argv)
>> #endif
>> 		io_ptr =3D unix_io_manager;
>>=20
>> +	if (print_label) {
>> +		/* For e2label emulation */
>> +		struct ext2_super_block sb;
>> +
>> +		/* Read only superblock. Nothing else metters.*/
>> +		retval =3D ext2fs_read_sb(device_name, io_ptr, &sb);
>> +		if (!retval) {
>> +			printf("%.*s\n", (int) sizeof(sb.s_volume_name),
>> +			       sb.s_volume_name);
>> +		}
>> +
>> +		remove_error_table(&et_ext2_error_table);
>> +		return retval;
>> +	}
>> +
>> retry_open:
>> 	if ((open_flag & EXT2_FLAG_RW) =3D=3D 0 || f_flag)
>> 		open_flag |=3D EXT2_FLAG_SKIP_MMP;
>> @@ -2972,14 +2987,6 @@ retry_open:
>> 	sb =3D fs->super;
>> 	fs->flags &=3D ~EXT2_FLAG_MASTER_SB_ONLY;
>>=20
>> -	if (print_label) {
>> -		/* For e2label emulation */
>> -		printf("%.*s\n", (int) sizeof(sb->s_volume_name),
>> -		       sb->s_volume_name);
>> -		remove_error_table(&et_ext2_error_table);
>> -		goto closefs;
>> -	}
>> -
>> 	retval =3D ext2fs_check_if_mounted(device_name, &mount_flags);
>> 	if (retval) {
>> 		com_err("ext2fs_check_if_mount", retval,
>> --
>> 2.14.3
>>=20
>=20


Cheers, Andreas






--Apple-Mail=_11E832A0-FE2A-4D65-BA1E-3F355BC104C6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl2BQAAACgkQcqXauRfM
H+C7IA/+KVposImK9g0Bli/PNwE/JvM4/zjMvior5h0lvC9yV6BH11MbVeehxhA+
ZkWf9wyAUfogS6JhbcvL2Qv7fxzfP7OnaeqEJy3w3UTtpUnIRmwTkBexnpgCiWoj
UDr2lA4Bt+oTGOwsjOSKn9KuW+1peLD0NacFeUXvIEhcWoL89xrSb7ppel6SyC5t
m8RQXxXCY1U4B5AdOkQj95LuO6R80f6KmOeFyd2jKiWlHBri+dcu96VSykhio6Qr
5cPl/S6KOK83n+mvqT8G3+59c1r10l0xRqumJQB6owc3UFl/rhk0aHDzW7NV8zQw
SeNj3hKsthTbWk28NcLAiqs1wdqmUbO4u0DyNfFBvF/7DoEyG9MQTbxM8hx5cMLk
D/EJbmlSORSx4DIYqwrsEZrfB2cNyp8YsnZlr6lIVp58A7BgmupVjycEPB7zIDqv
/Go0DEwxr695Ldlm7+u/2yg7rCYJMteGOKrudXWL0oaLvP7/R0O0Sa389ZctkTKG
B8SzkLMfVuNDoKry937SIc+OkO7l3zBNL5Ic1aUSbwF3EKMZbkGAAzLwhbAiZy+N
gpaB+E9Lg8n1DQwxUocRZWyKUdZpuOrRmowMgWHi/iirMTsRjzKsNHcdsytrkGUT
ueODjf/AvNUTVrQK96e6a/RqXbg0wCj+p0gF+soFBUnm0GXurgA=
=o4AD
-----END PGP SIGNATURE-----

--Apple-Mail=_11E832A0-FE2A-4D65-BA1E-3F355BC104C6--
