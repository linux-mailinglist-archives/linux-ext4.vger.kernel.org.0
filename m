Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB7F88420
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 22:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfHIUiW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Aug 2019 16:38:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34565 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfHIUiW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Aug 2019 16:38:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so46630913pfo.1
        for <linux-ext4@vger.kernel.org>; Fri, 09 Aug 2019 13:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=SOpLTXCTdEWXKiX9sDzGGsRofwhA/bTz6BfAXpQEPvw=;
        b=mXP1yIKYXZLTDOVRObyhF0oiRzyFJaQwymQRexARrGL56f4Qp9wY6Cxlb/q//e3qVz
         GPsGCKmh1sOhsH0aSTkHYXnmEgUC1Uid7Pjzgwa1uXQKQf4Qx5fPpGsB4AqF1AjB1FAM
         rB1VUL41R8F4wOs4Hl4rk7gSeKy8K8qbtrgtrrvJtFvfIISrDeIr+0nmqFs43/haZRpQ
         cExas5ty8L+bJc8j/GdgK5aj+84l8U36Gtk9gw/zfMqZ7HWL9IbAD7tFrgrZ2V1Ew7cS
         AyV4mYs2Okn13kKtxuKpsIlusKB0O/YLBBex/SdlkVIFAZrvWLJUvYkg0Xi3ANMe/3oj
         9Pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=SOpLTXCTdEWXKiX9sDzGGsRofwhA/bTz6BfAXpQEPvw=;
        b=NKM//xP9FocDJvrAlNlFopuu8707A/0BkOMf0fyR252mBIrFLzF8IKUd0d7YA2swCx
         0qJNqakfGf86D6f1ENU04CLFMYumWRq096N9/wgJk25rt/W81xHwhR6Ahycnr5XJdOq4
         w8dLqDd3tS9DCNqLHNFRxlDLtUdq8DAc/q9rIlQqNXH7igBj/tXaAxdSEY44g97K0+QJ
         5mCk6AUkrGjpB5nr+/oZRlptvVql9ejUBYZaxWQ+EcXHzFDj9tg80ZTsEzBXBxIvWtsp
         45uyGvVUza81ui6FNHY1CFiRUvCSz4Bo8cLaa04LYJjEQ8MXhTGk5bcI6MC5eSkDUpQg
         APMw==
X-Gm-Message-State: APjAAAWpRksY0oU5+AjV/2I20zo8EBPf6cLu3mlssksCzUengPO6q7k1
        Vb8yUQbO+Eaz/gqDhCf7z/bmaFFra6NidA==
X-Google-Smtp-Source: APXvYqy63moaKt/rLjeKrUT5FjIQMk1NZrJlKd1YrcLWI1N659x035vFe4B7hh8fQb+i/sxdt9+yRA==
X-Received: by 2002:a17:90a:9301:: with SMTP id p1mr11117412pjo.22.1565383101477;
        Fri, 09 Aug 2019 13:38:21 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id z4sm85510623pgp.80.2019.08.09.13.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 13:38:20 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <6DBCC366-02CC-4F2A-AA16-EC4587261699@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C40BCABE-8305-4CB2-AAE7-C0968EDF7698";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 05/12] jbd2: fast-commit commit path new APIs
