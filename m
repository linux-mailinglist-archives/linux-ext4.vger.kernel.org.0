Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3546C2C7BA4
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Nov 2020 23:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgK2WNV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 Nov 2020 17:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgK2WNU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 Nov 2020 17:13:20 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971A6C0613CF
        for <linux-ext4@vger.kernel.org>; Sun, 29 Nov 2020 14:12:40 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b6so9171136pfp.7
        for <linux-ext4@vger.kernel.org>; Sun, 29 Nov 2020 14:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=taZDuk3EbIVGtpO1cWLSmGe/49Re3DQdoJRPPH+ENf8=;
        b=e2zxNTrop0t4e0NcpFYkUkStxf44yU+K4G4zgidC7LNzOuSHXgZ4Y7dnL45AP7ozmN
         5N/YxyqcJlHXe7jJxJssxuvvvJizrdcY4eCocKg4Yae/nHs35tsfsDIzlbb5cXYdV3ac
         hGAW/IKwkLSOQPeX0kTB4hUjh8KMXoYSXY041g+zBgfECp6surRgWVCc/lBNfkEKhuwK
         ATbYRXPPTWkQzfHJlk286iuLJbnKGAb//WyK/5MkI5CZkPZdKSrrV6g5O1zSHF1wRxPN
         YvBiWGrU4CFWDWWd0zvb4YCLA61fUMtge6+IbsqL/J4fSeQ28M/grxSEZreVxVOD0dOG
         ztmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=taZDuk3EbIVGtpO1cWLSmGe/49Re3DQdoJRPPH+ENf8=;
        b=aom0NC5gpjttTbm0X607CvoMOFKI+hrNgvyjwRrskk0Q/GVhTT6fFF9GmLMDDE9qCk
         BIvw3/32J7tzfav64kq+3CLD/IxLnEpD+f6jB4OhN93pmb4lzsvs3aJDxhYTtDv/u8Cb
         bQp8FDfem2SNgxH/EXct5QnGrgehk/nHvCZToufL7YyPXJxACHBRquy3uOZxqNo3N1W+
         yxkPhJ4sV7yeUxjG+PR/OW9dYtvMviRnFC8BVPc9QegfnKIPzkPC9d3POgOFVvybxt3I
         osLac26cgPqVkL8sPfNmSMOrvUurNmjUSJNWnvwBJQihrRe37ZaboJCun51pd8zCpGBJ
         3MRg==
X-Gm-Message-State: AOAM533a9r3xEmnu2s8yQ3wkbLIQS5hZndQ7gGO2dPMxCIV/sJOSsn1F
        xpUbQLGUhl11Qq6flfID5rtaCg==
X-Google-Smtp-Source: ABdhPJz5n36Z4TwbOeLCN8+k/5p90R4FPGI59QV8O1aFCLww6UQ6JarjxTaWNcYIsbFKOonxSO072g==
X-Received: by 2002:a65:4608:: with SMTP id v8mr3506782pgq.393.1606687960097;
        Sun, 29 Nov 2020 14:12:40 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id m9sm14119965pfh.94.2020.11.29.14.12.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Nov 2020 14:12:39 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <75D9FAE2-6CCC-49A7-8D29-0FDC197C96E8@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4F60D8A3-C724-4FC5-B08B-C4D73DCBC499";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 04/12] ext4: Make ext4_abort() use __ext4_error()
