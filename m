Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80BF4C7EFF
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Mar 2022 01:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiCAADY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Feb 2022 19:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiCAADX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Feb 2022 19:03:23 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5815D6339
        for <linux-ext4@vger.kernel.org>; Mon, 28 Feb 2022 16:02:40 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id bc27so4055192pgb.4
        for <linux-ext4@vger.kernel.org>; Mon, 28 Feb 2022 16:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=N/6MOSleR5CqBrQZzdWU4Aov/CgKGabhUY3JAaH2E6A=;
        b=68IPfO+9+nnz6A15Blj33qhlZ+uc1A6TTa87XkrhV4ipyvggMBvMJMj0vbIfC7hHWo
         UnMFh7RzLteg5q3mVOqtua9k8buEFsP01VLHMAGOeB4gjy2MDIEpW2/XOWPHqgSjVbfC
         aNjyFNvDA13SXFkS7dL0MLFFNMqGNT347G9SDzJ9X4ZwJysydXBjmCz8Be1AzulKDEoN
         gWPU3ygBM3BU2H6wy/vskZ/jEdou0in3RfyPQU0Fo2xIP0dGDatOZHtwjpavnCJdye3o
         FEPxftOkiRwSzPmutFyL2ob/qFV9ilVFr7T+bV5qL51x4kyGU1DZRlBxNw/z+FwZD+ZJ
         ykzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=N/6MOSleR5CqBrQZzdWU4Aov/CgKGabhUY3JAaH2E6A=;
        b=AUMDQGyngp5oKXpgwb9oBAriAlcRMy1K3JNqcgIC+cpnL9ONT2RmIok9pN0KYxvYId
         KIo+ZNOo6Ma44ZlhkLuLhybaIOSrM2MrknAR1SdQIqNJK0gfT+kFPxp2ynssBkXWfNBB
         gH/tsRn1wx4LRWoUoTqEDadXzAhLNuOSF7mzzEt1JZMWUnDxIOlnlL68BMTRsaMKWdO8
         TWTfr3lGBsOy4wRBrIOdOQ17gr1cAvlVdMlXUj+NVjjT+VYLW+jsdhZ+Sfrv22QcxVbu
         z8oBiCjMWAnlxrBKAq+Rpgkc/B1Wq+Lde8B/Nkh41QLONNBnCA9n3dLY9/hPyqz8trrh
         Tj3Q==
X-Gm-Message-State: AOAM531vv+8r8zvVZ/mxUVU25nPVTGsu/RG059ZQN2NUcfr/QgDKeaOy
        1wJoxXnwRPPEgXC2Q2QGkcDMn/w/eZhkqQ==
X-Google-Smtp-Source: ABdhPJwx15MRV5UcOmmiIrdl0i8nt7bCgl1PKWUXk3yP+ZJkLdmDh/eKVRKzoCQWiszLmxPXAP8Q9g==
X-Received: by 2002:a05:6a00:10c9:b0:4ce:146e:6edf with SMTP id d9-20020a056a0010c900b004ce146e6edfmr24514927pfu.6.1646092959952;
        Mon, 28 Feb 2022 16:02:39 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id h22-20020a056a00231600b004e1784925e5sm15032819pfh.97.2022.02.28.16.02.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Feb 2022 16:02:39 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <BA69FF31-631B-41E5-A184-DB79908FA6AB@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B0447D88-66AD-4482-AE99-C97F9FE783A9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] e2fsck: no parent lookup in disconnected dir
