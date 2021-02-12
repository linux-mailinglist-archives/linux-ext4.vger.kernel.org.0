Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAB131A7E0
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Feb 2021 23:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhBLWkF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Feb 2021 17:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbhBLWh7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Feb 2021 17:37:59 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8488FC061786
        for <linux-ext4@vger.kernel.org>; Fri, 12 Feb 2021 14:37:18 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id cl8so421377pjb.0
        for <linux-ext4@vger.kernel.org>; Fri, 12 Feb 2021 14:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=baDmHPogU3zvEcdF9u+NsHPaekVSQPGjbpxRy9WcmQg=;
        b=J01o88GtEacIk/Er83AP32s4D6kOwcTdd+0vW4DLKThqo+okYPEazzBVLOdn691OJ4
         U2N/mB/PG+/zfOoV79ksfsOru3ftUq6J018S3Zca0M7vVrtB3DdolamMEgZUQ9MawTCo
         D/bc1/vuAR9WT+1cKg8w+jEjkhuld1WWftSAJ7ghXuXBebwbEsDX4p5TcN1uLd+Kbdq1
         Tis7uQaZjChVRni7VB8hXxK8A2Is2wFVj42b7gVAf2NVje/TvoeUeRLRlT3LVlRtuZFH
         GZtKsDldoXxJ7cQhyjz9lOlAo5RCnVpMKIyJSMHKrMBQasSLjjx4gYu1E+zeDXY62Cpe
         o+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=baDmHPogU3zvEcdF9u+NsHPaekVSQPGjbpxRy9WcmQg=;
        b=PrwL++8qfRomiKQ41X7993Ad6K1tK79NwpYlZg1DUReFo6BCAT3SZDi0HYVHGqafvx
         ZvYTrZTyWcU+g8EBnO8g0PlwTaKUoJz5Wzu1FEKUnQKtwzehWMWT1Tx1JKmQzLdY3iI5
         XTAEZdULfjbN7kiFAm9DAOZWQeQDEuV7nR04boPMyY+ZbVuEpc1JtRAwVzdRi6nuLZVd
         rRq36brY99Ji11kfILGbqn+WG1r9Z+AY+MgYsZMl84ZblMGCZ3QUAWw4075lTVBNqpGx
         fUzSuGjtjfUEiyFHEn5ZxmMoIF2cOEXswLESmqZz7TGqANpbLcmjqCyAbAnawnEo+wFK
         GM0g==
X-Gm-Message-State: AOAM531+bWx4j7L4DQL5X0L0LBeIKFeGRWC00gkPQ/+ma8uc9nHd8LgX
        il7uHfaWNrd0MUAaxrKzZaV9cw==
X-Google-Smtp-Source: ABdhPJw4Qb9UwNy36qUHZzQguE/i1DYug5VAddO8+8Pe4AuTwaBDZFdzuwQRwW+fvXxuNfqiHAHCyw==
X-Received: by 2002:a17:90b:1a86:: with SMTP id ng6mr4558735pjb.113.1613169437944;
        Fri, 12 Feb 2021 14:37:17 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id a5sm10170030pgl.41.2021.02.12.14.37.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2021 14:37:17 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <95D11120-F8E4-48DC-B149-1B2A5804E74D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_939BBF00-387D-4E4F-828E-E7E025EB433C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 5/5] ext4: add proc files to monitor new structures
Date:   Fri, 12 Feb 2021 15:36:57 -0700
In-Reply-To: <20210209202857.4185846-6-harshadshirwadkar@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>, Shuichi Ihara <sihara@ddn.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
 <20210209202857.4185846-6-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_939BBF00-387D-4E4F-828E-E7E025EB433C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 9, 2021, at 1:28 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> This patch adds a new file "mb_structs_summary" which allows us to see =
the
> summary of the new allocator structures added in this series.

Hmm, it is hard to visualize what these files will look like, could you
please include an example output in the commit message?  It looks like
they will no longer have one line per group, which is good, but maybe
one line per order?

