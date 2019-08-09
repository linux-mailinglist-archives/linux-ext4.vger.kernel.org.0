Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A81B18844E
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 22:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfHIU5s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Aug 2019 16:57:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:47057 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfHIU5s (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Aug 2019 16:57:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3so9210769pgt.13
        for <linux-ext4@vger.kernel.org>; Fri, 09 Aug 2019 13:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=76HtG/G3/u0fsY1KqLEbCyWtum92OFhmLlpQQgnwOLg=;
        b=DMxppkVmur0KeqyI6Ww0qBRw/Q36uL93A1+SfTqWWtYvX6r85Vhi4LnPNrMu915QoI
         xdnesJ3duh4QmHlQ5Rgo+5wNkI4CaO8l6F6kHhoty+zQXCUidt6MYgyElAMmxJou2wuw
         CNhvsxxwMp60stvW6sJvubDUBu8S1XdC9xwuq448cb9V9uKmasJ/hJ6CqRiYr+Kf0+qy
         7L1rlbCv7mT4H8LFFbydHCg7PSz4PQJxCcBWxYh8p7vLf6duh8E6QEXgKlPPtZgTjGHI
         NNtP2PQM8XuyOL+bn1WY8arDen/AXG5VrVdRhPC92J/FlTMbrdH//xd67MXtpykQEzaT
         B0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=76HtG/G3/u0fsY1KqLEbCyWtum92OFhmLlpQQgnwOLg=;
        b=CdE1/hIPjLWblXyjV0OblmqmC88NT3TjbRz+LrQ9GWnY5kWkQTXVkhXBRPl5Y6ktVb
         tolR2Z3I3AJGr6ip06vu5p4L+lVY0U6NpH5PK6/1pZyhUjLn277cLL/C14TmfZZzcnr6
         Ki9owvYBFft/TeWLatyaGabpfgBmzn0F1g+MI5mNv6h1VohuXr1bsYG7cr0B6fmk88XD
         SpeCKGen/FGtbng2ymYylPeGWmfNn7GT8NkxmKvYwJa0vP05ynPJC/yjel/eDGnAnhJs
         e6kU4whCrRDMvdgfBr/m5vHqu+tlbB3tCO6x05rhRIGSNG5TR4ajv8Vrt+tzMUYA0lq5
         fuuQ==
X-Gm-Message-State: APjAAAVocjq2Y0GfbJBkd7+oKzFJ8zMHqWaX2jZqFYzchYi4hjJAOEze
        GE2XSGU69AoITUCnxcJnPh4+Aw==
X-Google-Smtp-Source: APXvYqz8frZiLMXkGOS/MsuoOIKMwhgKNuBuJZ+UUogdDBDW0Kgm8OL5mkKtc9A5XIcoEuhEhMbVvA==
X-Received: by 2002:a62:174a:: with SMTP id 71mr24212295pfx.140.1565384266773;
        Fri, 09 Aug 2019 13:57:46 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id j10sm68971586pfn.188.2019.08.09.13.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 13:57:45 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <FDCA3989-2003-43C8-B582-B4D7A352A6FE@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_6ABD222A-51EF-4176-8ABE-A689A105BFAF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 06/12] jbd2: fast-commit recovery path changes
Date:   Fri, 9 Aug 2019 14:57:43 -0600
In-Reply-To: <20190809034552.148629-7-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
 <20190809034552.148629-7-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_6ABD222A-51EF-4176-8ABE-A689A105BFAF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Aug 8, 2019, at 9:45 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> This patch adds fast-commit recovery path changes for JBD2. If we find
> a fast commit block that is valid in our recovery phase call file
> system specific routine to handle that block.
>=20
> We also clear the fast commit flag in jbd2_mark_journal_empty() which
> is called after successful recovery as well successful

... as well as after successful ...

> checkpointing. This allows JBD2 journal to be compatible with older
> versions when there are not fast commit blocks.
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