Date:   Mon, 28 Feb 2022 17:02:38 -0700
In-Reply-To: <20211213063530.38352-1-adilger@whamcloud.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
References: <20211213063530.38352-1-adilger@whamcloud.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_B0447D88-66AD-4482-AE99-C97F9FE783A9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 12, 2021, at 11:35 PM, Andreas Dilger <adilger@whamcloud.com> =
wrote:
>=20
> Don't call into ext2fs_get_pathname() to do a name lookup for a
> disconnected directory, since the directory block traversal in
> pass1 has already scanned all of the leaf blocks and never finds
> the entry, always printing "???".  If the name entry had been
> found earlier, the directory would not be disconnected in pass3.
>=20
> Instead, lookup ".." and print the parent name in the prompt, and
> then do not search for the current directory name at all.  This
> avoids a useless full directory scan for each disconnected entry,
> which can potentially be slow if the parent directory is large.
>=20
> Separate the recursively looped directory case to a new error code,
> since it is a different problem that should use its own descriptive
> text, and a proper pathname can be shown in this case.

Ping.

The current behaviour is O(n^2).  With very large directories (10M
or more entries) this can cause e2fsck to run for many days as each
full-directory scan can be over 1s and is totally unnecessary.

Cheers, Andreas

>=20
> Lustre-bug-Id: https://jira.whamcloud.com/browse/LU-15330
> Change-Id: If17a92689f24f365ca1fbe5c837e7d5f383ebbe5
> Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
> ---
> e2fsck/pass3.c                        |  19 ++++++++++++-------
> e2fsck/problem.c                      |   8 +++++++-
> e2fsck/problem.h                      |   3 +++
> tests/f_bad_encryption/expect.1       |   6 +++---
> tests/f_badroot/expect.1              |   2 +-
> tests/f_encrypted_lpf/expect.1        |   4 ++--
> tests/f_expand/expect.1.gz            | Bin 13462 -> 13461 bytes
> tests/f_lpf2/expect.1                 |   4 ++--
> tests/f_noroot/expect.1               |   4 ++--
> tests/f_orphan_dotdot_ft/expect.1     |   6 +++---
> tests/f_rebuild_csum_rootdir/expect.1 |   2 +-
> tests/f_recnect_bad/expect.1          |   2 +-
> tests/f_resize_inode_meta_bg/expect.1 |   2 +-
> 13 files changed, 38 insertions(+), 24 deletions(-)
>=20
> diff --git a/e2fsck/pass3.c b/e2fsck/pass3.c
> index cedaaf5a..d6b8c8b4 100644
> --- a/e2fsck/pass3.c
> +++ b/e2fsck/pass3.c
> @@ -22,7 +22,7 @@
>  * will offer to reconnect it to /lost+found.  While it is chasing
>  * parent pointers up the filesystem tree, if pass3 sees a directory
>  * twice, then it has detected a filesystem loop, and it will again
> - * offer to reconnect the directory to /lost+found in to break the
> + * offer to reconnect the directory to /lost+found in order to break =
the
>  * filesystem loop.
>  *
>  * Pass 3 also contains the subroutine, e2fsck_reconnect_file() to
> @@ -304,7 +304,7 @@ static int check_directory(e2fsck_t ctx, =
ext2_ino_t dir,
> 		 * If it was marked done already, then we've reached a
> 		 * parent we've already checked.
> 		 */
> -	  	if (ext2fs_mark_inode_bitmap2(inode_done_map, ino))
> +		if (ext2fs_mark_inode_bitmap2(inode_done_map, ino))
> 			break;
>=20
> 		if (e2fsck_dir_info_get_parent(ctx, ino, &parent)) {
> @@ -319,13 +319,18 @@ static int check_directory(e2fsck_t ctx, =
ext2_ino_t dir,
> 		 */
> 		if (!parent ||
> 		    (loop_pass &&
> -		     (ext2fs_test_inode_bitmap2(inode_loop_detect,
> -					       parent)))) {
> +		     ext2fs_test_inode_bitmap2(inode_loop_detect, =
parent))) {
> 			pctx->ino =3D ino;
> -			if (fix_problem(ctx, PR_3_UNCONNECTED_DIR, =
pctx)) {
> -				if (e2fsck_reconnect_file(ctx, =
pctx->ino))
> +			if (parent)
> +				pctx->dir =3D parent;
> +			else
> +				ext2fs_lookup(fs, ino, "..", 2, NULL,
> +					      &pctx->dir);
> +			if (fix_problem(ctx, !parent ? =
PR_3_UNCONNECTED_DIR :
> +						       PR_3_LOOPED_DIR, =
pctx)) {
> +				if (e2fsck_reconnect_file(ctx, =
pctx->ino)) {
> 					ext2fs_unmark_valid(fs);
> -				else {
> +				} else {
> 					fix_dotdot(ctx, pctx->ino,
> 						   ctx->lost_and_found);
> 					parent =3D ctx->lost_and_found;
> diff --git a/e2fsck/problem.c b/e2fsck/problem.c
> index 757b5d56..66c9ae94 100644
> --- a/e2fsck/problem.c
> +++ b/e2fsck/problem.c
> @@ -1852,7 +1852,7 @@ static struct e2fsck_problem problem_table[] =3D =
{
> 	/* Unconnected directory inode */
> 	{ PR_3_UNCONNECTED_DIR,
> 	  /* xgettext:no-c-format */
> -	  N_("Unconnected @d @i %i (%p)\n"),
> +	  N_("Unconnected @d @i %i (was in %q)\n"),
> 	  PROMPT_CONNECT, 0, 0, 0, 0 },
>=20
> 	/* /lost+found not found */
> @@ -1989,6 +1989,12 @@ static struct e2fsck_problem problem_table[] =3D =
{
> 	  N_("/@l is encrypted\n"),
> 	  PROMPT_CLEAR, 0, 0, 0, 0 },
>=20
> +	/* Recursively looped directory inode */
> +	{ PR_3_LOOPED_DIR,
> +	  /* xgettext:no-c-format */
> +	  N_("Recursively looped @d @i %i (%p)\n"),
> +	  PROMPT_CONNECT, 0, 0, 0, 0 },
> +
> 	/* Pass 3A Directory Optimization	*/
>=20
> 	/* Pass 3A: Optimizing directories */
> diff --git a/e2fsck/problem.h b/e2fsck/problem.h
> index 24cdcf9b..e86bc889 100644
> --- a/e2fsck/problem.h
> +++ b/e2fsck/problem.h
> @@ -1132,6 +1132,9 @@ struct problem_context {
> /* Lost+found is encrypted */
> #define PR_3_LPF_ENCRYPTED		0x03001B
>=20
> +/* Recursively looped directory inode */
> +#define PR_3_LOOPED_DIR			0x03001D
> +
> /*
>  * Pass 3a --- rehashing directories
>  */
> diff --git a/tests/f_bad_encryption/expect.1 =
b/tests/f_bad_encryption/expect.1
> index d743e66f..70270959 100644
> --- a/tests/f_bad_encryption/expect.1
> +++ b/tests/f_bad_encryption/expect.1
> @@ -54,13 +54,13 @@ Encrypted entry =
'\M-ggCeM-/?M-^BM-{(M-^OM-9M-^QQAM-^N=3DM-c^Mo' in /edir (12) refe
> Clear? yes
>=20
> Pass 3: Checking directory connectivity
> -Unconnected directory inode 18 (/edir/???)
> +Unconnected directory inode 18 (was in /edir)
> Connect to /lost+found? yes
>=20
> -Unconnected directory inode 24 (/edir/???)
> +Unconnected directory inode 24 (was in /edir)
> Connect to /lost+found? yes
>=20
> -Unconnected directory inode 27 (/edir/???)
> +Unconnected directory inode 27 (was in /edir)
> Connect to /lost+found? yes
>=20
> Pass 4: Checking reference counts
> diff --git a/tests/f_badroot/expect.1 b/tests/f_badroot/expect.1
> index f9d01e57..ff924268 100644
> --- a/tests/f_badroot/expect.1
> +++ b/tests/f_badroot/expect.1
> @@ -9,7 +9,7 @@ Entry '..' in <2>/<11> (11) has deleted/unused inode =
2.  Clear? yes
> Pass 3: Checking directory connectivity
> Root inode not allocated.  Allocate? yes
>=20
> -Unconnected directory inode 11 (...)
> +Unconnected directory inode 11 (was in /)
> Connect to /lost+found? yes
>=20
> /lost+found not found.  Create? yes
> diff --git a/tests/f_encrypted_lpf/expect.1 =
b/tests/f_encrypted_lpf/expect.1
> index 7e215b7d..63ac5f3b 100644
> --- a/tests/f_encrypted_lpf/expect.1
> +++ b/tests/f_encrypted_lpf/expect.1
> @@ -1,7 +1,7 @@
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> -Unconnected directory inode 12 (/???)
> +Unconnected directory inode 12 (was in /)
> Connect to /lost+found? yes
>=20
> /lost+found is encrypted
> @@ -13,7 +13,7 @@ Restarting e2fsck from the beginning...
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> -Unconnected directory inode 11 (/???)
> +Unconnected directory inode 11 (was in /)
> Connect to /lost+found? yes
>=20
> Pass 3A: Optimizing directories
> diff --git a/tests/f_expand/expect.1.gz b/tests/f_expand/expect.1.gz
> index =
1015e155ca93f1aea0edfad09be6e795c0ab1898..81fe7dd67f81dd64100b5fdfe2884fab=
129ab721 100644
> GIT binary patch
> literal 13461
> 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
>=20
> literal 13462
> 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
>=20
> diff --git a/tests/f_lpf2/expect.1 b/tests/f_lpf2/expect.1
> index 633586cc..ab5d9ba3 100644
> --- a/tests/f_lpf2/expect.1
> +++ b/tests/f_lpf2/expect.1
> @@ -1,12 +1,12 @@
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> -Unconnected directory inode 12 (/???)
> +Unconnected directory inode 12 (was in /)
> Connect to /lost+found? yes
>=20
> /lost+found not found.  Create? yes
>=20
> -Unconnected directory inode 13 (/???)
> +Unconnected directory inode 13 (was in /)
> Connect to /lost+found? yes
>=20
> Pass 4: Checking reference counts
> diff --git a/tests/f_noroot/expect.1 b/tests/f_noroot/expect.1
> index 7bdd7cba..f8f652ec 100644
> --- a/tests/f_noroot/expect.1
> +++ b/tests/f_noroot/expect.1
> @@ -11,12 +11,12 @@ Entry '..' in /foo (12) has deleted/unused inode =
2.  Clear? yes
> Pass 3: Checking directory connectivity
> Root inode not allocated.  Allocate? yes
>=20
> -Unconnected directory inode 11 (...)
> +Unconnected directory inode 11 (was in /)
> Connect to /lost+found? yes
>=20
> /lost+found not found.  Create? yes
>=20
> -Unconnected directory inode 12 (...)
> +Unconnected directory inode 12 (was in /lost+found)
> Connect to /lost+found? yes
>=20
> Pass 4: Checking reference counts
> diff --git a/tests/f_orphan_dotdot_ft/expect.1 =
b/tests/f_orphan_dotdot_ft/expect.1
> index 6a1373f2..60924958 100644
> --- a/tests/f_orphan_dotdot_ft/expect.1
> +++ b/tests/f_orphan_dotdot_ft/expect.1
> @@ -17,13 +17,13 @@ Entry '..' in <12>/<15> (15) has an incorrect =
filetype (was 2, should be 6).
> Fix? yes
>=20
> Pass 3: Checking directory connectivity
> -Unconnected directory inode 13 (<12>/<13>)
> +Unconnected directory inode 13 (was in <12>)
> Connect to /lost+found? yes
>=20
> -Unconnected directory inode 14 (<12>/<14>)
> +Unconnected directory inode 14 (was in <12>)
> Connect to /lost+found? yes
>=20
> -Unconnected directory inode 15 (<12>/<15>)
> +Unconnected directory inode 15 (was in <12>)
> Connect to /lost+found? yes
>=20
> Pass 4: Checking reference counts
> diff --git a/tests/f_rebuild_csum_rootdir/expect.1 =
b/tests/f_rebuild_csum_rootdir/expect.1
> index 91e6027d..063fb8cc 100644
> --- a/tests/f_rebuild_csum_rootdir/expect.1
> +++ b/tests/f_rebuild_csum_rootdir/expect.1
> @@ -13,7 +13,7 @@ Pass 3: Checking directory connectivity
> '..' in / (2) is <The NULL inode> (0), should be / (2).
> Fix? yes
>=20
> -Unconnected directory inode 11 (/???)
> +Unconnected directory inode 11 (was in /)
> Connect to /lost+found? yes
>=20
> /lost+found not found.  Create? yes
> diff --git a/tests/f_recnect_bad/expect.1 =
b/tests/f_recnect_bad/expect.1
> index 97ffcc52..685eedfe 100644
> --- a/tests/f_recnect_bad/expect.1
> +++ b/tests/f_recnect_bad/expect.1
> @@ -12,7 +12,7 @@ i_faddr for inode 13 (/test/???) is 12, should be =
zero.
> Clear? yes
>=20
> Pass 3: Checking directory connectivity
> -Unconnected directory inode 13 (/test/???)
> +Unconnected directory inode 13 (was in /test)
> Connect to /lost+found? yes
>=20
> Pass 4: Checking reference counts
> diff --git a/tests/f_resize_inode_meta_bg/expect.1 =
b/tests/f_resize_inode_meta_bg/expect.1
> index 769f71ae..e248083f 100644
> --- a/tests/f_resize_inode_meta_bg/expect.1
> +++ b/tests/f_resize_inode_meta_bg/expect.1
> @@ -45,7 +45,7 @@ Pass 3: Checking directory connectivity
> '..' in / (2) is <The NULL inode> (0), should be / (2).
> Fix? yes
>=20
> -Unconnected directory inode 11 (/???)
> +Unconnected directory inode 11 (was in /)
> Connect to /lost+found? yes
>=20
> /lost+found not found.  Create? yes
> --
> 2.25.1
>=20


Cheers, Andreas






--Apple-Mail=_B0447D88-66AD-4482-AE99-C97F9FE783A9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmIdYp4ACgkQcqXauRfM
H+DxDBAAkkbL6ACzDY1iKcxs9TsJPLgFLGecW65XQ+OjuNWlz9iHuzO81FZOJfFt
yvQF3INyQr9nNdpi/24+vUl/DnW9IlNx1n6IhtjAUCCGD+jsfxc/CNLlxoI0r3eQ
EFtyAa3xs0c1kJhGFt2rPgBOuYJMXsmi3SysAdrfW9f71L7uZv6L36xSWfyw1OCv
ZXkWB2kVRn904HtCOzkr12M8IArg0nwbBk/GqzYc+sgvHn5YydA8Z/ngNM2dlrxB
xuIQwKdnpLnqImBfpTLo6heRQ8NW5CikmgDv7bFhSbzMNL9pWXpSiYhED2oeQCZ5
Kt26HGP98fs078t1snwXRfEtMNKmcOTCudM6UlqvEpM5iEHdw8VE2RGH560VMOFS
a+lubacNMxTjWR66L3/gpoHhqqEtJVjGuSqqdaB9AsYLyDOvK8ZJEJ9/mNptTuYl
aA8WvgeXNL9W/LnkPFurGTRwNccc0aDECYItkYDdkNTvMRnkb1+c0MLU2z6slxyy
P7/MSvBGRx09R/W3HeIfnLxkQJyWjkZtCKbuz+zj6OCrT4Ke2EcmLo9AhFelV28w
ZRDDqiqnc9h4ZY8wnpeteRhEa4V4LlkiE8ZG1IFLEAI+z5xz/QOnf8n2hA1oswh5
CzS4MS86e+iL648uJPAswQ7n37DLYe79c2niUUU9Rv1TTP+N/vg=
=zty8
-----END PGP SIGNATURE-----

--Apple-Mail=_B0447D88-66AD-4482-AE99-C97F9FE783A9--
