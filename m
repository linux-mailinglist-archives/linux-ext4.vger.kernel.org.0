Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B0C328F2B
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Mar 2021 20:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241273AbhCATqi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Mar 2021 14:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbhCATor (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Mar 2021 14:44:47 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26303C061756
        for <linux-ext4@vger.kernel.org>; Mon,  1 Mar 2021 11:43:57 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id i10so3051310pfk.4
        for <linux-ext4@vger.kernel.org>; Mon, 01 Mar 2021 11:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=gzyU35y7Bs6cMSpambovie7QtY9rov8HiW77aa1zY2A=;
        b=MASzkdFelfMuz+I9AK/f9zBXXBywRkg0XtWGmqya+Pbaux+ZK6IaPA224uqg6meblR
         BGhspiZiJMBDluh0FnKW9WqzrQuvM8jD5bksT6b3+g0YOvVCqjcbp2/twPRdCwtieSgM
         Dm7G/oVjwIRP/2tKhJFjs9FYcXtmPX16RjEfMCTVM87YY3jCg+dqqNWAnCdcGF9scCFL
         qrS2i4XuQEo/YAQu1B9knweiU3HIB716uniqddL1f0vc6dcZX9w7bPAdErQXE8eW1asH
         k0YU/K5H7j6iuYbanoL940kzNk+SZT5MwfN9FGy4zI6XIYDU40Fw1r5IDhR3xiYGaLa+
         F+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=gzyU35y7Bs6cMSpambovie7QtY9rov8HiW77aa1zY2A=;
        b=M1qdgbyepO4kJjp92slgVqQjA9rvlRLChXH+4z2CJ13NAhrCvj3Ko79blXFuUS8+ow
         HYkNz9LYpSZdNE52sy5cHQJkQ/B9GkXvVpGUJR/e2pgZMLwT6zMqIkiOPp/5Y7iIKjZw
         vEudEBvpTjXE8qNWGCLfiUObwYYBtPWvnn7u+yCS217NbAEolWsUZI1bjIFWmCjrJ84a
         X0CIrXSoWS623c/fi7ua5dWiMQB30CP3oudQE297nh1XH+ICATZFaB6CZ2LGrtnyYWCJ
         YzEcu8igqFbCsE5fMEd9UlpnNdEMQqj+Xx6BnOE5rQUvld5YW1yHhvhmhgUfXICuDmZW
         NEUg==
X-Gm-Message-State: AOAM531hx7ocCceTlMu3aEmsHs9Q5zIMyLg/7yW3Emd/8w4jBlI3fEs+
        Y8qNaHrdzCNtbnftMtx6jxTXww==
X-Google-Smtp-Source: ABdhPJyNm1eFxthBKtsB5AYDutRhFlkFDGzBfCJ2fMO0A4hRQf7ED2FOXjyv0ZotlYKKggqdIFMtow==
X-Received: by 2002:a63:7885:: with SMTP id t127mr344053pgc.237.1614627836608;
        Mon, 01 Mar 2021 11:43:56 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id x190sm18648267pfx.166.2021.03.01.11.43.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Mar 2021 11:43:55 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C7CB3E07-5CAE-4E31-8456-137710B16C25@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F677A744-15ED-4B16-8903-0C355A93AAC7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 5/5] ext4: add proc files to monitor new structures
Date:   Mon, 1 Mar 2021 12:43:51 -0700
In-Reply-To: <20210226193612.1199321-6-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20210226193612.1199321-1-harshadshirwadkar@gmail.com>
 <20210226193612.1199321-6-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_F677A744-15ED-4B16-8903-0C355A93AAC7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 26, 2021, at 12:36 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> This patch adds a new file "mb_structs_summary" which allows us to see