If at all possible, it makes sense to have well-formatted output that
follows YAML formatting (https://yaml-online-parser.appspot.com/ can
verify this) so that it can be easily parsed (both as YAML and via
awk or other text processing tools).  That doesn't mean you need to
embed a YAML parser, just a few well-placed ':' and spaces...

Unfortunately, files like "mb_groups" were created before that wisdom
was learned, and are a bit of a nightmare to parse today.

A few comments inline...

> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>=20
> +static int ext4_mb_seq_structs_summary_show(struct seq_file *seq, =
void *v)
> +{
> +

Extra blank line here can be removed

> +	if (position >=3D MB_NUM_ORDERS(sb)) {
> +		seq_puts(seq, "Tree\n");

Prefer not to use capitalized words.

This should have a ':' like "tree:", but this still leaves the question
"what is the tree for?" so using "fragment_size_tree:" or similar would
be better.

> +		n =3D rb_first(&sbi->s_mb_avg_fragment_size_root);
> +		if (!n) {
> +			seq_puts(seq, "<Empty>\n");

I'm guessing this won't happen very often, but it might be easier if it
kept the same output format, so "min: 0, max: 0, num_nodes: 0", or just
initialize those values and then skip the intermediate processing below
before printing out the summary line (better because there is only one
place that is formatting the output, so it will be consistent)?

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
> +		seq_printf(seq, "Min: %d, Max: %d, Num Nodes: %d\n",

These should be "%u" and not "%d"?  I'd assume none will ever be =
negative.

Prefer not to have spaces within keys, so that it is possible to use
e.g. 'awk /field:/ { print $2 }' to extract a value.  "num_nodes:" or
"tree_nodes: is better. To be a subset of "tree:" they should be
indented with 4 spaces or a tab:

    fragment_size_tree:
        tree_min: nnn
        tree_max: mmm
        tree_nodes: ooo


> +	if (position =3D=3D 0)
> +		seq_puts(seq, "Largest Free Order Lists:\n");

Similarly, avoiding spaces in the key makes this easier to parse,
like "max_free_order_lists:" or similar.

> +	seq_printf(seq, "Order %ld list: ", position);

Here, "    list_order_%u: %u groups\n" would be more clear, and
can be printed in a single call instead of being split up.


Cheers, Andreas






--Apple-Mail=_939BBF00-387D-4E4F-828E-E7E025EB433C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAnAwwACgkQcqXauRfM
H+AjPQ//aw3GysIT0I/dXIHU7JZXBvQeMyVKDRNlCQs38dxCFhcUHEeSnoy2Vxwc
YUSg2silZlFEkrkwqEgxsTdiVIo859+gEYnxTnwBcToDtN9isCp5ijBFLdXRaa35
5Xv5NMKdijufILCFFDEOu4yQRlB3/Z3fMuy7htixoYjnoKXFZZ5x2OSsHQcSaZ0R
2GNY6qXPwm+wdEcGBs0tIDcDiynNbGRs2bgnt/fGxCVZn9zbQV3qtO1/rKR2BYOU
ZBMFjSYil46xMPCZYB7U8PiDXOD75Y8MHRCoR4cvft0uPgXXOVkFL+OtOu3IvL9L
F5ecAwVVEjsIATavkAUreAnXtDCIwaCi11Jf/OcJPO7CauAYoXnH+rqq0GRcNn1l
jBZiFvPYg8VpQuLBXjNiR19q4fl6WquD65/OWNUKh+OhLKoJT0Z97aZcreXmnD6/
YAPqmDmAzjxh8o/Z7lrkg+LUH8IEOlLv48DfBqUWBmzDCPdh4soiKuZiBeNJ1/S2
KQyoKFl68LKvTVZOkBQOrCUtXyCcgdGzCev4qgajDzsDiCM+0HRBIT2WIXb8fpvS
F711HYSwo6isQHGS4GpgB3IAzqi+v1zjgQMLF+MdxnqSr2vTVW/+NCOIiPwJw+XW
jMYmEqVg7MawwKshV10EFhNlf/MJOQ5uXAdO0NPX3SSb/XX0uek=
=SXIA
-----END PGP SIGNATURE-----

--Apple-Mail=_939BBF00-387D-4E4F-828E-E7E025EB433C--
