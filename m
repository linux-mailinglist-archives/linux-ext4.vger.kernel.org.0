Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30B1788375
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 21:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfHITsq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Aug 2019 15:48:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41012 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfHITsq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Aug 2019 15:48:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so45189775pls.8
        for <linux-ext4@vger.kernel.org>; Fri, 09 Aug 2019 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=QRdDP2eU6FTjqMFDi1LPPiQdvxOZcanuTweWM7P8B5w=;
        b=gI03KasnlFT0fyyXNC+EHVnztEfvN9kM8ygEnEFxffk0qAu7oR4IW1MOUCPnt/yhjl
         LRkoJ78ErEz+RacjIvJBrY+DLu1oEiuQMdUiG14LO/hFW5PtsF3BWVjdwRh3BQh3u/9e
         4Xa+5lsQLlSjk3EZPb47JQKHepM2driR99n/TGT7BhUubMsaLBZk/ZfMVr0VomyRivfh
         tcELxE/lLJ6CfKZq5u2sZU9kYyvxDvI6siIIItALv9mO1SN32HILyLKtyqABvvZLleIg
         2k9RFG2TXSLahqx4LDVJhasJqEXdjm597+BLm6RvKKzXG6Gu1S1xSgKC0O5DNz6hjyLo
         23KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=QRdDP2eU6FTjqMFDi1LPPiQdvxOZcanuTweWM7P8B5w=;
        b=oAhLIbpVCJQCVmWKn3L0UV3vqNarcX3L5jczG1vZBOb52ae3eI/7tnT/3guLNkYDzp
         DK+Xr/+m2/UFBhemBKrfzcLrmgGCeA+RXY9nAl5luOVFFlms0fy2p8/cff+JIAAJsEYW
         ANzQt6/Tkc3T5YkL0lLB8oyrXrGUs86MnBZ+BcPyDVH9RMiWemsVdt5hb4HhG4KQFLKW
         cteCDOwnkSySfuIExj5gkfe0fmJ7NTrttH/zjkoCBE7U0PNUTe3j59ngPb5+v8eWh6IB
         BO92kgZjyiTyKQ6suGxnOLInWrVfAHC7jnxsbQQKTOkAnR328t3D68cowoxDfJkxDXRx
         AExQ==
X-Gm-Message-State: APjAAAXBzpBsP10CPp2l8q1uXMsLhPxfLJNLL0ZCAHSNShXm+gE2JBks
        r7+TNLXAkaS6R39yWqna5Or3cp/fziOOIg==
X-Google-Smtp-Source: APXvYqxuzrVFBSbxVg83tjxieesUvkMIM5w1SGY91yr9AELBqvNd5LTJJYbniihHJUd2cKByiMIMOg==
X-Received: by 2002:a17:902:d70a:: with SMTP id w10mr19424547ply.251.1565380125536;
        Fri, 09 Aug 2019 12:48:45 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id c35sm30855006pgl.72.2019.08.09.12.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 12:48:44 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <13BA3D29-983E-4D7F-901E-3EF78201C9AB@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4D669F6B-3783-45FB-851C-DE7F50F47816";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 02/12] jbd2: add fast commit fields to journal_s
 structure
Date:   Fri, 9 Aug 2019 13:48:43 -0600
In-Reply-To: <20190809034552.148629-3-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
 <20190809034552.148629-3-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_4D669F6B-3783-45FB-851C-DE7F50F47816
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 8, 2019, at 9:45 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> For fast commits, JBD2 as of now allocates a default of 128 blocks at
> the end of the journalling area. Although JBD2 owns these blocks, it
> doesn't control what exactly should be written in these blocks. It
> just provides the right abstraction for making these blocks usable by
> file systems. This patch adds necessary fields to manage these fast
> commit blocks.
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Contrary to the description, this patch doesn't really do anything =
beyond
adding unused fields and constants to the header, and as such isn't =
really
useful to land on its own since there is no way to see what the fields
are used for.  In particular, I was going to say that =
JBD2_FAST_COMMIT_BLOCKS
should only be reserved if the FAST_COMMIT feature is enabled (unlike =
what
is written above, which implies that they are always reserved), =
otherwise
it can impact filesystem performance even when the feature is not =
active.

I'd recommend to merge these changes with the patch where the =
fields/constants
are actually used.

Cheers, Andreas

