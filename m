Return-Path: <linux-ext4+bounces-10228-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C89EAB7CED6
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 14:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CF41BC31E3
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 06:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57F8244681;
	Wed, 17 Sep 2025 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="mv6Z3jY3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D58B823DD
	for <linux-ext4@vger.kernel.org>; Wed, 17 Sep 2025 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089762; cv=none; b=C2ouE9aIOREm4rxhhpCsBdvgGTJluHwRbdrgELYrsp5oR6L2C6P2aGNS/n0UzzDMIFvxFheUEtqSaUcrhqZWGcj5MEktLwVRR2bVJW3y6t/+kd+2A55aU3hy8AvlP3oPMsgYXieTgegGS6Rpo6UYwUJx91Ly0IFSnSZ4SuNXUxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089762; c=relaxed/simple;
	bh=zQb+Jr32bhudRNP0qqZ1e3LHYGdjkczwc3rsuol2ZZQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=YViW+5wCRMKpfpOgXTS6gka7fbqmXDQEzoe+fj0lCYXn6sP6SXzLXHRVzXR1TcSpKIUSgrvoVJPARPw4G/Vkz10zzI52kJahpPmk4AaNBe3R5lmX+Fv2HpTHglKhwoe60QQzkyqY/w+h+yLKXAGPgR+BlvXCjncKq84Q13oWUpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=mv6Z3jY3; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4c3d8bd21eso4087007a12.2
        for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 23:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1758089758; x=1758694558; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJ9dC1UPtrL0lkBIR/ocUamoadJwQpZNedRF4DiXd4c=;
        b=mv6Z3jY3smzxlz061moGRxfQw17j+pF9XB3Chbs0xPuYSJe9pr0uMjfFLH6aCBHvE0
         2/NzbwlawXUxA0qKFghB4+6mRb4fdT2t40gUx+WhlPIPP/p/Ldi1K+QNJ8GSk25nML2k
         vTrAqhce+IY6Ib49Ft2FSjBMwQBU9otqK0+/W2uUITqnunCjbE76nYnaGOCFNfd41ACm
         shEVY998VWe8H2520t3dyLfrFyp5KqtD6sywJ371qrEjxL5JZ0U1pCJaPwFmBc+XzEkU
         3c+zo/8vk/0EbTjFMGHHJLRqCje8TwqoaRsCPagJD4J/ITrLaUlZiZ1zeI99uHZefENO
         73Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758089758; x=1758694558;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJ9dC1UPtrL0lkBIR/ocUamoadJwQpZNedRF4DiXd4c=;
        b=OSApzKbYUOePUIw3S7N6ceOjqwav24lslecONUeTTu7N2YOpRXTQAxeoIr+QTDeH7s
         dkKQjwMWU8jWP/VmwhBrhPlmdmShfWBp3m9lcU0b1FYfjtu89fKLAWlvcBL10lOSkem9
         38+2rtg4bOc1OTjOGjY8VleSXO5uIsEGwwbf1NbxvF0GjJXxuKkz8YAb9cKa2V36+DV9
         E4j1T91c5TBw0Bb6KbnMtwo2y3ixtvtEucTARVrJ6HssQGjYt2IBAPT2dWDNrL8eNHPe
         cmua2WB8t3bUdOhxRK/FL7S9kPsjgEEFSupM2NF2/BbMAzd+b0RR7rAUbQgv0v5yB0Zi
         CZjw==
X-Gm-Message-State: AOJu0YxJ/4D1n6Zv4M3AOFs4uTl64+A2oS1R1ddXBpYItO3kyQMi8Bow
	cGjm6eN6Cfs42UZY/SKBpecV3eTG/+2BtUjoPgWTvTEPlClGQIWfQy08nU+hHvewbyBVtQ/X+ur
	xITWX
X-Gm-Gg: ASbGncvVTV8xOO7lMydgP3RfmkUlQ0gXo6wa9u8mh9UewjKNZUFIsvIql/Guk/szz3u
	CatwRXUdXzlAV0H5Dl5LLaOYs2iiDKwVjauhJQ+S3f3OmZLDe2m6cyyakr8iJxPzdPSNOrxowgY
	dcTKj/9Z4nEwAUR/SFllY7qvXAJJDYz9+Lckb0PUKstQa4iV5DfD2EeqyDhOxohfQmtoFqjL4qk
	MV5bYGmYfHVW90k3zIU9GYgFDhdOQcTpRRZOKMn7R7ylq9mLh96IUcSQKrQzAgAi5FpGJ4JsQ9p
	BcPv7m78kSG3zN/I91wPv3QHuQcrqYd1qLTdeet5p3he4jXIcP4bz5ck6NlbFFZj8h3cqvD3eNQ
	6PaF39Ek1FJlHG51Qt7RafF0O313suOwtqofSc1N/1mUPJh82SPS+FX/VY4wJOk/qRRY5I+z6