> the summary of the new allocator structures added in this
> series. Here's the sample output of file:
>=20
> optimize_scan: 1
> max_free_order_lists:
>        list_order_0_groups: 0
>        list_order_1_groups: 0
>        list_order_2_groups: 0
>        list_order_3_groups: 0
>        list_order_4_groups: 0
>        list_order_5_groups: 0
>        list_order_6_groups: 0
>        list_order_7_groups: 0
>        list_order_8_groups: 0
>        list_order_9_groups: 0
>        list_order_10_groups: 0
>        list_order_11_groups: 0
>        list_order_12_groups: 0
>        list_order_13_groups: 40
> fragment_size_tree:
>        tree_min: 16384
>        tree_max: 32768
>        tree_nodes: 40
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/ext4.h    |  1 +
> fs/ext4/mballoc.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++
> fs/ext4/sysfs.c   |  2 ++
> 3 files changed, 89 insertions(+)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index d792418c39ca..81209a749e75 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2818,6 +2818,7 @@ int __init ext4_fc_init_dentry_cache(void);
>=20
> /* mballoc.c */
> extern const struct seq_operations ext4_mb_seq_groups_ops;
> +extern const struct seq_operations ext4_mb_seq_structs_summary_ops;
> extern long ext4_mb_stats;
> extern long ext4_mb_max_to_scan;
> extern int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset);
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index bcfd849bc61e..4378b36be8b9 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2910,6 +2910,92 @@ int ext4_seq_mb_stats_show(struct seq_file =
*seq, void *offset)
> 	return 0;
> }
>=20
> +static void *ext4_mb_seq_structs_summary_start(struct seq_file *seq, =
loff_t *pos)
> +{
> +	struct super_block *sb =3D PDE_DATA(file_inode(seq->file));
> +	unsigned long position;
> +
> +	read_lock(&EXT4_SB(sb)->s_mb_rb_lock);
> +
> +	if (*pos < 0 || *pos >=3D MB_NUM_ORDERS(sb) + 1)
> +		return NULL;
> +	position =3D *pos + 1;
> +	return (void *) ((unsigned long) position);
> +}
> +
> +static void *ext4_mb_seq_structs_summary_next(struct seq_file *seq, =
void *v, loff_t *pos)
> +{
> +	struct super_block *sb =3D PDE_DATA(file_inode(seq->file));
> +	unsigned long position;
> +
> +	++*pos;
> +	if (*pos < 0 || *pos >=3D MB_NUM_ORDERS(sb) + 1)
> +		return NULL;
> +	position =3D *pos + 1;
> +	return (void *) ((unsigned long) position);
> +}
> +
> +static int ext4_mb_seq_structs_summary_show(struct seq_file *seq, =
void *v)
> +{
> +	struct super_block *sb =3D PDE_DATA(file_inode(seq->file));
> +	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> +	unsigned long position =3D ((unsigned long) v);
> +	struct ext4_group_info *grp;
> +	struct rb_node *n;
> +	unsigned int count, min, max;
> +
> +	position--;
> +	if (position >=3D MB_NUM_ORDERS(sb)) {
> +		seq_puts(seq, "fragment_size_tree:\n");
> +		n =3D rb_first(&sbi->s_mb_avg_fragment_size_root);
> +		if (!n) {
> +			seq_puts(seq, "\ttree_min: 0\n\ttree_max: =
0\n\ttree_nodes: 0\n");
> +			return 0;
> +		}
> +		grp =3D rb_entry(n, struct ext4_group_info, =
bb_avg_fragment_size_rb);
> +		min =3D grp->bb_fragments ? grp->bb_free / =
grp->bb_fragments : 0;
> +		count =3D 1;
> +		while (rb_next(n)) {
> +			count++;
> +			n =3D rb_next(n);
> +		}
> +		grp =3D rb_entry(n, struct ext4_group_info, =
bb_avg_fragment_size_rb);
> +		max =3D grp->bb_fragments ? grp->bb_free / =
grp->bb_fragments : 0;
> +
> +		seq_printf(seq, "\ttree_min: %u\n\ttree_max: =
%u\n\ttree_nodes: %u\n",
> +			   min, max, count);
> +		return 0;
> +	}
> +
> +	if (position =3D=3D 0) {
> +		seq_printf(seq, "optimize_scan: %d\n",
> +			   test_opt2(sb, MB_OPTIMIZE_SCAN) ? 1 : 0);
> +		seq_puts(seq, "max_free_order_lists:\n");
> +	}
> +	count =3D 0;
> +	list_for_each_entry(grp, =
&sbi->s_mb_largest_free_orders[position],
> +			    bb_largest_free_order_node)
> +		count++;
> +	seq_printf(seq, "\tlist_order_%u_groups: %u\n",
> +		   (unsigned int)position, count);
> +
> +	return 0;
> +}
> +
> +static void ext4_mb_seq_structs_summary_stop(struct seq_file *seq, =
void *v)
> +{
> +	struct super_block *sb =3D PDE_DATA(file_inode(seq->file));
> +
> +	read_unlock(&EXT4_SB(sb)->s_mb_rb_lock);
> +}
> +
> +const struct seq_operations ext4_mb_seq_structs_summary_ops =3D {
> +	.start  =3D ext4_mb_seq_structs_summary_start,
> +	.next   =3D ext4_mb_seq_structs_summary_next,
> +	.stop   =3D ext4_mb_seq_structs_summary_stop,
> +	.show   =3D ext4_mb_seq_structs_summary_show,
> +};
> +
> static struct kmem_cache *get_groupinfo_cache(int blocksize_bits)
> {
> 	int cache_index =3D blocksize_bits - EXT4_MIN_BLOCK_LOG_SIZE;
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 16b8a838f631..4a3b78684f83 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -525,6 +525,8 @@ int ext4_register_sysfs(struct super_block *sb)
> 				&ext4_mb_seq_groups_ops, sb);
> 		proc_create_single_data("mb_stats", 0444, sbi->s_proc,
> 				ext4_seq_mb_stats_show, sb);
> +		proc_create_seq_data("mb_structs_summary", 0444, =
sbi->s_proc,
> +				&ext4_mb_seq_structs_summary_ops, sb);
> 	}
> 	return 0;
> }
> --
> 2.30.1.766.gb4fecdf3b7-goog
>=20


