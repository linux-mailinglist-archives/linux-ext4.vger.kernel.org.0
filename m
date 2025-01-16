Return-Path: <linux-ext4+bounces-6129-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3EDA12F78
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jan 2025 01:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682E83A576A
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jan 2025 00:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DC8A50;
	Thu, 16 Jan 2025 00:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="FlAG15JU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70964EC4
	for <linux-ext4@vger.kernel.org>; Thu, 16 Jan 2025 00:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736986091; cv=none; b=oChbUm95894zzX7r1z9n96Tz23rkofxMPHyS08ixJX9q3oX81W2fVLx93wlOkGQEBuypguABq858MEEzehEXluWFeoncdcNRCbHDkAQKIWNFdR00zjtgWyhoTfilIJZHuTYGAEKb3aWQ+Gd5Zy5U77+GQa+R+C35NBr+0hDpntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736986091; c=relaxed/simple;
	bh=N2Jvn9l6VbqWuwV3+Ji8AjnPeDez/5B/rHGuyAJGWj8=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=qqK8ox9DIG/z3Z2ANuXe7VyZ7rCKXVNgg/+2HMRkB5+xEuahQukZqMRLJstrGb2LdtGZLneqVXFRgG+qOYYJvNGtxpnxgIlJ5TJLZPoIWvM4XuBNy5l+nmrhr2nbBtfz2Adq558F+rnaQtIarRpT5z/IL5WI9V9rCxYjZhHawLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=FlAG15JU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-218c8aca5f1so6750865ad.0
        for <linux-ext4@vger.kernel.org>; Wed, 15 Jan 2025 16:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1736986088; x=1737590888; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5XhZ4olIBPsoiEWHAuxRlg+Ia8WSD/FJhaP37D81vW4=;
        b=FlAG15JUArrcIbpSbNEk2AuwpC+rRcr48oOQcOwIIBqdRDcxb2GmZ+uSm+iy4ncJtl
         MdDij/z2BWa5jj2cf0XTBLKx+odZYzwga5+tnPorUnr64rjm3pjC2V/kBUXxBBGHY4qE
         SAEwXUh9Anf0l0kwMI618MBD/wxhHnVtN8kGExrnbHE4hRgY/L0TLobaFMD+ANZZj3FH
         YNAw3kicUF9r3W48NHYHwbNmAAhf2Br4wJ2xuYiZpNqbKRROJ0R1ftOiZydz8jBlEHaY
         3dzEMeurH7IVthL1I1lR5yE6XmX33JKipJMhaYCnSakvebwcUA/p5VYC/eR5JVzd3Sxn
         HP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736986088; x=1737590888;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5XhZ4olIBPsoiEWHAuxRlg+Ia8WSD/FJhaP37D81vW4=;
        b=Rr6dGHcnw19/bxLE9yp2MfA3vOr55b3hQIUMN9rUQv4pWZR4LcUvWK78YQ1rOOxyA8
         noHGOjGGo21FuU43FxoFqtAqVASEFGIQC6Pi6pLmseQKENUz/3wfWaXTSflfhWWYKlIC
         EiPw3Y9kxjvPJwQrjwwC1KSjKNSVoP9bs60ikjqf25xi/H5Gy4ueFX0drx4A5/iSbyAf
         u1ewjM8Z2OVrBPprUgqevOK7bNtm7Eoi85iSB+lhmEz0lUN1Yp6h4hbNmCHrY26WJnMF
         Rq31HqMdL/LMFbvJUUIvEfJKw+d+W0gqU4mixh3v9cWNF3byyky5GcsrKuFQx9VZ36hi
         KZOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKZK+PQCRf898HVhbixCUVxe9+1hfvpELwP0RAHE3Tc9nNcLeaaoTRBvc5rQiFtb3NU1SG5LBsEcTA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcw0ctXAh2dOPCWGBeS54szdRApdQy/fX1mXxx47dJOnIPjEAM
	v/ZC5NMo+OjTol2tYV0ApAiMsGiEcNTIXx89fnyhuaNVZfkuN3FTxKJd0l+2MWT9ikjukE/T6wy
	/
