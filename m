Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2761033EF4C
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Mar 2021 12:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhCQLLr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Mar 2021 07:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhCQLLp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Mar 2021 07:11:45 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23610C06174A
        for <linux-ext4@vger.kernel.org>; Wed, 17 Mar 2021 04:11:45 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u4so2606767ljo.6
        for <linux-ext4@vger.kernel.org>; Wed, 17 Mar 2021 04:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rva6DsjqQvOESWdLXJeKkbdjep6wSBLR8B12EeFuy48=;
        b=e7GegjgVR9Dp5aPiq31P5itiZi9+nCaAgqeN3tSpPVhbczvquAb35MlZK1dn+3skpw
         Iu82UYUH253SY/NC+OWgxff/eDUKItZNMv5FZOaKrVJx3k0n6EMd1rtHk4C7aXMrhsmp
         q6/GgxvkXZQfa1F1dObxOxGyPLHxj8HizZXHzeJlIk2ZH+63Bd3Q5WuZ5YB90Ymmhz38
         ZAXOaS4R+Q6vSRAymDfdiSE0R2662NG3vdVZnmkZZ+2rrj5RvZPm4fmI/u4AMleDlqvn
         BKW7qlPiNLT5ribHd6woFRt+CeAi3IbGDVDutZcyHbjSFq9CNKCT++rr1350IZ4D7G6A
         NJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rva6DsjqQvOESWdLXJeKkbdjep6wSBLR8B12EeFuy48=;
        b=kqspB3GdGpl2T15ouvxr4LCyHD0VjL3tuxV/uBO2Oim/ZinV9C7LdyPnvtfgdI4AHA
         SYNXVy2UGCbQJYURcLekaJMQ43yzmMpdBBqhk0Rew+qxS8avJJzkGMOU3i9bzJcjHrAN
         4CEsJ7lBYMqtpJMrIFg2QMO2kf6y4BPbaZUy4v3CFYS2sw9APsIW/HneWJaJWCKM7unf
         9RWzOUNkMzhN+15V9XHlsbWgHkLbFOdIR6KnCfUviawAAlMtTIqvaZfbQb+LjJoXAFrH
         4pKArScSs+pR/ppY+DYyp7AQegl4GaHdocrkiMMO/BQ6iMuZYRpoZVQK5aLCJJGSGomC
         ziAw==
X-Gm-Message-State: AOAM533dDDI2YP4pCFNJ+X2DvIi12bOSe7zDqtxzET3jvqk79SmlogD6
        SgeW01mqQpxgzKo7lZiJhtrqubQLntO/XtoP
X-Google-Smtp-Source: ABdhPJwvPYlgXCTsHFI+z5tnfvwVDrvDDPI1e5bITjxVKejVxadrnVpvMnGY1zq9thO9lVzcssKMmw==
X-Received: by 2002:a2e:b0f2:: with SMTP id h18mr2000123ljl.396.1615979503493;
        Wed, 17 Mar 2021 04:11:43 -0700 (PDT)
Received: from [192.168.43.113] ([95.153.135.74])
        by smtp.gmail.com with ESMTPSA id l30sm3359419lfp.221.2021.03.17.04.11.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Mar 2021 04:11:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [PATCH v4 2/6] ext4: add ability to return parsed options from
 parse_options
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <20210315173716.360726-3-harshadshirwadkar@gmail.com>
Date:   Wed, 17 Mar 2021 14:11:40 +0300
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Content-Transfer-Encoding: quoted-printable
Message-Id: <DF664098-1DA0-4F18-9E55-FA935C48F6E0@gmail.com>
References: <20210315173716.360726-1-harshadshirwadkar@gmail.com>
 <20210315173716.360726-3-harshadshirwadkar@gmail.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3445.104.17)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Harshad,

Thank you for a new patchiest.

One comment bellow.

