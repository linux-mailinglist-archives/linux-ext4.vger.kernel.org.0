Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33963264D92
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Sep 2020 20:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgIJSqA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Sep 2020 14:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbgIJSpm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Sep 2020 14:45:42 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DDCC061573
        for <linux-ext4@vger.kernel.org>; Thu, 10 Sep 2020 11:45:40 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l191so4727478pgd.5
        for <linux-ext4@vger.kernel.org>; Thu, 10 Sep 2020 11:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Y7iVP72shB1xRZlx25aC+mXAcihSM60gP6RHjqjMJ5o=;
        b=a5SzwmkuwnmgPE9L0ulvsrNdctlFOJTlcE6yDmOp0H8Uyp1g6lFTn4O4Baely86wvC
         FRDCchWwhUjHwjdAHvhwJr9Lr5qClZywF93XPF115wT9h4/j51lruwG8IkHUCUb4qa9y
         uluw/JDTc4LenwAor07pvqB0c7ChAEnEi4ZdCBlvR7o9IX8l9cmZgDVtakNa4O/suaM6
         /I0R+PorLRAUeElzzd/AL1HRUTDAZQC/q7HqDEZmDi37hHNcjRUJiRclH8otX38G7qsV
         ITzRS4dyb5cO490YrUehlaODbwnVqkxCwJQIRr/AH4XGj9bnawJzXJP5eUsZPXQEGwLK
         Ik6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Y7iVP72shB1xRZlx25aC+mXAcihSM60gP6RHjqjMJ5o=;
        b=PpWAXutFzwnJjl83VwVjSGcRaIMr/SthVrqWZtv5f/ppLmXqA+fEoLV1zGI30eSjux
         U5bSnKSP5CEjnGoowsZKbfRGKP7TM3g1RzGggHyo7vvQAS2PNfTRvR5BaM+7Lwf0IKW8
         q72LA+UqUgE/7LGp2QkZ/X3yORSCPHyhuOF4ye5TcE20tkkuz33R4EOMEt9xQ0aN5Ql3
         OHTWr8e76LUIB1dENgqn5PgJLX1jfp7Pth3x+qomryZ8SjH2WS2BEjYyqdnH8CajE1Ls
         Soh9lqftpbVYkYNjVnjCoF+vDO/qolldjyKQzoB1ewf2gYJbjf//BFF+zD0Qa+ODc+j/
         o0/w==
X-Gm-Message-State: AOAM532D6c2im4KNJBtNH6NtLfRLVuMd5BFv/WvaG9858uiXzKi9hTF5
        tQ0pdX9cW19825H/kyxs8Jy4fL6oA8x2Aw==
X-Google-Smtp-Source: ABdhPJwxje7i6eqyWCgEDSlKxf/Y0drJ7bcPKqJYXrqYuV614ljJTDjnEWQHJTllqJuKklylb8eAOw==
X-Received: by 2002:a17:902:778b:: with SMTP id o11mr6868671pll.127.1599763540333;
        Thu, 10 Sep 2020 11:45:40 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id z4sm6601671pfr.197.2020.09.10.11.45.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2020 11:45:38 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <FD23DAA4-1CC7-45FB-9AED-9CB3B014B930@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_35463B1B-B6E9-496E-80F9-00265B2319C0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] jbd2: avoid transaction reuse after reformatting
Date:   Thu, 10 Sep 2020 12:45:34 -0600
In-Reply-To: <tencent_2341B065211F204FA07C3ADDA1AE07706405@qq.com>
Cc:     darrick.wong@oracle.com, jack@suse.com, linux-ext4@vger.kernel.org,
        tytso@mit.edu, Fengnan Chang <changfengnan@hikvision.com>
To:     changfengnan <changfengnan@qq.com>
References: <tencent_2341B065211F204FA07C3ADDA1AE07706405@qq.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_35463B1B-B6E9-496E-80F9-00265B2319C0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 10, 2020, at 5:55 AM, changfengnan <changfengnan@qq.com> wrote:
>=20
> From: Fengnan Chang <changfengnan@hikvision.com>
>=20
> When format ext4 with lazy_journal_init=3D1, the previous transaction =
is
> still on disk, it is possible that the previous transaction will be
> used again during jbd2 recovery.Because the seed is changed, the CRC
> check will fail.
>=20
> Signed-off-by: Fengnan Chang <changfengnan@hikvision.com>