X-Gm-Gg: ASbGncvcrQ/hnTN57Sp/h3KGsFMnOaM0YReELEVspLrBgmPc/7/pnKaxhFo96xIS40B
	xAU1wBL/WH5Zg3GzK4YneG0QXo/gTUg/aNkM64n0A17XY3NLbNA+lpKT1t3BpREswfsJozr9p5r
	j+LyTW7RkMLx4HS8beLaK5HOZg0Nx9Qwhq05Hp+pznH16rJLuDeihpYj6H0nBNOuaICixaAGHoB
	H2RvEdQhx58RFtW97Ni6n+Jd9h6itXBhcjflf8B32TRqqN/YrMcnN05cdcdvQ7Z8udZhkeL10PT
	aXymh5WUTgQ5CB4sZ4fE/Oy/lpICww==
X-Google-Smtp-Source: AGHT+IFuk/RHYny3bbfaAEdWLGYgzJMk0keqer9nW/oe+EN+UcsQV3z5ICAv835zLd/ytOk/hF8aiA==
X-Received: by 2002:a17:902:d2d0:b0:216:45b9:439b with SMTP id d9443c01a7336-21a8400a357mr490100285ad.50.1736986087616;
        Wed, 15 Jan 2025 16:08:07 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f21a21csm88069145ad.109.2025.01.15.16.08.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2025 16:08:06 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <C3DE528C-218D-49DD-AF81-3C84CA131ED5@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_87C18749-2439-43F1-9E3C-9F5A8EBBCE8F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH V2] jbd2: use rhashtable for revoke records during replay
Date: Wed, 15 Jan 2025 17:08:03 -0700
In-Reply-To: <20241113144752.3hzcbrhvh4znrcf7@quack3>
Cc: Li Dongyang <dongyangli@ddn.com>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Alex Zhuravlev <bzzz@whamcloud.com>
To: Jan Kara <jack@suse.cz>,
 Theodore Ts'o <tytso@mit.edu>
References: <20241105034428.578701-1-dongyangli@ddn.com>
 <20241108103358.ziocxsyapli2pexv@quack3> <20241108161118.GA42603@mit.edu>
 <11AF8D3C-411F-436C-AC8D-B1C057D02091@dilger.ca>
 <20241113144752.3hzcbrhvh4znrcf7@quack3>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_87C18749-2439-43F1-9E3C-9F5A8EBBCE8F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 13, 2024, at 7:47 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> On Tue 12-11-24 11:44:11, Andreas Dilger wrote:
