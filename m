Return-Path: <linux-ext4+bounces-6231-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A34C1A1BE65
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jan 2025 23:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716DE188BA4A
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jan 2025 22:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA83E1E7C1F;
	Fri, 24 Jan 2025 22:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="T17bXoOX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E0D1DB363
	for <linux-ext4@vger.kernel.org>; Fri, 24 Jan 2025 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737757707; cv=none; b=Kht6dFTjl4GV84QPdxeR5Qh+qCi/e/fyatc9uq9UVtnLMoZcysvYoPB/PQ16TY3txQRvh8DJNxGLuJGkVJnyoswsi2LqBrHLcO8E4dMyAOkr05FePWhsgLus4hLovPBEoFBvfJCCSukyl73EVswFyVPLllPyfCnNSaMVliaMWI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737757707; c=relaxed/simple;
	bh=lFLZMDurgWrUWyJpGXu7TehGxAlOzsIWQRxq5Lb+Uuk=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=p6OsowhlnfXEl9yJDKJBc1CiAHNJN/HZuD2IrIRUZyvVnP8lpGJCBunvjh4s0Fsgzuefosr74ubGppXSP6cey/jhmfZqMTY+akZmAo43okWy2Kdt3CCHXVdsxWKGUrXztpG7ooxurm6jsU/K2hC0f0i7qjxS57oCUzAp2qWY1L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=T17bXoOX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21631789fcdso50567555ad.1
        for <linux-ext4@vger.kernel.org>; Fri, 24 Jan 2025 14:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1737757703; x=1738362503; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QIwdKGtAYltGzmFSg1+KhYKdo2tA1zVdIdvG9+KnB+U=;
        b=T17bXoOXqxkF+kDhmcKOhT1KAfpo5lSk08Cf/I2tTLtegbMvgaRSb4Hrhi8fuDKMnl
         WXdYepHbRkwlDbvqiArBu+WYI6MS8+HFtx+gVL80XoFsgqqleUYNqyUj0kg7DP6SckLP
         djVLAV0kDYo6rYJ8hHSqKIDcNqzjt36/rFGH7HNKr3W86kAnYW7KyT1KpdUCRVZXJU+T
         RfJZjb3O5i5k+Pjx0hGjoz5k82kznGEEflkUxk0dqERqCmx4TG7r69D5LBLzaD5907rJ
         fVJOu4a6w6IGxmbtTQIAfwGXxLbXmp/Ox2kM1xsZjBT4D8Mqq3XUB/Pr3tSQFWuQZO/N
         EuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737757703; x=1738362503;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIwdKGtAYltGzmFSg1+KhYKdo2tA1zVdIdvG9+KnB+U=;
        b=Fv0JtYU6I/+zruL12NtLhpbHO6gDqJk12l5OKzkuUVUOSbSD4BEs6o3wpsUkUqsnja
         jrhZ4TkeMHdtwZjE5vQLYVSohpVj6NhqJSzUc63ilzhGGe5+DfsEbjjzUinAx87Bns8T
         KpwpcNpMI64jA+e6yOTbJ58YK1q7HLZs8QwmdAgLEbINJC9LuI9Km9PokaGPPoz5m+Rm
         D4HY1cTqiczr2h7PkVvLE73fYlkG6mn7XxeNFM7PukrIV9ac6P4QfRTBiXNa3IVVTB+9
         uDo60rycosnCsdVXjZCNbXn4g9A/AfrQzD2LUqPCdSmnz9bASdjw8wznzk6vBcn2VzWe
         JY/A==
X-Forwarded-Encrypted: i=1; AJvYcCUTYIIoZXbAKzyhcSme92mpVHCVQS/6ALLYQvO//nqVqd+s1nsPrkwjfLTwYWPNB0/rbOcW8+KPm9xB@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTOQMxH1gEtw4SvP77TVTeG9SI9PJ+ErRHEtTodx+ITAyF/sL
	EbEsmbyhAKP28r0sIjlUiGV3XUM5/ZQcyu41r57x0cd+mS9D3v0ACVOSJJhr1uM=
