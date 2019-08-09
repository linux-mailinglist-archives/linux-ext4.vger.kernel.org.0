Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7B188492
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 23:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfHIVX1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Aug 2019 17:23:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45873 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfHIVX1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Aug 2019 17:23:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id w26so1412672pfq.12
        for <linux-ext4@vger.kernel.org>; Fri, 09 Aug 2019 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=/hWUUvPtXr1ws1slMxvIUYFf4shDweH13FcS4onqQcQ=;
        b=oK8a42RnLYqCCB3KlVqbDC4A7hFJkcz4YufnHrZIaF1+TXKwJhG+W5K6zY0FvuJOoP
         DgLOyU76YPB2p3mzHOCwtvlCiBDuqhnUWhsMB3nEer86jY77IC7PXSoX0eg0dLxVsapW
         LadKXpJh7ROvj0LHnYi9M2leTGlLmAjB7apokgkO3MGhU5tdVTqeTkdZLQuemg1PKfp9
         XGUUrlQV+o13fwYlEDQk5ZozVlWSCLKBU3j64n0i4c2d7PChxmZFrOw1umf/iuk89wWk
         xx5jseWLiZiktGavR+yHLaBTqxGkF5kHM7zoC7bAhqIS77ERbJho55XbzcGkm3o32vie
         Sdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=/hWUUvPtXr1ws1slMxvIUYFf4shDweH13FcS4onqQcQ=;
        b=FrOHYUMEmzBB72t/BH+iXhwZP0D3NnkMPWgnd1+fUfkxgHbPxv61NnWH0gUzZO3Ygp
         7Tb8ObaQT1f66UYaK02pq/4hEORke9gWgeL+BAqUiSXufrfNx6CzbjivEJRlXCz5luuA
         dDBdzcUGDxrau/t4Cm5IZKFdh+zqZ9wWSkKARTIuWHrpo6ryyRU0sZxvZj+ZG85Kjr07
         1t24M94ZRoN02nsljE7xEk4KneI/Fpx7kTzUtfTY6t/8VvnQaWhgCsv3qsA3NMi7ZbmN
         maCR5r3kylSBY8NIrcLgxD3C5J5SWv9VZsUIVVZXbr4/iE0jBbKKijNjLR6YKY6WJ16C
         DBWQ==
X-Gm-Message-State: APjAAAUybWCGlwI133ecZHBlgZfPsv48H59/hd+yjGGRdqfSUu4P2/Ps
        ge7uWuQuK07kJsVK3pbbOB/Ub45TWsFFZw==
X-Google-Smtp-Source: APXvYqx3/FnHUyAavTPQHl49VRBkGgzeO4Dl12UtRBPs3ru2l3eKespEHO6ckVs8hD8tSFl4Wzb/+Q==
X-Received: by 2002:aa7:8752:: with SMTP id g18mr22691816pfo.201.1565385806529;
        Fri, 09 Aug 2019 14:23:26 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id p7sm113071454pfp.131.2019.08.09.14.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 14:23:25 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <10EB162C-FDCF-476B-9AC0-923C2230DEA7@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5AE9DEDC-F3C0-4C22-BC85-E523B0676F1F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 07/12] ext4: add fields that are needed to track
 changed files
Date:   Fri, 9 Aug 2019 15:23:23 -0600
In-Reply-To: <20190809034552.148629-8-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
 <20190809034552.148629-8-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_5AE9DEDC-F3C0-4C22-BC85-E523B0676F1F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 8, 2019, at 9:45 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> Ext4's fast commit feature tracks changed files and maintains them in
