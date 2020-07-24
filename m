Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D238422C72C
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jul 2020 15:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgGXN6f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Jul 2020 09:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgGXN6f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Jul 2020 09:58:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE8AC0619D3
        for <linux-ext4@vger.kernel.org>; Fri, 24 Jul 2020 06:58:35 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d17so10078652ljl.3
        for <linux-ext4@vger.kernel.org>; Fri, 24 Jul 2020 06:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5yw/8x6q8lAz139DnbHVvZjJi2dIOwvGLDT/O3ku00g=;
        b=TgOM6t8yXZl1TR3zxuOaAu2BYdJvyR4WGt9m18g23ZbNh0yjbxerory7eZyyTZFDXl
         bmTyR9JTyDLGpu8wqcLNW+u0Ni323qlgAcb4mqTb8E9Wom6LuNiaA+dcCQNeXNpzcExc
         OUb24At8H0yGQZf8YP003wPY+McmgKNDAyde0/jw0TAmLq22Xh9rYdMkJ8hbldQlbDx4
         oLINFtEvBKp2IFcF26+AfvhvqeE+S8/Tc4k9ED1OHO+ng4l4ndWSrkwcnEE2E4pZNBOx
         Ry5ZiyyoY5TGhFv6/zravSgCPgIwwTUqhrmbF/2yTD1qA+V5RI5NuRlY8J7gMoX3R6oR
         76tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5yw/8x6q8lAz139DnbHVvZjJi2dIOwvGLDT/O3ku00g=;
        b=OX8/LTnNbI/qMlSrPMURbgiZVis7OQ6xAwYUo9oFV4j//mll33tMIgxvbS+wcvc4iu
         mwhKpcpV/QvEt4Cn4z2pD5BFpmXMKU1KM6Nd5u3kcKRAGRrcOTgGBVkyZ6FWDrq9s/Kt
         /VLWMKjsLGgjT07qVM6MxFDnOGO+fTIlFO5aYvYx/f2bnd2KZmwa6b5WYPA2VrkEnezJ
         +qiIj8NHbKedT2lDH4zSVO7Be+72gg4a7DN7cj04bMrBZYpctAAFssdmaSEYxVL2nkL7
         x+JiTUutB0D3uKFI39Vp/EZEyPsheZKnzbHFc4LvLzKUJe5FP9bgLT2pJ/MFaLzjFl8R
         bs0g==
X-Gm-Message-State: AOAM533LpUEP0+pckX1gUCbf9ERhp7909xrh9Df+zpkvm7T3GLUb3gPs
        KZvWBUWIdYbQ2m+EnjxGzWg=
X-Google-Smtp-Source: ABdhPJwnk/Sk0Ywe4OlwmqCBEvONn+hYNXKRcozZQrUYBXasg6HQgNaonJtv52n1IdUbGmumHzEOeg==
X-Received: by 2002:a2e:1641:: with SMTP id 1mr4274156ljw.73.1595599113423;
        Fri, 24 Jul 2020 06:58:33 -0700 (PDT)
Received: from [192.168.1.192] ([195.245.244.36])
        by smtp.gmail.com with ESMTPSA id s28sm266478ljm.24.2020.07.24.06.58.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 06:58:31 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH 4/4] ext4: add prefetch_block_bitmaps mount options
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <20200717155352.1053040-5-tytso@mit.edu>
Date:   Fri, 24 Jul 2020 16:58:26 +0300
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Alex Zhuravlev <bzzz@whamcloud.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F8BF005-0F3A-42E4-A8C7-9AA7970DD986@gmail.com>
References: <20200717155352.1053040-1-tytso@mit.edu>
 <20200717155352.1053040-5-tytso@mit.edu>
