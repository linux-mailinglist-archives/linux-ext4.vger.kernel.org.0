Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6608B553F
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 20:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfIQSWj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 14:22:39 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40648 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbfIQSWi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 14:22:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id 7so4554174ljw.7
        for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2019 11:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NvDEaulblz8BYfrg2teaS9eEvJV5UJSYuKgmxCkErHQ=;
        b=Sh658MqbbcA+2wMagYm1ZG9BG7RDkrL2dbw+g+2ocAA3QzrtJcIF+4EPiArgPMxEAJ
         /Nsdbcc3iEsUHuA5Aj3UuzZL9yDUpem+IARzm4ZHfJ4BX8wHUA+NCAdktx3WSPs84HPT
         YBDTZw8IHdDDL/MTnSFmsETwCFa9rgE0fdINFJA4p6L6IxKe9O4htsYCyWyTnXIbOAj4
         lcA9Ii4Bj39BdarEI+Wjj7xe1rnNLGMYYbbin5wQOUyX3T2hHHfbKzx0WBDw0KUQg7Ke
         SZNb36pMMKFXPXLY1wIf0ME6D5vLJZHeP5HNMTietZzqWlg8je7n7KViXiDXwysYqLg5
         a7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NvDEaulblz8BYfrg2teaS9eEvJV5UJSYuKgmxCkErHQ=;
        b=dZjD4jD11YkmUgfYqI6XOQWUjvMjhzHtjguuqeIABcL6+TahknSy3lgOEpTZlrnkvG
         HPOVupXk+YCr3duGoJKTcMFpJYazXQt0a6fT8XuNSEbLkiIfRFkenGMqHfERHIsK6UZf
         Sf9FW5u2KftdxQ+qgRt+iOChjRCyx+8X6uUt2i3vLlRFzgLu9tP+hB2eV6BFh0AaZtOk
         Uvp8C6tfmQLOrN+poxVztZzxAYJ/HJKOHg4Nyg4qzPVBp6cFsxHX9UTFWgd4StqY+cDe
         zBw6YX216TRdyJR/88Rq9kNrWYM9jyzREu800dtCESfYA1SFsNj/nASSf7kihZH0x87V
         04Zw==
X-Gm-Message-State: APjAAAWW6qmjDMxtsZwfgH+cDnnGJb6Cn7f6T/3AWZmhqcizUgfP615W
        2JSFEnLJRixhZRtyV9yyJlXmSYs8FFF7zQ==
X-Google-Smtp-Source: APXvYqw/RMPcW2wV8VQUt8MGx5VkTZ6CwbsaXJS7aE4yP1CdjO2tHGUoq3h3wscMxgZbHrq353M+ig==
X-Received: by 2002:a2e:442:: with SMTP id 63mr2717600lje.66.1568744556204;
        Tue, 17 Sep 2019 11:22:36 -0700 (PDT)
Received: from [192.168.1.192] ([195.208.173.203])
        by smtp.gmail.com with ESMTPSA id r19sm575978ljd.95.2019.09.17.11.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 11:22:35 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext2fs: add ext2fs_read_sb that returns superblock
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <20190905110110.32627-1-c17828@cray.com>
Date:   Tue, 17 Sep 2019 21:22:30 +0300
Cc:     adilger.kernel@dilger.ca
Content-Transfer-Encoding: quoted-printable
Message-Id: <490AFB3A-CA8B-41BE-96BF-94EBA93FF5B3@gmail.com>
References: <20190905110110.32627-1-c17828@cray.com>
To:     linux-ext4 <linux-ext4@vger.kernel.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Should I change anything it this patch?

Thanks,
Artem Blagodarenko.

