Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8314E397D07
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jun 2021 01:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbhFAX3d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Jun 2021 19:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbhFAX3c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Jun 2021 19:29:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04273C061574
        for <linux-ext4@vger.kernel.org>; Tue,  1 Jun 2021 16:27:50 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l10-20020a17090a150ab0290162974722f2so630612pja.2
        for <linux-ext4@vger.kernel.org>; Tue, 01 Jun 2021 16:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Rtlc7ygUploG8FbVXseqxMbLmq9hsvVjj3liIx3W3bQ=;
        b=OTI4F1/YNPkHEIadqFije0G74Seob/UY9PptGffruwqdobBIWk1T2C4Aoo7ZEztXHA
         vz3qnO0PaHQmXJRAUUU1RwmnLdxGeYvLf+7ghdVvDDwAcrtvndhbv15DYPnEdEnp5xu5
         0NLqBGwnBBmYlWuFbOZGQsNL4XCfA3z2f0gz8tCFJAglLWNDOJoGyczglGERzxV+UOOv
         7y/j+XHJLsMRA8E127Vb5eEQLNYOhpW0V2Tc1r+Ag0BADLgU57ERtlBRZNfEb2wk7O1X
         t3zaa+C5d21UeI79BHt6r8HcGDZ6IyV6j47oLfKspJNb6pbbYEmlHtDd6QfO0tQA+hrW
         qHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Rtlc7ygUploG8FbVXseqxMbLmq9hsvVjj3liIx3W3bQ=;
        b=JHt2NsqsixHZ0zLakVymNr+ireIuIPDxIm+S7solKBEMjZT5WmrCoNDinw2dhljGwM
         SJ6oB0a2t4T+JJHnMOxx1yHxwU5hVQHoXJwgI9Al0dL2GBIx5DzYpBdFOFGq78PUkszt
         gPXs7WgZud7MO17OHrBF1WFGcPw/QSgkDIrAQ8kn4mM1jhIUYDW2vK9XRD6JD6faOUFa
         RxK81FxbhC5Lut+xXWvPZ+2a7g+mx8AMpvZuzcnY+998JenT60zBBIHkjsXzbJlEXfDM
         XUvCUt++f3WWCS/qAaVMwNa2OJZgQ+VneNO68qYQEAwzHS2RHfFZpuvi9D7YcD//FHBO
         BNmQ==
X-Gm-Message-State: AOAM5338BN+Ru2QpBPVizJy0vAmxmzSsGoozHu7yUgB1AH2uXH/IVSTu
        gC8G6Pvb04GzyvOaegbhXxbmrA==
X-Google-Smtp-Source: ABdhPJyp9dukigVciiPWdFTq1Xbb4DOlzzTmeh+tnTGdxdUx+Ah41JxNmTLulof6gDHiVRP851w3Xw==
X-Received: by 2002:a17:90a:ae15:: with SMTP id t21mr2340121pjq.55.1622590069418;
        Tue, 01 Jun 2021 16:27:49 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id v2sm13800165pfm.134.2021.06.01.16.27.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 16:27:48 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <A963F3A9-2106-4919-AE7C-8700F60A17EF@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_CE141ECF-E551-473C-BBA3-4B33595D1C31";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] e2fsck: replay all commits except broken ones
Date:   Tue, 1 Jun 2021 17:27:47 -0600
In-Reply-To: <20210527085707.91688-1-artem.blagodarenko@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>
References: <20210527085707.91688-1-artem.blagodarenko@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_CE141ECF-E551-473C-BBA3-4B33595D1C31
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 27, 2021, at 2:57 AM, Artem Blagodarenko =
<artem.blagodarenko@gmail.com> wrote:
>=20
> E2fsck interrupts journal replay if a broken transaction is found.
> Journal is replayed partly. Some useful transactions are not replayed.
>=20
> Let's change this behavior and process all transactions except broken =
ones
> if "-E repair_journal" option is set.

