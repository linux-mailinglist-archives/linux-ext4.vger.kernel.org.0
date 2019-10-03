Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3B6CA3CE
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Oct 2019 18:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389687AbfJCQTG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 12:19:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32792 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389673AbfJCQTC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Oct 2019 12:19:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id q1so2098856pgb.0
        for <linux-ext4@vger.kernel.org>; Thu, 03 Oct 2019 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xwJ+goq56V61KKdUp1nXU3PcbR5cWKTPI7JwjuelYXM=;
        b=hyp83+4jBvXpvboY1Q8WaQ1GiZC66yMNhix38Mq6ItRsEHKNnztY8eLYiaPlROtMiO
         6oCrTF0iPbEgOB1yIfYXwZUNntXHpcgbqYMHdsrSpU//1oFcoVUMi6FdT1qDJ4oU5ZuE
         YGUquHvTdaL75XGy8rtdvQuw6+sC0ov/E2wa4PLsscBpLmLXxVJH+5K6oThVWNml2dcb
         wGmPc9wWRn6eFsxfQSH21Qr0k7DWt44yZ3bFzcWcQh+taOcZLlNT966/TdVvaKC9Wpqk
         X8+F4+HlLub7GFezI7CYgWMI9L66oD8/nsrQTIdzeCl6JGH8VgvzUNj4WQzY3FBxTAxI
         M0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xwJ+goq56V61KKdUp1nXU3PcbR5cWKTPI7JwjuelYXM=;
        b=kigFhJeiFK6O7/m1zOAFjwCr2aWJ7Uu2arCRsyQDmjXtM59vmJfuH1taBylXEAHOop
         fR3y7+j5Sq/f3gOqIatKiBD1yAZHQREAj2jjd/TXCPpfk/b6MXBwlGdp3vaz+2Tqo7mW
         1P7njb3C7wNjCWBRQs2dupEjTc7e9ZgKt8kAMC0txk828vvKQHWptPBDssbC6w2evFz3
         z0kR9LOcZb8EVkwqHwsOa5UoJ4d2FtGeHNOyeNvQRP+PlMEeo51IrcuRp3WPwAJz+ako
         FcupXxNJOsMRNLMRU88GIQOx7/NVjxOUr2TAnLRZq81yEMgcvHWzbegcFMc2BczgvbNW
         PU5g==
X-Gm-Message-State: APjAAAXT6fdnQUYbVlZBzT624HMHtN99E2WanvMpY+OEbLeLvI4l1MJN
        K74Bv+BsfY6Ac1KIrablc6VuH9zLhEE=
X-Google-Smtp-Source: APXvYqwWbEvPNnOSmoZ+Tj+A9qU3f3+vAVMOEdC4/oW4WXBs3yc1fSoo+bYhaxQX/uUKcaOpKpkEBg==
X-Received: by 2002:a17:90a:3d03:: with SMTP id h3mr11611819pjc.49.1570119541664;
        Thu, 03 Oct 2019 09:19:01 -0700 (PDT)
Received: from [192.168.248.234] ([63.239.150.218])
        by smtp.gmail.com with ESMTPSA id t9sm2749051pgj.89.2019.10.03.09.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 09:19:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext2fs: add ext2fs_read_sb that returns superblock
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <20191003160122.GB13093@magnolia>
Date:   Thu, 3 Oct 2019 19:18:47 +0300
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca
Content-Transfer-Encoding: quoted-printable
Message-Id: <EDEB5AE3-80AC-43D7-8726-4D9E45D710FE@gmail.com>
References: <20190905110110.32627-1-c17828@cray.com>
 <20191003160122.GB13093@magnolia>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Darrick, thanks for feedback.

> On 3 Oct 2019, at 19:01, Darrick J. Wong <darrick.wong@oracle.com> =
wrote:
>=20
> On Thu, Sep 05, 2019 at 02:01:10PM +0300, Artem Blagodarenko wrote:
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
>>  *  Note: if superblock is non-zero, block-size must also be =
non-zero.
>>  * 	Superblock and block_size can be zero to use the default size.
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
>=20
>                                                      matters. */
>=20
>> +		retval =3D ext2fs_read_sb(device_name, io_ptr, &sb);
>> +		if (!retval) {
>> +			printf("%.*s\n", (int) sizeof(sb.s_volume_name),
>> +			       sb.s_volume_name);
>> +		}
>=20
> Um, does this drop the error without making a report?

No error message to output, but error code is returned to pointer.
I believe user expect only disk label, no other output.

>=20
>> +
>> +		remove_error_table(&et_ext2_error_table);
>> +		return retval;
>> +	}
>=20
> I wonder if ext[24] should implement FS_IOC_[GS]ETFSLABEL for mounted
> filesystems =E2=80=A6 ?

Probably not very useful for Lustre FS, there disk label is not needed =
during cluster work.
Darrick, can you suggest any use case for this?
Also such features need to be added in separate patch. This patch is =
about performance optimisation.=20

Best regards,
Artem Blagodarenko.
>=20
> --D
>=20
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
>> --=20
>> 2.14.3