> On 5 Sep 2019, at 14:01, Artem Blagodarenko =
<artem.blagodarenko@gmail.com> wrote:
>=20
> tune2fs is used to make e2label duties.  ext2fs_open2() reads group
> descriptors which are not used during disk label obtaining, but takes
> a lot of time on large partitions.
>=20
> This patch adds ext2fs_read_sb(), there only initialized superblock
> is returned This saves time dramatically.
>=20
> Signed-off-by: Artem Blagodarenko <c17828@cray.com>
> Cray-bug-id: LUS-5777
> ---
> lib/ext2fs/ext2fs.h |  2 ++
> lib/ext2fs/openfs.c | 16 ++++++++++++++++
> misc/tune2fs.c      | 23 +++++++++++++++--------
> 3 files changed, 33 insertions(+), 8 deletions(-)
>=20
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index 59fd9742..3a63b74d 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -1630,6 +1630,8 @@ extern int ext2fs_journal_sb_start(int =
blocksize);
> extern errcode_t ext2fs_open(const char *name, int flags, int =
superblock,
> 			     unsigned int block_size, io_manager =
manager,
> 			     ext2_filsys *ret_fs);
> +extern errcode_t ext2fs_read_sb(const char *name, io_manager manager,
> +				struct ext2_super_block * super);
> extern errcode_t ext2fs_open2(const char *name, const char =
*io_options,
> 			      int flags, int superblock,
> 			      unsigned int block_size, io_manager =
manager,
> diff --git a/lib/ext2fs/openfs.c b/lib/ext2fs/openfs.c
> index 51b54a44..95f45d84 100644
> --- a/lib/ext2fs/openfs.c
> +++ b/lib/ext2fs/openfs.c
> @@ -99,6 +99,22 @@ static void block_sha_map_free_entry(void *data)
> 	return;
> }
>=20
> +errcode_t ext2fs_read_sb(const char *name, io_manager manager,
> +			 struct ext2_super_block * super)
> +{
> +	io_channel	io;
> +	errcode_t	retval =3D 0;
> +
> +	retval =3D manager->open(name, 0, &io);
> +	if (!retval) {
> +		retval =3D io_channel_read_blk(io, 1, -SUPERBLOCK_SIZE,
> +				     super);
> +		io_channel_close(io);
> +	}
> +
> +	return retval;
> +}
> +
> /*
>  *  Note: if superblock is non-zero, block-size must also be non-zero.
>  * 	Superblock and block_size can be zero to use the default size.
> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> index 7d2d38d7..fea607e1 100644
> --- a/misc/tune2fs.c
> +++ b/misc/tune2fs.c
> @@ -2879,6 +2879,21 @@ int tune2fs_main(int argc, char **argv)
> #endif
> 		io_ptr =3D unix_io_manager;
>=20
> +	if (print_label) {
> +		/* For e2label emulation */
> +		struct ext2_super_block sb;
> +
> +		/* Read only superblock. Nothing else metters.*/
> +		retval =3D ext2fs_read_sb(device_name, io_ptr, &sb);
> +		if (!retval) {
> +			printf("%.*s\n", (int) sizeof(sb.s_volume_name),
> +			       sb.s_volume_name);
> +		}
> +
> +		remove_error_table(&et_ext2_error_table);
> +		return retval;
> +	}
> +
> retry_open:
> 	if ((open_flag & EXT2_FLAG_RW) =3D=3D 0 || f_flag)
> 		open_flag |=3D EXT2_FLAG_SKIP_MMP;
> @@ -2972,14 +2987,6 @@ retry_open:
> 	sb =3D fs->super;
> 	fs->flags &=3D ~EXT2_FLAG_MASTER_SB_ONLY;
>=20
> -	if (print_label) {
> -		/* For e2label emulation */
> -		printf("%.*s\n", (int) sizeof(sb->s_volume_name),
> -		       sb->s_volume_name);
> -		remove_error_table(&et_ext2_error_table);
> -		goto closefs;
> -	}
> -
> 	retval =3D ext2fs_check_if_mounted(device_name, &mount_flags);
> 	if (retval) {
> 		com_err("ext2fs_check_if_mount", retval,
> --=20
> 2.14.3
>=20

