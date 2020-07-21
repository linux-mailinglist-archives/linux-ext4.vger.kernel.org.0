Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D04F227A85
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 10:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgGUIUI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 04:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgGUIUI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jul 2020 04:20:08 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA074C061794
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 01:20:07 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so11612411pgf.0
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=1lkhz8foaO9U3KZdlC5umcW/T9Bh+PtOWOuwS9kDxGI=;
        b=sjwLW3uz1VYw9FBnX/cmqTI0gMmWz2XI254EuS92fGKz+iFgzP94mucJNc1qx7YM61
         qg8vnCgAl/Pn//yxIctfVXcLIoDaQfQmFJFrasPl57HsL+1Zq+b5apNMZLv3jX9SWeST
         ud34K59ZJ+e34+DiqDaw6BbvJfLixR/bXm9vHS2yFraCadDzWgHg7WA6p90JY+zlyVR7
         QcjVuYuNj3FDujopcVrSGwW3SlaPFxwRQntoZYUUTrbYc3Rf8Jyxo/g7ijla3wHkoeBN
         w2mkVfQPPEvBLZ9M98MKYUVbmnppHD59JtDGW+pT/F5Fw+uGqHjG1fWbZFhICiQOGYCM
         HPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=1lkhz8foaO9U3KZdlC5umcW/T9Bh+PtOWOuwS9kDxGI=;
        b=OgOa68ORKh61Rf0QUmAJ+H2tPBmQLsbhKVSUalqQGl9Q/P5R9SQiNuQAN7NyekuBKw
         QFzm02HDFM6nIFvDyL6w0mwuTWJa13guWDbTOb7GJiJC/N/F3cVqe85LogDpO/ovC87/
         StorYVACLToDWRLrXbpH7bM7kxejs+N+N918q5YcEPphsajqAmEAxFs7IuIR3Adj2Qls
         7l+5PiABPnZv+FuMRYeTxuQuGPo3aiW3EoFfRpJfipmcNs0rAUvty/FNIvD2an66jjyD
         a7ygnnVTZ/+E/Ioo+x1cBQAbsBZBRMKyYMgk9HiFYnwhjDzsW6dGjiinlXYa3b3CkdE2
         J/Ww==
X-Gm-Message-State: AOAM530MCzVjK5T0+9+ruchFImG91jg22Gk2SK9l99yGZMqhDLzidQJP
        sATYsUccDXf/2X4b0wTfvwncGJqsy5U=
X-Google-Smtp-Source: ABdhPJzrtxNoS9fBv49uwl7e8OkUiIhdPSOiZEtvHnIh20FodWdduLQ10FFVI1XmpW1Q5aFQBpk5QQ==
X-Received: by 2002:a62:1bc6:: with SMTP id b189mr2215960pfb.150.1595319607207;
        Tue, 21 Jul 2020 01:20:07 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id p19sm16837367pgj.74.2020.07.21.01.20.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 01:20:06 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <6FF647F3-5CB2-4F22-BDD3-C0D128F24FE9@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_989FC853-D24D-45EB-9ACC-C13F3E1AB1A9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 4/4] ext4: add prefetch_block_bitmaps mount options
Date:   Tue, 21 Jul 2020 02:20:04 -0600
In-Reply-To: <20200717155352.1053040-5-tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Alex Zhuravlev <bzzz@whamcloud.com>
To:     Theodore Ts'o <tytso@mit.edu>
References: <20200717155352.1053040-1-tytso@mit.edu>
 <20200717155352.1053040-5-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_989FC853-D24D-45EB-9ACC-C13F3E1AB1A9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 17, 2020, at 9:53 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> For file systems where we can afford to keep the buddy bitmaps cached,
> we can speed up initial writes to large file systems by starting to
> load the block allocation bitmaps as soon as the file system is
> mounted.  This won't work well for _super_ large file systems, or
> memory constrained systems, so we only enable this when it is
> requested via a mount option.

