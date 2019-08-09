Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0B3B883A1
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 22:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfHIUCS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Aug 2019 16:02:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44842 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfHIUCS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Aug 2019 16:02:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so46561047pfe.11
        for <linux-ext4@vger.kernel.org>; Fri, 09 Aug 2019 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=FnQPDFdnpE4k6iXAIOEv3zNdh8BGX2U/iFXxOLDops8=;
        b=xCju4mSE+0CF6xRmKQQhj3aTeFLAZkcn3wclaMYHrziw6NsXY4wMN1Ql21/r8miehy
         +CpewgB3cUawTkGe6XAts/UT+Ta8cFuoL/4BHa8T1tjApesjgMIY81dkXmv8bK7XwI0f
         rVSKWVMlQWlkSQ4/2hhpZHE1QYqwaNCviibZmNs37HDw3MR7K3TPJ3/vhiwypnHq7x0t
         WQxEXmNsGwOy6grNIX/mSl0JTmviyYgIecfHNH44EAFQyd0HY/RCfhQON2zr6rBNf299
         lRznGIkVHau/s+20wGNo01vgDhBmwtYvHJPAsRsL0QacbvE35tJKIndaQlwhllGI94q8
         xS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=FnQPDFdnpE4k6iXAIOEv3zNdh8BGX2U/iFXxOLDops8=;
        b=W9azcRJpRewcwGLlhvBE8CZqpIPPEHa93Q8il7PRUQKS+C+PXPrxm7IF5PIwh/gl0F
         wV18A/Y9LogdJZ7lUdXVCCXY0oPeov48uWc5xNo5IntLmp/KWsN6TViSDkFWr5KcYMGM
         9KIt2k8GLSrp1nzoQtUv7OfyU9ojA+827P15jlM8r6y4omwfspLa2+j7fij9IAx+Rkka
         S+F06fo79Ag1cDfoB5pV01seczAUDAQVK8i17Oth1rQun+QkQq4YnWxcNsvfa1t+vg67
         C9Sa6ylpBQYdSwrFzR3BDRYPT9XP74w+BNGHYff14xZOyqsTwV+7K1QSRLvwKPruWXBo
         vCmw==
X-Gm-Message-State: APjAAAWtIyNrVD+IXN3MB1lqPD7Mk+amFvm502ejxiWbNS9Gj0QooK7X
        3vAUw347Pya2TqYyeUL0AZkpI0iADjYtpQ==
X-Google-Smtp-Source: APXvYqxBeCpnhLvVwgWDHyd3RwC9Pd5msgX8IawDEiaVcnWlTm4Hc3JOdfus+TkxCzstCg2XdnUZqw==
X-Received: by 2002:a63:4a20:: with SMTP id x32mr10681775pga.357.1565380937441;
        Fri, 09 Aug 2019 13:02:17 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id h13sm68510386pfn.13.2019.08.09.13.02.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 13:02:16 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <D1E772AE-A30B-434B-916E-E3B5FADE6517@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0DAE298B-7407-4922-A873-54D37CC90D2A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 03/12] jbd2: fast commit setup and enable
Date:   Fri, 9 Aug 2019 14:02:13 -0600
In-Reply-To: <20190809034552.148629-4-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
 <20190809034552.148629-4-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_0DAE298B-7407-4922-A873-54D37CC90D2A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 8, 2019, at 9:45 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> This patch allows file systems to turn fast commits on and thereby