To:     Theodore Ts'o <tytso@mit.edu>
X-Mailer: Apple Mail (2.3445.104.15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Thanks for patch. I believe it can be useful in some case. I have tried =
this patch. The option works fine.
One comment is placed bellow.

Best regards,
Artem Blagodarenko

> On 17 Jul 2020, at 18:53, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> For file systems where we can afford to keep the buddy bitmaps cached,
> we can speed up initial writes to large file systems by starting to
> load the block allocation bitmaps as soon as the file system is
> mounted.  This won't work well for _super_ large file systems, or
> memory constrained systems, so we only enable this when it is
> requested via a mount option.
>=20
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
> fs/ext4/ext4.h    | 13 ++++++++++++
> fs/ext4/mballoc.c | 10 ++++------
> fs/ext4/super.c   | 51 +++++++++++++++++++++++++++++++++++++----------
> 3 files changed, 57 insertions(+), 17 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 7451662e092a..c04d4ef0b77a 100644
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
> +typedef enum {
> +	EXT4_LI_MODE_ITABLE,
> +	EXT4_LI_MODE_PREFETCH_BBITMAP
> +} ext4_li_mode;
> +
> struct ext4_li_request {
> 	struct super_block	*lr_super;
> 	struct ext4_sb_info	*lr_sbi;
> +	ext4_li_mode		lr_mode;
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
> index 172994349bf6..c072d06d678d 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2224,9 +2224,8 @@ static int ext4_mb_good_group_nolock(struct =
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
> @@ -2276,9 +2275,8 @@ ext4_mb_prefetch(struct super_block *sb, =
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
> index 330957ed1f05..9e19d5830745 100644
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
> @@ -3197,19 +3201,33 @@ static void print_daily_error_info(struct =
timer_list *t)
> 	mod_timer(&sbi->s_err_report, jiffies + 24*60*60*HZ);  /* Once a =
day */
> }
>=20
> +static int ext4_run_li_prefetch(struct ext4_li_request *elr,
> +				struct super_block *sb, ext4_group_t =
group)
> +{
> +	unsigned int prefetch_ios =3D 0;
> +
> +	elr->lr_next_group =3D ext4_mb_prefetch(sb, group,
> +					      =
EXT4_SB(sb)->s_mb_prefetch,
> +					      &prefetch_ios);
> +	if (prefetch_ios)
> +		ext4_mb_prefetch_fini(sb, elr->lr_next_group, =
prefetch_ios);
> +	return (group >=3D elr->lr_next_group);
> +}
> +
> /* Find next suitable group and run ext4_init_inode_table */
> static int ext4_run_li_request(struct ext4_li_request *elr)
> {
> 	struct ext4_group_desc *gdp =3D NULL;
> -	ext4_group_t group, ngroups;
> -	struct super_block *sb;
> +	ext4_group_t group =3D elr->lr_next_group;
> +	struct super_block *sb =3D elr->lr_super;
> +	ext4_group_t ngroups =3D EXT4_SB(sb)->s_groups_count;
> 	unsigned long timeout =3D 0;
> 	int ret =3D 0;
>=20
> -	sb =3D elr->lr_super;
> -	ngroups =3D EXT4_SB(sb)->s_groups_count;
> +	if (elr->lr_mode =3D=3D EXT4_LI_MODE_PREFETCH_BBITMAP)
> +		return ext4_run_li_prefetch(elr, sb, group);
>=20
> -	for (group =3D elr->lr_next_group; group < ngroups; group++) {
> +	for (; group < ngroups; group++) {
> 		gdp =3D ext4_get_group_desc(sb, group, NULL);
> 		if (!gdp) {
> 			ret =3D 1;
> @@ -3219,13 +3237,12 @@ static int ext4_run_li_request(struct =
ext4_li_request *elr)
> 		if (!(gdp->bg_flags & =
cpu_to_le16(EXT4_BG_INODE_ZEROED)))
> 			break;
> 	}
> -
> 	if (group >=3D ngroups)
> 		ret =3D 1;
>=20
> 	if (!ret) {
> 		timeout =3D jiffies;
> -		ret =3D ext4_init_inode_table(sb, group,
> +		ret =3D ext4_init_inode_table(elr->lr_super, group,
> 					    elr->lr_timeout ? 0 : 1);
> 		if (elr->lr_timeout =3D=3D 0) {
> 			timeout =3D (jiffies - timeout) *
> @@ -3234,6 +3251,10 @@ static int ext4_run_li_request(struct =
ext4_li_request *elr)
> 		}
> 		elr->lr_next_sched =3D jiffies + elr->lr_timeout;
> 		elr->lr_next_group =3D group + 1;
> +	} else if (test_opt(sb, PREFETCH_BLOCK_BITMAPS)) {
> +		elr->lr_mode =3D EXT4_LI_MODE_PREFETCH_BBITMAP;
> +		elr->lr_next_group =3D 0;
> +		ret =3D 0;
> 	}
> 	return ret;
> }
> @@ -3459,7 +3480,8 @@ static int ext4_li_info_new(void)
> }
>=20
> static struct ext4_li_request *ext4_li_request_new(struct super_block =
*sb,
> -					    ext4_group_t start)
> +						   ext4_group_t start,
> +						   ext4_li_mode mode)
> {
> 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> 	struct ext4_li_request *elr;
> @@ -3468,6 +3490,7 @@ static struct ext4_li_request =
*ext4_li_request_new(struct super_block *sb,
> 	if (!elr)
> 		return NULL;
>=20
> +	elr->lr_mode =3D mode;
> 	elr->lr_super =3D sb;
> 	elr->lr_sbi =3D sbi;
> 	elr->lr_next_group =3D start;
> @@ -3488,6 +3511,7 @@ int ext4_register_li_request(struct super_block =
*sb,
> 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> 	struct ext4_li_request *elr =3D NULL;
> 	ext4_group_t ngroups =3D sbi->s_groups_count;
> +	ext4_li_mode lr_mode =3D EXT4_LI_MODE_ITABLE;
> 	int ret =3D 0;
>=20
> 	mutex_lock(&ext4_li_mtx);
> @@ -3501,10 +3525,15 @@ int ext4_register_li_request(struct =
super_block *sb,
> 	}
>=20
> 	if (first_not_zeroed =3D=3D ngroups || sb_rdonly(sb) ||
> -	    !test_opt(sb, INIT_INODE_TABLE))
> -		goto out;
> +	    !test_opt(sb, INIT_INODE_TABLE)) {
> +		if (test_opt(sb, PREFETCH_BLOCK_BITMAPS)) {
> +			first_not_zeroed =3D 0;

ext4_register_li_request() can be called on EXT4_IOC_RESIZE_FS lctl as
	err =3D ext4_register_li_request(sb, o_group);

In this case inode tables will be initialised started from new block =
range, but block bitmaps loading loop will start from group 0. Yes, this =
loaded groups will be skipped finally, but there are useless CPU time.


> +			lr_mode =3D EXT4_LI_MODE_PREFETCH_BBITMAP;
> +		} else
> +			goto out;
> +	}
>=20
> -	elr =3D ext4_li_request_new(sb, first_not_zeroed);
> +	elr =3D ext4_li_request_new(sb, first_not_zeroed, lr_mode);
> 	if (!elr) {
> 		ret =3D -ENOMEM;
> 		goto out;
> --=20
> 2.24.1
>=20

