Return-Path: <linux-ext4+bounces-13516-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHuzNejCgmkpaAMAu9opvQ
	(envelope-from <linux-ext4+bounces-13516-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 04:54:16 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C0EE1680
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 04:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEF6B308F9D6
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Feb 2026 03:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D258C2DD5F6;
	Wed,  4 Feb 2026 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="XCyhnuIl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D5028000F
	for <linux-ext4@vger.kernel.org>; Wed,  4 Feb 2026 03:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770177202; cv=none; b=jhA6hhsSFkDwViRs1La8rgeacDEpQMgoXg1DZctPNaXU5QL8eeDePL1QfBdNk7tGqh+KPRtUK3cj3N812njiA8aaL+P7o/3lrqz3NaLcMRNsLd5ZXalATOtu6uKFiLtU8q54xIG449SxUozsZPT0IusnSVeX/XGALNUGDSwcdyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770177202; c=relaxed/simple;
	bh=Sq/0MuOrsshTlCVoQck4Z+Jcq+1BfdJ3LbTMlEIaZg4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=R42JNbxDgNVDZ7MtSciMAG/yp2fDOz8tJvoeqEAp7C14kuAwy16GOhP0+b7TMQqRSGT8N4FUur2EKVYqXD91wlyRZvHCiMgIPwuR4fOyRtOT7f/E9pbCeZrjSq5eML/mjcM+S15wBUJ8XM5W+jfS1/y0aJSqPdWKtzQWSUPedfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=XCyhnuIl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29f30233d8aso40149645ad.0
        for <linux-ext4@vger.kernel.org>; Tue, 03 Feb 2026 19:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1770177199; x=1770781999; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrmCgP+1rlKEXkaMoq+hI17BHfkqZPGBfI0ezgyFhkc=;
        b=XCyhnuIlYZZk6w5NmOPEqiY+PntAMj9pT8s09nG+UVXmuRIz/c+fno5WCmdO81Gxck
         1roHXRN7TjS9y+xXGneGLgsB+bVPv5S06rAFSXBPxVxW1vLC0ZkU1rJZUTZ92pu1pqEi
         C1vdSbV1w3itU/m1sMXM1dNWoP4bpJEtQXfbsGGxKniPF8XoV3SVsrJUxa+FO5V+8feQ
         Lh3jAkvGRn9KlVJZweleqJB+yeCsUoV4L6nY9Wyb92tKXipuxoZa2fh45Lm3DExtObax
         eNi3xFvChIcr9qHKfbpq8IJsXdJAaNI/iKJwxjlnwqz4enVLW9joGlaCOAlMOdNzM7J1
         hphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770177199; x=1770781999;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TrmCgP+1rlKEXkaMoq+hI17BHfkqZPGBfI0ezgyFhkc=;
        b=XacB8n9Ppz/ydS9o0Asgd/Kig5D9ii92WnKJjrYSZFTwNAQBF6MhlzT1a+DRfY3MpK
         mlENzxATZKLZzI4RDFpNhX6VlA3q+ukAkfFnYhXxhxnpmzfTXngmHC7mTFk5kjMCpUo3
         ZHKrl6kOx6gQh+H/Xno9QsYRQah44wQZFrl7Q1/OkoOvonS9A0BqS4vcIQYT2Dj86jzb
         N9fp/tfgojOU6q8Cysek8mWEpB8Mf1ZzruJv1Is3QnFKUOwSyJA0cLvAt8s/6lNOLvFp
         i2at+VRzjZC27/XHyN7LvP8kBBR15oUGHHSosZAsU4F5OqTepIZU3WjM+0RujonrP1sC
         UoOw==
X-Forwarded-Encrypted: i=1; AJvYcCVT6Qc28XHKYRQMVKcnCsbxZcOHNLMao/wInPNT+YfIKPRUkXCKm5Fb49NbuYjdbEEPipDI8nl7Kq6Z@vger.kernel.org
X-Gm-Message-State: AOJu0YweFBcqyc+YHL43wzz9kCUDwEmMJKaCiS1XbIEOhgrq3cCZVDYd
	SDFJcCaeg1N+2qNF8WxWLmW4SaeSAJ9LDhAwND9CdNd/b7ngcMaZFjUQTCxyblgPnRI=
X-Gm-Gg: AZuq6aIr4pUFEcYcWYs1FFjKNch3jCIEMJdKisdIjQxo+h3oPGd7hM+WGxTbc3lt1/G
	718s7UU3soXDHn0Be3NjRS05WtY5XIxzbOC//rJde6THQov6YhZBBVpzWT1DdtzUgxtoo2SIFEF
	BOO3rlXCBVlWiIM1sXdsjnTzZGNroB4mZ8lC7LUmvf9XUEIHBnEeFvOonYKuGLg85SdikS8BMaC
	Az52/jpkan/H4eqBVwtcrijKYyz5TICKczMoRlY/MPRgCPkK8wLCWOYnKiHyEvL+14qsDlXUoA6
	EiCOdiXwEqke0lQRsCxW7vPkgdcMak/nndvzt3bEtj7A6i2C/pJdKryu7ilvI0TTyP8qOsj3Kjf
	rcAMjl3H9GB8YFeBS/zQ5LGvJT7La5iZ/QJizLcDRS0zirtLiXgzNG0Nrui8Ka4Zsx0SSBq5fxf
	uDrl5J8nXwICzeR3bUu+RwbeUOKMlbynHg1vNJgsY6cVzikZxs6e14YHKdY5xbVOOwYQ==
X-Received: by 2002:a17:903:1ae8:b0:2a0:8ca7:69de with SMTP id d9443c01a7336-2a933fd8e92mr19855105ad.41.1770177199515;
        Tue, 03 Feb 2026 19:53:19 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d434f17sm854077b3a.41.2026.02.03.19.53.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Feb 2026 19:53:18 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH] ext4: add optional rotating block allocation policy
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260204033112.406079-1-mario_lohajner@rocketmail.com>
Date: Tue, 3 Feb 2026 20:53:07 -0700
Cc: tytso@mit.edu,
 linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C3DAF83A-CE88-4348-BCE2-237960F3CD9D@dilger.ca>