> restrict the normal journalling space to total journal blocks minus
> JBD2_FAST_COMMIT_BLOCKS. Fast commits are not actually performed, just
> the interface to turn fast commits on is opened.
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>=20
> ---
>=20
> Changelog:
>=20
> V2: No changes since V1
> ---
> fs/ext4/super.c      |  3 ++-
> fs/jbd2/journal.c    | 39 ++++++++++++++++++++++++++++++++-------
> fs/ocfs2/journal.c   |  4 ++--
> include/linux/jbd2.h |  2 +-
> 4 files changed, 37 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index e376ac040cce..81c3ec165822 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4933,7 +4933,8 @@ static int ext4_load_journal(struct super_block =
*sb,
> 		if (save)
> 			memcpy(save, ((char *) es) +
> 			       EXT4_S_ERR_START, EXT4_S_ERR_LEN);
> -		err =3D jbd2_journal_load(journal);
> +		err =3D jbd2_journal_load(journal,
> +					test_opt2(sb, =
JOURNAL_FAST_COMMIT));
> 		if (save)
> 			memcpy(((char *) es) + EXT4_S_ERR_START,
> 			       save, EXT4_S_ERR_LEN);
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 953990eb70a9..59ad709154a3 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1159,12 +1159,15 @@ static journal_t *journal_init_common(struct =
block_device *bdev,
> 	journal->j_blk_offset =3D start;
> 	journal->j_maxlen =3D len;
> 	n =3D journal->j_blocksize / sizeof(journal_block_tag_t);
> -	journal->j_wbufsize =3D n;
> +	journal->j_wbufsize =3D n - JBD2_FAST_COMMIT_BLOCKS;

The reservation of the JBD2_FAST_COMMIT_BLOCKS should only be done in
the case of the FAST_COMMIT feature being enabled.  Otherwise it can
hurt performance for filesystems where this feature is not enabled.

Cheers, Andreas

> 	journal->j_wbuf =3D kmalloc_array(n, sizeof(struct buffer_head =
*),
> 					GFP_KERNEL);
> 	if (!journal->j_wbuf)
> 		goto err_cleanup;
>=20
> +	journal->j_fc_wbuf =3D &journal->j_wbuf[journal->j_wbufsize];
> +	journal->j_fc_wbufsize =3D JBD2_FAST_COMMIT_BLOCKS;
> +
> 	bh =3D getblk_unmovable(journal->j_dev, start, =
journal->j_blocksize);
> 	if (!bh) {
> 		pr_err("%s: Cannot get buffer for journal superblock\n",
> @@ -1297,11 +1300,19 @@ static int journal_reset(journal_t *journal)
> 	}
>=20
> 	journal->j_first =3D first;
> -	journal->j_last =3D last;
>=20
> -	journal->j_head =3D first;
> -	journal->j_tail =3D first;
> -	journal->j_free =3D last - first;
> +	if (jbd2_has_feature_fast_commit(journal)) {
> +		journal->j_last_fc =3D last;
> +		journal->j_last =3D last - JBD2_FAST_COMMIT_BLOCKS;
> +		journal->j_first_fc =3D journal->j_last + 1;
> +		journal->j_fc_off =3D 0;
> +	} else {
> +		journal->j_last =3D last;
> +	}
> +
> +	journal->j_head =3D journal->j_first;
> +	journal->j_tail =3D journal->j_first;
> +	journal->j_free =3D journal->j_last - journal->j_first;
>=20
> 	journal->j_tail_sequence =3D journal->j_transaction_sequence;
> 	journal->j_commit_sequence =3D journal->j_transaction_sequence - =
1;
> @@ -1626,9 +1637,17 @@ static int load_superblock(journal_t *journal)
> 	journal->j_tail_sequence =3D be32_to_cpu(sb->s_sequence);
> 	journal->j_tail =3D be32_to_cpu(sb->s_start);
> 	journal->j_first =3D be32_to_cpu(sb->s_first);
> -	journal->j_last =3D be32_to_cpu(sb->s_maxlen);
> 	journal->j_errno =3D be32_to_cpu(sb->s_errno);
>=20
> +	if (jbd2_has_feature_fast_commit(journal)) {
> +		journal->j_last_fc =3D be32_to_cpu(sb->s_maxlen);
> +		journal->j_last =3D journal->j_last_fc - =
JBD2_FAST_COMMIT_BLOCKS;
> +		journal->j_first_fc =3D journal->j_last + 1;
> +		journal->j_fc_off =3D 0;
> +	} else {
> +		journal->j_last =3D be32_to_cpu(sb->s_maxlen);
> +	}
> +
> 	return 0;
> }
>=20
> @@ -1641,7 +1660,7 @@ static int load_superblock(journal_t *journal)
>  * a journal, read the journal from disk to initialise the in-memory
>  * structures.
>  */
> -int jbd2_journal_load(journal_t *journal)
> +int jbd2_journal_load(journal_t *journal, bool enable_fc)
> {
> 	int err;
> 	journal_superblock_t *sb;
> @@ -1684,6 +1703,12 @@ int jbd2_journal_load(journal_t *journal)
> 		return -EFSCORRUPTED;
> 	}
>=20
> +	if (enable_fc)
> +		jbd2_journal_set_features(journal, 0, 0,
> +					  =
JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
> +	else
> +		jbd2_journal_clear_features(journal, 0, 0,
> +					    =
JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
> 	/* OK, we've finished with the dynamic journal bits:
> 	 * reinitialise the dynamic contents of the superblock in memory
> 	 * and reset them on disk. */
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index 930e3d388579..3b4d91b16e8e 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -1057,7 +1057,7 @@ int ocfs2_journal_load(struct ocfs2_journal =
*journal, int local, int replayed)
>=20
> 	osb =3D journal->j_osb;
>=20
> -	status =3D jbd2_journal_load(journal->j_journal);
> +	status =3D jbd2_journal_load(journal->j_journal, false);
> 	if (status < 0) {
> 		mlog(ML_ERROR, "Failed to load journal!\n");
> 		goto done;
> @@ -1642,7 +1642,7 @@ static int ocfs2_replay_journal(struct =
ocfs2_super *osb,
> 		goto done;
> 	}
>=20
> -	status =3D jbd2_journal_load(journal);
> +	status =3D jbd2_journal_load(journal, false);
> 	if (status < 0) {
> 		mlog_errno(status);
> 		if (!igrab(inode))
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 9a750b732241..153840b422cc 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1476,7 +1476,7 @@ extern int	   jbd2_journal_set_features
> 		   (journal_t *, unsigned long, unsigned long, unsigned =
long);
> extern void	   jbd2_journal_clear_features
> 		   (journal_t *, unsigned long, unsigned long, unsigned =
long);
> -extern int	   jbd2_journal_load       (journal_t *journal);
> +extern int	   jbd2_journal_load(journal_t *journal, bool =
enable_fc);
> extern int	   jbd2_journal_destroy    (journal_t *);
> extern int	   jbd2_journal_recover    (journal_t *journal);
> extern int	   jbd2_journal_wipe       (journal_t *, int);
> --
> 2.23.0.rc1.153.gdeed80330f-goog
>=20


Cheers, Andreas






--Apple-Mail=_0DAE298B-7407-4922-A873-54D37CC90D2A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1N0UYACgkQcqXauRfM
H+CO5g/9GDIWt1FdkySn8p0YJG/j8CFDxlcf4wvXxAXuvUo0APTYZhGuI5nCNTsc
0OmFinsijHi58rigi6cpQjopcMMUbM8SpO+BM4l0X+lflNF1gel5HlBtGuCiU6ft
sMMQhX2+xDF8jglXqKdvJ7o3LLSStMF1yJUmeHBmDQa0DZjtd062/pdwpYQDfrUL
dPGJcAR5/Gk7hI3+TJ7W4u0J5MtQU7s/CT+OuGxkJMeU9DzD3V7dwz1EK3CMEJIQ
TOeb9tF22DG34wzgO8KG21b/m/06XFBXwcgRyUlnDaLc5yu4EsFHQ6AoOX6KQxxN
X2SBsAnSAvtOED/LlI+U0oscrFq0rr3RRdHfBbThmQrdmmgra7uZfY/Ic8ZOozyd
RrGa2aPrioYTmqFVGxWSsnKkLKzr6Um66X6DoDx3RsVqkK700/PJUR0ow1Xm/Xn6
anNYGNHMS9qUC3oeIUKyLJXrsBQkdrde7LzBwIiuaq2Q9QPjMmXGCo5BEHu9YPOj
MI4X3/QCE5HchslV5ueL6iuRfBXy8LMoElPaxlBaSWBmg1iyIYbvR0/Wwar/MFMm
9dlGTY/TMccDPTaKC18IGm1vf0Jyp35yD72MtCBdV/fEAz7dgsssHz0nMUho38hL
N1g0tvCFXjzac5x0w9CA45DKWeWLAuEbKwJML2RojZVpl7Hx3yQ=
=n+5B
-----END PGP SIGNATURE-----

--Apple-Mail=_0DAE298B-7407-4922-A873-54D37CC90D2A--