In the past we discussed using the per-block checksums in the journal
(which I think are now widely available, maybe only with metacsum?)
to detect which blocks in the journal are corrupted, and only skip
replay of those blocks.  If the same block is overwritten in a later
journal replay phase (e.g. common case for bitmaps, group descriptors,
busy inodes, etc), then no extra action is needed by e2fsck (in theory,
though we may still want to run an e2fsck to find *other* corruption).

The kernel could probably do the same, to avoid aborting a mount due to
small journal corruption.  If the corrupted blocks are bitmaps, then the
filesystem could maybe still continue to mount, with those groups marked
EXT4_GROUP_INFO_BBITMAP_CORRUPT or EXT4_GROUP_INFO_IBITMAP_CORRUPT so
they are skipped during allocation, and only mark the filesystem in =
error.
If there are other blocks corrupted, the mount should probably still =
fail.

Cheers, Andreas

>=20
> HPE-bug-id: LUS-9452
> ---
> e2fsck/e2fsck.h         |  1 +
> e2fsck/journal.c        |  3 +++
> e2fsck/recovery.c       | 41 +++++++++++++++++++++++++++++++----------
> e2fsck/unix.c           |  3 +++
> lib/e2p/feature.c       |  2 ++
> lib/ext2fs/kernel-jbd.h |  5 ++++-
> misc/ext4.5.in          |  4 ++++
> 7 files changed, 48 insertions(+), 11 deletions(-)
>=20
> diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
> index 15d043ee..7dccc8e4 100644
> --- a/e2fsck/e2fsck.h
> +++ b/e2fsck/e2fsck.h
> @@ -179,6 +179,7 @@ struct resource_track {
> #define E2F_OPT_UNSHARE_BLOCKS  0x40000
> #define E2F_OPT_CLEAR_UNINIT	0x80000 /* Hack to clear the uninit bit =
*/
> #define E2F_OPT_CHECK_ENCODING  0x100000 /* Force verification of =
encoded filenames */
> +#define E2F_OPT_REPAIR_JOURNAL	0x200000 /* Apply all possible =
from journal */
>=20
> /*
>  * E2fsck flags
> diff --git a/e2fsck/journal.c b/e2fsck/journal.c
> index a425bbd1..9b84c477 100644
> --- a/e2fsck/journal.c
> +++ b/e2fsck/journal.c
> @@ -1620,6 +1620,9 @@ static errcode_t recover_ext3_journal(e2fsck_t =
ctx)
> 	if (retval)
> 		return retval;
>=20
> +	if (ctx->options & E2F_OPT_REPAIR_JOURNAL)
> +		jbd2_set_feature_repair(journal);
> +
> 	retval =3D e2fsck_journal_load(journal);
> 	if (retval)
> 		goto errout;
> diff --git a/e2fsck/recovery.c b/e2fsck/recovery.c
> index dc0694fc..5aa3e529 100644
> --- a/e2fsck/recovery.c
> +++ b/e2fsck/recovery.c
> @@ -33,6 +33,7 @@ struct recovery_info
> 	int		nr_replays;
> 	int		nr_revokes;
> 	int		nr_revoke_hits;
> +	int             nr_skipped;
> };
>=20
> static int do_one_pass(journal_t *journal,
> @@ -313,8 +314,9 @@ int jbd2_journal_recover(journal_t *journal)
> 	jbd_debug(1, "JBD2: recovery, exit status %d, "
> 		  "recovered transactions %u to %u\n",
> 		  err, info.start_transaction, info.end_transaction);
> -	jbd_debug(1, "JBD2: Replayed %d and revoked %d/%d blocks\n",
> -		  info.nr_replays, info.nr_revoke_hits, =
info.nr_revokes);
> +	jbd_debug(1, "JBD2: Replayed %d, skipped %d, and revoked %d/%d =
blocks\n",
> +		  info.nr_replays, info.nr_skipped, info.nr_revoke_hits,
> +		  info.nr_revokes);
>=20
> 	/* Restart the log at the next transaction ID, thus invalidating
> 	 * any existing commit records in the log. */
> @@ -787,16 +789,35 @@ static int do_one_pass(journal_t *journal,
> 				}
>=20
> 				/* Neither checksum match nor unused? */
> -				if (!((crc32_sum =3D=3D found_chksum &&
> -				       cbh->h_chksum_type =3D=3D
> -						JBD2_CRC32_CHKSUM &&
> -				       cbh->h_chksum_size =3D=3D
> -						JBD2_CRC32_CHKSUM_SIZE) =
||
> -				      (cbh->h_chksum_type =3D=3D 0 &&
> -				       cbh->h_chksum_size =3D=3D 0 &&
> -				       found_chksum =3D=3D 0)))
> +				if (cbh->h_chksum_type =3D=3D 0 &&
> +				    cbh->h_chksum_size =3D=3D 0 &&
> +				    found_chksum =3D=3D 0)
> 					goto chksum_error;
>=20
> +				if (!(crc32_sum =3D found_chksum &&
> +				    cbh->h_chksum_type =3D=3D =
JBD2_CRC32_CHKSUM &&
> +				    cbh->h_chksum_size =3D=3D
> +						JBD2_CRC32_CHKSUM_SIZE)) =
{
> +					if =
(jbd2_has_feature_repair(journal)) {
> +						/*
> +						 * Commit with wrong =
checksum.
> +						 * Let's skip it. There =
are
> +						 * some corect commits =
after.
> +						*/
> +						++info->nr_skipped;
> +						jbd_debug(1, "JBD2: "
> +							  =
"crc32_sum(0x%x)i !=3D"
> +							  " =
found_chksum(0x%x)"
> +							  ". =
Skipped.\n",
> +							  crc32_sum,
> +							  found_chksum);
> +						brelse(bh);
> +						next_commit_ID++;
> +					} else {
> +						goto chksum_error;
> +					}
> +				}
> +
> 				crc32_sum =3D ~0;
> 			}
> 			if (pass =3D=3D PASS_SCAN &&
> diff --git a/e2fsck/unix.c b/e2fsck/unix.c
> index c5f9e441..fc7649fc 100644
> --- a/e2fsck/unix.c
> +++ b/e2fsck/unix.c
> @@ -763,6 +763,9 @@ static void parse_extended_opts(e2fsck_t ctx, =
const char *opts)
> 			ctx->options |=3D E2F_OPT_CLEAR_UNINIT;
> 			continue;
> #endif
> +		} else if (strcmp(token, "repair_journal") =3D=3D 0) {
> +			ctx->options |=3D E2F_OPT_REPAIR_JOURNAL;
> +			continue;
> 		} else {
> 			fprintf(stderr, _("Unknown extended option: =
%s\n"),
> 				token);
> diff --git a/lib/e2p/feature.c b/lib/e2p/feature.c
> index 22910602..6cd11384 100644
> --- a/lib/e2p/feature.c
> +++ b/lib/e2p/feature.c
> @@ -134,6 +134,8 @@ static struct feature jrnl_feature_list[] =3D {
>                        "journal_checksum_v2" },
>        {       E2P_FEATURE_INCOMPAT, JBD2_FEATURE_INCOMPAT_CSUM_V3,
>                        "journal_checksum_v3" },
> +       {       E2P_FEATURE_INCOMPAT, JBD2_FEATURE_INCOMPAT_REPAIR,
> +			"journal_repair" },
>        {       0, 0, 0 },
> };
>=20
> diff --git a/lib/ext2fs/kernel-jbd.h b/lib/ext2fs/kernel-jbd.h
> index 2978ccb6..4a2cef20 100644
> --- a/lib/ext2fs/kernel-jbd.h
> +++ b/lib/ext2fs/kernel-jbd.h
> @@ -265,6 +265,7 @@ typedef struct journal_superblock_s
> #define JBD2_FEATURE_INCOMPAT_CSUM_V2		0x00000008
> #define JBD2_FEATURE_INCOMPAT_CSUM_V3		0x00000010
> #define JBD2_FEATURE_INCOMPAT_FAST_COMMIT	0x00000020
> +#define JBD2_FEATURE_INCOMPAT_REPAIR		0x00000040
>=20
> /* Features known to this kernel version: */
> #define JBD2_KNOWN_COMPAT_FEATURES	0
> @@ -274,7 +275,8 @@ typedef struct journal_superblock_s
> 					 JBD2_FEATURE_INCOMPAT_64BIT|\
> 					 JBD2_FEATURE_INCOMPAT_CSUM_V2|	=
\
> 					 JBD2_FEATURE_INCOMPAT_CSUM_V3 | =
\
> -					 =
JBD2_FEATURE_INCOMPAT_FAST_COMMIT)
> +					 =
JBD2_FEATURE_INCOMPAT_FAST_COMMIT | \
> +					 JBD2_FEATURE_INCOMPAT_REPAIR)
>=20
> #ifdef NO_INLINE_FUNCS
> extern size_t journal_tag_bytes(journal_t *journal);
> @@ -392,6 +394,7 @@ JBD2_FEATURE_INCOMPAT_FUNCS(async_commit,	=
ASYNC_COMMIT)
> JBD2_FEATURE_INCOMPAT_FUNCS(csum2,		CSUM_V2)
> JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
> JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
> +JBD2_FEATURE_INCOMPAT_FUNCS(repair,		REPAIR)
>=20
> #if (defined(E2FSCK_INCLUDE_INLINE_FUNCS) || =
!defined(NO_INLINE_FUNCS))
> /*
> diff --git a/misc/ext4.5.in b/misc/ext4.5.in
> index 90bc4f88..95266864 100644
> --- a/misc/ext4.5.in
> +++ b/misc/ext4.5.in
> @@ -574,6 +574,10 @@ Commit block can be written to disk without =
waiting for descriptor blocks. If
> enabled older kernels cannot mount the device.
> This will enable 'journal_checksum' internally.
> .TP
> +.B journal_repair
> +If journal is broken, apply all valid transactions and pass
> +all broken ones(with invalid crc).
> +.TP
> .BR barrier=3D0 " / " barrier=3D1 " / " barrier " / " nobarrier
> These mount options have the same effect as in ext3.  The mount =
options
> "barrier" and "nobarrier" are added for consistency with other ext4 =
mount
> --
> 2.18.4
>=20


Cheers, Andreas






--Apple-Mail=_CE141ECF-E551-473C-BBA3-4B33595D1C31
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmC2wnMACgkQcqXauRfM
H+DdjA//ZQnMOboladM2iTpo3uYDtP9ms5tTGWxVP/pmwTtTlxBcsRhbuKZZgttj
mJEwOKPgkRusOQ+usH+ppLMZNKF6I1sdNLmbb60I7rkMlsgEh7a0mc+MIvnXxPdL
eNaHmF2WbGnSD+9wFHx7l/WjKXMGvNy3JQZrxmJ2kWdF+FyOxPxbqKPRRpZ3wWAC
0ttEn5p9qgl5XWTTsYUjA/sFArNjKAlasLXIrVCvpRdkdKKWdIcHG4ycuh5XqEvZ
xyLFmWjNyg1UTFdOtEdlhu9ZAiQVO6z83kd68hswEu8S5vlcDp20E5GJxa83YnwK
Po6s43BlI2aaaxkIf/3DQU8haKuWmwNGB63QhsOecbiRyIpJoXnI1beA0qElwOL2
X6jM0hhqBg7erHxmQU+Tb5igxKWaIJq9DLasU2Wp50F9Ylp2pym8yYvaYUuo2DhY
QP0uP5XdcCTR09FmH9ED2dVOz0m3OpK7/OnqL5qQzTUN9oX3E4Arp5+cuzXQ77lm
HfEQsmwMr4x9SY8AfqcXCUwjpTdgNOJ9NW2QNvzQS/ruIfpxEkT2b5aGOBtVu8C2
ysnkQNmYHF20KbrZxmBsBO9VbFHWitver7nojnvOxC+jUlE7/i5qW1/j6peomGOp
qpj5AkU1etBGFr2kx+5FsQWSfPV8JMXYF5z0RYd0RR6xTIa1Bvk=
=Tixw
-----END PGP SIGNATURE-----

--Apple-Mail=_CE141ECF-E551-473C-BBA3-4B33595D1C31--