X-Google-Smtp-Source: AGHT+IEilgxaWWrR4cMH1tKvlhZQPxdisHbTMir/bj86FVDHDn6o8NpsMSzhccNHeDw9T8qgPmDfgQ==
X-Received: by 2002:a17:902:db02:b0:267:cdb8:c683 with SMTP id d9443c01a7336-268123806c5mr11749355ad.27.1758089757832;
        Tue, 16 Sep 2025 23:15:57 -0700 (PDT)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-263741745d5sm103111675ad.94.2025.09.16.23.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 23:15:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andreas Dilger <adilger@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/3] tune2fs: rework parse_extended_opts() so it only parses the option string
Date: Wed, 17 Sep 2025 00:15:46 -0600
Message-Id: <4E28AA2D-F408-4155-83DE-A899545F355C@dilger.ca>
References: <20250917032814.395887-3-tytso@mit.edu>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Theodore Ts'o <tytso@mit.edu>
In-Reply-To: <20250917032814.395887-3-tytso@mit.edu>
To: Theodore Ts'o <tytso@mit.edu>
X-Mailer: iPhone Mail (22G100)

On Sep 16, 2025, at 21:28, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> =EF=BB=BFThe parse_extended_opts() was doing two things: interpreting the
> string passed into the command line and modifying the file system's
> superblock.  Separate out the file system modification and move it out
> from parse_extended_opts().
>=20
> This allows the user to specify more than one -E command-line option,
> and it also allows some of the file system changes to be modified via
> an ioctl for a mounted file system.
>=20
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
> misc/tune2fs.c | 211 +++++++++++++++++++++++++++----------------------
> 1 file changed, 118 insertions(+), 93 deletions(-)
>=20
> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> index 1b3716e1..e752c328 100644
> --- a/misc/tune2fs.c
> +++ b/misc/tune2fs.c
> @@ -123,8 +123,19 @@ extern int ask_yn(const char *string, int def);
> #define OPT_JOURNAL_OPTS    18
> #define OPT_MNTOPTS        19
> #define OPT_FEATURES        20
> -#define OPT_EXTENDED_CMD    21
> -#define MAX_OPTS        22
> +#define OPT_CLEAR_MMP        21
> +#define OPT_MMP_INTERVAL    22
> +#define OPT_FORCE_FSCK        23
> +#define OPT_TEST_FS        24
> +#define OPT_CLEAR_TEST_FS    25
> +#define OPT_RAID_STRIDE        26
> +#define OPT_RAID_STRIPE_WIDTH    27
> +#define OPT_HASH_ALG        28
> +#define OPT_MOUNT_OPTS        29
> +#define OPT_ENCODING        30
> +#define OPT_ENCODING_FLAGS    31
> +#define OPT_ORPHAN_FILE_SIZE    32
> +#define MAX_OPTS        33

This looks like it should be an enum?

Cheers, Andreas

