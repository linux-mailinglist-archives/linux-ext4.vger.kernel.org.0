Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5DACA14E
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Oct 2019 17:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfJCPrb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 11:47:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45501 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfJCPrb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Oct 2019 11:47:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id r134so2203393lff.12
        for <linux-ext4@vger.kernel.org>; Thu, 03 Oct 2019 08:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OPjQ8wdwz1GEb8wS94mL9Pue/O6MN6Uk9Vek3ZY7+xU=;
        b=ezCeeMjniXj2soIbWVNycbyk5xgkJBcEi4OGgPWwH8IwxDa2H7s9OcnR01yzh7z1ZF
         E90YBNnQKFZZhLm+Njad+oAOLRbNk4TYyVv4h+aWHO2f3P3V0I4lygu5i5fq8HJOHQne
         K9R68n27kblGHu3S+7m0I4Ei2Awai7N6U1M3PZdfs5vu1qNu0uiqL+O5hcgPmLQbYawC
         PAhVghj+16w7Bkjc34W79aNsWfjzNoQK4SmReB5veT0TAaSwIhmQBTu9RtqgUepM9wDr
         VYNX+MuMT7qzGlTS1hVFc0HWIUEYtP1V7pvGJVQemqwJ6thXnwAzVxHjy/cRIFbiVIky
         E47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OPjQ8wdwz1GEb8wS94mL9Pue/O6MN6Uk9Vek3ZY7+xU=;
        b=YPRttVYoN/lrgy+jKzp7DlNg1HvDGszy/YJq7rfccmvmcSRc9++FNXV7lTyyIUL/7+
         uThWVrB4bN0S7c+Wb2pFK7LxO1HjVcTTcHncQzK18552tiV6oBofhBOsnt6TrQV2cG/P
         KzD1wIv8Tx7ji5Hm2rBVJS8j4Bu6SKp5Zl/vZ/pl66qUPP7peBa6r037OmumZqkHWsOu
         pg9Yi9GsdNztNIw13aG8t/N3VKgALD21+6miz6K3rbTWAy/RlEpR4UZfrXpPnxl2QV+S
         NlxjwKicuWrTVIUPdY3FmttbUNL0p42sRHjA/IqVeEmL/DEZOgmqxvPIQMwR5GkwFEvQ
         QxDQ==
X-Gm-Message-State: APjAAAUYKncdT/Ni6pKK/QeNxAlDBs3fIq4xlhD97TF7NFpnMA6f9tjN
        v5A+abzVCxMsaNbp3kcPrUBG0XhTkm/JAA==
X-Google-Smtp-Source: APXvYqyvPMxwSYunyztp1e5VSh4x6Zqkrf7E/PJpGqqGAMI1f7aHClisP3cOxjKCZJI6oLkNmZSQnA==
X-Received: by 2002:ac2:418c:: with SMTP id z12mr6423959lfh.183.1570117648670;
        Thu, 03 Oct 2019 08:47:28 -0700 (PDT)
Received: from [192.168.43.113] ([95.153.133.129])
        by smtp.gmail.com with ESMTPSA id j26sm597474lja.25.2019.10.03.08.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 08:47:27 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext2fs: add ext2fs_read_sb that returns superblock
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <20190905110110.32627-1-c17828@cray.com>
Date:   Thu, 3 Oct 2019 18:47:21 +0300
Cc:     adilger.kernel@dilger.ca
Content-Transfer-Encoding: quoted-printable
Message-Id: <1B7DFCD4-F274-4A7A-B7FC-04566308322F@gmail.com>
References: <20190905110110.32627-1-c17828@cray.com>
To:     linux-ext4 <linux-ext4@vger.kernel.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Does anybody wants to give any feedback for this?
e2label became really faster on large partitions with this patch. =
Probably it can be useful.

Ted, what do you think?

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