>=20
> ---
>=20
> Changelog:
>=20
> V2: Fixed checkpatch error.
> ---
> fs/jbd2/journal.c  | 12 ++++++++++
> fs/jbd2/recovery.c | 59 +++++++++++++++++++++++++++++++++++++++++++---
> 2 files changed, 68 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 1e15804b2c3c..ae4584a60cc3 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1604,6 +1604,7 @@ int jbd2_journal_update_sb_log_tail(journal_t =
*journal, tid_t tail_tid,
> static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
> {
> 	journal_superblock_t *sb =3D journal->j_superblock;
> +	bool had_fast_commit =3D false;
>=20
> 	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
> 	lock_buffer(journal->j_sb_buffer);
> @@ -1617,6 +1618,14 @@ static void jbd2_mark_journal_empty(journal_t =
*journal, int write_op)
>=20
> 	sb->s_sequence =3D cpu_to_be32(journal->j_tail_sequence);
> 	sb->s_start    =3D cpu_to_be32(0);
> +	if (jbd2_has_feature_fast_commit(journal)) {
> +		/*
> +		 * When journal is clean, no need to commit fast commit =
flag and
> +		 * make file system incompatible with older kernels.
> +		 */
> +		jbd2_clear_feature_fast_commit(journal);
> +		had_fast_commit =3D true;
> +	}
>=20
> 	jbd2_write_superblock(journal, write_op);
>=20
> @@ -1624,6 +1633,9 @@ static void jbd2_mark_journal_empty(journal_t =
*journal, int write_op)
> 	write_lock(&journal->j_state_lock);
> 	journal->j_flags |=3D JBD2_FLUSHED;
> 	write_unlock(&journal->j_state_lock);
> +
> +	if (had_fast_commit)
> +		jbd2_set_feature_fast_commit(journal);
> }
>=20
>=20
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index a4967b27ffb6..3a6cd1497504 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -225,8 +225,12 @@ static int count_tags(journal_t *journal, struct =
buffer_head *bh)
> /* Make sure we wrap around the log correctly! */
> #define wrap(journal, var)						=
\
> do {									=
\
> -	if (var >=3D (journal)->j_last)					=
\
> -		var -=3D ((journal)->j_last - (journal)->j_first);	=
\
> +	unsigned long _wrap_last =3D					=
\
> +		jbd2_has_feature_fast_commit(journal) ?			=
\
> +			(journal)->j_last_fc : (journal)->j_last;	=
\
> +									=
\
> +	if (var >=3D _wrap_last)						=
\
> +		var -=3D (_wrap_last - (journal)->j_first);		=
\
> } while (0)
>=20
> /**
> @@ -413,6 +417,49 @@ static int jbd2_block_tag_csum_verify(journal_t =
*j, journal_block_tag_t *tag,
> 		return tag->t_checksum =3D=3D cpu_to_be16(csum32);
> }
>=20
> +static int fc_do_one_pass(journal_t *journal,
> +			  struct recovery_info *info, enum passtype =
pass)
> +{
> +	unsigned int expected_commit_id =3D info->end_transaction;
> +	unsigned long next_fc_block;
> +	struct buffer_head *bh;
> +	unsigned int seq;
> +	journal_header_t *jhdr;
> +	int err =3D 0;
> +
> +	next_fc_block =3D journal->j_first_fc;
> +
> +	while (next_fc_block !=3D journal->j_last_fc) {
> +		jbd_debug(3, "Fast commit replay: next block %lld",
> +			  next_fc_block);
> +		err =3D jread(&bh, journal, next_fc_block);
> +		if (err)
> +			break;
> +
> +		jhdr =3D (journal_header_t *)bh->b_data;
> +		seq =3D be32_to_cpu(jhdr->h_sequence);
> +		if (be32_to_cpu(jhdr->h_magic) !=3D JBD2_MAGIC_NUMBER ||
> +		    seq !=3D expected_commit_id) {
> +			break;
> +		}
> +		jbd_debug(3, "Processing fast commit blk with seq %d",
> +			  seq);
> +		if (pass =3D=3D PASS_REPLAY &&
> +		    journal->j_fc_replay_callback) {
> +			err =3D journal->j_fc_replay_callback(journal,
> +							    bh);
> +			if (err)
> +				break;
> +		}
> +		next_fc_block++;
> +	}
> +
> +	if (err)
> +		jbd_debug(3, "Fast commit replay failed, err =3D %d\n", =
err);
> +
> +	return err;
> +}
> +
> static int do_one_pass(journal_t *journal,
> 			struct recovery_info *info, enum passtype pass)
> {
> @@ -470,7 +517,7 @@ static int do_one_pass(journal_t *journal,
> 				break;
>=20
> 		jbd_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
> -			  next_commit_ID, next_log_block, =
journal->j_last);
> +			  next_commit_ID, next_log_block, =
journal->j_last_fc);
>=20
> 		/* Skip over each chunk of the transaction looking
> 		 * either the next descriptor block or the final commit
> @@ -768,6 +815,8 @@ static int do_one_pass(journal_t *journal,
> 			if (err)
> 				goto failed;
> 			continue;
> +		case JBD2_FC_BLOCK:
> +			continue;
>=20
> 		default:
> 			jbd_debug(3, "Unrecognised magic %d, end of =
scan.\n",
> @@ -799,6 +848,10 @@ static int do_one_pass(journal_t *journal,
> 				success =3D -EIO;
> 		}
> 	}
> +
> +	if (jbd2_has_feature_fast_commit(journal) && pass =3D=3D =
PASS_REPLAY)
> +		fc_do_one_pass(journal, info, pass);
> +
> 	if (block_error && success =3D=3D 0)
> 		success =3D -EIO;
> 	return success;
> --
> 2.23.0.rc1.153.gdeed80330f-goog
>=20


Cheers, Andreas






--Apple-Mail=_6ABD222A-51EF-4176-8ABE-A689A105BFAF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1N3kcACgkQcqXauRfM
H+B/TA/9HFq0vr8vZtXEt+2xwrFyJhoHx5phDt9SBIl3nmdaRblu7xUqljEwDwmi
paeBmzqSheR8+OI3IwT5o7dhYiBTdvGUxwSsXi8YUrD2bMcQ0YTnx4Yl8DPIvLAS
rd1BgklFXm2A8K0YZ260b4F6G9TC9IeS8rWkWqdK4fow7lvrOzfO7tIAr5EhEPzm
aV11HaoPrCS74+xGAdJpB3OHvlktC7QFQfQnH2wccUrUrZR9xIaoW5jiBXAr+d9z
Mn97evTNt4jHsDD17wsFJEPOriyIDFd8c4sbvIKCSOUFFqp+lIpywYYT0zmuelN4
+yVlvTD9AE5L64U/J2Ll6lYWETj4DuwBiJjQOMJJRIn9Y34ehCBWlI+GI5kPUa8i
XAXgqJ4TAewjXexh3JNzBKkUzXQ6rsQyO5DdXk9yKGEKgf5YwJGFe5TxnF71flGS
yn8ugpqpEARjtopobgq4bxZ6kXQ1zllAQiD0vGZx8Pgzms8oJIPA2bsqbalpkFTO
y7eNEQZRGKDbWPd7AkTtKEvL4KxnjuXDOfFugqlefzdI5NKiVGkvP3SrLieshygQ
dlI40fPn2ns4c9t/0nrJ5uqApEQLfk1zAYBI7lleOryCFdfY/5E4Ec0gaIN+tAY2
Olmxs9fn9MwhdTIZH1gStM531rLLQpEH5V30OQ+yJzVcGF3WxT4=
=LOnB
-----END PGP SIGNATURE-----

--Apple-Mail=_6ABD222A-51EF-4176-8ABE-A689A105BFAF--