> On 15 Mar 2021, at 20:37, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> Before this patch, the function parse_options() was returning
> journal_devnum and journal_ioprio variables to the caller. This patch
> generalizes that interface to allow parse_options to return any parsed
> options to return back to the caller. In this patch series, it gets
> used to capture the value of "mb_optimize_scan=3D%u" mount option.
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
> fs/ext4/super.c | 50 ++++++++++++++++++++++++++++---------------------
> 1 file changed, 29 insertions(+), 21 deletions(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 071d131fadd8..0491e7a6b04c 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2089,9 +2089,14 @@ static int =
ext4_set_test_dummy_encryption(struct super_block *sb,
> 	return 1;
> }
>=20
> +struct ext4_parsed_options {
> +	unsigned long journal_devnum;
> +	unsigned int journal_ioprio;
> +};
> +
> static int handle_mount_opt(struct super_block *sb, char *opt, int =
token,
> -			    substring_t *args, unsigned long =
*journal_devnum,
> -			    unsigned int *journal_ioprio, int =
is_remount)
> +			    substring_t *args, struct =
ext4_parsed_options *parsed_opts,
> +			    int is_remount)
> {
> 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> 	const struct mount_opts *m;
> @@ -2248,7 +2253,7 @@ static int handle_mount_opt(struct super_block =
*sb, char *opt, int token,
> 				 "Cannot specify journal on remount");
> 			return -1;
> 		}
> -		*journal_devnum =3D arg;
> +		parsed_opts->journal_devnum =3D arg;
> 	} else if (token =3D=3D Opt_journal_path) {
> 		char *journal_path;
> 		struct inode *journal_inode;
> @@ -2284,7 +2289,7 @@ static int handle_mount_opt(struct super_block =
*sb, char *opt, int token,
> 			return -1;
> 		}
>=20
> -		*journal_devnum =3D =
new_encode_dev(journal_inode->i_rdev);
> +		parsed_opts->journal_devnum =3D =
new_encode_dev(journal_inode->i_rdev);
> 		path_put(&path);
> 		kfree(journal_path);
> 	} else if (token =3D=3D Opt_journal_ioprio) {
> @@ -2293,7 +2298,7 @@ static int handle_mount_opt(struct super_block =
*sb, char *opt, int token,
> 				 " (must be 0-7)");
> 			return -1;
> 		}
> -		*journal_ioprio =3D
> +		parsed_opts->journal_ioprio =3D
> 			IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, arg);
> 	} else if (token =3D=3D Opt_test_dummy_encryption) {
> 		return ext4_set_test_dummy_encryption(sb, opt, &args[0],
> @@ -2410,8 +2415,7 @@ static int handle_mount_opt(struct super_block =
*sb, char *opt, int token,
> }
>=20
> static int parse_options(char *options, struct super_block *sb,
> -			 unsigned long *journal_devnum,
> -			 unsigned int *journal_ioprio,
> +			 struct ext4_parsed_options *ret_opts,
> 			 int is_remount)
> {
> 	struct ext4_sb_info __maybe_unused *sbi =3D EXT4_SB(sb);
> @@ -2431,8 +2435,8 @@ static int parse_options(char *options, struct =
super_block *sb,
> 		 */
> 		args[0].to =3D args[0].from =3D NULL;
> 		token =3D match_token(p, tokens, args);
> -		if (handle_mount_opt(sb, p, token, args, journal_devnum,
> -				     journal_ioprio, is_remount) < 0)
> +		if (handle_mount_opt(sb, p, token, args, ret_opts,
> +				     is_remount) < 0)
> 			return 0;
> 	}
> #ifdef CONFIG_QUOTA
> @@ -4014,7 +4018,6 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> 	ext4_fsblk_t sb_block =3D get_sb_block(&data);
> 	ext4_fsblk_t logical_sb_block;
> 	unsigned long offset =3D 0;
> -	unsigned long journal_devnum =3D 0;
> 	unsigned long def_mount_opts;
> 	struct inode *root;
> 	const char *descr;
> @@ -4025,8 +4028,12 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> 	int needs_recovery, has_huge_files;
> 	__u64 blocks_count;
> 	int err =3D 0;
> -	unsigned int journal_ioprio =3D DEFAULT_JOURNAL_IOPRIO;
> 	ext4_group_t first_not_zeroed;
> +	struct ext4_parsed_options parsed_opts;
> +
> +	/* Set defaults for the variables that will be set during =
parsing */
> +	parsed_opts.journal_ioprio =3D DEFAULT_JOURNAL_IOPRIO;
> +	parsed_opts.journal_devnum =3D 0;
>=20
> 	if ((data && !orig_data) || !sbi)
> 		goto out_free_base;
> @@ -4272,8 +4279,7 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> 					      GFP_KERNEL);
> 		if (!s_mount_opts)
> 			goto failed_mount;
> -		if (!parse_options(s_mount_opts, sb, &journal_devnum,
> -				   &journal_ioprio, 0)) {
> +		if (!parse_options(s_mount_opts, sb, &parsed_opts, 0)) {
> 			ext4_msg(sb, KERN_WARNING,
> 				 "failed to parse options in superblock: =
%s",
> 				 s_mount_opts);
> @@ -4281,8 +4287,7 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> 		kfree(s_mount_opts);
> 	}
> 	sbi->s_def_mount_opt =3D sbi->s_mount_opt;
> -	if (!parse_options((char *) data, sb, &journal_devnum,
> -			   &journal_ioprio, 0))
> +	if (!parse_options((char *) data, sb, &parsed_opts, 0))
> 		goto failed_mount;
>=20
> #ifdef CONFIG_UNICODE
> @@ -4773,7 +4778,7 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> 	 * root first: it may be modified in the journal!
> 	 */
> 	if (!test_opt(sb, NOLOAD) && ext4_has_feature_journal(sb)) {
> -		err =3D ext4_load_journal(sb, es, journal_devnum);
> +		err =3D ext4_load_journal(sb, es, =
parsed_opts.journal_devnum);
> 		if (err)
> 			goto failed_mount3a;
> 	} else if (test_opt(sb, NOLOAD) && !sb_rdonly(sb) &&
> @@ -4873,7 +4878,7 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> 		goto failed_mount_wq;
> 	}
>=20
> -	set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
> +	set_task_ioprio(sbi->s_journal->j_task, =
parsed_opts.journal_ioprio);
>=20
> 	sbi->s_journal->j_submit_inode_data_buffers =3D
> 		ext4_journal_submit_inode_data_buffers;
> @@ -5808,13 +5813,15 @@ static int ext4_remount(struct super_block =
*sb, int *flags, char *data)
> 	struct ext4_mount_options old_opts;
> 	int enable_quota =3D 0;
> 	ext4_group_t g;
> -	unsigned int journal_ioprio =3D DEFAULT_JOURNAL_IOPRIO;
> 	int err =3D 0;
> #ifdef CONFIG_QUOTA
> 	int i, j;
> 	char *to_free[EXT4_MAXQUOTAS];
> #endif
> 	char *orig_data =3D kstrdup(data, GFP_KERNEL);
> +	struct ext4_parsed_options parsed_opts;
> +
> +	parsed_opts.journal_ioprio =3D DEFAULT_JOURNAL_IOPRIO;

Why don=E2=80=99t you set "parsed_opts.journal_devnum =3D 0;" here too?

>=20
> 	if (data && !orig_data)
> 		return -ENOMEM;
> @@ -5845,7 +5852,8 @@ static int ext4_remount(struct super_block *sb, =
int *flags, char *data)
> 			old_opts.s_qf_names[i] =3D NULL;
> #endif
> 	if (sbi->s_journal && sbi->s_journal->j_task->io_context)
> -		journal_ioprio =3D =
sbi->s_journal->j_task->io_context->ioprio;
> +		parsed_opts.journal_ioprio =3D
> +			sbi->s_journal->j_task->io_context->ioprio;
>=20
> 	/*
> 	 * Some options can be enabled by ext4 and/or by VFS mount flag
> @@ -5855,7 +5863,7 @@ static int ext4_remount(struct super_block *sb, =
int *flags, char *data)
> 	vfs_flags =3D SB_LAZYTIME | SB_I_VERSION;
> 	sb->s_flags =3D (sb->s_flags & ~vfs_flags) | (*flags & =
vfs_flags);
>=20
> -	if (!parse_options(data, sb, NULL, &journal_ioprio, 1)) {
> +	if (!parse_options(data, sb, &parsed_opts, 1)) {
> 		err =3D -EINVAL;
> 		goto restore_opts;
> 	}
> @@ -5905,7 +5913,7 @@ static int ext4_remount(struct super_block *sb, =
int *flags, char *data)
>=20
> 	if (sbi->s_journal) {
> 		ext4_init_journal_params(sb, sbi->s_journal);
> -		set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
> +		set_task_ioprio(sbi->s_journal->j_task, =
parsed_opts.journal_ioprio);
> 	}
>=20
> 	/* Flush outstanding errors before changing fs state */
> --=20
> 2.31.0.rc2.261.g7f71774620-goog

Best regards,
Artem Blagodarenko

