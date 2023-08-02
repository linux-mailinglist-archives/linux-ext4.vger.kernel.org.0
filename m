Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B37776D954
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Aug 2023 23:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjHBVSz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Aug 2023 17:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjHBVSz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Aug 2023 17:18:55 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F2BE6F
        for <linux-ext4@vger.kernel.org>; Wed,  2 Aug 2023 14:18:52 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bb84194bf3so2552875ad.3
        for <linux-ext4@vger.kernel.org>; Wed, 02 Aug 2023 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1691011132; x=1691615932;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uHolgJMhzXtJHuQHLjXEEYCSb7L5AR92M/u4DPi4yJU=;
        b=TKDELtRGUh199HROQw+b0JnxbWfEREW70scq98CatFVhxX8y7LRlHp2pYRexrRIcPt
         bRIZ128rosdi4APBx2GPYhDWPCXv0t7OyMJ7X+eyE+aZbT1t/M21XUpkeNa+zFQdeKGw
         6UWCa8RV9h2DSrO3JO/GlNNvcQEoEIClIA2YggJM/2dYLeICc1Tyq+uK7Qdw9HL9OBWm
         pp1SnuCtKCuSdyksZuiyXwpz3F4+7jq+f4jPysS7PJdvxHQQ9P4gPlU6/w1P9WaPcykX
         CXsYlZvEbkQJQ8A6OPDSBDLtxfFf7gLXJ8SyzSwAauiAI6J52hLzfLF5Z2j0ukkfLTkE
         E/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691011132; x=1691615932;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHolgJMhzXtJHuQHLjXEEYCSb7L5AR92M/u4DPi4yJU=;
        b=H9QjFG+0ZY0Ie7cd66lxem/5KgckmHMP3yuz9q/3qsjaVCPxqfMP+r4v8Rvb1fla+u
         6N+DNlvUyHQfBQbwL4ZyEj5Gcqg4OzvnwOscdBojMtWwyKKAg8/i2UO2LiRUaIoMrGip
         Cb+12ni/eIjtq2MeOCp/jFWcxqG6iQKjh/HmsGPrjS23nK0fK/S691fuZlANxuUjO4Ub
         q1gC+PRes0QS2imbjAy79X7zVGqzv74/pXkL41NCeuM+2+Ovn+174xA65ipmP5I44sxc
         Sl3bz/4MwhToKkEBENtT91xbNSTExnxq2fgFCemOyPHGYwP3bmmWw9NQMBMJhuz24SSo
         OeBA==
X-Gm-Message-State: ABy/qLajy97iDjVjNJAEXpiDjl1almhdG+gBpQKLnMvIadhWRaTfSGuS
        ZZkQpIkym22uuesQkCEGpn7acZtQbLQYyMJrwe4=
X-Google-Smtp-Source: APBJJlHk/jFtj+XFBeWR6oZzMb5d2+DLXXG5QwfJcaf9g4RVIjolxyiaJYvmAaRMOV3JSLq78EfwkQ==
X-Received: by 2002:a17:903:228a:b0:1b5:561a:5ca9 with SMTP id b10-20020a170903228a00b001b5561a5ca9mr17791641plh.50.1691011132194;
        Wed, 02 Aug 2023 14:18:52 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id k19-20020a170902761300b001bc2831e1a8sm3813091pll.80.2023.08.02.14.18.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Aug 2023 14:18:51 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <24621E74-A0EA-435D-BA60-73E4266814A2@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_428E15F0-D314-4F15-A33E-74F62FD022C5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: Add periodic superblock update check
Date:   Wed, 2 Aug 2023 15:18:48 -0600
In-Reply-To: <20230731122526.30158-1-vk.en.mail@gmail.com>
Cc:     linux-ext4@vger.kernel.org
To:     Vitaliy Kuznetsov <vk.en.mail@gmail.com>
References: <20230731122526.30158-1-vk.en.mail@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_428E15F0-D314-4F15-A33E-74F62FD022C5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 31, 2023, at 6:25 AM, Vitaliy Kuznetsov <vk.en.mail@gmail.com> =
wrote:
>=20
> This patch introduces a mechanism to periodically check and update
> the superblock within the ext4 file system. The main purpose of this
> patch is to keep the disk superblock up to date. The update will be
> performed if more than one hour has passed since the last update, and
> if more than 16MB of data have been written to disk.
>=20
> This check and update is performed within the =
ext4_journal_commit_callback
> function, ensuring that the superblock is written while the disk is
> active, rather than based on a timer that may trigger during disk idle
> periods.
>=20
> Discussion https://www.spinics.net/lists/linux-ext4/msg85865.html
>=20
> Signed-off-by: Vitaliy Kuznetsov <vk.en.mail@gmail.com>