X-Gm-Gg: ASbGnctQdKMm8Muu/yNevs8qWsplKeYQYAinsRigEHQZcbJ/Y7Rfior5uPUE2zxZXCt
	Ix++/mpcoVvF/SH3U3fqUoRIYqgiyu2P1EavCeU9wqPAmUxmfLWklFk3EEDbCvKfuoH/ocTicfX
	7UhL9uBDk+GRNoLkjHw/OxaUkRmLmh56aw9Gk4ORqTnj7uFS0Hke7f7g7+58c1RTnGGjhJDYOT5
	kisWBC7DiahfTCeCRYRebT0MOYMsP6JsLou9Kmb9jm87bZRXeBVzbo+RLhaFJf4KIRm8m7Oh6xk
	IpqkWhpKyulvkde1xBIdr0oFI/4yLAwsmEb6zfJOwcD/LhHrlycB9w==
X-Google-Smtp-Source: AGHT+IHP3AnvH8RFlXIo4WVkzNmBfH+Fbk8iGkiaO5uL/LkOQ6xBdB2aBcqj/z+dg9osoOmVQCYGbw==
X-Received: by 2002:a05:6a00:aa05:b0:725:41c4:dbc7 with SMTP id d2e1a72fcca58-72f7d20675amr15702209b3a.4.1737757703194;
        Fri, 24 Jan 2025 14:28:23 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a69eb69sm2496121b3a.13.2025.01.24.14.28.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2025 14:28:22 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <AF2CAD6A-A078-4FF4-AA0C-BF170BA5560B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A124609C-8E08-452D-BD58-22738D11BE76";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] jbd2: Avoid long replay times due to high number or
 revoke blocks
Date: Fri, 24 Jan 2025 15:28:19 -0700
In-Reply-To: <20250121140925.17231-2-jack@suse.cz>
Cc: Ted Tso <tytso@mit.edu>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Alexey Zhuravlev <azhuravlev@ddn.com>,
 Zhang Yi <yi.zhang@huawei.com>,
 Li Dongyang <dongyangli@ddn.com>
