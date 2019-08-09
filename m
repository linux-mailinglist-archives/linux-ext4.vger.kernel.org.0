Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B41B98853C
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 23:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfHIVqX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Aug 2019 17:46:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46353 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfHIVqW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Aug 2019 17:46:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id c3so23576624pfa.13
        for <linux-ext4@vger.kernel.org>; Fri, 09 Aug 2019 14:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=h3rMRLXY6xeEbCSHqZuF2VQo/6gARO2a8owQLzGya1o=;
        b=O+xFss00ORcm1jRJibAYsloTcyb0Qt4lMXSNqphLQ8MmLhIQFEurj81NgeTPlxPrFn
         sbRqIcBfVqRBq+Y9Oiqxe7cFQHaW9UfBngeLINO3AsW2atxZhbinr+kdFdzGMvIQsUBZ
         gsLTOYrJnGyUqzwXnR51QqjuKGh04s1owHxD3ZjyrGwrSGHc84YQi9CTJRcVcP5Q8d81
         4us3HunWDN3tzxDDqEnUZHYQUN4DJonq9cVtoVHopqfRaqZVwG8qOMF2ua0w20Y80nOl
         T0Mpe3Xj+UvjnNGKL5oA6v5/4QhytO9aEDOqAn/EWmj4jLyvYJPaTOwi/wi7tW3ZRagq
         xyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=h3rMRLXY6xeEbCSHqZuF2VQo/6gARO2a8owQLzGya1o=;
        b=TVCHW86usYjMKjdgOBvrRP47NCODUFa0Y94ULm8neUQzobT+J4f5J2iRqh5AGplbUs
         RdVS7o9JvPacJn+NF4Kx1KzwlsdSsdRT7n0A5yX/Ti1At7E/0n13q8v804Srv7LwIBm4
         Br2djuI6ZJ2Bl3nKAbEPMZq3VlVhqlK49dnIJnEOf6t7BdYpmJzrK6rkDE4UeCb3kZ4e
         GCskKTCCaRjqcds8ZN59KhGzifRNWNG/EbOCLGYcGKLy3NQ0lcNIcckIqp25EQWzRAuc
         /frvPDgED5nmQgVyw56bZLFlwEh7AiN/SQjKYep2fnPEPZrx46BQD24q2VZSkzfWOSED
         RnTQ==
X-Gm-Message-State: APjAAAXwHOyUweL9gdFfWVwCTvOdOvmaRempwr77RG/Kdtsxsd0a5h8Z
        dyRLQ7pPMU3xyoPzLNyb6pnoa1vRZD/1Pw==
X-Google-Smtp-Source: APXvYqyeTRO9VaWFNPiLW7ri5p9jJshKYNTnoEJNPjdjEvLdx4IbcA5b3ePAUN2YQfM2cGJoD2oAIQ==
X-Received: by 2002:a17:90a:30e4:: with SMTP id h91mr11070611pjb.37.1565387181675;
        Fri, 09 Aug 2019 14:46:21 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id s43sm5914046pjb.10.2019.08.09.14.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 14:46:21 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <BC4620C8-1AC6-4543-BBE8-012067ED3CEA@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_716BE7DA-4A72-4D29-A629-E9F1621C9D99";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 08/12] ext4: track changed files for fast commit
Date:   Fri, 9 Aug 2019 15:46:18 -0600
In-Reply-To: <20190809034552.148629-9-harshadshirwadkar@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
 <20190809034552.148629-9-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_716BE7DA-4A72-4D29-A629-E9F1621C9D99
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 8, 2019, at 9:45 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> For fast commit, we need to remember all the files that have changed
> since last fast commit / full commit. For changes that are fast commit
> incompatible, we mark the file system fast commit incompatible. This
> patch adds code to either remember files that have changed or to mark
> ext4 as fast commit ineligible. We inspect every ext4_mark_inode_dirty
> calls and decide whether that particular file change is fast
> compatible or not.
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Some minor code style cleanups.