Cheers, Andreas






--Apple-Mail=_F677A744-15ED-4B16-8903-0C355A93AAC7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmA9Q/cACgkQcqXauRfM
H+DRhw//Z7N1/0WfRCuXaG2d8q1uYYC1kg/ut2Rp8kQw0hVYziZ2/1vDGezB8k7l
ZV/1PHtHlif1x075izNNZspfgdh/TafNbM/Kluc5LmP19xAZKltqzMMS/kPTjaNy
EnnH57Tdkf6uxdtA50GwtufEBNV1C/cxxvvT5ZpiQEMsKCN4L0XgEkADt/ut5Q0F
BwPnL/7aVZ1JSz6WpneY3mZkVLqXwl7Zs3vsPoxqwUrl6cYXpnZwoqh35hNcIZMe
jFmKAoRbTNc1EhWk+eeq/SRDsBxdggkVNQRf2A/P528KNdUZVjEY7g82WpvhJd6w
g8BBsl4HZ107WR1lJm6jolaNv3bSS9cSrlnMHECPPJF35bye9uIlNmTa3/qq7QDU
QyPF3NT9yV7+2mCBtSKaccXmaG9qdh0JR4Rq+ea1Vw1kSEDgSdaX3Y6d4sZLH81p
2TdCuF6YhRarI/u2p5nkEBDMQE6hIb4l4f13TaAi4R3mL2S2kMVYAypBka332/3+
2yHasER0ToL7nnE+kVXqNGO0/hsAg8a0uljSvgoSvB9IJtUSmMsvzG+wOfryLp7a
JCAniKXFDiutG6JguxJdjGjLUUVIIMlQtBkjzMzlZpp5WkZh7W+lIGjihF5hdoTj
4sdCd6cV0MHETInWyNNmMC0eIeKBG3PIA4d/NcWErcwNLK6eMPY=
=R6th
-----END PGP SIGNATURE-----

--Apple-Mail=_F677A744-15ED-4B16-8903-0C355A93AAC7--