>> On Nov 8, 2024, at 9:11 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>>>=20
>>> On Fri, Nov 08, 2024 at 11:33:58AM +0100, Jan Kara wrote:
>>>>> 1048576 records - 95 seconds
>>>>> 2097152 records - 580 seconds
>>>>=20
>>>> These are really high numbers of revoke records. Deleting couple GB =
of
>>>> metadata doesn't happen so easily. Are they from a real workload or =
just
>>>> a stress test?
>>>=20
>>> For context, the background of this is that this has been an
>>> out-of-tree that's been around for a very long time, for use with
>>> Lustre servers where apparently, this very large number of revoke
>>> records is a real thing.
>>=20
>> Yes, we've seen this in production if there was a crash after =
deleting
>> many millions of log records.  This causes remount to take =
potentially
>> several hours before completing (and this was made worse by HA =
causing
>> failovers due to mount being "stuck" doing the journal replay).
>=20
> Thanks for clarification!
>=20
>>>> If my interpretation is correct, then rhashtable is unnecessarily
>>>> huge hammer for this. Firstly, as the big hash is needed only =
during
>>>> replay, there's no concurrent access to the data
>>>> structure. Secondly, we just fill the data structure in the
>>>> PASS_REVOKE scan and then use it. Thirdly, we know the number of
>>>> elements we need to store in the table in advance (well, currently
>>>> we don't but it's trivial to modify PASS_SCAN to get that number).
>>>>=20
>>>> So rather than playing with rhashtable, I'd modify PASS_SCAN to sum
>>>> up number of revoke records we're going to process and then prepare
>>>> a static hash of appropriate size for replay (we can just use the
>>>> standard hashing fs/jbd2/revoke.c uses, just with differently sized
>>>> hash table allocated for replay and point journal->j_revoke to
>>>> it). And once recovery completes jbd2_journal_clear_revoke() can
>>>> free the table and point journal->j_revoke back to the original
>>>> table. What do you think?
>>>=20
>>> Hmm, that's a really nice idea; Andreas, what do you think?
>>=20
>> Implementing code to manually count and resize the recovery hashtable
>> will also have its own complexity, including possible allocation size
>> limits for a huge hash table.  That could be worked around by =
kvmalloc(),
>> but IMHO this essentially starts "open coding" something rhashtable =
was
>> exactly designed to avoid.
>=20
> Well, I'd say the result is much simpler than rhashtable code since
> you don't need all that dynamic reallocation and complex locking. =
Attached is a patch that implements my suggestion. I'd say it is
> simpler than having two types of revoke block hashing depending on
> whether we are doing recovery or running the journal.
>=20
> I've tested it and it seems to work fine (including replay of a
> journal with sufficiently many revoke blocks) but I'm not sure
> I can do a meaningful performance testing (I cannot quite reproduce
> the slow replay times even when shutting down the filesystem after
> deleting 1000000 directories). So can you please give it a spin?

Alex posted test results on the other rhashtable revoke thread,
which show both the rhashtable and Jan's dynamically-allocated hash
table perform much better than the original fixed-size hash table.

On Jan 13, 2025, at 8:31 AM, Alexey Zhuravlev <azhuravlev@ddn.com> =
wrote:
> I benchmarked rhashtable based patch vs Jan's patch:
>=20
> records		vanilla	rhashtable	JK patch
> 2.5M records	102s	29s		25s
> 5.0M records	317s	28s		30s
> 6.0M records	--	35s		44s
>=20
> The tests were done using 4.18 kernel (I guess this doesn't
> matter much in this context), using an SSD.
>=20
> Time to mount after a crash (simulated with read-only device
> mapper) was measured.
>=20
> Unfortunately I wasn't able to reproduce with more records
> as my test node has just 32GB RAM,

I'm OK with either variant landing.  This issue doesn't happen on
a regular basis, only when a huge amount of data is deleted just
before the server crashes, so waiting +/-5s for revoke processing
isn't critical, but waiting for 30h definitely is a problem.

Jan, do you want to resubmit your patch as a standalone email,
or can Ted just take it from below (or the original attachment on
your email)?

Note I also have a patch for e2fsprogs to scale the revoke hashtable
size, to avoid a similar issue with e2fsck. I will submit separately.

Cheers, Andreas