> a queue. We also remember for each file the logical block range that
> needs to be committed. This patch adds these fields to ext4_inode_info
> and ext4_sb_info and also adds initialization calls.
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>=20
> ---
>=20
> Changelog:
>=20
> V2: Converted s_fc_lock from mutex to spinlock to improve parallelism
>    performance.
> ---
> fs/ext4/ext4.h      | 34 ++++++++++++++++++++++++++++++++++
> fs/ext4/ext4_jbd2.c | 13 +++++++++++++
> fs/ext4/ext4_jbd2.h |  2 ++
> fs/ext4/inode.c     |  1 +
> fs/ext4/super.c     |  7 +++++++
> 5 files changed, 57 insertions(+)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index becbda38b7db..0d15d4539dda 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -921,6 +921,27 @@ enum {
> 	I_DATA_SEM_QUOTA,
> };
>=20
> +/*
> + * Ext4 fast commit inode specific information
> + */
> +struct ext4_fast_commit_inode_info {
> +	/* TID / SUB-TID when old_i_size and i_size were recorded */
> +	tid_t fc_tid;
> +	tid_t fc_subtid;
> +
> +	/*
> +	 * Start of logical block range that needs to be committed in =
this fast
> +	 * commit
> +	 */
> +	loff_t fc_lblk_start;
> +
> +	/*
> +	 * End of logical block range that needs to be committed in this =
fast
> +	 * commit
> +	 */
> +	loff_t fc_lblk_end;

Since these are logical block numbers within the journal, they certainly
don't need to be 64-bit values.  loff_t is for byte offsets, this should
use ext4_lblk_t, which will also reduce the size of the struct by 8 =
bytes.

> +};
> +
>=20
> /*
>  * fourth extended file system inode data in memory
> @@ -955,6 +976,9 @@ struct ext4_inode_info {
>=20
> 	struct list_head i_orphan;	/* unlinked but open inodes */
>=20
> +	struct list_head i_fc_list;	/* inodes that need fast commit =
*/

This comment should document what lock is protecting this list, along
with the other fields.

> +	struct ext4_fast_commit_inode_info i_fc;

Since this increases the size of the inode, does it affect the number of
inodes that can fit into one page of ext4_inode_cachep?

> 	/*
> 	 * i_disksize keeps track of what the inode size is ON DISK, not
> 	 * in memory.  During truncate, i_size is set to the new size by
> @@ -1529,6 +1553,16 @@ struct ext4_sb_info {
> 	/* Barrier between changing inodes' journal flags and writepages =
ops. */
> 	struct percpu_rw_semaphore s_journal_flag_rwsem;
> 	struct dax_device *s_daxdev;
> +
> +	/* Ext4 fast commit stuff */
> +	bool fc_replay;			/* Fast commit replay in =
progress */
> +	struct list_head s_fc_q;	/* Inodes that need fast commit. =
*/

This comment should document what lock is protecting this list, along
with the other fields.

> +	__u32 s_fc_q_cnt;		/* Number of inodes in the fc =
queue */
> +	bool s_fc_eligible;		/*
> +					 * Are changes after the last =
commit
> +					 * eligible for fast commit?
> +					 */

It is slightly more space efficient to put the bool values together
rather than interleaving them between 64-bit values.