Thanks for sending the patch.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/super.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
> fs/ext4/sysfs.c |  4 ++--
> 2 files changed, 54 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c94ebf704616..2159e9705404 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -433,6 +433,57 @@ static time64_t __ext4_get_tstamp(__le32 *lo, =
__u8 *hi)
> #define ext4_get_tstamp(es, tstamp) \
> 	__ext4_get_tstamp(&(es)->tstamp, &(es)->tstamp ## _hi)
>=20
> +#define EXT4_SB_REFRESH_INTERVAL_SEC (3600) /* seconds (1 hour) */
> +#define EXT4_SB_REFRESH_INTERVAL_KB (16384) /* kilobytes (16MB) */
> +
> +/*
> + * The ext4_maybe_update_superblock() function checks and updates the
> + * superblock if needed.
> + *
> + * This function is designed to update the on-disk superblock only =
under
> + * certain conditions to prevent excessive disk writes and =
unnecessary
> + * waking of the disk from sleep. The superblock will be updated if:
> + * 1. More than an hour has passed since the last superblock update, =
and
> + * 2. More than 16MB have been written since the last superblock =
update.
> + *
> + * @sb: The superblock
> + */
> +static void ext4_maybe_update_superblock(struct super_block *sb)
> +{
> +	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> +	struct ext4_super_block *es =3D sbi->s_es;
> +	journal_t *journal =3D sbi->s_journal;
> +	time64_t now;
> +	__u64 last_update;
> +	__u64 lifetime_write_kbytes;
> +	__u64 diff_size;
> +
> +	if (sb_rdonly(sb) || !(sb->s_flags & SB_ACTIVE) ||
> +	    !journal || (journal->j_flags & JBD2_UNMOUNT))
> +		return;
> +
> +	now =3D ktime_get_real_seconds();
> +	last_update =3D ext4_get_tstamp(es, s_wtime);
> +
> +	if (likely(now - last_update < EXT4_SB_REFRESH_INTERVAL_SEC))
> +		return;
> +
> +	lifetime_write_kbytes =3D sbi->s_kbytes_written +
> +		((part_stat_read(sb->s_bdev, sectors[STAT_WRITE]) -
> +		  sbi->s_sectors_written_start) >> 1);
> +
> +	/* Get the number of kilobytes not written to disk to account
> +	 * for statistics and compare with a multiple of 16 MB. This
> +	 * is used to determine when the next superblock commit should
> +	 * occur (i.e. not more often than once per 16MB if there was
> +	 * less written in an hour).
> +	 */
> +	diff_size =3D lifetime_write_kbytes - =
le64_to_cpu(es->s_kbytes_written);
> +
> +	if (diff_size > EXT4_SB_REFRESH_INTERVAL_KB)
> +		schedule_work(&EXT4_SB(sb)->s_error_work);
> +}
> +
> /*
>  * The del_gendisk() function uninitializes the disk-specific data
>  * structures, including the bdi structure, without telling anyone
> @@ -459,6 +510,7 @@ static void ext4_journal_commit_callback(journal_t =
*journal, transaction_t *txn)
> 	BUG_ON(txn->t_state =3D=3D T_FINISHED);
>=20
> 	ext4_process_freed_data(sb, txn->t_tid);
> +	ext4_maybe_update_superblock(sb);
>=20
> 	spin_lock(&sbi->s_md_lock);
> 	while (!list_empty(&txn->t_private_list)) {
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 6d332dff79dd..9f334de4f636 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -515,7 +515,8 @@ static const struct kobj_type ext4_feat_ktype =3D =
{
>=20
> void ext4_notify_error_sysfs(struct ext4_sb_info *sbi)
> {
> -	sysfs_notify(&sbi->s_kobj, NULL, "errors_count");
> +	if (sbi->s_add_error_count > 0)
> +		sysfs_notify(&sbi->s_kobj, NULL, "errors_count");
> }
>=20
> static struct kobject *ext4_root;
> @@ -605,4 +606,3 @@ void ext4_exit_sysfs(void)
> 	remove_proc_entry(proc_dirname, NULL);
> 	ext4_proc_root =3D NULL;
> }
> -
> --


Cheers, Andreas






--Apple-Mail=_428E15F0-D314-4F15-A33E-74F62FD022C5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmTKyDkACgkQcqXauRfM
H+BichAAkyZQ9GLNG6QqQukJi/wXEXiIBJ2L6nsvSu7mbHETv1HkFvg25IVKxl32
E6XzzzTRSD1XBSwtCEtFM9mwHLho0D9I2pJUQFLRmu3TO8Jt+Sy08LUxma6bZKtM
ohIUogpdsHyvdNjN6ciSfCQp27sgvm1nDwZD668jGMW0IwCknujTqvjek4Wz7Mrj
NIltfl+gyzrV2ZBIr62UgCAuY3G076l8ws7J9K0mn71j3Pbl42wX/M7iPsQPQkCs
vfNHELLX4DlfUR6kygF6Ilis+K9rhTgv2pMUjMYTLDd5F+wtc1djufoMhOH+F9xU
+qbGcsoyNl6RLwjQ+PwgCBu1tzYs9uT1WYr+bmjDkt45bseMYSVBpP9NAHpBkoQe
a8ktGCl5d+kihpDbDyIGt2JqijNzeJvg2XUhKGgKRzDk6+9Sx+qONNoz3OwgQihu
/zYa2FYAIL2vr6GM+YEDXYD8TYtv2/MtUbYRCkkE8L5TUrxihvXWYSMegu+XI2A1
GmonF/oPK2+ftuyEIId+khywzGrlOeXiI7iTvqDQbsHQs41X4lBixdbQ8sWy5hoM
ycHXHpcIZ5Kl9360/woWvRETtwFW17Ov0VZTem9tud4vgAIEuCRl95ZNWj0I+8nF
rGO1EfTmV/ydWwFDp5M2U5usqTf2njgqrPUOLl5Mh6jyx7FAQrg=
=kb2G
-----END PGP SIGNATURE-----

--Apple-Mail=_428E15F0-D314-4F15-A33E-74F62FD022C5--