To: Jan Kara <jack@suse.cz>
References: <20250121140925.17231-2-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_A124609C-8E08-452D-BD58-22738D11BE76
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 21, 2025, at 7:09 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> Some users are reporting journal replay takes a long time when there =
is
> excessive number of revoke blocks in the journal. Reported times are
> like:
>=20
> 1048576 records - 95 seconds
> 2097152 records - 580 seconds
>=20
> The problem is that hash chains in the revoke table gets excessively
> long in these cases. Fix the problem by sizing the revoke table
> appropriately before the revoke pass.
>=20
> Thanks to Alexey Zhuravlev <azhuravlev@ddn.com> for benchmarking the
> patch with large numbers of revoke blocks [1].
>=20
> [1] https://lore.kernel.org/all/20250113183107.7bfef7b6@x390.bzzz77.ru
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/jbd2/recovery.c   | 58 ++++++++++++++++++++++++++++++++++++--------
> fs/jbd2/revoke.c     |  8 +++---
> include/linux/jbd2.h |  2 ++
> 3 files changed, 54 insertions(+), 14 deletions(-)
>=20
> Changes since v1:
> * rebased on 6.13
> * move check in do_one_pass()
>=20
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 9192be7c19d8..7c23a8be673f 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -39,7 +39,7 @@ struct recovery_info
>=20
> static int do_one_pass(journal_t *journal,
> 				struct recovery_info *info, enum =
passtype pass);
> -static int scan_revoke_records(journal_t *, struct buffer_head *,
> +static int scan_revoke_records(journal_t *, enum passtype, struct =
buffer_head *,
> 				tid_t, struct recovery_info *);
>=20
> #ifdef __KERNEL__
> @@ -327,6 +327,12 @@ int jbd2_journal_recover(journal_t *journal)
> 		  journal->j_transaction_sequence, journal->j_head);
>=20
> 	jbd2_journal_clear_revoke(journal);
> +	/* Free revoke table allocated for replay */
> +	if (journal->j_revoke !=3D journal->j_revoke_table[0] &&
> +	    journal->j_revoke !=3D journal->j_revoke_table[1]) {
> +		jbd2_journal_destroy_revoke_table(journal->j_revoke);
> +		journal->j_revoke =3D journal->j_revoke_table[1];
> +	}
> 	err2 =3D sync_blockdev(journal->j_fs_dev);
> 	if (!err)
> 		err =3D err2;
> @@ -612,6 +618,31 @@ static int do_one_pass(journal_t *journal,
> 	first_commit_ID =3D next_commit_ID;
> 	if (pass =3D=3D PASS_SCAN)
> 		info->start_transaction =3D first_commit_ID;
> +	else if (pass =3D=3D PASS_REVOKE) {
> +		/*
> +		 * Would the default revoke table have too long hash =
chains
> +		 * during replay?
> +		 */
> +		if (info->nr_revokes > JOURNAL_REVOKE_DEFAULT_HASH * 16) =
{
> +			unsigned int hash_size;
> +
> +			/*
> +			 * Aim for average chain length of 8, limit at =
1M
> +			 * entries to avoid problems with malicious
> +			 * filesystems.
> +			 */
> +			hash_size =3D =
min(roundup_pow_of_two(info->nr_revokes / 8),
> +					1U << 20);
> +			journal->j_revoke =3D
> +				=
jbd2_journal_init_revoke_table(hash_size);
> +			if (!journal->j_revoke) {
> +				printk(KERN_ERR
> +				       "JBD2: failed to allocate revoke =
table for replay with %u entries. "
> +				       "Journal replay may be slow.\n", =
hash_size);
> +				journal->j_revoke =3D =
journal->j_revoke_table[1];
> +			}
> +		}
> +	}
>=20
> 	jbd2_debug(1, "Starting recovery pass %d\n", pass);
>=20
> @@ -851,6 +882,13 @@ static int do_one_pass(journal_t *journal,
> 			continue;
>=20
> 		case JBD2_REVOKE_BLOCK:
> +			/*
> +			 * If we aren't in the SCAN or REVOKE pass, then =
we can
> +			 * just skip over this block.
> +			 */
> +			if (pass !=3D PASS_REVOKE && pass !=3D =
PASS_SCAN)
> +				continue;
> +
> 			/*
> 			 * Check revoke block crc in pass_scan, if csum =
verify
> 			 * failed, check commit block time later.
> @@ -863,12 +901,7 @@ static int do_one_pass(journal_t *journal,
> 				need_check_commit_time =3D true;
> 			}
>=20
> -			/* If we aren't in the REVOKE pass, then we can
> -			 * just skip over this block. */
> -			if (pass !=3D PASS_REVOKE)
> -				continue;
> -
> -			err =3D scan_revoke_records(journal, bh,
> +			err =3D scan_revoke_records(journal, pass, bh,
> 						  next_commit_ID, info);
> 			if (err)
> 				goto failed;
> @@ -922,8 +955,9 @@ static int do_one_pass(journal_t *journal,
>=20
> /* Scan a revoke record, marking all blocks mentioned as revoked. */
>=20
> -static int scan_revoke_records(journal_t *journal, struct buffer_head =
*bh,
> -			       tid_t sequence, struct recovery_info =
*info)
> +static int scan_revoke_records(journal_t *journal, enum passtype =
pass,
> +			       struct buffer_head *bh, tid_t sequence,
> +			       struct recovery_info *info)
> {
> 	jbd2_journal_revoke_header_t *header;
> 	int offset, max;
> @@ -944,6 +978,11 @@ static int scan_revoke_records(journal_t =
*journal, struct buffer_head *bh,
> 	if (jbd2_has_feature_64bit(journal))
> 		record_len =3D 8;
>=20
> +	if (pass =3D=3D PASS_SCAN) {
> +		info->nr_revokes +=3D (max - offset) / record_len;
> +		return 0;
> +	}
> +
> 	while (offset + record_len <=3D max) {
> 		unsigned long long blocknr;
> 		int err;
> @@ -956,7 +995,6 @@ static int scan_revoke_records(journal_t *journal, =
struct buffer_head *bh,
> 		err =3D jbd2_journal_set_revoke(journal, blocknr, =
sequence);
> 		if (err)
> 			return err;
> -		++info->nr_revokes;
> 	}
> 	return 0;
> }
> diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
> index 4556e4689024..f4ac308e84c5 100644
> --- a/fs/jbd2/revoke.c
> +++ b/fs/jbd2/revoke.c
> @@ -215,7 +215,7 @@ int __init =
jbd2_journal_init_revoke_table_cache(void)
> 	return 0;
> }
>=20
> -static struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int =
hash_size)
> +struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int =
hash_size)
> {
> 	int shift =3D 0;
> 	int tmp =3D hash_size;
> @@ -231,7 +231,7 @@ static struct jbd2_revoke_table_s =
*jbd2_journal_init_revoke_table(int hash_size)
> 	table->hash_size =3D hash_size;
> 	table->hash_shift =3D shift;
> 	table->hash_table =3D
> -		kmalloc_array(hash_size, sizeof(struct list_head), =
GFP_KERNEL);
> +		kvmalloc_array(hash_size, sizeof(struct list_head), =
GFP_KERNEL);
> 	if (!table->hash_table) {
> 		kmem_cache_free(jbd2_revoke_table_cache, table);
> 		table =3D NULL;
> @@ -245,7 +245,7 @@ static struct jbd2_revoke_table_s =
*jbd2_journal_init_revoke_table(int hash_size)
> 	return table;
> }
>=20
> -static void jbd2_journal_destroy_revoke_table(struct =
jbd2_revoke_table_s *table)
> +void jbd2_journal_destroy_revoke_table(struct jbd2_revoke_table_s =
*table)
> {
> 	int i;
> 	struct list_head *hash_list;
> @@ -255,7 +255,7 @@ static void =
jbd2_journal_destroy_revoke_table(struct jbd2_revoke_table_s *table)
> 		J_ASSERT(list_empty(hash_list));
> 	}
>=20
> -	kfree(table->hash_table);
> +	kvfree(table->hash_table);
> 	kmem_cache_free(jbd2_revoke_table_cache, table);
> }
>=20
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 50f7ea8714bf..610841635204 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1634,6 +1634,8 @@ extern void	   =
jbd2_journal_destroy_revoke_record_cache(void);
> extern void	   jbd2_journal_destroy_revoke_table_cache(void);
> extern int __init jbd2_journal_init_revoke_record_cache(void);
> extern int __init jbd2_journal_init_revoke_table_cache(void);
> +struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int =
hash_size);
> +void jbd2_journal_destroy_revoke_table(struct jbd2_revoke_table_s =
*table);
>=20
> extern void	   jbd2_journal_destroy_revoke(journal_t *);
> extern int	   jbd2_journal_revoke (handle_t *, unsigned long long, =
struct buffer_head *);
> --
> 2.43.0
>=20


Cheers, Andreas






--Apple-Mail=_A124609C-8E08-452D-BD58-22738D11BE76
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmeUFAMACgkQcqXauRfM
H+C1LA//d4UodQiV+A+4SxRn/o16sPZiLcJTD9IcRUTTjjFUVglcr24g62yHG51u
1cnqVYxZ1NGNTNrp1eetSArDrGp7tHnUb0kF7fYwM3ln2XiJ2tdj21kuHIcXoUwV
oGONZiPszTlsIXQBNq6Hg518ABULf5dTz9uO5sFmN+V67g1tTrIJPHYDWs0Nd33x
UImUrpFJg4oSyrRAP+LE07GS9eUavxlECw4gLwpY8IzUf8ns+M1d4JyLlRdnCDDw
1dElCzIfmVyk7qAQ3QJ7PcSb0e7AOiNKTedtOkt5lwK9U0fmrt8Uxf+PhWqyZ629
Hy3hw3EVV4U5Lxr44nsxjc9eL+yqt98id9LeGPBmVWY4ljWoKe9Fc7dBHmdW3550
c75fmrDAN6Q9+7AyrokrPU1E+FAqulq6kMV9+BYyiKbDEIYmHCbRpKNs89q4nF7m
2GQK8PnxiLVduv4020P1cwmKZKFq3C+Mwe7rEwNTEYeQ9VrOpRNFHRgI0XsIRR27
mmi5TjaAqQAwgv9ONyI4tIebuqSlXKe+y+ipJjNXepbQfWBvuT/y6kpU7CT/1R6g
I5rAsnXEvlf3FE2OfKauyem80xnpFw7I3gN1klsDGJSVnQdVt0ZdmxmIdRbDr01m
onuEdDbYm6N+WJAlW42rqgtJUDKEGq3ZfN4NcxDXMH3ldKpcGa4=
=5ib/
-----END PGP SIGNATURE-----

--Apple-Mail=_A124609C-8E08-452D-BD58-22738D11BE76--

