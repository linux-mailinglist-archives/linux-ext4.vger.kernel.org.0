Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FD24F05C3
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Apr 2022 21:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240620AbiDBT0q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 2 Apr 2022 15:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240018AbiDBT0p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 2 Apr 2022 15:26:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4186361
        for <linux-ext4@vger.kernel.org>; Sat,  2 Apr 2022 12:24:52 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u14so1396711pjj.0
        for <linux-ext4@vger.kernel.org>; Sat, 02 Apr 2022 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=c88WuIGaNwvqiJs6o6Eh+GlCBxvTxN/541R+XkAQQmE=;
        b=bSluFAbGkCpSz76NHXDh3RGGpGtleuwYGL/vhTraJB8mVm9OI2EI8vLdrmQQkvuf5O
         81FwBKY/oEUmhsOiKB6mx0yzDbFJ1TdQ6QGYL7QmsOLadEx+WUHUtIN/V0JFU83d42gz
         3h/yZ4BaE5u/l8kwOBlmfz3iXsq4RuKKpOneyLLOs5Q3kJJON5Ka9Jdb8pFvw8VAOww5
         /0T2XFq5KVKQjvZxgeTHZrwxfmg2ugQUOYRRwc2nDKvDwFfTR423thfPwtBRrEeYn8PK
         TqZftXFTd7kct6rZza+v7IHODWzzenpggddm/V4pWVBiktHjGmSr4JGJ9fTE/QgfgJFI
         0bBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=c88WuIGaNwvqiJs6o6Eh+GlCBxvTxN/541R+XkAQQmE=;
        b=ByyfCepE+MDC9w5n36I3AK7NI573PEHBXwI9ZakYljbJ74edeqRcI4txI5CDs85Gj7
         pH9k5hdg7YomPbpdniFn8fhKFLynfMkW7LYLAI6rz3nGaPboIROTyIM3uxp63R2kdjiO
         8pN4hshOs38L0budfjD+Bgq+2vPTUHWW0hnh/MCfUhPbwHAELPpx7fzMkHeOBnVNW2pF
         cpulkOiCI/jVaPW71DwTJiVKkrc8NLnqnulgaKki6dFtQt8nMpCvhlbAwpXI/5nR4g1p
         zeFPXTLS2VvsEj0VffzzQSb7BjH8ki0TMlZ7m2NTuVQcQiaqdMePUfumrUZEAA8aZpkF
         NQLg==
X-Gm-Message-State: AOAM532ILDWOWHS6QPPqyn6BVoiWpMPQ1fVVVyEuOOok2VB2wMob+JX+
        4bR3fmZwAAvhQnyd4YgzRZ9TXw==
X-Google-Smtp-Source: ABdhPJyXx7QtPGh9A05ExlLivt2nsalhazAV6qqjJOdcED2UcViHFqdDSypfiRYgbsaxzWOqduD1WA==
X-Received: by 2002:a17:902:d5cd:b0:156:6263:bbc7 with SMTP id g13-20020a170902d5cd00b001566263bbc7mr11352820plh.160.1648927491445;
        Sat, 02 Apr 2022 12:24:51 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id k137-20020a633d8f000000b0039800918b00sm5845475pga.77.2022.04.02.12.24.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Apr 2022 12:24:51 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <BBCE411D-E6D0-4826-8F4E-89A09E30D515@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5C9BCCF5-2135-4AAE-A29B-DB2A049310C3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] ext4: truncate during setxattr leads to kernel panic
Date:   Sat, 2 Apr 2022 13:24:47 -0600
In-Reply-To: <20220402084023.1841375-1-anserper@ya.ru>
Cc:     linux-ext4@vger.kernel.org,
        Andrew Perepechko <andrew.perepechko@hpe.com>