I was looking at this, and maybe I misunderstand the code, but it looks
like it does the itable zeroing first, then once that is completed it
will do the block bitmap prefetch:

	if (first_not_zeroed =3D=3D ngroups || sb_rdonly(sb) ||
	    !test_opt(sb, INIT_INODE_TABLE)) {
		if (test_opt(sb, PREFETCH_BLOCK_BITMAPS)) {
			first_not_zeroed =3D 0;
			lr_mode =3D EXT4_LI_MODE_PREFETCH_BBITMAP;
	}

so it would only get into this case of first_not_zeroed =3D=3D ngroups
after all of the inode tables are marked zeroed in the GDT.

However, it seems to me that the order of these two should be reversed,
since inode table zeroing can take ages (GB/TB to write), while block
bitmap loading could be done much more quickly.  Also, if the itable
zeroing is ever changed to verify that the itable blocks are properly
marked in the block bitmap (which seems reasonable), then "prefetch"
of the block bitmaps would be too late.

It isn't clear if there is any benefit to also prefetch the inode
bitmaps at the same time?  It doesn't look like they are used by
the itable zeroing code, only the GDT inode high watermark.

It would seem to me that if an application is writing to a newly-mounted
filesystem that the block bitmaps will *always* be needed, while itable
zeroing is a "nice to have when it can be done" since there is no real
expectation in the code that the itable is zeroed.  Only e2fsck cares
about this, and if your system fails before it finishes, you have
bigger problems to worry about.

I'm not adamant about changing this before landing, if you see a real
benefit from this today, just some thoughts for possible improvement.

Cheers, Andreas

> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
> fs/ext4/ext4.h    | 13 ++++++++++++
> fs/ext4/mballoc.c | 10 ++++------
> fs/ext4/super.c   | 51 +++++++++++++++++++++++++++++++++++++----------
> 3 files changed, 57 insertions(+), 17 deletions(-)
>=20
>=20
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
> --
> 2.24.1
>=20


Cheers, Andreas






--Apple-Mail=_989FC853-D24D-45EB-9ACC-C13F3E1AB1A9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8WpTUACgkQcqXauRfM
H+DjFA/+M8UhKm1zVEuJhoR12PGNJN1OZfhpjQ8aUnKTe+ni19MYwchOmEcNHzUE
TiQxpJsWcAGNOQkQkD9ST1oFWnxElbBJa4TMUIigmSifZcf1gJS8rNQXdX23YHCG
AHgmgjdRW4LHdhObN/ovpdrSt3lsh2IoIUAAXLzHi5/D0wWLYY+VW/da5eSwddfO
nTY9Zh0nnrsPgOj295RfZikhsKAYmbv8C0XewuQ1RKemy56itQBbjUz0n71rKz33
UokHJ7Syu/oi/OQfXWRdONV2I89OZYEcn1UnLqhx7YdZfwKngJ/3mKVRnw18NaXH
MpNj/rbnOSX5pY3SAPkmw4MeWtEB1tN47J4Zf6GRc0Vsh5tjSq2A3Dr9ZWOkiNfw
H0oXbjE/IcL9+KA7Q/3s5zILG0H1IyoWsLsELhFbD2Iba7SI5N3vlIebHAjPDTot
hdnlyw36eqKzJz0BConWS9eTWUyIoxDB9g37HKwlaNSE2YbQ69JzrgBkje7Hi4Mh
w4DQFm/hQYrLCZ2onET/j4d96QPZy7dIx5gBmljq6lrXG12xwlS4hmyvGlC5hgo0
Dexl0HTC+87LcYPPnGMt429TB6YtK2B9oyuFlWPRo5o1OLVtaWB8NEbwywbrB8WD
qk5CQ3a7aBEKelWZS8vi+PF6Ix+R78W2ARhe/Q/d9JSyHQlJWd0=
=+3w1
-----END PGP SIGNATURE-----

--Apple-Mail=_989FC853-D24D-45EB-9ACC-C13F3E1AB1A9--