Date:   Fri, 9 Aug 2019 14:38:19 -0600
In-Reply-To: <20190809034552.148629-6-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
 <20190809034552.148629-6-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_C40BCABE-8305-4CB2-AAE7-C0968EDF7698
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 8, 2019, at 9:45 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> This patch adds new helper APIs that ext4 needs for fast
> commits. These new fast commit APIs are used by subsequent fast commit
> patches to implement fast commits. Following new APIs are added:
>=20
> /*
> * Returns when either a full commit or a fast commit
> * completes
> */
> int jbd2_fc_complete_commit(journal_tc *journal, tid_t tid,
> 			    tid_t tid, tid_t subtid)
>=20
> /* Send all the data buffers related to an inode */
> int journal_submit_inode_data(journal_t *journal,
> 			      struct jbd2_inode *jinode)
>=20
> /* Map one fast commit buffer for use by the file system */
> int jbd2_map_fc_buf(journal_t *journal, struct buffer_head **bh_out)
>=20
> /* Wait on fast commit buffers to complete IO */
> jbd2_wait_on_fc_bufs(journal_t *journal, int num_bufs)
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
>=20
> Changelog:
>=20
> V2: 1) Fixed error reported by kbuild test robot. Removed duplicate
>       EXPORT_SYMBOL() call. Also, added EXPORT_SYMBOL() for the new
>       APIs introduced.
>    2) Changed jbd2_submit_fc_bufs() to jbd2_wait_on_fc_bufs(). This
>       gives client file system to submit JBD2 buffers according to
>       its own convenience.
> ---
> fs/jbd2/commit.c     | 32 +++++++++++++++
> fs/jbd2/journal.c    | 98 ++++++++++++++++++++++++++++++++++++++++++++
> include/linux/jbd2.h |  6 +++
> 3 files changed, 136 insertions(+)
>=20
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 9281814606e7..db62a53436e3 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -202,6 +202,38 @@ static int =
journal_submit_inode_data_buffers(struct address_space *mapping,
> 	return ret;
> }
>=20
> +int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode =
*jinode)
> +{
> +	struct address_space *mapping;
> +	loff_t dirty_start =3D jinode->i_dirty_start;
> +	loff_t dirty_end =3D jinode->i_dirty_end;
> +	int ret;
> +
> +	if (!jinode)
> +		return 0;
> +
> +	if (!(jinode->i_flags & JI_WRITE_DATA))
> +		return 0;
> +
> +	dirty_start =3D jinode->i_dirty_start;
> +	dirty_end =3D jinode->i_dirty_end;
> +
> +	mapping =3D jinode->i_vfs_inode->i_mapping;
> +	jinode->i_flags |=3D JI_COMMIT_RUNNING;
> +
> +	trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
> +	ret =3D journal_submit_inode_data_buffers(mapping, dirty_start,
> +						dirty_end);
> +
> +	jinode->i_flags &=3D ~JI_COMMIT_RUNNING;
> +	/* Protect JI_COMMIT_RUNNING flag */
> +	smp_mb();
> +	wake_up_bit(&jinode->i_flags, __JI_COMMIT_RUNNING);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(jbd2_submit_inode_data);
> +
> /*
>  * Submit all the data buffers of inode associated with the =
transaction to
>  * disk.
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index ab05e47ed2d4..1e15804b2c3c 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -811,6 +811,33 @@ int jbd2_complete_transaction(journal_t *journal, =
tid_t tid)
> }
> EXPORT_SYMBOL(jbd2_complete_transaction);
>=20
> +int jbd2_fc_complete_commit(journal_t *journal, tid_t tid, tid_t =
subtid)
> +{
> +	int	need_to_wait =3D 1;
> +
> +	read_lock(&journal->j_state_lock);
> +	if (journal->j_running_transaction &&
> +	    journal->j_running_transaction->t_tid =3D=3D tid) {
> +		/* Check if fast commit was already done */
> +		if (journal->j_subtid > subtid)
> +			need_to_wait =3D 0;
> +		if (journal->j_commit_request !=3D tid) {
> +			/* transaction not yet started, so request it */
> +			read_unlock(&journal->j_state_lock);
> +			jbd2_log_start_commit(journal, tid, false);
> +			goto wait_commit;
> +		}
> +	} else if (!(journal->j_committing_transaction &&
> +		     journal->j_committing_transaction->t_tid =3D=3D =
tid))
> +		need_to_wait =3D 0;
> +	read_unlock(&journal->j_state_lock);
> +	if (!need_to_wait)
> +		return 0;
> +wait_commit:
> +	return __jbd2_log_wait_commit(journal, tid, subtid);
> +}
> +EXPORT_SYMBOL(jbd2_fc_complete_commit);
> +
> /*
>  * Log buffer allocation routines:
>  */
> @@ -831,6 +858,77 @@ int jbd2_journal_next_log_block(journal_t =
*journal, unsigned long long *retp)
> 	return jbd2_journal_bmap(journal, blocknr, retp);
> }
>=20
> +int jbd2_map_fc_buf(journal_t *journal, struct buffer_head **bh_out)
> +{
> +	unsigned long long pblock;
> +	unsigned long blocknr;
> +	int ret =3D 0;
> +	struct buffer_head *bh;
> +	int fc_off;
> +	journal_header_t *jhdr;
> +
> +	write_lock(&journal->j_state_lock);
> +
> +	if (journal->j_fc_off + journal->j_first_fc < =
journal->j_last_fc) {
> +		fc_off =3D journal->j_fc_off;
> +		blocknr =3D journal->j_first_fc + fc_off;
> +		journal->j_fc_off++;
> +	} else {
> +		ret =3D -EINVAL;
> +	}
> +	write_unlock(&journal->j_state_lock);
> +
> +	if (ret)
> +		return ret;
> +
> +	ret =3D jbd2_journal_bmap(journal, blocknr, &pblock);
> +	if (ret)
> +		return ret;
> +
> +	bh =3D __getblk(journal->j_dev, pblock, journal->j_blocksize);
> +	if (!bh)
> +		return -ENOMEM;
> +
> +	lock_buffer(bh);
> +	jhdr =3D (journal_header_t *)bh->b_data;
> +	jhdr->h_magic =3D cpu_to_be32(JBD2_MAGIC_NUMBER);
> +	jhdr->h_blocktype =3D cpu_to_be32(JBD2_FC_BLOCK);
> +	jhdr->h_sequence =3D =
cpu_to_be32(journal->j_running_transaction->t_tid);
> +
> +	set_buffer_uptodate(bh);
> +	unlock_buffer(bh);
> +	journal->j_fc_wbuf[fc_off] =3D bh;
> +
> +	*bh_out =3D bh;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(jbd2_map_fc_buf);
> +
> +int jbd2_wait_on_fc_bufs(journal_t *journal, int num_blks)
> +{
> +	struct buffer_head *bh;
> +	int i, j_fc_off;
> +
> +	read_lock(&journal->j_state_lock);
> +	j_fc_off =3D journal->j_fc_off;
> +	read_unlock(&journal->j_state_lock);
> +
> +	/*
> +	 * Wait in reverse order to minimize chances of us being woken =
up before
> +	 * all IOs have completed
> +	 */
> +	for (i =3D j_fc_off - 1; i >=3D j_fc_off - num_blks; i--) {
> +		bh =3D journal->j_fc_wbuf[i];
> +		wait_on_buffer(bh);
> +		if (unlikely(!buffer_uptodate(bh)))
> +			return -EIO;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(jbd2_wait_on_fc_bufs);
> +
> /*
>  * Conversion of logical to physical block numbers for the journal
>  *
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 535f88dff653..5362777d06f8 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -124,6 +124,7 @@ typedef struct journal_s	journal_t;	/* =
Journal control structure */
> #define JBD2_SUPERBLOCK_V1	3
> #define JBD2_SUPERBLOCK_V2	4
> #define JBD2_REVOKE_BLOCK	5
> +#define JBD2_FC_BLOCK		6
>=20
> /*
>  * Standard header for all descriptor blocks:
> @@ -1582,6 +1583,7 @@ int jbd2_transaction_committed(journal_t =
*journal, tid_t tid);
> int jbd2_complete_transaction(journal_t *journal, tid_t tid);
> int jbd2_log_do_checkpoint(journal_t *journal);
> int jbd2_trans_will_send_data_barrier(journal_t *journal, tid_t tid);
> +int jbd2_fc_complete_commit(journal_t *journal, tid_t tid, tid_t =
subtid);
>=20
> void __jbd2_log_wait_for_space(journal_t *journal);
> extern void __jbd2_journal_drop_transaction(journal_t *, transaction_t =
*);
> @@ -1732,6 +1734,10 @@ static inline tid_t  =
jbd2_get_latest_transaction(journal_t *journal)
> 	return tid;
> }
>=20
> +int jbd2_map_fc_buf(journal_t *journal, struct buffer_head **bh_out);
> +int jbd2_wait_on_fc_bufs(journal_t *journal, int num_blks);
> +int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode =
*jinode);
> +
> #ifdef __KERNEL__
>=20
> #define buffer_trace_init(bh)	do {} while (0)
> --
> 2.23.0.rc1.153.gdeed80330f-goog
>=20


Cheers, Andreas






--Apple-Mail=_C40BCABE-8305-4CB2-AAE7-C0968EDF7698
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1N2bsACgkQcqXauRfM
H+BixA//UeEraTRXuNpNkS9FcInlgICP+4uq0r1fwkOQCxFC/EW97qASf2nN//DF
r96PVeOT2tgOIhU1w4ZiOi7o7CihEFRW6KgfixSJPSFNrwCqk4S8BDTxy8LEy5Kt
bD84KMJICPFG23y+rxQEYHgyQSH/DotaDy6sRAwMMsBOZsIjp6bmqsT0rWz4H9WS
LoGob3RqNnnI46lyMw/bnQduZES0gSmULBNnxXM5TN29HY2cr3uilssW2bHweg7K
/aHNXjfr2Bk4pu6KprHGTjecHtsQKWx/b+79WcS3AlElGLin4sLPpav7xR528NtR
X+r3/4juEF1ocWV03kVZV1ldjdCGP+M6+2rwjUgQIg7ZiLrMuwSAnaXjYqcc+Kl9
tStp3/uQ+Unp+oldP1EEjNZzgt6abgOKfkiMWaUIyokSYAVEibMe7pu2BGfZIPCL
EhgzH6hhSqPXIAqI7LQKcJ1qnViJTefwU0wT0blIzerdr71lHFpu8AM2VaXMqMs+
ZWlJg5wLcPq3kO8XtBNZh7f5rsalEuK55rqamKda6MusW8Lehy9QMK/V+Zq0CUl1
ifqB/n7s3YNKGVWICk6whH6BIR4xup5/IRB9sWWVb1WrHDEPOC26bxzIi9DCX88f
g521O8YZ8KaOeyk+2BB/SzDSIe5xBSok1zWrwwc0Nh4e1bHaBng=
=va7D
-----END PGP SIGNATURE-----

--Apple-Mail=_C40BCABE-8305-4CB2-AAE7-C0968EDF7698--