> @@ -759,6 +761,8 @@ int ext4_write_inline_data_end(struct inode =
*inode, loff_t pos, unsigned len,
>=20
> 	ext4_write_unlock_xattr(inode, &no_expand);
> 	brelse(iloc.bh);
> +	ext4_fc_enqueue_inode(ext4_journal_current_handle(),
> +					   inode);

(style) "inode" doesn't need to be split to a separate line

> 	mark_inode_dirty(inode);
> out:
> 	return copied;
> @@ -974,6 +978,8 @@ int ext4_da_write_inline_data_end(struct inode =
*inode, loff_t pos,
> 	 * ordering of page lock and transaction start for journaling
> 	 * filesystems.
> 	 */
> +	ext4_fc_enqueue_inode(ext4_journal_current_handle(),
> +					   inode);

(style) "inode" doesn't need to be split to a separate line

> @@ -5697,6 +5719,8 @@ int ext4_setattr(struct dentry *dentry, struct =
iattr *attr)
>=20
> 	if (!error) {
> 		setattr_copy(inode, attr);
> +		ext4_fc_enqueue_inode(ext4_journal_current_handle(),
> +						   inode);

(style) "inode" doesn't need to be split to a separate line

> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0b833e9b61c1..c7bb52bdaf6e 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1129,6 +1129,16 @@ static void ext4_destroy_inode(struct inode =
*inode)
> 				true);
> 		dump_stack();
> 	}
> +	if (!list_empty(&(EXT4_I(inode)->i_fc_list))) {
> +#ifdef EXT4FS_DEBUG
> +		if (EXT4_SB(inode->i_sb)->s_fc_eligible) {
> +			pr_warn("%s: INODE %ld in FC List with FC =
allowd",
> +				__func__, inode->i_ino);

(style) this should use ext4fs_debug(), since pr_warn() is not really
used in the ext4 code

> +			dump_stack();
> +		}
> +#endif
> +		ext4_fc_del(inode);
> +	}
> }


Cheers, Andreas






--Apple-Mail=_716BE7DA-4A72-4D29-A629-E9F1621C9D99
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1N6asACgkQcqXauRfM
H+DIBQ//XFdCCI13Uj22Ab5TuuwG+MF/TTGvwZXQTMqWaDHjQrGnUHdph/Fmn8rG
1QOSUMdbFvLrYKpIwDKi+aa29H8Cxlmju3s/Zz8IMsmhE9n54XWJdIFR6esGT4jr
79Fl2pxnYrWcTe8LeiuHLF7yRPUAKPZlo+Cv1tspfbPDL1iOZHv3SO7NeqGTr3pW
KtRLBNS5w0eCfFgs0T/LJXI8ONfx+UvzF4kAzWeb/Rmi4qIKdReNmpSrRHGG5J6R
xljaWfvLbhITVXeBqR4FspnnIwltD9YSB1XdKsgmIROlJ5FX6+vKjY5BA8ZzqpeK
yJj4KJSg0KYhveUV4HCLqWyjzTqnmoF9jtWgplwrzGFYhcMgbv2D2KoiwAZ+cVQ4
iX/HKL3SRt1/Pky8s1z4N0Bf4/YDliKO1vEPV7BYMv5aQ1iIhAPceFbD1ns1wKGt
zjqGXULrcLDcE/s/O6Q2T6FInRuuY+ipZ34i0/sf/z8fgD7JTcQwt+jq2BOJn9Cy
phOIxxBYiKuHlEUITDZNBeJ6bwjWqb3CgSay68ryfyrzwT+XafkwQxlFwwwCZJ02
B4tBWiusG4g+uwxloZ3SskFXxhY1Act4AUAN/nEsE3bAKjoQaqtot0+aS6fDGDjs
/4L5JziObzvgHKoO+hHzLvp5xdxyk0qjOC+6h20z7ZfMVmOXKK4=
=HRMy
-----END PGP SIGNATURE-----

--Apple-Mail=_716BE7DA-4A72-4D29-A629-E9F1621C9D99--
