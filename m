Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EA44F3FDC
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Apr 2022 23:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbiDEN0B (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Apr 2022 09:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380520AbiDEMx4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Apr 2022 08:53:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2932D3586D
        for <linux-ext4@vger.kernel.org>; Tue,  5 Apr 2022 04:53:59 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id k21so22804607lfe.4
        for <linux-ext4@vger.kernel.org>; Tue, 05 Apr 2022 04:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vCX5aiW23yefgecc63cFLFUQq0C7dBZ7yVRDAdJPOpo=;
        b=GlVI5SDeqj347dB+hNKkcXmI0S4xKM7CTpX3dB6y8IoJmLXiPm81Fw1pmkL+jhfamM
         tUE4TtVeaEM4tL8FXBwd5j630MeekiBo+8n6FQ6dXwlqRXzsI19jbxARALuwP7r3C95P
         4yJ45gEWyfZXcKWfAAvs0VeGqSuWIluhZtvtcFLI5FMfPaUsFP9tl9yD/7mU3Q0OYeVQ
         eIqqVJVG6HINM163/SJNPx0i6DHFl0nKFWyw/gWSBzkZGrr2vxP651rsp6UHs1xNL4wK
         Od89Bhyowe2YFkWHYzPovopx/CSMOcPgaIXRXA1fJ4uyXAS24CECtycFTpo+rTjpYQ/V
         b/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vCX5aiW23yefgecc63cFLFUQq0C7dBZ7yVRDAdJPOpo=;
        b=cXH51owtgYud3dgnxMwaIjW5dFyQpmozB0YSHukXSr+tqEAHcHvxPt/esDP24I71+p
         M9TENnzYqeLD0gr/9VLSdGq+/LbFH2x01jjsPBW73a8bJON1Oq9bcQYJ3X3bVV4IJnVB
         e0XFi83TsR0HtYTeJwZm8IjjVCMivzndGGx8fANrSxFY+mmmDTKq1w7915pICVumf+Ot
         YRKsQXbTo1k/x3pcb4Gcgy2Nz5iBqcdUMcUTuTOu2tERCHgbUxjhHfG/B7Prt1ORwEn1
         /zd4tqyZYR0fI7bCzTz7+oQYYFwrQ/ToX3PpI9A+l+pV6m5TMNjpiVccbj8MJB8p0XqR
         nrCQ==
X-Gm-Message-State: AOAM533s88a9q33m2g6681f6yv6p61BaK391B09PjnI66PyQGHZceBA1
        jKwwxs5DkRqV3SuUrlUsF5hIubZqPhs=
X-Google-Smtp-Source: ABdhPJz34eokqppGwRwHXeGNzETl7hSErfEQOQ52VPcX5tNhWZLfm8CtfXCrZnNm1ukHQEPfNaOr/w==
X-Received: by 2002:a05:6512:2341:b0:448:2465:7cf with SMTP id p1-20020a056512234100b00448246507cfmr2315797lfu.474.1649159637216;
        Tue, 05 Apr 2022 04:53:57 -0700 (PDT)
Received: from [192.168.2.15] ([83.234.50.195])
        by smtp.gmail.com with ESMTPSA id l3-20020a056512332300b0044a34844974sm1481055lfe.12.2022.04.05.04.53.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Apr 2022 04:53:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v3] ext4: truncate during setxattr leads to kernel panic
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <20220402084023.1841375-1-anserper@ya.ru>
Date:   Tue, 5 Apr 2022 14:53:54 +0300
Cc:     linux-ext4@vger.kernel.org,
        Andrew Perepechko <andrew.perepechko@hpe.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <323538E7-7276-4F71-A78D-91E58D27D72E@gmail.com>
References: <20220402084023.1841375-1-anserper@ya.ru>
To:     anserper@ya.ru
X-Mailer: Apple Mail (2.3445.9.7)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Reviewed-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>

> 2 =D0=B0=D0=BF=D1=80. 2022 =D0=B3., =D0=B2 11:40, anserper@ya.ru =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
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
> --=20
> 2.25.1
>=20