Date:   Sun, 29 Nov 2020 15:12:38 -0700
In-Reply-To: <20201127113405.26867-5-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jan Kara <jack@suse.cz>
References: <20201127113405.26867-1-jack@suse.cz>
 <20201127113405.26867-5-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_4F60D8A3-C724-4FC5-B08B-C4D73DCBC499
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 27, 2020, at 4:33 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> The only difference between __ext4_abort() and __ext4_error() is that
> the former one ignores errors=3Dcontinue mount option. Unify the code =
to
> reduce duplication.
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/ext4.h      | 29 ++++++++----------
> fs/ext4/ext4_jbd2.c |  4 +--
> fs/ext4/inode.c     |  2 +-
> fs/ext4/super.c     | 84 =
++++++++++++++---------------------------------------
> 4 files changed, 37 insertions(+), 82 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 65ecaf96d0a4..e67291c4a10b 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2952,9 +2952,9 @@ extern void =
ext4_mark_group_bitmap_corrupted(struct super_block *sb,
> 					     ext4_group_t block_group,
> 					     unsigned int flags);
>=20
> -extern __printf(6, 7)
> -void __ext4_error(struct super_block *, const char *, unsigned int, =
int, __u64,
> -		  const char *, ...);
> +extern __printf(7, 8)
> +void __ext4_error(struct super_block *, const char *, unsigned int, =
bool,
> +		  int, __u64, const char *, ...);
> extern __printf(6, 7)
> void __ext4_error_inode(struct inode *, const char *, unsigned int,
> 			ext4_fsblk_t, int, const char *, ...);
> @@ -2963,9 +2963,6 @@ void __ext4_error_file(struct file *, const char =
*, unsigned int, ext4_fsblk_t,
> 		     const char *, ...);
> extern void __ext4_std_error(struct super_block *, const char *,
> 			     unsigned int, int);
> -extern __printf(5, 6)
> -void __ext4_abort(struct super_block *, const char *, unsigned int, =
int,
> -		  const char *, ...);
> extern __printf(4, 5)
> void __ext4_warning(struct super_block *, const char *, unsigned int,
> 		    const char *, ...);
> @@ -2995,6 +2992,9 @@ void __ext4_grp_locked_error(const char *, =
unsigned int,
> #define EXT4_ERROR_FILE(file, block, fmt, a...)				=
\
> 	ext4_error_file((file), __func__, __LINE__, (block), (fmt), ## =
a)
>=20
> +#define ext4_abort(sb, err, fmt, a...)					=
\
> +	__ext4_error((sb), __func__, __LINE__, true, (err), 0, (fmt), ## =
a)
> +
> #ifdef CONFIG_PRINTK
>=20
> #define ext4_error_inode(inode, func, line, block, fmt, ...)		=
\
> @@ -3005,11 +3005,11 @@ void __ext4_grp_locked_error(const char *, =
unsigned int,
> #define ext4_error_file(file, func, line, block, fmt, ...)		=
\
> 	__ext4_error_file(file, func, line, block, fmt, ##__VA_ARGS__)
> #define ext4_error(sb, fmt, ...)					=
\
> -	__ext4_error((sb), __func__, __LINE__, 0, 0, (fmt), =
##__VA_ARGS__)
> +	__ext4_error((sb), __func__, __LINE__, false, 0, 0, (fmt),	=
\
> +		##__VA_ARGS__)
> #define ext4_error_err(sb, err, fmt, ...)				=
\
> -	__ext4_error((sb), __func__, __LINE__, (err), 0, (fmt), =
##__VA_ARGS__)
> -#define ext4_abort(sb, err, fmt, ...)					=
\
> -	__ext4_abort((sb), __func__, __LINE__, (err), (fmt), =
##__VA_ARGS__)
> +	__ext4_error((sb), __func__, __LINE__, false, (err), 0, (fmt),	=
\
> +		##__VA_ARGS__)
> #define ext4_warning(sb, fmt, ...)					=
\
> 	__ext4_warning(sb, __func__, __LINE__, fmt, ##__VA_ARGS__)
> #define ext4_warning_inode(inode, fmt, ...)				=
\
> @@ -3042,17 +3042,12 @@ do {							=
		\
> #define ext4_error(sb, fmt, ...)					=
\
> do {									=
\
> 	no_printk(fmt, ##__VA_ARGS__);					=
\
> -	__ext4_error(sb, "", 0, 0, 0, " ");				=
\
> +	__ext4_error(sb, "", 0, false, 0, 0, " ");			=
\
> } while (0)
> #define ext4_error_err(sb, err, fmt, ...)				=
\
> do {									=
\
> 	no_printk(fmt, ##__VA_ARGS__);					=
\
> -	__ext4_error(sb, "", 0, err, 0, " ");				=
\
> -} while (0)
> -#define ext4_abort(sb, err, fmt, ...)					=
\
> -do {									=
\
> -	no_printk(fmt, ##__VA_ARGS__);					=
\
> -	__ext4_abort(sb, "", 0, err, " ");				=
\
> +	__ext4_error(sb, "", 0, false, err, 0, " ");			=
\
> } while (0)
> #define ext4_warning(sb, fmt, ...)					=
\
> do {									=
\
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index 0fd0c42a4f7d..1a0a827a7f34 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -296,8 +296,8 @@ int __ext4_forget(const char *where, unsigned int =
line, handle_t *handle,
> 	if (err) {
> 		ext4_journal_abort_handle(where, line, __func__,
> 					  bh, handle, err);
> -		__ext4_abort(inode->i_sb, where, line, -err,
> -			   "error %d when attempting revoke", err);
> +		__ext4_error(inode->i_sb, where, line, true, -err, 0,
> +			     "error %d when attempting revoke", err);
> 	}
> 	BUFFER_TRACE(bh, "exit");
> 	return err;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 0d8385aea898..3a39fa0d6a3a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4610,7 +4610,7 @@ struct inode *__ext4_iget(struct super_block =
*sb, unsigned long ino,
> 	    (ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))) {
> 		if (flags & EXT4_IGET_HANDLE)
> 			return ERR_PTR(-ESTALE);
> -		__ext4_error(sb, function, line, EFSCORRUPTED, 0,
> +		__ext4_error(sb, function, line, false, EFSCORRUPTED, 0,
> 			     "inode #%lu: comm %s: iget: illegal inode =
#",
> 			     ino, current->comm);
> 		return ERR_PTR(-EFSCORRUPTED);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 61e6e5f156f3..dddaadc55475 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -662,16 +662,21 @@ static bool system_going_down(void)
>  * We'll just use the jbd2_journal_abort() error code to record an =
error in
>  * the journal instead.  On recovery, the journal will complain about
>  * that error until we've noted it down and cleared it.
> + *
> + * If force_ro is set, we unconditionally force the filesystem into =
an
> + * ABORT|READONLY state, unless the error response on the fs has been =
set to
> + * panic in which case we take the easy way out and panic =
immediately. This is
> + * used to deal with unrecoverable failures such as journal IO errors =
or ENOMEM
> + * at a critical moment in log management.
>  */
> -
> -static void ext4_handle_error(struct super_block *sb)
> +static void ext4_handle_error(struct super_block *sb, bool force_ro)
> {
> 	journal_t *journal =3D EXT4_SB(sb)->s_journal;
>=20
> 	if (test_opt(sb, WARN_ON_ERROR))
> 		WARN_ON_ONCE(1);
>=20
> -	if (sb_rdonly(sb) || test_opt(sb, ERRORS_CONT))
> +	if (sb_rdonly(sb) || (!force_ro && test_opt(sb, ERRORS_CONT)))
> 		return;
>=20
> 	ext4_set_mount_flag(sb, EXT4_MF_FS_ABORTED);
> @@ -682,18 +687,17 @@ static void ext4_handle_error(struct super_block =
*sb)
> 	 * could panic during 'reboot -f' as the underlying device got =
already
> 	 * disabled.
> 	 */
> -	if (test_opt(sb, ERRORS_RO) || system_going_down()) {
> -		ext4_msg(sb, KERN_CRIT, "Remounting filesystem =
read-only");
> -		/*
> -		 * Make sure updated value of ->s_mount_flags will be =
visible
> -		 * before ->s_flags update
> -		 */
> -		smp_wmb();
> -		sb->s_flags |=3D SB_RDONLY;
> -	} else if (test_opt(sb, ERRORS_PANIC)) {
> +	if (test_opt(sb, ERRORS_PANIC) && !system_going_down()) {
> 		panic("EXT4-fs (device %s): panic forced after error\n",
> 			sb->s_id);
> 	}
> +	ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
> +	/*
> +	 * Make sure updated value of ->s_mount_flags will be visible =
before
> +	 * ->s_flags update
> +	 */
> +	smp_wmb();
> +	sb->s_flags |=3D SB_RDONLY;
> }
>=20
> #define ext4_error_ratelimit(sb)					=
\
> @@ -701,7 +705,7 @@ static void ext4_handle_error(struct super_block =
*sb)
> 			     "EXT4-fs error")
>=20
> void __ext4_error(struct super_block *sb, const char *function,
> -		  unsigned int line, int error, __u64 block,
> +		  unsigned int line, bool force_ro, int error, __u64 =
block,
> 		  const char *fmt, ...)
> {
> 	struct va_format vaf;
> @@ -721,7 +725,7 @@ void __ext4_error(struct super_block *sb, const =
char *function,
> 		va_end(args);
> 	}
> 	save_error_info(sb, error, 0, block, function, line);
> -	ext4_handle_error(sb);
> +	ext4_handle_error(sb, force_ro);
> }
>=20
> void __ext4_error_inode(struct inode *inode, const char *function,
> @@ -753,7 +757,7 @@ void __ext4_error_inode(struct inode *inode, const =
char *function,
> 	}
> 	save_error_info(inode->i_sb, error, inode->i_ino, block,
> 			function, line);
> -	ext4_handle_error(inode->i_sb);
> +	ext4_handle_error(inode->i_sb, false);
> }
>=20
> void __ext4_error_file(struct file *file, const char *function,
> @@ -792,7 +796,7 @@ void __ext4_error_file(struct file *file, const =
char *function,
> 	}
> 	save_error_info(inode->i_sb, EFSCORRUPTED, inode->i_ino, block,
> 			function, line);
> -	ext4_handle_error(inode->i_sb);
> +	ext4_handle_error(inode->i_sb, false);
> }
>=20
> const char *ext4_decode_error(struct super_block *sb, int errno,
> @@ -860,51 +864,7 @@ void __ext4_std_error(struct super_block *sb, =
const char *function,
> 	}
>=20
> 	save_error_info(sb, -errno, 0, 0, function, line);
> -	ext4_handle_error(sb);
> -}
> -
> -/*
> - * ext4_abort is a much stronger failure handler than ext4_error.  =
The
> - * abort function may be used to deal with unrecoverable failures =
such
> - * as journal IO errors or ENOMEM at a critical moment in log =
management.
> - *
> - * We unconditionally force the filesystem into an ABORT|READONLY =
state,
> - * unless the error response on the fs has been set to panic in which
> - * case we take the easy way out and panic immediately.
> - */
> -
> -void __ext4_abort(struct super_block *sb, const char *function,
> -		  unsigned int line, int error, const char *fmt, ...)
> -{
> -	struct va_format vaf;
> -	va_list args;
> -
> -	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
> -		return;
> -
> -	save_error_info(sb, error, 0, 0, function, line);
> -	va_start(args, fmt);
> -	vaf.fmt =3D fmt;
> -	vaf.va =3D &args;
> -	printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: %pV\n",
> -	       sb->s_id, function, line, &vaf);
> -	va_end(args);
> -
> -	if (sb_rdonly(sb) =3D=3D 0) {
> -		ext4_set_mount_flag(sb, EXT4_MF_FS_ABORTED);
> -		if (EXT4_SB(sb)->s_journal)
> -			jbd2_journal_abort(EXT4_SB(sb)->s_journal, =
-EIO);
> -
> -		ext4_msg(sb, KERN_CRIT, "Remounting filesystem =
read-only");
> -		/*
> -		 * Make sure updated value of ->s_mount_flags will be =
visible
> -		 * before ->s_flags update
> -		 */
> -		smp_wmb();
> -		sb->s_flags |=3D SB_RDONLY;
> -	}
> -	if (test_opt(sb, ERRORS_PANIC) && !system_going_down())
> -		panic("EXT4-fs panic from previous error\n");
> +	ext4_handle_error(sb, false);
> }
>=20
> void __ext4_msg(struct super_block *sb,
> @@ -1007,7 +967,7 @@ __acquires(bitlock)
>=20
> 	ext4_unlock_group(sb, grp);
> 	ext4_commit_super(sb, 1);
> -	ext4_handle_error(sb);
> +	ext4_handle_error(sb, false);
> 	/*
> 	 * We only get here in the ERRORS_RO case; relocking the group
> 	 * may be dangerous, but nothing bad will happen since the
> --
> 2.16.4
>=20


Cheers, Andreas






--Apple-Mail=_4F60D8A3-C724-4FC5-B08B-C4D73DCBC499
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/EHNYACgkQcqXauRfM
H+BDsQ/8Dpvt3bt2D5SirKptkZbVNk2G7wHM+0/yuVBIS4r9M3FhwWubjJLRSJUI
JzYIoma4cNin6QjwToqXWIkOe0R+myWEM5tzHJ5vuTupQeYwbbd7GaWdSQI1MOdL
/tyMcgRnmLypsY+1Wg44wboKtJUUfAJxfJF0KKWbQkahn3LKRI1+/6wbsKp20pY0
FevcQ/4MeHEs4lO5C7O/QpK62z8alXrCI8ab7/siDVznKYnxe4rfpZQ8huyduFwo
LG3Y4ZnOlaNoV/uE3R7b+RusLu2KH4I2B2y5Z+KrVb4Dfjdef9LMDhmJD6W+b9Fi
y+AAwv4Gw7Z4ZzxqyrWQPpe/h6wwJQFYmI1X/B/N2PlISEsdhZ3jt4BfwPpfPufH
utOQ4huvFDK48wb/wluY7d4YBteq+TXoi0op9mfrPCfx64Sj7wlcgoZeJRIiL4Ln
IOwbNf7lIgc5x6+n869CzQoGwR6c90Bp5XdxggFuVV5C+dX6WO8jlo4go4eeD8hw
xhGZ1Z2nwqJ3xd1tBLC2C3x9BZJu/3J9H90q6LB3QAOvV2LVsCsr5x5eIK/BVJ2p
Zt00XnE15s+7lcUKy7On82qJIpFIkulHWW603FIXawGd9+vfG4rQIM1x79+QwsSI
OTSow6FDNBO408iuCusLfLaBiTTPdiGVoKcZ29INz+Y1vFMJ0eM=
=KAVa
-----END PGP SIGNATURE-----

--Apple-Mail=_4F60D8A3-C724-4FC5-B08B-C4D73DCBC499--