This version of the patch looks OK, with one trivial indentation problem
after the "jbd_debug(1, "JBD2: Invalid checksum" line that could be =
fixed.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/jbd2/recovery.c | 60 +++++++++++++++++++++++++++++++++++++++++-----
> 1 file changed, 54 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index a4967b27ffb6..8a6bc322a06d 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -33,6 +33,8 @@ struct recovery_info
> 	int		nr_replays;
> 	int		nr_revokes;
> 	int		nr_revoke_hits;
> +	unsigned long  ri_commit_block;
> +	__be64  last_trans_commit_time;
> };
>=20
> enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
> @@ -412,7 +414,27 @@ static int jbd2_block_tag_csum_verify(journal_t =
*j, journal_block_tag_t *tag,
> 	else
> 		return tag->t_checksum =3D=3D cpu_to_be16(csum32);
> }
> +/*
> + * We check the commit time and compare it with the commit time of
> + * the previous transaction, if it's smaller than previous,
> + * We think it's not belong to same journal.
> + */
> +static bool is_same_journal(journal_t *journal, struct buffer_head =
*bh, unsigned long blocknr, __u64 last_commit_sec)
> +{
> +	unsigned long commit_block =3D blocknr + count_tags(journal, bh) =
+ 1;
> +	struct buffer_head *nbh;
> +	struct commit_header *cbh;
> +	__u64	commit_sec;
> +	int err =3D jread(&nbh, journal, commit_block);
>=20
> +	if (err)
> +		return true;
> +
> +	cbh =3D (struct commit_header *)nbh->b_data;
> +	commit_sec =3D be64_to_cpu(cbh->h_commit_sec);
> +
> +	return commit_sec >=3D last_commit_sec;
> +}
> static int do_one_pass(journal_t *journal,
> 			struct recovery_info *info, enum passtype pass)
> {
> @@ -514,18 +536,29 @@ static int do_one_pass(journal_t *journal,
> 		switch(blocktype) {
> 		case JBD2_DESCRIPTOR_BLOCK:
> 			/* Verify checksum first */
> +			if (pass =3D=3D PASS_SCAN)
> +				info->ri_commit_block =3D 0;
> +
> 			if (jbd2_journal_has_csum_v2or3(journal))
> 				descr_csum_size =3D
> 					sizeof(struct =
jbd2_journal_block_tail);
> 			if (descr_csum_size > 0 &&
> 			    !jbd2_descriptor_block_csum_verify(journal,
> 							       =
bh->b_data)) {
> -				printk(KERN_ERR "JBD2: Invalid checksum =
"
> -				       "recovering block %lu in log\n",
> +				if (is_same_journal(journal, bh, =
next_log_block-1, info->last_trans_commit_time)) {
> +					printk(KERN_ERR "JBD2: Invalid =
checksum recovering block %lu in log\n",
> 				       next_log_block);
> -				err =3D -EFSBADCRC;
> -				brelse(bh);
> -				goto failed;
> +					err =3D -EFSBADCRC;
> +					brelse(bh);
> +					goto failed;
> +				} else {
> +					/*it's not belong to same =
journal, just end this recovery with success*/
> +					jbd_debug(1, "JBD2: Invalid =
checksum found in block %lu in log, but not same journal %d\n",
> +				       next_log_block, next_commit_ID);

The continued line should be indented one more tab.

> +					err =3D 0;
> +					brelse(bh);
> +					goto done;
> +				}
> 			}
>=20
> 			/* If it is a valid descriptor block, replay it
> @@ -688,6 +721,17 @@ static int do_one_pass(journal_t *journal,
> 			 * are present verify them in PASS_SCAN; else =
not
> 			 * much to do other than move on to the next =
sequence
> 			 * number. */
> +			if (pass =3D=3D PASS_SCAN) {
> +				struct commit_header *cbh =3D
> +					(struct commit_header =
*)bh->b_data;
> +				if (info->ri_commit_block) {
> +					jbd_debug(1, "invalid commit =
block found in %lu, stop here.\n", next_log_block);
> +					brelse(bh);
> +					goto done;
> +				}
> +				info->ri_commit_block =3D =
next_log_block;
> +				info->last_trans_commit_time =3D =
be64_to_cpu(cbh->h_commit_sec);
> +			}
> 			if (pass =3D=3D PASS_SCAN &&
> 			    jbd2_has_feature_checksum(journal)) {
> 				int chksum_err, chksum_seen;
> @@ -761,7 +805,11 @@ static int do_one_pass(journal_t *journal,
> 				brelse(bh);
> 				continue;
> 			}
> -
> +			if (pass !=3D PASS_SCAN && =
info->ri_commit_block) {
> +				jbd_debug(1, "invalid revoke block found =
in %lu, stop here.\n", next_log_block);
> +				brelse(bh);
> +				goto done;
> +			}
> 			err =3D scan_revoke_records(journal, bh,
> 						  next_commit_ID, info);
> 			brelse(bh);
> --
> 2.27.0.windows.1
>=20
>=20


Cheers, Andreas






--Apple-Mail=_35463B1B-B6E9-496E-80F9-00265B2319C0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9adE4ACgkQcqXauRfM
H+CkFQ/+JiDncMtlK6TUvln/x+Pr1mSH3rmI3Jnmlyyj0he9bp74Pti9+TInMO7V
VJP3UGvVSFWGfB+w9ykXjZAEY9N7wwqN7lMy4ZRD3do/wYaTo3RPD7rEalPVbj4I
Exos3nKluvTWgh+E1wbWA/Uw01EpxDBOLK4lG5c4vsoWPROQfCg2b0mnwkaBsdFe
j+d5TxHJ54bBnSQPDkDLEhGUtPJ5F9aOICfYqTrSFc0wrp6gY9/tNc+a1MK31EIZ
dvBucYMP3hYfPiFA8FQcxlvuMfwVyoJOTDIzlP1NCUutQG2em/a/WD0pVuPExYhl
kUyUqxtd2KUpZUiRc4nOFPOGHA6au0SAPpTn6ZKM0lL0G1352emyLsDNtB2hmXpd
2i++ux5nYDHbA1aldKzWJZua5tSCFo0BpysnAUHH/ITWPQZyVIcewAHCRreSuz0D
FBA9LmhUBtz8B3vkejdkNGDIhVoK0S2W8HiQZDFeuG7DnETqZgRiYJjiHKInK9Vd
XplXpQVQnxux+SHrvfyscgOYmPhDThsxqrxiRa8JfsbzaEMPfSZIxP0fJjNONTAf
MWNuDDJS8bFpz1JJmfQRBc7iTauUxUTcEJGuBdcNhs0pDYYkP44e/1tR6Yb0lGfo
wCEoGqWVi59gHpBgkHk0rMr3xEWmeVwVVcnCHA2PCpVrlrP4yTM=
=KYMc
-----END PGP SIGNATURE-----

--Apple-Mail=_35463B1B-B6E9-496E-80F9-00265B2319C0--