> static bool opts[MAX_OPTS];
>=20
> const char *program_name =3D "tune2fs";
> @@ -132,7 +143,6 @@ char *device_name;
> char *new_label, *new_last_mounted, *requested_uuid;
> char *io_options;
> static int force, do_list_super, sparse_value =3D -1;
> -static int clear_mmp;
> static time_t last_check_time;
> static int max_mount_count, mount_count, mount_flags;
> static unsigned long interval;
> @@ -140,12 +150,16 @@ static blk64_t reserved_blocks;
> static double reserved_ratio;
> static unsigned long resgid, resuid;
> static unsigned short errors;
> +static unsigned long mmp_interval;
> +static int hash_alg;
> +static char *hash_alg_str;
> +static int encoding;
> +static __u16 encoding_flags;
> +static char *encoding_str, *encoding_flags_str;
> static int open_flag;
> static char *features_cmd;
> static char *mntopts_cmd;
> static int stride, stripe_width;
> -static int stride_set, stripe_width_set;
> -static char *extended_cmd;
> static unsigned long new_inode_size;
> static char *ext_mount_opts;
> static int quota_enable[MAXQUOTAS];
> @@ -153,7 +167,6 @@ static int rewrite_checksums;
> static int feature_64bit;
> static int fsck_requested;
> static char *undo_file;
> -int enabling_casefold;
>=20
> int journal_size, journal_fc_size, journal_flags;
> char *journal_device;
> @@ -184,6 +197,8 @@ void do_findfs(int argc, char **argv);
> int journal_enable_debug =3D -1;
> #endif
>=20
> +static int parse_extended_opts(const char *ext_opts);
> +
> static void usage(void)
> {
>    fprintf(stderr,
> @@ -1645,7 +1660,6 @@ mmp_error:
>        }
>        fs->super->s_encoding =3D EXT4_ENC_UTF8_12_1;
>        fs->super->s_encoding_flags =3D e2p_get_encoding_flags(EXT4_ENC_UTF8=
_12_1);
> -        enabling_casefold =3D 1;
>    }
>=20
>    if (FEATURE_OFF(E2P_FEATURE_INCOMPAT, EXT4_FEATURE_INCOMPAT_CASEFOLD)) {=

> @@ -1661,7 +1675,6 @@ mmp_error:
>        }
>        fs->super->s_encoding =3D 0;
>        fs->super->s_encoding_flags =3D 0;
> -        enabling_casefold =3D 0;
>    }
>=20
>    if (FEATURE_ON(E2P_FEATURE_INCOMPAT,
> @@ -2066,8 +2079,8 @@ static void parse_tune2fs_options(int argc, char **a=
rgv)
>            }
>            break;
>        case 'E':
> -            opts[OPT_EXTENDED_CMD] =3D true;
> -            extended_cmd =3D optarg;
> +            if (parse_extended_opts(optarg))
> +                exit(1);
>            break;
>        case 'f': /* Force */
>            force++;
> @@ -2259,6 +2272,11 @@ static void parse_tune2fs_options(int argc, char **=
argv)
>            argv[optind]);
>        exit(1);
>    }
> +    if (opts[OPT_ENCODING_FLAGS] && !opts[OPT_ENCODING]) {
> +        fprintf(stderr, _("error: An encoding must be explicitly "
> +                  "specified when passing encoding-flags\n"));
> +        exit(1);
> +    }
> }
>=20
> #ifdef CONFIG_BUILD_FINDFS
> @@ -2282,23 +2300,22 @@ void do_findfs(int argc, char **argv)
> }
> #endif
>=20
> -static int parse_extended_opts(ext2_filsys fs, const char *opts)
> +#define member_size(type, member) (sizeof( ((type *)0)->member ))
> +
> +static int parse_extended_opts(const char *ext_opts)
> {
> -    struct ext2_super_block *sb =3D fs->super;
>    char    *buf, *token, *next, *p, *arg;
> -    int    len, hash_alg;
> +    int    len;
>    int    r_usage =3D 0;
> -    int encoding =3D 0;
> -    char    *encoding_flags =3D NULL;
>=20
> -    len =3D strlen(opts);
> +    len =3D strlen(ext_opts);
>    buf =3D malloc(len+1);
>    if (!buf) {
>        fprintf(stderr, "%s",
>            _("Couldn't allocate memory to parse options!\n"));
>        return 1;
>    }
> -    strcpy(buf, opts);
> +    strcpy(buf, ext_opts);
>    for (token =3D buf; token && *token; token =3D next) {
>        p =3D strchr(token, ',');
>        next =3D 0;
> @@ -2313,14 +2330,13 @@ static int parse_extended_opts(ext2_filsys fs, con=
st char *opts)
>        }
>        if (strcmp(token, "clear-mmp") =3D=3D 0 ||
>            strcmp(token, "clear_mmp") =3D=3D 0) {
> -            clear_mmp =3D 1;
> +            opts[OPT_CLEAR_MMP] =3D true;
>        } else if (strcmp(token, "mmp_update_interval") =3D=3D 0) {
> -            unsigned long intv;
>            if (!arg) {
>                r_usage++;
>                continue;
>            }
> -            intv =3D strtoul(arg, &p, 0);
> +            mmp_interval =3D strtoul(arg, &p, 0);
>            if (*p) {
>                fprintf(stderr,
>                    _("Invalid mmp_update_interval: %s\n"),
> @@ -2328,34 +2344,22 @@ static int parse_extended_opts(ext2_filsys fs, con=
st char *opts)
>                r_usage++;
>                continue;
>            }
> -            if (intv =3D=3D 0) {
> -                intv =3D EXT4_MMP_UPDATE_INTERVAL;
> -            } else if (intv > EXT4_MMP_MAX_UPDATE_INTERVAL) {
> +            if (mmp_interval =3D=3D 0) {
> +                mmp_interval =3D EXT4_MMP_UPDATE_INTERVAL;
> +            } else if (mmp_interval > EXT4_MMP_MAX_UPDATE_INTERVAL) {
>                fprintf(stderr,
>                    _("mmp_update_interval too big: %lu\n"),
> -                    intv);
> +                    mmp_interval);
>                r_usage++;
>                continue;
>            }
> -            printf(P_("Setting multiple mount protection update "
> -                  "interval to %lu second\n",
> -                  "Setting multiple mount protection update "
> -                  "interval to %lu seconds\n", intv),
> -                   intv);
> -            sb->s_mmp_update_interval =3D intv;
> -            ext2fs_mark_super_dirty(fs);
> +            opts[OPT_MMP_INTERVAL] =3D true;
>        } else if (!strcmp(token, "force_fsck")) {
> -            sb->s_state |=3D EXT2_ERROR_FS;
> -            printf(_("Setting filesystem error flag to force fsck.\n"));
> -            ext2fs_mark_super_dirty(fs);
> +            opts[OPT_FORCE_FSCK] =3D true;
>        } else if (!strcmp(token, "test_fs")) {
> -            sb->s_flags |=3D EXT2_FLAGS_TEST_FILESYS;
> -            printf("Setting test filesystem flag\n");
> -            ext2fs_mark_super_dirty(fs);
> +            opts[OPT_TEST_FS] =3D true;
>        } else if (!strcmp(token, "^test_fs")) {
> -            sb->s_flags &=3D ~EXT2_FLAGS_TEST_FILESYS;
> -            printf("Clearing test filesystem flag\n");
> -            ext2fs_mark_super_dirty(fs);
> +            opts[OPT_CLEAR_TEST_FS] =3D true;
>        } else if (strcmp(token, "stride") =3D=3D 0) {
>            if (!arg) {
>                r_usage++;
> @@ -2369,7 +2373,7 @@ static int parse_extended_opts(ext2_filsys fs, const=
 char *opts)
>                r_usage++;
>                continue;
>            }
> -            stride_set =3D 1;
> +            opts[OPT_RAID_STRIDE] =3D true;
>        } else if (strcmp(token, "stripe-width") =3D=3D 0 ||
>               strcmp(token, "stripe_width") =3D=3D 0) {
>            if (!arg) {
> @@ -2384,7 +2388,7 @@ static int parse_extended_opts(ext2_filsys fs, const=
 char *opts)
>                r_usage++;
>                continue;
>            }
> -            stripe_width_set =3D 1;
> +            opts[OPT_RAID_STRIPE_WIDTH] =3D true;
>        } else if (strcmp(token, "hash_alg") =3D=3D 0 ||
>               strcmp(token, "hash-alg") =3D=3D 0) {
>            if (!arg) {
> @@ -2399,21 +2403,21 @@ static int parse_extended_opts(ext2_filsys fs, con=
st char *opts)
>                r_usage++;
>                continue;
>            }
> -            sb->s_def_hash_version =3D hash_alg;
> -            printf(_("Setting default hash algorithm "
> -                 "to %s (%d)\n"),
> -                   arg, hash_alg);
> -            ext2fs_mark_super_dirty(fs);
> +            hash_alg_str =3D strdup(arg);
> +            opts[OPT_HASH_ALG] =3D true;
>        } else if (!strcmp(token, "mount_opts")) {
>            if (!arg) {
>                r_usage++;
>                continue;
>            }
> -            if (strlen(arg) >=3D sizeof(fs->super->s_mount_opts)) {
> +            if (strlen(arg) >=3D
> +                member_size(struct ext2_super_block,
> +                    s_mount_opts)) {
>                fprintf(stderr,
>                    "Extended mount options too long\n");
>                continue;
>            }
> +            opts[OPT_MOUNT_OPTS] =3D true;
>            ext_mount_opts =3D strdup(arg);
>        } else if (!strcmp(token, "encoding")) {
>            if (!arg) {
> @@ -2426,36 +2430,33 @@ static int parse_extended_opts(ext2_filsys fs, con=
st char *opts)
>                r_usage++;
>                continue;
>            }
> -            if (ext2fs_has_feature_casefold(sb) && !enabling_casefold) {
> -                fprintf(stderr, _("Cannot alter existing encoding\n"));
> -                r_usage++;
> -                continue;
> -            }
>            encoding =3D e2p_str2encoding(arg);
>            if (encoding < 0) {
>                fprintf(stderr, _("Invalid encoding: %s\n"), arg);
>                r_usage++;
>                continue;
>            }
> -            enabling_casefold =3D 1;
> -            sb->s_encoding =3D encoding;
> -            printf(_("Setting encoding to '%s'\n"), arg);
> -            sb->s_encoding_flags =3D
> -                e2p_get_encoding_flags(sb->s_encoding);
> +            encoding_str =3D strdup(arg);
> +            opts[OPT_ENCODING] =3D true;
>        } else if (!strcmp(token, "encoding_flags")) {
>            if (!arg) {
>                r_usage++;
>                continue;
>            }
> -            encoding_flags =3D arg;
> +            if (e2p_str2encoding_flags(EXT4_ENC_UTF8_12_1,
> +                           arg, &encoding_flags)) {
> +                fprintf(stderr,
> +        _("error: Invalid encoding flag: %s\n"), arg);
> +                r_usage++;
> +            }
> +            encoding_flags_str =3D strdup(arg);
> +            opts[OPT_ENCODING_FLAGS] =3D true;
>        } else if (!strcmp(token, "orphan_file_size")) {
>            if (!arg) {
>                r_usage++;
>                continue;
>            }
> -            orphan_file_blocks =3D parse_num_blocks2(arg,
> -                         fs->super->s_log_block_size);
> -
> +            orphan_file_blocks =3D parse_num_blocks2(arg, 0);
>            if (orphan_file_blocks < 1) {
>                fprintf(stderr,
>                    _("Invalid size of orphan file %s\n"),
> @@ -2463,30 +2464,10 @@ static int parse_extended_opts(ext2_filsys fs, con=
st char *opts)
>                r_usage++;
>                continue;
>            }
> +            opts[OPT_ORPHAN_FILE_SIZE] =3D true;
>        } else
>            r_usage++;
>    }
> -
> -    if (encoding > 0 && !r_usage) {
> -        sb->s_encoding_flags =3D
> -            e2p_get_encoding_flags(sb->s_encoding);
> -
> -        if (encoding_flags &&
> -            e2p_str2encoding_flags(sb->s_encoding, encoding_flags,
> -                       &sb->s_encoding_flags)) {
> -            fprintf(stderr, _("error: Invalid encoding flag: %s\n"),
> -                    encoding_flags);
> -            r_usage++;
> -        } else if (encoding_flags)
> -            printf(_("Setting encoding_flags to '%s'\n"),
> -                 encoding_flags);
> -        ext2fs_set_feature_casefold(sb);
> -        ext2fs_mark_super_dirty(fs);
> -    } else if (encoding_flags && !r_usage) {
> -        fprintf(stderr, _("error: An encoding must be explicitly "
> -                  "specified when passing encoding-flags\n"));
> -        r_usage++;
> -    }
>    if (r_usage) {
>        fprintf(stderr, "%s", _("\nBad options specified.\n\n"
>            "Extended options are separated by commas, "
> @@ -3518,27 +3499,64 @@ _("Warning: The journal is dirty. You may wish to r=
eplay the journal like:\n\n"
>        if (rc)
>            goto closefs;
>    }
> +    if (ext2fs_has_feature_casefold(sb) && opts[OPT_ENCODING]) {
> +        fprintf(stderr, _("Cannot alter existing encoding\n"));
> +        rc =3D 1;
> +        goto closefs;
> +    }
>    if (features_cmd) {
>        rc =3D update_feature_set(fs, features_cmd);
>        if (rc)
>            goto closefs;
>    }
> -    if (extended_cmd) {
> -        rc =3D parse_extended_opts(fs, extended_cmd);
> -        if (rc)
> -            goto closefs;
> -        if (clear_mmp && !force) {
> +    if (opts[OPT_CLEAR_MMP]) {
> +        if (!force) {
>            fputs(_("Error in using clear_mmp. "
>                "It must be used with -f\n"),
>                  stderr);
>            rc =3D 1;
>            goto closefs;
>        }
> -    }
> -    if (clear_mmp) {
>        rc =3D ext2fs_mmp_clear(fs);
>        goto closefs;
>    }
> +    if (opts[OPT_MMP_INTERVAL]) {
> +        printf(P_("Setting multiple mount protection update "
> +              "interval to %lu second\n",
> +              "Setting multiple mount protection update "
> +              "interval to %lu seconds\n", mmp_interval),
> +               mmp_interval);
> +        sb->s_mmp_update_interval =3D mmp_interval;
> +        ext2fs_mark_super_dirty(fs);
> +    }
> +    if (opts[OPT_FORCE_FSCK]) {
> +        sb->s_state |=3D EXT2_ERROR_FS;
> +        printf(_("Setting filesystem error flag to force fsck.\n"));
> +        ext2fs_mark_super_dirty(fs);
> +    }
> +    if (opts[OPT_TEST_FS]) {
> +        sb->s_flags |=3D EXT2_FLAGS_TEST_FILESYS;
> +        printf("Setting test filesystem flag\n");
> +        ext2fs_mark_super_dirty(fs);
> +    }
> +    if (opts[OPT_CLEAR_TEST_FS]) {
> +        sb->s_flags &=3D ~EXT2_FLAGS_TEST_FILESYS;
> +        printf("Clearing test filesystem flag\n");
> +        ext2fs_mark_super_dirty(fs);
> +    }
> +    if (opts[OPT_ENCODING]) {
> +        ext2fs_set_feature_casefold(sb);
> +        sb->s_encoding =3D encoding;
> +        printf(_("Setting encoding to '%s'\n"), encoding_str);
> +        if (opts[OPT_ENCODING_FLAGS]) {
> +            sb->s_encoding_flags =3D encoding_flags;
> +            printf(_("Setting encoding_flags to '%s'\n"),
> +                   encoding_flags_str);
> +        } else
> +            sb->s_encoding_flags =3D
> +                e2p_get_encoding_flags(sb->s_encoding);
> +            ext2fs_mark_super_dirty(fs);
> +    }
>    if (journal_size || journal_device) {
>        rc =3D add_journal(fs);
>        if (rc)
> @@ -3554,6 +3572,7 @@ _("Warning: The journal is dirty. You may wish to re=
play the journal like:\n\n"
>            rc =3D 1;
>            goto closefs;
>        }
> +        orphan_file_blocks >>=3D fs->super->s_log_block_size;
>        err =3D ext2fs_create_orphan_file(fs, orphan_file_blocks);
>        if (err) {
>            com_err(program_name, err, "%s",
> @@ -3764,17 +3783,23 @@ _("Warning: The journal is dirty. You may wish to r=
eplay the journal like:\n\n"
>=20
>    if (do_list_super)
>        list_super(sb);
> -    if (stride_set) {
> +    if (opts[OPT_RAID_STRIDE]) {
>        sb->s_raid_stride =3D stride;
>        ext2fs_mark_super_dirty(fs);
>        printf(_("Setting stride size to %d\n"), stride);
>    }
> -    if (stripe_width_set) {
> +    if (opts[OPT_RAID_STRIPE_WIDTH]) {
>        sb->s_raid_stripe_width =3D stripe_width;
>        ext2fs_mark_super_dirty(fs);
>        printf(_("Setting stripe width to %d\n"), stripe_width);
>    }
> -    if (ext_mount_opts) {
> +    if (opts[OPT_HASH_ALG]) {
> +        sb->s_def_hash_version =3D hash_alg;
> +        printf(_("Setting default hash algorithm to %s (%d)\n"),
> +               hash_alg_str, hash_alg);
> +        ext2fs_mark_super_dirty(fs);
> +    }
> +    if (opts[OPT_MOUNT_OPTS]) {
>        strncpy((char *)(fs->super->s_mount_opts), ext_mount_opts,
>            sizeof(fs->super->s_mount_opts));
>        fs->super->s_mount_opts[sizeof(fs->super->s_mount_opts)-1] =3D 0;
> --
> 2.51.0
>=20
>=20

