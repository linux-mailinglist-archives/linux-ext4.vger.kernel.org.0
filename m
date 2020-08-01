Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F89023514E
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Aug 2020 10:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgHAI7K (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 1 Aug 2020 04:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgHAI7J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 1 Aug 2020 04:59:09 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D35C06174A
        for <linux-ext4@vger.kernel.org>; Sat,  1 Aug 2020 01:59:09 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mt12so8462555pjb.4
        for <linux-ext4@vger.kernel.org>; Sat, 01 Aug 2020 01:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=PYDQugF/nNg8S3P75BhUchzZJTz/S5C6jhTArpY3DtE=;
        b=yF+tc3U06QYOja0eMiLp3LnpqbxdX+5JtBPmWI+O0KpKOp62ehnnW2AVB2aaFJ45Mh
         M6hQA/zXfYRebFiOKTv/SyMCMuFfcqUIkTVCwIh/j9HOFz5HlPgfFIaOlfWEs2UT5Xhk
         8uj8nNJeQYKEcRhiNoVAEfSpJwdUH9y2LqjXmPjTBUy+J/VUUk5EZnlaryVGxzJlwcTH
         V4j+5lr2Ks+eM/2ghaqwk29Ei9mmvmj3l3qMpdOYYndZVWK4StB5sGvGg8dBQOpIlJX7
         tim2AmxOXsp2FDf2FGRg3/5AwqzkoMqVDmNb7cF7Mx1gdVXBKKH4D92c0wRFc0/SK7ju
         2myQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=PYDQugF/nNg8S3P75BhUchzZJTz/S5C6jhTArpY3DtE=;
        b=umMHafCoRhOG0Z3KCT1lPEg1F4Zfjqm9v6daaEkoYFfM8IPr6SabfI+icbSQiuZ9in
         6/BhY/BpRaGG5e7+AFS3iRFFlsmzSt3BgzDcSMpAqgVb5h3VwKj9XUVSU5Ga/QB5rNVb
         HYYgzSqo9zBbtmUWzVd4wI1fltkkTsAL/JkecKfVHhgZtoX/VJWWummdAy4hUQD3q2vB
         c9zQiG6+lxC5c0AReRv5K+DDNCokh7hsdeultPK1rScfvH9a+2BynaKgg6//ZF/Oq+UH
         R78X0WdBub0w/H4E4fNRs/1dkege6Iqx5pzrhyge49gU2STq8Ow4W/ngPgUuN5fetuwg
         5uiQ==
X-Gm-Message-State: AOAM532oCC3JzTa5jmTejDNvpeDyuxhkkxaPnVkUYQ3TTVOLLf4HvgmV
        o07X0LextmAwpTgaXKA2JKDi0RImJKU=
X-Google-Smtp-Source: ABdhPJzrxs7TkirmQ4+t/Hdnh6ayXCulUeRlIgvh2X4rpmvIe8JP1iUTqfT9wLEIOkA685M1lQhfKQ==
X-Received: by 2002:a17:902:8d95:: with SMTP id v21mr6995610plo.108.1596272348786;
        Sat, 01 Aug 2020 01:59:08 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id y17sm12842139pfe.30.2020.08.01.01.59.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Aug 2020 01:59:08 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F6E21B09-FA23-407A-9FAB-25570E1D89CE@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F52BEE52-3347-4DA2-A2AD-AF5032547F11";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 4/4] ext4: add prefetch_block_bitmaps mount options
Date:   Sat, 1 Aug 2020 02:57:57 -0600
In-Reply-To: <20200731190805.181253-5-tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
References: <20200731190805.181253-1-tytso@mit.edu>
 <20200731190805.181253-5-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_F52BEE52-3347-4DA2-A2AD-AF5032547F11
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 31, 2020, at 1:08 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> For file systems where we can afford to keep the buddy bitmaps cached,
> we can speed up initial writes to large file systems by starting to
> load the block allocation bitmaps as soon as the file system is
> mounted.  This won't work well for _super_ large file systems, or
> memory constrained systems, so we only enable this when it is
> requested via a mount option.
>=20
> Addresses-Google-Bug: 159488342
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/ext4.h              | 15 +++++++++-
> fs/ext4/mballoc.c           | 10 +++----
> fs/ext4/super.c             | 59 +++++++++++++++++++++++++++----------
> include/trace/events/ext4.h | 44 +++++++++++++++++++++++++++
> 4 files changed, 105 insertions(+), 23 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 7451662e092a..4df6f429de1a 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1172,6 +1172,7 @@ struct ext4_inode_info {
> #define EXT4_MOUNT_JOURNAL_CHECKSUM	0x800000 /* Journal checksums */
> #define EXT4_MOUNT_JOURNAL_ASYNC_COMMIT	0x1000000 /* Journal =
Async Commit */
> #define EXT4_MOUNT_WARN_ON_ERROR	0x2000000 /* Trigger WARN_ON on =
error */
> +#define EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS 0x4000000
> #define EXT4_MOUNT_DELALLOC		0x8000000 /* Delalloc support */
> #define EXT4_MOUNT_DATA_ERR_ABORT	0x10000000 /* Abort on file data =
write */
> #define EXT4_MOUNT_BLOCK_VALIDITY	0x20000000 /* Block validity =
checking */
> @@ -2315,9 +2316,15 @@ struct ext4_lazy_init {
> 	struct mutex		li_list_mtx;
> };
>=20
> +enum ext4_li_mode {
> +	EXT4_LI_MODE_PREFETCH_BBITMAP,
> +	EXT4_LI_MODE_ITABLE,
> +};
> +
> struct ext4_li_request {
> 	struct super_block	*lr_super;
> -	struct ext4_sb_info	*lr_sbi;
> +	enum ext4_li_mode	lr_mode;
> +	ext4_group_t		lr_first_not_zeroed;
> 	ext4_group_t		lr_next_group;
> 	struct list_head	lr_request;
> 	unsigned long		lr_next_sched;
> @@ -2657,6 +2664,12 @@ extern int ext4_mb_reserve_blocks(struct =
super_block *, int);
> extern void ext4_discard_preallocations(struct inode *);
> extern int __init ext4_init_mballoc(void);
> extern void ext4_exit_mballoc(void);
> +extern ext4_group_t ext4_mb_prefetch(struct super_block *sb,
> +				     ext4_group_t group,
> +				     unsigned int nr, int *cnt);
> +extern void ext4_mb_prefetch_fini(struct super_block *sb, =
ext4_group_t group,
> +				  unsigned int nr);
> +
> extern void ext4_free_blocks(handle_t *handle, struct inode *inode,
> 			     struct buffer_head *bh, ext4_fsblk_t block,
> 			     unsigned long count, int flags);
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index b1ef35a9e9f1..47de61e44db2 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2233,9 +2233,8 @@ static int ext4_mb_good_group_nolock(struct =
ext4_allocation_context *ac,
>  * Start prefetching @nr block bitmaps starting at @group.
>  * Return the next group which needs to be prefetched.
>  */
> -static ext4_group_t
> -ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
> -		 unsigned int nr, int *cnt)
> +ext4_group_t ext4_mb_prefetch(struct super_block *sb, ext4_group_t =
group,
> +			      unsigned int nr, int *cnt)
> {
> 	ext4_group_t ngroups =3D ext4_get_groups_count(sb);
> 	struct buffer_head *bh;
> @@ -2285,9 +2284,8 @@ ext4_mb_prefetch(struct super_block *sb, =
ext4_group_t group,
>  * waiting for the block allocation bitmap read to finish when
>  * ext4_mb_prefetch_fini is called from ext4_mb_regular_allocator().
>  */
> -static void
> -ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
> -		      unsigned int nr)
> +void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t =
group,
> +			   unsigned int nr)
> {
> 	while (nr-- > 0) {
> 		struct ext4_group_desc *gdp =3D ext4_get_group_desc(sb, =
group,
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 330957ed1f05..51e91a220ea9 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1521,6 +1521,7 @@ enum {
> 	Opt_dioread_nolock, Opt_dioread_lock,
> 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
> 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
> +	Opt_prefetch_block_bitmaps,
> };
>=20
> static const match_table_t tokens =3D {
> @@ -1612,6 +1613,7 @@ static const match_table_t tokens =3D {
> 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
> 	{Opt_nombcache, "nombcache"},
> 	{Opt_nombcache, "no_mbcache"},	/* for backward compatibility */
> +	{Opt_prefetch_block_bitmaps, "prefetch_block_bitmaps"},
> 	{Opt_removed, "check=3Dnone"},	/* mount option from ext2/3 */
> 	{Opt_removed, "nocheck"},	/* mount option from ext2/3 */
> 	{Opt_removed, "reservation"},	/* mount option from ext2/3 */
> @@ -1829,6 +1831,8 @@ static const struct mount_opts {
> 	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
> 	{Opt_test_dummy_encryption, 0, MOPT_STRING},
> 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
> +	{Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
> +	 MOPT_SET},
> 	{Opt_err, 0, 0}
> };
>=20
> @@ -3201,15 +3205,34 @@ static void print_daily_error_info(struct =
timer_list *t)
> static int ext4_run_li_request(struct ext4_li_request *elr)
> {
> 	struct ext4_group_desc *gdp =3D NULL;
> -	ext4_group_t group, ngroups;
> -	struct super_block *sb;
> +	struct super_block *sb =3D elr->lr_super;
> +	ext4_group_t ngroups =3D EXT4_SB(sb)->s_groups_count;
> +	ext4_group_t group =3D elr->lr_next_group;
> 	unsigned long timeout =3D 0;
> +	unsigned int prefetch_ios =3D 0;
> 	int ret =3D 0;
>=20
> -	sb =3D elr->lr_super;
> -	ngroups =3D EXT4_SB(sb)->s_groups_count;
> +	if (elr->lr_mode =3D=3D EXT4_LI_MODE_PREFETCH_BBITMAP) {
> +		elr->lr_next_group =3D ext4_mb_prefetch(sb, group,
> +				EXT4_SB(sb)->s_mb_prefetch, =
&prefetch_ios);
> +		if (prefetch_ios)
> +			ext4_mb_prefetch_fini(sb, elr->lr_next_group,
> +					      prefetch_ios);
> +		trace_ext4_prefetch_bitmaps(sb, group, =
elr->lr_next_group,
> +					    prefetch_ios);
> +		if (group >=3D elr->lr_next_group) {
> +			ret =3D 1;
> +			if (elr->lr_first_not_zeroed !=3D ngroups &&
> +			    !sb_rdonly(sb) && test_opt(sb, =
INIT_INODE_TABLE)) {
> +				elr->lr_next_group =3D =
elr->lr_first_not_zeroed;
> +				elr->lr_mode =3D EXT4_LI_MODE_ITABLE;
> +				ret =3D 0;
> +			}
> +		}
> +		return ret;
> +	}
>=20
> -	for (group =3D elr->lr_next_group; group < ngroups; group++) {
> +	for (; group < ngroups; group++) {
> 		gdp =3D ext4_get_group_desc(sb, group, NULL);
> 		if (!gdp) {
> 			ret =3D 1;
> @@ -3227,9 +3250,10 @@ static int ext4_run_li_request(struct =
ext4_li_request *elr)
> 		timeout =3D jiffies;
> 		ret =3D ext4_init_inode_table(sb, group,
> 					    elr->lr_timeout ? 0 : 1);
> +		trace_ext4_lazy_itable_init(sb, group);
> 		if (elr->lr_timeout =3D=3D 0) {
> 			timeout =3D (jiffies - timeout) *
> -				  elr->lr_sbi->s_li_wait_mult;
> +				EXT4_SB(elr->lr_super)->s_li_wait_mult;
> 			elr->lr_timeout =3D timeout;
> 		}
> 		elr->lr_next_sched =3D jiffies + elr->lr_timeout;
> @@ -3244,15 +3268,11 @@ static int ext4_run_li_request(struct =
ext4_li_request *elr)
>  */
> static void ext4_remove_li_request(struct ext4_li_request *elr)
> {
> -	struct ext4_sb_info *sbi;
> -
> 	if (!elr)
> 		return;
>=20
> -	sbi =3D elr->lr_sbi;
> -
> 	list_del(&elr->lr_request);
> -	sbi->s_li_request =3D NULL;
> +	EXT4_SB(elr->lr_super)->s_li_request =3D NULL;
> 	kfree(elr);
> }
>=20
> @@ -3461,7 +3481,6 @@ static int ext4_li_info_new(void)
> static struct ext4_li_request *ext4_li_request_new(struct super_block =
*sb,
> 					    ext4_group_t start)
> {
> -	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> 	struct ext4_li_request *elr;
>=20
> 	elr =3D kzalloc(sizeof(*elr), GFP_KERNEL);
> @@ -3469,8 +3488,13 @@ static struct ext4_li_request =
*ext4_li_request_new(struct super_block *sb,
> 		return NULL;
>=20
> 	elr->lr_super =3D sb;
> -	elr->lr_sbi =3D sbi;
> -	elr->lr_next_group =3D start;
> +	elr->lr_first_not_zeroed =3D start;
> +	if (test_opt(sb, PREFETCH_BLOCK_BITMAPS))
> +		elr->lr_mode =3D EXT4_LI_MODE_PREFETCH_BBITMAP;
> +	else {
> +		elr->lr_mode =3D EXT4_LI_MODE_ITABLE;
> +		elr->lr_next_group =3D start;
> +	}
>=20
> 	/*
> 	 * Randomize first schedule time of the request to
> @@ -3488,6 +3512,7 @@ int ext4_register_li_request(struct super_block =
*sb,
> 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> 	struct ext4_li_request *elr =3D NULL;
> 	ext4_group_t ngroups =3D sbi->s_groups_count;
> +	enum ext4_li_mode lr_mode =3D EXT4_LI_MODE_ITABLE;
> 	int ret =3D 0;
>=20
> 	mutex_lock(&ext4_li_mtx);
> @@ -3500,8 +3525,10 @@ int ext4_register_li_request(struct super_block =
*sb,
> 		goto out;
> 	}
>=20
> -	if (first_not_zeroed =3D=3D ngroups || sb_rdonly(sb) ||
> -	    !test_opt(sb, INIT_INODE_TABLE))
> +	if (test_opt(sb, PREFETCH_BLOCK_BITMAPS)) {
> +		lr_mode =3D EXT4_LI_MODE_PREFETCH_BBITMAP;
> +	} else if (first_not_zeroed =3D=3D ngroups || sb_rdonly(sb) ||
> +		   !test_opt(sb, INIT_INODE_TABLE))
> 		goto out;
>=20
> 	elr =3D ext4_li_request_new(sb, first_not_zeroed);
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index cbcd2e1a608d..8008d2e116b9 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -2742,6 +2742,50 @@ TRACE_EVENT(ext4_error,
> 		  __entry->function, __entry->line)
> );
>=20
> +TRACE_EVENT(ext4_prefetch_bitmaps,
> +	    TP_PROTO(struct super_block *sb, ext4_group_t group,
> +		     ext4_group_t next, unsigned int prefetch_ios),
> +
> +	TP_ARGS(sb, group, next, prefetch_ios),
> +
> +	TP_STRUCT__entry(
> +		__field(	dev_t,	dev			)
> +		__field(	__u32,	group			)
> +		__field(	__u32,	next			)
> +		__field(	__u32,	ios			)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev	=3D sb->s_dev;
> +		__entry->group	=3D group;
> +		__entry->next	=3D next;
> +		__entry->ios	=3D prefetch_ios;
> +	),
> +
> +	TP_printk("dev %d,%d group %u next %u ios %u",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->group, __entry->next, __entry->ios)
> +);
> +
> +TRACE_EVENT(ext4_lazy_itable_init,
> +	    TP_PROTO(struct super_block *sb, ext4_group_t group),
> +
> +	TP_ARGS(sb, group),
> +
> +	TP_STRUCT__entry(
> +		__field(	dev_t,	dev			)
> +		__field(	__u32,	group			)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev	=3D sb->s_dev;
> +		__entry->group	=3D group;
> +	),
> +
> +	TP_printk("dev %d,%d group %u",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev), =
__entry->group)
> +);
> +
> #endif /* _TRACE_EXT4_H */
>=20
> /* This part must be outside protection */
> --
> 2.24.1
>=20


Cheers, Andreas






--Apple-Mail=_F52BEE52-3347-4DA2-A2AD-AF5032547F11
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8lLpwACgkQcqXauRfM
H+ABDxAAkC8ZZFJGgmrQQJeUK6SWrKooMR9MSjHoLkO+hmbUSY2e1K8Pjdp3z7iV
cUFRsmbqcdE+5P6LpJgBhLp8TQ/lvJUL0Ikn+43PfHIZRyLin+QMIGH8ENxcABLC
Vx91opW/FTRkvBtjavJa2rXAVkj1iGz7st0/MF/p3zZ8EaiOCyGwFsgtErsf8QgQ
MBWPfjPgllCHE6x4OaosbEk2PkZYAQP5iN2wh9idSeRQvQWHhGtx0V/Lb8DCokgL
nsKMisuitC6F6saRbz6H8bRevcJFZWIOiAy06UpCvtOTnyVGix/a+G6ht1wyG5B4
bVOJW7Ls8140jssetfr35v3wuhRE0EjmdHEScEP/EXSeQn0pKUlxB9BkJnnsM8W0
JyB2KOv/vVQITjrSXwBk3Qn/6VXIWmGvOSySxt9K0oMF3YyzugFJASS5GRbf85Hp
DC/HaRl1G9xW+zk/sNqneKXVYQQpAht4jhLSky5B6Zl5XN0qVbRxrUe0rGDVJajO
ncxjIN1VS+MFM/casY9c2ifAveYa58ptPTNoXR8EiBFMBTrWvTuNsQFB26eBUm+V
UdA6Zzr3PRgKr8pxA3o3xqWuQ2wGNY3qJYwIYS6JaXw5hQSgyBJJpEmQ4f1WJogR
TAzm+sAV9qPsbLfrI5bQcg6gcWMAWcO+WHakEJ+PMEQg+nfZaYo=
=IvT1
-----END PGP SIGNATURE-----

--Apple-Mail=_F52BEE52-3347-4DA2-A2AD-AF5032547F11--