> =46rom db87b1d2cac01bc8336b70a32616388e6ff9fa8f Mon Sep 17 00:00:00 =
2001
> From: Jan Kara <jack@suse.cz>
> Date: Wed, 13 Nov 2024 11:53:13 +0100
> Subject: [PATCH] jbd2: Avoid long replay times due to high number or =
revoke
>  blocks
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
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/jbd2/recovery.c   | 54 =
+++++++++++++++++++++++++++++++++++++-------
>  fs/jbd2/revoke.c     |  8 +++----
>  include/linux/jbd2.h |  2 ++
>  3 files changed, 52 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 667f67342c52..9845f72e456a 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -39,7 +39,7 @@ struct recovery_info
>=20
>  static int do_one_pass(journal_t *journal,
>  				struct recovery_info *info, enum =
passtype pass);
> -static int scan_revoke_records(journal_t *, struct buffer_head *,
> +static int scan_revoke_records(journal_t *, enum passtype, struct =
buffer_head *,
>  				tid_t, struct recovery_info *);
>=20
>  #ifdef __KERNEL__
> @@ -327,6 +327,12 @@ int jbd2_journal_recover(journal_t *journal)
>  		  journal->j_transaction_sequence, journal->j_head);
>=20
>  	jbd2_journal_clear_revoke(journal);
> +	/* Free revoke table allocated for replay */
> +	if (journal->j_revoke !=3D journal->j_revoke_table[0] &&
> +	    journal->j_revoke !=3D journal->j_revoke_table[1]) {
> +		jbd2_journal_destroy_revoke_table(journal->j_revoke);
> +		journal->j_revoke =3D journal->j_revoke_table[1];
> +	}
>  	err2 =3D sync_blockdev(journal->j_fs_dev);
>  	if (!err)
>  		err =3D err2;
> @@ -517,6 +523,31 @@ static int do_one_pass(journal_t *journal,
>  	first_commit_ID =3D next_commit_ID;
>  	if (pass =3D=3D PASS_SCAN)
>  		info->start_transaction =3D first_commit_ID;
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
>  	jbd2_debug(1, "Starting recovery pass %d\n", pass);
>=20
> @@ -874,14 +905,16 @@ static int do_one_pass(journal_t *journal,
>  				need_check_commit_time =3D true;
>  			}
>=20
> -			/* If we aren't in the REVOKE pass, then we can
> -			 * just skip over this block. */
> -			if (pass !=3D PASS_REVOKE) {
> +			/*
> +			 * If we aren't in the SCAN or REVOKE pass, then =
we can
> +			 * just skip over this block.
> +			 */
> +			if (pass !=3D PASS_REVOKE && pass !=3D =
PASS_SCAN) {
>  				brelse(bh);
>  				continue;
>  			}
>=20
> -			err =3D scan_revoke_records(journal, bh,
> +			err =3D scan_revoke_records(journal, pass, bh,
>  						  next_commit_ID, info);
>  			brelse(bh);
>  			if (err)
> @@ -937,8 +970,9 @@ static int do_one_pass(journal_t *journal,
>=20
>  /* Scan a revoke record, marking all blocks mentioned as revoked. */
>=20
> -static int scan_revoke_records(journal_t *journal, struct buffer_head =
*bh,
> -			       tid_t sequence, struct recovery_info =
*info)
> +static int scan_revoke_records(journal_t *journal, enum passtype =
pass,
> +			       struct buffer_head *bh, tid_t sequence,
> +			       struct recovery_info *info)
>  {
>  	jbd2_journal_revoke_header_t *header;
>  	int offset, max;
> @@ -959,6 +993,11 @@ static int scan_revoke_records(journal_t =
*journal, struct buffer_head *bh,
>  	if (jbd2_has_feature_64bit(journal))
>  		record_len =3D 8;
>=20
> +	if (pass =3D=3D PASS_SCAN) {
> +		info->nr_revokes +=3D (max - offset) / record_len;
> +		return 0;
> +	}
> +
>  	while (offset + record_len <=3D max) {
>  		unsigned long long blocknr;
>  		int err;
> @@ -971,7 +1010,6 @@ static int scan_revoke_records(journal_t =
*journal, struct buffer_head *bh,
>  		err =3D jbd2_journal_set_revoke(journal, blocknr, =
sequence);
>  		if (err)
>  			return err;
> -		++info->nr_revokes;
>  	}
>  	return 0;
>  }
> diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
> index 4556e4689024..f4ac308e84c5 100644
> --- a/fs/jbd2/revoke.c
> +++ b/fs/jbd2/revoke.c
> @@ -215,7 +215,7 @@ int __init =
jbd2_journal_init_revoke_table_cache(void)
>  	return 0;
>  }
>=20
> -static struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int =
hash_size)
> +struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int =
hash_size)
>  {
>  	int shift =3D 0;
>  	int tmp =3D hash_size;
> @@ -231,7 +231,7 @@ static struct jbd2_revoke_table_s =
*jbd2_journal_init_revoke_table(int hash_size)
>  	table->hash_size =3D hash_size;
>  	table->hash_shift =3D shift;
>  	table->hash_table =3D
> -		kmalloc_array(hash_size, sizeof(struct list_head), =
GFP_KERNEL);
> +		kvmalloc_array(hash_size, sizeof(struct list_head), =
GFP_KERNEL);
>  	if (!table->hash_table) {
>  		kmem_cache_free(jbd2_revoke_table_cache, table);
>  		table =3D NULL;
> @@ -245,7 +245,7 @@ static struct jbd2_revoke_table_s =
*jbd2_journal_init_revoke_table(int hash_size)
>  	return table;
>  }
>=20
> -static void jbd2_journal_destroy_revoke_table(struct =
jbd2_revoke_table_s *table)
> +void jbd2_journal_destroy_revoke_table(struct jbd2_revoke_table_s =
*table)
>  {
>  	int i;
>  	struct list_head *hash_list;
> @@ -255,7 +255,7 @@ static void =
jbd2_journal_destroy_revoke_table(struct jbd2_revoke_table_s *table)
>  		J_ASSERT(list_empty(hash_list));
>  	}
>=20
> -	kfree(table->hash_table);
> +	kvfree(table->hash_table);
>  	kmem_cache_free(jbd2_revoke_table_cache, table);
>  }
>=20
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 8aef9bb6ad57..781615214d47 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1634,6 +1634,8 @@ extern void	   =
jbd2_journal_destroy_revoke_record_cache(void);
>  extern void	   jbd2_journal_destroy_revoke_table_cache(void);
>  extern int __init jbd2_journal_init_revoke_record_cache(void);
>  extern int __init jbd2_journal_init_revoke_table_cache(void);
> +struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int =
hash_size);
> +void jbd2_journal_destroy_revoke_table(struct jbd2_revoke_table_s =
*table);
>=20
>  extern void	   jbd2_journal_destroy_revoke(journal_t *);
>  extern int	   jbd2_journal_revoke (handle_t *, unsigned long long, =
struct buffer_head *);
> --
> 2.35.3




Cheers, Andreas






--Apple-Mail=_87C18749-2439-43F1-9E3C-9F5A8EBBCE8F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmeITeQACgkQcqXauRfM
H+B0qg/8CAc8eP+Q/gywN5iL/mZv9+AgucMeXQG6WzcwiF7fvyWGaWGWvvEUaCxS
KTA7/C+mhZTvH7kfhixR7b7tjbitsyytMQdVHMgY/5Al26ih7YlcO9JuVQm3W3a5
RDWynl/0pmmjQDB29B2JjWJd9dPBI1Uik60QuTEkleIhXMt2+ZvOgtlV0lhZYb4R
In0aqh7X1NIxPLhe5Gimx2KNqQ1dthrvgUb+QpB+4brK9Dg86bfofsxNDpQCx26P
bmZAPaCeUdO8Tzze/7o2VTTLZ8v+2WmZC9IX0nCygo+Lrrsib3IamD91EwaAnvgK
TkMHGFGNVD1UZzCrzpCM7gy8CaE6MvTxmkh5ya3xtyvnHvikeNjc4qSvrHam0vz3
sBXxlogzeE+Sbtr2UgOhNBwDw6rPtXp12lgq6V4gYUitNHnz6AnpL6QYIIODJgKB
lgyXCY9z/tGG3iXR/rPw3Bkj6FISxCJbCTnC+iOx5aKmjn5THbwCVf+yGwJllW6V
4Xxjg9VJLGmwoDkpM1IwkWwLdOFR/3rIOdn3UauPzCsXe/BdQ4fnH+u9yX5w9DtA
vOvebHTIo+7Uj+zX0QpTo8gF9zkKZVjNI7Pm/260RVH2NNulJ5XLRB9I3U6xCbq8
4IOFUz7tiYt7jA67lzspdtujxSmgGm4rxFJSQu/lBgWjffjNVck=
=h62+
-----END PGP SIGNATURE-----

--Apple-Mail=_87C18749-2439-43F1-9E3C-9F5A8EBBCE8F--