To:     anserper@ya.ru
References: <20220402084023.1841375-1-anserper@ya.ru>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_5C9BCCF5-2135-4AAE-A29B-DB2A049310C3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 2, 2022, at 2:40 AM, anserper@ya.ru wrote:
>=20
> From: Andrew Perepechko <andrew.perepechko@hpe.com>
>=20
> When changing a large xattr value to a different large xattr value,
> the old xattr inode is freed. Truncate during the final iput causes
> current transaction restart. Eventually, parent inode bh is marked
> dirty and kernel panic happens when jbd2 figures out that this bh
> belongs to the committed transaction.
>=20
> A possible fix is to call this final iput in a separate thread.
> This way, setxattr transactions will never be split into two.
> Since the setxattr code adds xattr inodes with nlink=3D0 into the
> orphan list, old xattr inodes will be properly cleaned up in
> any case.
>=20
> Signed-off-by: Andrew Perepechko <andrew.perepechko@hpe.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> HPE-bug-id: LUS-10534
>=20
> Changes since v1:
> - fixed a bug added during the porting
> - fixed a workqueue related deadlock reported by Tetsuo Handa
> ---
> fs/ext4/ext4.h    |  7 +++++--
> fs/ext4/page-io.c |  2 +-
> fs/ext4/super.c   | 15 ++++++++-------
> fs/ext4/xattr.c   | 39 +++++++++++++++++++++++++++++++++++++--
> 4 files changed, 51 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 3f87cca49f0c..52db5d6bae7f 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1650,8 +1650,11 @@ struct ext4_sb_info {
> 	struct flex_groups * __rcu *s_flex_groups;
> 	ext4_group_t s_flex_groups_allocated;
>=20
> -	/* workqueue for reserved extent conversions (buffered io) */
> -	struct workqueue_struct *rsv_conversion_wq;
> +	/*
> +	 * workqueue for reserved extent conversions (buffered io)
> +	 * and large ea inodes reclaim
> +	 */
> +	struct workqueue_struct *s_misc_wq;
>=20
> 	/* timer for periodic error stats printing */
> 	struct timer_list s_err_report;
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 495ce59fb4ad..0142b88471ff 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -228,7 +228,7 @@ static void ext4_add_complete_io(ext4_io_end_t =
*io_end)
> 	WARN_ON(!(io_end->flag & EXT4_IO_END_UNWRITTEN));
> 	WARN_ON(!io_end->handle && sbi->s_journal);
> 	spin_lock_irqsave(&ei->i_completed_io_lock, flags);
> -	wq =3D sbi->rsv_conversion_wq;
> +	wq =3D sbi->s_misc_wq;
> 	if (list_empty(&ei->i_rsv_conversion_list))
> 		queue_work(wq, &ei->i_rsv_conversion_work);
> 	list_add_tail(&io_end->list, &ei->i_rsv_conversion_list);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 81749eaddf4c..ee03f593b264 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1200,10 +1200,11 @@ static void ext4_put_super(struct super_block =
*sb)
> 	int i, err;
>=20
> 	ext4_unregister_li_request(sb);
> +	flush_workqueue(sbi->s_misc_wq);
> 	ext4_quota_off_umount(sb);
>=20
> 	flush_work(&sbi->s_error_work);
> -	destroy_workqueue(sbi->rsv_conversion_wq);
> +	destroy_workqueue(sbi->s_misc_wq);
> 	ext4_release_orphan_info(sb);
>=20
> 	/*
> @@ -5294,9 +5295,9 @@ static int __ext4_fill_super(struct fs_context =
*fc, struct super_block *sb)
> 	 * The maximum number of concurrent works can be high and
> 	 * concurrency isn't really necessary.  Limit it to 1.
> 	 */
> -	EXT4_SB(sb)->rsv_conversion_wq =3D
> -		alloc_workqueue("ext4-rsv-conversion", WQ_MEM_RECLAIM | =
WQ_UNBOUND, 1);
> -	if (!EXT4_SB(sb)->rsv_conversion_wq) {
> +	EXT4_SB(sb)->s_misc_wq =3D
> +		alloc_workqueue("ext4-misc", WQ_MEM_RECLAIM | =
WQ_UNBOUND, 1);
> +	if (!EXT4_SB(sb)->s_misc_wq) {
> 		printk(KERN_ERR "EXT4-fs: failed to create =
workqueue\n");
> 		ret =3D -ENOMEM;
> 		goto failed_mount4;
> @@ -5514,8 +5515,8 @@ static int __ext4_fill_super(struct fs_context =
*fc, struct super_block *sb)
> 	sb->s_root =3D NULL;
> failed_mount4:
> 	ext4_msg(sb, KERN_ERR, "mount failed");
> -	if (EXT4_SB(sb)->rsv_conversion_wq)
> -		destroy_workqueue(EXT4_SB(sb)->rsv_conversion_wq);
> +	if (EXT4_SB(sb)->s_misc_wq)
> +		destroy_workqueue(EXT4_SB(sb)->s_misc_wq);
> failed_mount_wq:
> 	ext4_xattr_destroy_cache(sbi->s_ea_inode_cache);
> 	sbi->s_ea_inode_cache =3D NULL;
> @@ -6129,7 +6130,7 @@ static int ext4_sync_fs(struct super_block *sb, =
int wait)
> 		return 0;
>=20
> 	trace_ext4_sync_fs(sb, wait);
> -	flush_workqueue(sbi->rsv_conversion_wq);
> +	flush_workqueue(sbi->s_misc_wq);
> 	/*
> 	 * Writeback quota in non-journalled quota case - journalled =
quota has
> 	 * no dirty dquots
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 042325349098..ee13675fbead 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1544,6 +1544,36 @@ static int =
ext4_xattr_inode_lookup_create(handle_t *handle, struct inode *inode,
> 	return 0;
> }
>=20
> +struct delayed_iput_work {
> +	struct work_struct work;
> +	struct inode *inode;
> +};
> +
> +static void delayed_iput_fn(struct work_struct *work)
> +{
> +	struct delayed_iput_work *diwork;
> +
> +	diwork =3D container_of(work, struct delayed_iput_work, work);
> +	iput(diwork->inode);
> +	kfree(diwork);
> +}
> +
> +static void delayed_iput(struct inode *inode, struct =
delayed_iput_work *work)
> +{
> +	if (!inode) {
> +		kfree(work);
> +		return;
> +	}
> +
> +	if (!work) {
> +		iput(inode);
> +	} else {
> +		INIT_WORK(&work->work, delayed_iput_fn);
> +		work->inode =3D inode;
> +		queue_work(EXT4_SB(inode->i_sb)->s_misc_wq, =
&work->work);
> +	}
> +}
> +
> /*
>  * Reserve min(block_size/8, 1024) bytes for xattr entries/names if =
ea_inode
>  * feature is enabled.
> @@ -1561,6 +1591,7 @@ static int ext4_xattr_set_entry(struct =
ext4_xattr_info *i,
> 	int in_inode =3D i->in_inode;
> 	struct inode *old_ea_inode =3D NULL;
> 	struct inode *new_ea_inode =3D NULL;
> +	struct delayed_iput_work *diwork =3D NULL;
> 	size_t old_size, new_size;
> 	int ret;
>=20
> @@ -1637,7 +1668,11 @@ static int ext4_xattr_set_entry(struct =
ext4_xattr_info *i,
> 	 * Finish that work before doing any modifications to the xattr =
data.
> 	 */
> 	if (!s->not_found && here->e_value_inum) {
> -		ret =3D ext4_xattr_inode_iget(inode,
> +		diwork =3D kmalloc(sizeof(*diwork), GFP_NOFS);
> +		if (!diwork)
> +			ret =3D -ENOMEM;
> +		else
> +			ret =3D ext4_xattr_inode_iget(inode,
> 					    =
le32_to_cpu(here->e_value_inum),
> 					    le32_to_cpu(here->e_hash),
> 					    &old_ea_inode);
> @@ -1790,7 +1825,7 @@ static int ext4_xattr_set_entry(struct =
ext4_xattr_info *i,
>=20
> 	ret =3D 0;
> out:
> -	iput(old_ea_inode);
> +	delayed_iput(old_ea_inode, diwork);
> 	iput(new_ea_inode);
> 	return ret;
> }
> --
> 2.25.1
>=20


Cheers, Andreas






--Apple-Mail=_5C9BCCF5-2135-4AAE-A29B-DB2A049310C3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmJIowAACgkQcqXauRfM
H+C72w//Z+Eb2rui9w7cB332V8WtGnQnsJlJbnAjUnhCjKOPeAvFzcPX77qA+sbN
jb9HIDecFwmvuqYZfcBkdNJO4EH3D2j7AIXYH6vUKYqtUbxoVioMydxr4KbQCAi/
Lvg0uG44T4Spu9z28MdlvsGSohiXatsuaMO/rmcUFWlPtAD84zHYTHp9T417YCTX
dgyLt09rNY2qUsemuSQu4Irz1en2m/xGM8V1rEBUptGQmsQAuMPifcNOdP/Fwe7g
1ZARMguAy/nd7vay5bq2kwnRY9VD6MloTI03j4rzjNxMAWvDpsj+1RE1bKsFvGJt
4wIc/80vD0kTeVQzS54aJoiCOKIJ+i1HmASS02PnzyS5KPKpiEleJd9ubQEIKHKy
TfHdX6sOv6wW6eKxHbox9hC92ZnjE5601mlL45Zse1nTH91EC/xl1AdjGQ3pl44g
GaPJYsI+t/TbOwiR8fhjvz8FeYqbAi27xIQ19KMT31mZEhWdYilKI+8kDd9fhEoY
DK3yXOxBEYfZjgq0KpCrXnJ97yk+4Fr0PZYZqr+QhiyWSAlPnIEhHVQ5FWE83nut
AA5a6aPSaUZUYU1X15T5MWC7xazA1xjLcmgHHFWSGFiUwLflSDoVjT4LBX/nKjRX
/hlw6UjXIy0TVkY9BZltPX9htItytVARoto7+Tx80CEdbxgUS4c=
=uvGl
-----END PGP SIGNATURE-----

--Apple-Mail=_5C9BCCF5-2135-4AAE-A29B-DB2A049310C3--