References: <20260204033112.406079-1-mario_lohajner.ref@rocketmail.com>
 <20260204033112.406079-1-mario_lohajner@rocketmail.com>
To: Mario Lohajner <mario_lohajner@rocketmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dilger-ca.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13516-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[dilger.ca];
	DKIM_TRACE(0.00)[dilger-ca.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[rocketmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dilger.ca:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rocketmail.com:email,dilger-ca.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 39C0EE1680
X-Rspamd-Action: no action

On Feb 3, 2026, at 20:31, Mario Lohajner <mario_lohajner@rocketmail.com> =
wrote:
>=20
> Add support for the rotalloc allocation policy as a new mount
> option. Policy rotates the starting block group for new allocations.
>=20
> Changes:
> - fs/ext4/ext4.h
> rotalloc policy dedlared, extend sb with cursor, vector & lock
>=20
> - fs/ext4/mballoc.h
> expose allocator functions for vectoring in super.c
>=20
> - fs/ext4/super.c
> parse rotalloc mnt opt, init cursor, lock and allocator vector
>=20
> - fs/ext4/mballoc.c
> add rotalloc allocator, vectored allocator call in new_blocks
>=20
> The policy is selected via a mount option and does not change the
> on-disk format or default allocation behavior. It preserves existing
> allocation heuristics within a block group while distributing
> allocations across block groups in a deterministic sequential manner.
>=20
> The rotating allocator is implemented as a separate allocation path
> selected at mount time. This avoids conditional branches in the =
regular
> allocator and keeps allocation policies isolated.
> This also allows the rotating allocator to evolve independently in the
> future without increasing complexity in the regular allocator.
>=20
> The policy was tested using v6.18.6 stable locally with the new mount
> option "rotalloc" enabled, confirmed working as desribed!

Hi Mario,
can you please provide some background/reasoning behind this allocator?
I suspect there are good reasons/workloads that could benefit from it
(e.g. flash wear leveling), but that should be stated in the commit
message, and preferably with some benchmarks/measurements that show
some benefit from adding this feature.

Cheers, Andreas

>=20
> Signed-off-by: Mario Lohajner <mario_lohajner@rocketmail.com>
> ---
> fs/ext4/ext4.h    |   8 +++
> fs/ext4/mballoc.c | 152 ++++++++++++++++++++++++++++++++++++++++++++--
> fs/ext4/mballoc.h |   3 +
> fs/ext4/super.c   |  18 +++++-
> 4 files changed, 175 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 56112f201cac..cbbb7c05d7a2 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -229,6 +229,9 @@ struct ext4_allocation_request {
> unsigned int flags;
> };
>=20
> +/* expose rotalloc allocator argument pointer type */
> +struct ext4_allocation_context;
> +
> /*
>  * Logical to physical block mapping, used by ext4_map_blocks()
>  *
> @@ -1230,6 +1233,7 @@ struct ext4_inode_info {
>  * Mount flags set via mount options or defaults
>  */
> #define EXT4_MOUNT_NO_MBCACHE 0x00001 /* Do not use mbcache */
> +#define EXT4_MOUNT_ROTALLOC 0x00002 /* Use rotalloc policy/allocator =
*/
> #define EXT4_MOUNT_GRPID 0x00004 /* Create files with directory's =
group */
> #define EXT4_MOUNT_DEBUG 0x00008 /* Some debugging messages */
> #define EXT4_MOUNT_ERRORS_CONT 0x00010 /* Continue on errors */
> @@ -1559,6 +1563,10 @@ struct ext4_sb_info {
> unsigned long s_mount_flags;
> unsigned int s_def_mount_opt;
> unsigned int s_def_mount_opt2;
> + /* Rotalloc cursor, lock & new_blocks allocator vector */
> + unsigned int s_rotalloc_cursor;
> + spinlock_t s_rotalloc_lock;
> + int (*s_mb_new_blocks)(struct ext4_allocation_context *ac);
> ext4_fsblk_t s_sb_block;
> atomic64_t s_resv_clusters;
> kuid_t s_resuid;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 56d50fd3310b..74f79652c674 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2314,11 +2314,11 @@ static void ext4_mb_check_limits(struct =
ext4_allocation_context *ac,
>  *   stop the scan and use it immediately
>  *
>  * * If free extent found is smaller than goal, then keep retrying
> - *   upto a max of sbi->s_mb_max_to_scan times (default 200). After
> + *   up to a max of sbi->s_mb_max_to_scan times (default 200). After
>  *   that stop scanning and use whatever we have.
>  *
>  * * If free extent found is bigger than goal, then keep retrying
> - *   upto a max of sbi->s_mb_min_to_scan times (default 10) before
> + *   up to a max of sbi->s_mb_min_to_scan times (default 10) before
>  *   stopping the scan and using the extent.
>  *
>  *
> @@ -2981,7 +2981,7 @@ static int ext4_mb_scan_group(struct =
ext4_allocation_context *ac,
> return ret;
> }
>=20
> -static noinline_for_stack int
> +noinline_for_stack int
> ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
> {
> ext4_group_t i;
> @@ -3012,7 +3012,7 @@ ext4_mb_regular_allocator(struct =
ext4_allocation_context *ac)
> * is greater than equal to the sbi_s_mb_order2_reqs
> * You can tune it via /sys/fs/ext4/<partition>/mb_order2_req
> * We also support searching for power-of-two requests only for
> - * requests upto maximum buddy size we have constructed.
> + * requests up to maximum buddy size we have constructed.
> */
> if (i >=3D sbi->s_mb_order2_reqs && i <=3D MB_NUM_ORDERS(sb)) {
> if (is_power_of_2(ac->ac_g_ex.fe_len))
> @@ -3101,6 +3101,144 @@ ext4_mb_regular_allocator(struct =
ext4_allocation_context *ac)
> return err;
> }
>=20
> +/* Rotating allocator (rotalloc mount option) */
> +noinline_for_stack int
> +ext4_mb_rotating_allocator(struct ext4_allocation_context *ac)
> +{
> + ext4_group_t i, goal;
> + int err =3D 0;
> + struct super_block *sb =3D ac->ac_sb;
> + struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> + struct ext4_buddy e4b;
> +
> + BUG_ON(ac->ac_status =3D=3D AC_STATUS_FOUND);
> +
> + /* Set the goal from s_rotalloc_cursor */
> + spin_lock(&sbi->s_rotalloc_lock);
> + goal =3D sbi->s_rotalloc_cursor;
> + spin_unlock(&sbi->s_rotalloc_lock);
> + ac->ac_g_ex.fe_group =3D goal;
> +
> + /* first, try the goal */
> + err =3D ext4_mb_find_by_goal(ac, &e4b);
> + if (err || ac->ac_status =3D=3D AC_STATUS_FOUND)
> + goto out;
> +
> + if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
> + goto out;
> +
> + /*
> + * ac->ac_2order is set only if the fe_len is a power of 2
> + * if ac->ac_2order is set we also set criteria to CR_POWER2_ALIGNED
> + * so that we try exact allocation using buddy.
> + */
> + i =3D fls(ac->ac_g_ex.fe_len);
> + ac->ac_2order =3D 0;
> + /*
> + * We search using buddy data only if the order of the request
> + * is greater than equal to the sbi_s_mb_order2_reqs
> + * You can tune it via /sys/fs/ext4/<partition>/mb_order2_req
> + * We also support searching for power-of-two requests only for
> + * requests up to maximum buddy size we have constructed.
> + */
> + if (i >=3D sbi->s_mb_order2_reqs && i <=3D MB_NUM_ORDERS(sb)) {
> + if (is_power_of_2(ac->ac_g_ex.fe_len))
> + ac->ac_2order =3D array_index_nospec(i - 1,
> +   MB_NUM_ORDERS(sb));
> + }
> +
> + /* if stream allocation is enabled, use global goal */
> + if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
> + int hash =3D ac->ac_inode->i_ino % sbi->s_mb_nr_global_goals;
> +
> + ac->ac_g_ex.fe_group =3D READ_ONCE(sbi->s_mb_last_groups[hash]);
> + ac->ac_g_ex.fe_start =3D -1;
> + ac->ac_flags &=3D ~EXT4_MB_HINT_TRY_GOAL;
> + }
> +
> + /*
> + * Let's just scan groups to find more-less suitable blocks We
> + * start with CR_GOAL_LEN_FAST, unless it is power of 2
> + * aligned, in which case let's do that faster approach first.
> + */
> + ac->ac_criteria =3D CR_GOAL_LEN_FAST;
> + if (ac->ac_2order)
> + ac->ac_criteria =3D CR_POWER2_ALIGNED;
> +
> + ac->ac_e4b =3D &e4b;
> + ac->ac_prefetch_ios =3D 0;
> + ac->ac_first_err =3D 0;
> +
> + /* Be sure to start scanning with goal from s_rotalloc_cursor! */
> + ac->ac_g_ex.fe_group =3D goal;
> +repeat:
> + while (ac->ac_criteria < EXT4_MB_NUM_CRS) {
> + err =3D ext4_mb_scan_groups(ac);
> + if (err)
> + goto out;
> +
> + if (ac->ac_status !=3D AC_STATUS_CONTINUE)
> + break;
> + }
> +
> + if (ac->ac_b_ex.fe_len > 0 && ac->ac_status !=3D AC_STATUS_FOUND &&
> +    !(ac->ac_flags & EXT4_MB_HINT_FIRST)) {
> + /*
> + * We've been searching too long. Let's try to allocate
> + * the best chunk we've found so far
> + */
> + ext4_mb_try_best_found(ac, &e4b);
> + if (ac->ac_status !=3D AC_STATUS_FOUND) {
> + int lost;
> +
> + /*
> + * Someone more lucky has already allocated it.
> + * The only thing we can do is just take first
> + * found block(s)
> + */
> + lost =3D atomic_inc_return(&sbi->s_mb_lost_chunks);
> + mb_debug(sb, "lost chunk, group: %u, start: %d, len: %d, lost: =
%d\n",
> + ac->ac_b_ex.fe_group, ac->ac_b_ex.fe_start,
> + ac->ac_b_ex.fe_len, lost);
> +
> + ac->ac_b_ex.fe_group =3D 0;
> + ac->ac_b_ex.fe_start =3D 0;
> + ac->ac_b_ex.fe_len =3D 0;
> + ac->ac_status =3D AC_STATUS_CONTINUE;
> + ac->ac_flags |=3D EXT4_MB_HINT_FIRST;
> + ac->ac_criteria =3D CR_ANY_FREE;
> + goto repeat;
> + }
> + }
> +
> + if (sbi->s_mb_stats && ac->ac_status =3D=3D AC_STATUS_FOUND) {
> + atomic64_inc(&sbi->s_bal_cX_hits[ac->ac_criteria]);
> + if (ac->ac_flags & EXT4_MB_STREAM_ALLOC &&
> +    ac->ac_b_ex.fe_group =3D=3D ac->ac_g_ex.fe_group)
> + atomic_inc(&sbi->s_bal_stream_goals);
> + }
> +out:
> + if (!err && ac->ac_status !=3D AC_STATUS_FOUND && ac->ac_first_err)
> + err =3D ac->ac_first_err;
> +
> + mb_debug(sb, "Best len %d, origin len %d, ac_status %u, ac_flags =
0x%x, cr %d ret %d\n",
> + ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
> + ac->ac_flags, ac->ac_criteria, err);
> +
> + if (ac->ac_prefetch_nr)
> + ext4_mb_prefetch_fini(sb, ac->ac_prefetch_grp, ac->ac_prefetch_nr);
> +
> + if (!err) {
> + /* Finally, if no errors, set the currsor to best group! */
> + goal =3D ac->ac_b_ex.fe_group;
> + spin_lock(&sbi->s_rotalloc_lock);
> + sbi->s_rotalloc_cursor =3D goal;
> + spin_unlock(&sbi->s_rotalloc_lock);
> + }
> +
> + return err;
> +}
> +
> static void *ext4_mb_seq_groups_start(struct seq_file *seq, loff_t =
*pos)
> {
> struct super_block *sb =3D pde_data(file_inode(seq->file));
> @@ -6314,7 +6452,11 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t =
*handle,
> goto errout;
> repeat:
> /* allocate space in core */
> - *errp =3D ext4_mb_regular_allocator(ac);
> + /*
> + * Use vectored allocator insead of fixed
> + * ext4_mb_regular_allocator(ac) function
> + */
> + *errp =3D sbi->s_mb_new_blocks(ac);
> /*
> * pa allocated above is added to grp->bb_prealloc_list only
> * when we were able to allocate some block i.e. when
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index 15a049f05d04..309190ce05ae 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -270,4 +270,7 @@ ext4_mballoc_query_range(
> ext4_mballoc_query_range_fn formatter,
> void *priv);
>=20
> +/* Expose rotating & regular allocators for vectoring */
> +int ext4_mb_rotating_allocator(struct ext4_allocation_context *ac);
> +int ext4_mb_regular_allocator(struct ext4_allocation_context *ac);
> #endif
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 87205660c5d0..f53501bbfb4b 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1673,7 +1673,7 @@ enum {
> Opt_nomblk_io_submit, Opt_block_validity, Opt_noblock_validity,
> Opt_inode_readahead_blks, Opt_journal_ioprio,
> Opt_dioread_nolock, Opt_dioread_lock,
> - Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
> + Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable, =
Opt_rotalloc,
> Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
> Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan,
> Opt_errors, Opt_data, Opt_data_err, Opt_jqfmt, Opt_dax_type,
> @@ -1797,6 +1797,7 @@ static const struct fs_parameter_spec =
ext4_param_specs[] =3D {
> fsparam_u32 ("init_itable", Opt_init_itable),
> fsparam_flag ("init_itable", Opt_init_itable),
> fsparam_flag ("noinit_itable", Opt_noinit_itable),
> + fsparam_flag ("rotalloc", Opt_rotalloc),
> #ifdef CONFIG_EXT4_DEBUG
> fsparam_flag ("fc_debug_force", Opt_fc_debug_force),
> fsparam_u32 ("fc_debug_max_replay", Opt_fc_debug_max_replay),
> @@ -1878,6 +1879,7 @@ static const struct mount_opts {
> {Opt_noauto_da_alloc, EXT4_MOUNT_NO_AUTO_DA_ALLOC, MOPT_SET},
> {Opt_auto_da_alloc, EXT4_MOUNT_NO_AUTO_DA_ALLOC, MOPT_CLEAR},
> {Opt_noinit_itable, EXT4_MOUNT_INIT_INODE_TABLE, MOPT_CLEAR},
> + {Opt_rotalloc, EXT4_MOUNT_ROTALLOC, MOPT_SET},
> {Opt_dax_type, 0, MOPT_EXT4_ONLY},
> {Opt_journal_dev, 0, MOPT_NO_EXT2},
> {Opt_journal_path, 0, MOPT_NO_EXT2},
> @@ -2264,6 +2266,9 @@ static int ext4_parse_param(struct fs_context =
*fc, struct fs_parameter *param)
> ctx->s_li_wait_mult =3D result.uint_32;
> ctx->spec |=3D EXT4_SPEC_s_li_wait_mult;
> return 0;
> + case Opt_rotalloc:
> + ctx_set_mount_opt(ctx, EXT4_MOUNT_ROTALLOC);
> + return 0;
> case Opt_max_dir_size_kb:
> ctx->s_max_dir_size_kb =3D result.uint_32;
> ctx->spec |=3D EXT4_SPEC_s_max_dir_size_kb;
> @@ -5512,6 +5517,17 @@ static int __ext4_fill_super(struct fs_context =
*fc, struct super_block *sb)
> }
> }
>=20
> + /*
> + * Initialize rotalloc cursor, lock and
> + * vector new_blocks to rotating^regular allocator
> + */
> + sbi->s_rotalloc_cursor =3D 0;
> + spin_lock_init(&sbi->s_rotalloc_lock);
> + if (test_opt(sb, ROTALLOC))
> + sbi->s_mb_new_blocks =3D ext4_mb_rotating_allocator;
> + else
> + sbi->s_mb_new_blocks =3D ext4_mb_regular_allocator;
> +
> /*
> * Get the # of file system overhead blocks from the
> * superblock if present.
> --=20
> 2.52.0
>=20


Cheers, Andreas