> +	spinlock_t s_fc_lock;
> };
>=20
> static inline struct ext4_sb_info *EXT4_SB(struct super_block *sb)
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index 7c70b08d104c..75b6db808837 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -330,3 +330,16 @@ int __ext4_handle_dirty_super(const char *where, =
unsigned int line,
> 		mark_buffer_dirty(bh);
> 	return err;
> }
> +
> +void ext4_init_inode_fc_info(struct inode *inode)
> +{
> +	handle_t *handle =3D ext4_journal_current_handle();
> +	struct ext4_inode_info *ei =3D EXT4_I(inode);
> +
> +	memset(&ei->i_fc, 0, sizeof(ei->i_fc));
> +	if (ext4_handle_valid(handle)) {
> +		ei->i_fc.fc_tid =3D handle->h_transaction->t_tid;
> +		ei->i_fc.fc_subtid =3D =
handle->h_transaction->t_journal->j_subtid;
> +	}
> +	INIT_LIST_HEAD(&ei->i_fc_list);
> +}
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index ef8fcf7d0d3b..2305c1acd415 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -459,4 +459,6 @@ static inline int =
ext4_should_dioread_nolock(struct inode *inode)
> 	return 1;
> }
>=20
> +void ext4_init_inode_fc_info(struct inode *inode);
> +
> #endif	/* _EXT4_JBD2_H */
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 420fe3deed39..f230a888eddd 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4996,6 +4996,7 @@ struct inode *__ext4_iget(struct super_block =
*sb, unsigned long ino,
> 	for (block =3D 0; block < EXT4_N_BLOCKS; block++)
> 		ei->i_data[block] =3D raw_inode->i_block[block];
> 	INIT_LIST_HEAD(&ei->i_orphan);
> +	ext4_init_inode_fc_info(&ei->vfs_inode);
>=20
> 	/*
> 	 * Set transaction id's of transactions that have to be =
committed
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 6bab59ae81f7..0b833e9b61c1 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1100,6 +1100,7 @@ static struct inode *ext4_alloc_inode(struct =
super_block *sb)
> 	ei->i_datasync_tid =3D 0;
> 	atomic_set(&ei->i_unwritten, 0);
> 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
> +	ext4_init_inode_fc_info(&ei->vfs_inode);
> 	return &ei->vfs_inode;
> }
>=20
> @@ -1139,6 +1140,7 @@ static void init_once(void *foo)
> 	init_rwsem(&ei->i_data_sem);
> 	init_rwsem(&ei->i_mmap_sem);
> 	inode_init_once(&ei->vfs_inode);
> +	ext4_init_inode_fc_info(&ei->vfs_inode);
> }
>=20
> static int __init init_inodecache(void)
> @@ -4301,6 +4303,11 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> 	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
> 	mutex_init(&sbi->s_orphan_lock);
>=20
> +	INIT_LIST_HEAD(&sbi->s_fc_q);
> +	sbi->s_fc_q_cnt =3D 0;
> +	sbi->s_fc_eligible =3D true;
> +	spin_lock_init(&sbi->s_fc_lock);
> +
> 	sb->s_root =3D NULL;
>=20
> 	needs_recovery =3D (es->s_last_orphan !=3D 0 ||
> --
> 2.23.0.rc1.153.gdeed80330f-goog
>=20


Cheers, Andreas






--Apple-Mail=_5AE9DEDC-F3C0-4C22-BC85-E523B0676F1F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1N5EsACgkQcqXauRfM
H+BsQBAAs+swJ8zweZf0HllFSbSUaSBoIi9mNubikcNuqMQDxCybglvwN18MeRar
32bJrGq4aQ4uKfMV/+Jfi5w76cVPrxkr7732s8/j3xJPkK5vVuYFzKQP+Gfems5e
C0v1uN3j9r51/Nnm3X4wCd9fBHdt1kNw0jF68tZFfFuIf/Om3GOOTUqg4CZQhUcR
HawOU+gsum+89QzZKQwL69Qw1zByo3v8Xuy45TMqcv2pmSTpKQ5gVQhbbfWuCTJS
5JFRqGzs8p09y96qoiU+j+XaBeGz29PtnfKGaGRo4rPhJgYX4LlD7TgTcIvm76HH
XzeM7RAzntVtGOb2gBIAjGJ52+vWYi672PDev9RFSUwpTUv4aJvZxIMVdQ1wbJxM
T27I+yzN91WLMaZ6D4DU73xMdzR+EjYBwJpn/9nHi4UbjaB4Nc4SZPkxwW8LGEJl
nzn/Ck42iOA3wVPvu5+r9QVJgZ0QEg9JZzaKpZMmrt65Hf5ZgfCGZx7aYSN5ABsl
SEs0Wod/AmtBt5n32sJ/9dguL4ul/kX3RKYp2GHGVunMlQcw++6sf5emIzK/c4Db
a+L4EUpoQIB8K+1gh4c99MU90NpPPCLbEVysYSVH9IgMCetJ6oNZSaJdR+UVXWc1
U7XJCGcK8qukJ+mqSo/19W2MUb1APE/k00WiYVXl5PLOG03IlZY=
=xCG0
-----END PGP SIGNATURE-----

--Apple-Mail=_5AE9DEDC-F3C0-4C22-BC85-E523B0676F1F--