> ---
>=20
> Changelog:
>=20
> V2: Added struct transaction_run_stats_s * argument to
>    j_fc_commit_callback to collect stats
> ---
> include/linux/jbd2.h | 79 ++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 79 insertions(+)
>=20
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index b7eed49b8ecd..9a750b732241 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -66,6 +66,7 @@ void __jbd2_debug(int level, const char *file, const =
char *func,
> extern void *jbd2_alloc(size_t size, gfp_t flags);
> extern void jbd2_free(void *ptr, size_t size);
>=20
> +#define JBD2_FAST_COMMIT_BLOCKS 128
> #define JBD2_MIN_JOURNAL_BLOCKS 1024
>=20
> #ifdef __KERNEL__
> @@ -918,6 +919,34 @@ struct journal_s
> 	 */
> 	unsigned long		j_last;
>=20
> +	/**
> +	 * @j_first_fc:
> +	 *
> +	 * The block number of the first fast commit block in the =
journal
> +	 */
> +	unsigned long		j_first_fc;
> +
> +	/**
> +	 * @j_current_fc:
> +	 *
> +	 * Journal fc block iterator
> +	 */
> +	unsigned long		j_fc_off;
> +
> +	/**
> +	 * @j_last_fc:
> +	 *
> +	 * The block number of the last fast commit block in the journal
> +	 */
> +	unsigned long		j_last_fc;
> +
> +	/**
> +	 * @j_do_full_commit:
> +	 *
> +	 * Force a full commit. If this flag is set JBD2 won't try fast =
commits
> +	 */
> +	bool			j_do_full_commit;
> +
> 	/**
> 	 * @j_dev: Device where we store the journal.
> 	 */
> @@ -987,6 +1016,15 @@ struct journal_s
> 	 */
> 	tid_t			j_transaction_sequence;
>=20
> +	/**
> +	 * @j_subtid:
> +	 *
> +	 * One plus the sequence number of the most recently committed =
fast
> +	 * commit. This represents the sub transaction ID for the next =
fast
> +	 * commit.
> +	 */
> +	tid_t			j_subtid;
> +
> 	/**
> 	 * @j_commit_sequence:
> 	 *
> @@ -1068,6 +1106,20 @@ struct journal_s
> 	 */
> 	int			j_wbufsize;
>=20
> +	/**
> +	 * @j_fc_wbuf:
> +	 *
> +	 * Array of bhs for fast commit transactions
> +	 */
> +	struct buffer_head	**j_fc_wbuf;
> +
> +	/**
> +	 * @j_fc_wbufsize:
> +	 *
> +	 * Size of @j_fc_wbufsize array.
> +	 */
> +	int			j_fc_wbufsize;
> +
> 	/**
> 	 * @j_last_sync_writer:
> 	 *
> @@ -1167,6 +1219,33 @@ struct journal_s
> 	 */
> 	struct lockdep_map	j_trans_commit_map;
> #endif
> +	/**
> +	 * @j_fc_commit_callback:
> +	 *
> +	 * File-system specific function that performs actual fast =
commit
> +	 * operation. Should return 0 if the fast commit was successful, =
in that
> +	 * case, JBD2 will just increment journal->j_subtid and move on. =
If it
> +	 * returns < 0, JBD2 will fall-back to full commit.
> +	 */
> +	int (*j_fc_commit_callback)(struct journal_s *journal, tid_t =
tid,
> +				    tid_t subtid,
> +				    struct transaction_run_stats_s =
*stats);
> +	/**
> +	 * @j_fc_replay_callback:
> +	 *
> +	 * File-system specific function that performs replay of a fast
> +	 * commit. JBD2 calls this function for each fast commit block =
found in
> +	 * the journal.
> +	 */
> +	int (*j_fc_replay_callback)(struct journal_s *journal,
> +				    struct buffer_head *bh);
> +	/**
> +	 * @j_fc_cleanup_callback:
> +	 *
> +	 * Clean-up after fast commit or full commit. JBD2 calls this =
function
> +	 * after every commit operation.
> +	 */
> +	void (*j_fc_cleanup_callback)(struct journal_s *journal);
> };
>=20
> #define jbd2_might_wait_for_commit(j) \
> --
> 2.23.0.rc1.153.gdeed80330f-goog
>=20


Cheers, Andreas






--Apple-Mail=_4D669F6B-3783-45FB-851C-DE7F50F47816
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1NzhsACgkQcqXauRfM
H+DMIhAAqSyA4FI+1ARpbiug7tFwGngrL9D3EZIHMD1++3t8i7jkXt4sQdMtdMTO
LeYFYTxIObpzuEnqAxCvtUeRvGbBcqTtH3ygGDlhGU+HvQTbbMJJgUhpg0V+M44A
5PFf+iETinJ+W8FOpAFF3WWUNKis9WKbYwNsy9f1/nd/BwHT6hNzTuDpKAOHYVVk
EgbMWyzgifn7o+uCdIOVpZ0Q6vWCh9dr8qbDKIZe4xvdh6Q9ptIhf0w+YvuXw/mr
54det++gDFChL1k0RBmCb04wgZ4zSEY6sBeHcrCMrbqpUANM41aLg19DeBEH3w5L
tnjLXbM91VLn7iwdHlUfLak2gHZ65FOEBy7OYp34Dc9fYY09XmAaBwVohm3Ti+1a
vPC9jbs2grA7qs3/jTp4K7LWbve5qaOdDOhWymKpeNjM0tfqAL3mdsoybTOfIblD
Qk0cjotohhOmgMsyEMtK0nd1NiGdeVT9EBDMEVpTHDBcwBj26VFrl7u7cFHWF/24
Z9TjLqze05Fcu8hE16HatfuIvtej4khZfMbBEaz5cKIR4DKDzPhMP6XQJEszIUgK
29N3VzVAcsaw6AVILwZdmwSGz8py4KCYHSKGffVOOdjM1U+k5FDnA+os1EMkXvjP
LHXC+iMpnYwaSeptPfQ9t84LoKMTvV5L8Pe5qW2O+Z8dBhen9YQ=
=qrTA
-----END PGP SIGNATURE-----

--Apple-Mail=_4D669F6B-3783-45FB-851C-DE7F50F47816--
