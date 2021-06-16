Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4333AA4CF
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 21:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFPT6k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 15:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhFPT6j (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Jun 2021 15:58:39 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A776C061574
        for <linux-ext4@vger.kernel.org>; Wed, 16 Jun 2021 12:56:33 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id m2so2890235pgk.7
        for <linux-ext4@vger.kernel.org>; Wed, 16 Jun 2021 12:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=NAsDhRBTrJSFPkVmOmsmthvWwwezDyHskU2qrtOpJb8=;
        b=UnSTnsgKM+YzxHkIFRgqjJv6EKOIR4kXm/nPUw/12Y0WLVPnm6Z4s88qdeb7Gox5Xq
         lzf75mcYhexmQzg39+2hgZqHK6+hX3BnzDPXvlvsZ92dMJdDmHI7X53A9OBD7GKdRxKi
         7CdHGdGT4snb6H0toch1TC2KCUqMwHg5Powiwb1xwyRhz83upCsErEdrEDw0eT9fHESn
         C2KNupJF9hTDWKzUP2Jgm0TV4fEclSUDDGG9vn5VQRe4GS+sH+M/yH2fUcdpIO0DYTfC
         17IZpkJOKzJZf3Z5wqGvf5f1qhMwqY8vafyoTFyBAJhmV+WWriB46YVte9FQGvWNstxu
         w4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=NAsDhRBTrJSFPkVmOmsmthvWwwezDyHskU2qrtOpJb8=;
        b=AmNw1UjmO81ZOv8JASNwwODx/RCCi8XTHEG7rsI6pBP6t/Pw63qdeeH8mVoJq3XcIG
         4s9DDqABarUPdMZwk0mrYv+sS7wX4stcH8KBNXx+YkwkxUwCFzJrQ4GK/VkuvJDTNJR4
         gkqsbSXPGlkn5aR8LJiturSuBrMKApeWlreuSNLzajByXdmXQhpHUF39Pb7Ct2We/azV
         uptGIeOwNechyvPn83hcC5nezL8DBhtoV9oUn8uiJQ9wc9auE9RZ4tKJNBfYIGEY6Emm
         Pq3WoZQkflH2BCkjOv7dm2Gpw2UomyY50BgvN2OR6rLWHS/9d+QezXuXpTPcOrKxwysa
         bPNQ==
X-Gm-Message-State: AOAM531BRNZysENR6Qks30fmBwp1dJnUOSKjxPpqgnISFlc2EoFhk8Df
        O71OtpMLzK9z1JnOWeysMX7IxA==
X-Google-Smtp-Source: ABdhPJyNTpmj0PQNZtzw+3XMBWjEju3XEsjZlNhHA1Dxqyds6Eu8txsvlrp8H/wl0tqvL/8Rn8Pvzg==
X-Received: by 2002:aa7:949c:0:b029:2fa:c881:dd0 with SMTP id z28-20020aa7949c0000b02902fac8810dd0mr1424856pfk.9.1623873392927;
        Wed, 16 Jun 2021 12:56:32 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 35sm2577158pjo.16.2021.06.16.12.56.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jun 2021 12:56:32 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <0DB920A0-26A5-4B76-B2E6-78B1B678072C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_252D0CE2-0624-4473-BA9F-9CEB980F1CD9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/4] ext4: Support for checksumming from journal triggers
Date:   Wed, 16 Jun 2021 13:56:30 -0600
In-Reply-To: <20210616105655.5129-2-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jan Kara <jack@suse.cz>
References: <20210616105655.5129-1-jack@suse.cz>
 <20210616105655.5129-2-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_252D0CE2-0624-4473-BA9F-9CEB980F1CD9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 16, 2021, at 4:56 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> JBD2 layer support triggers which are called when journaling layer =
moves
> buffer to a certain state. We can use the frozen trigger, which gets
> called when buffer data is frozen and about to be written out to the
> journal, to compute block checksums for some buffer types (similarly =
as
> does ocfs2). This avoids unnecessary repeated recomputation of the
> checksum (at the cost of larger window where memory corruption won't =
be
> caught by checksumming) and is even necessary when there are
> unsynchronized updaters of the checksummed data.
>=20
> So add argument to ext4_journal_get_write_access() and
> ext4_journal_get_create_access() which describes buffer type so that
> triggers can be set accordingly. This patch is mostly only a change of
> prototype of the above mentioned functions and a few small helpers. =
Real
> checksumming will come later.
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Comment inline.

>=20
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index be799040a415..f601e24b6015 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -229,11 +231,18 @@ int __ext4_journal_get_write_access(const char =
*where, unsigned int line,
>=20
> 	if (ext4_handle_valid(handle)) {
> 		err =3D jbd2_journal_get_write_access(handle, bh);
> -		if (err)
> +		if (err) {
> 			ext4_journal_abort_handle(where, line, __func__, =
bh,
> 						  handle, err);
> +			return err;
> +		}
> 	}
> -	return err;
> +	if (trigger_type =3D=3D EXT4_JTR_NONE || =
!ext4_has_metadata_csum(sb))
> +		return 0;
> +	WARN_ON_ONCE(trigger_type >=3D EXT4_JOURNAL_TRIGGER_COUNT);

I'm not sure WARN_ON_ONCE() is enough here.  This would essentially =
result
in executing a random (or maybe NULL) function pointer later on.  Either
trigger_type should be checked early and return an error, or this should
be a BUG_ON() so that the crash happens here instead of in jbd context.

> +	jbd2_journal_set_triggers(bh,
> +		=
&EXT4_SB(sb)->s_journal_triggers[trigger_type].tr_triggers);
> +	return 0;
> }
>=20
> /*
> @@ -304,17 +313,27 @@ int __ext4_forget(const char *where, unsigned =
int line,
> int __ext4_journal_get_create_access(const char *where, unsigned int =
line,
> -				handle_t *handle, struct buffer_head =
*bh)
> +				handle_t *handle, struct super_block =
*sb,
> +				struct buffer_head *bh,
> +				enum ext4_journal_trigger_type =
trigger_type)
> {
> -	int err =3D 0;
> +	int err;
>=20
> -	if (ext4_handle_valid(handle)) {
> -		err =3D jbd2_journal_get_create_access(handle, bh);
> -		if (err)
> -			ext4_journal_abort_handle(where, line, __func__,
> -						  bh, handle, err);
> +	if (!ext4_handle_valid(handle))
> +		return 0;
> +
> +	err =3D jbd2_journal_get_create_access(handle, bh);
> +	if (err) {
> +		ext4_journal_abort_handle(where, line, __func__, bh, =
handle,
> +					  err);
> +		return err;
> 	}
> -	return err;
> +	if (trigger_type =3D=3D EXT4_JTR_NONE || =
!ext4_has_metadata_csum(sb))
> +		return 0;
> +	WARN_ON_ONCE(trigger_type >=3D EXT4_JOURNAL_TRIGGER_COUNT);

Same.

> +	jbd2_journal_set_triggers(bh,
> +		=
&EXT4_SB(sb)->s_journal_triggers[trigger_type].tr_triggers);
> +	return 0;
> }


Cheers, Andreas






--Apple-Mail=_252D0CE2-0624-4473-BA9F-9CEB980F1CD9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmDKV24ACgkQcqXauRfM
H+Aqpg/9EqZ8D3mb6R7/lah7naT0ASlRNsBJIlRRqq0c+r2cmbtrCrEDoqxgf/2V
LD/Zs2MveADVV1Sd7IR2s17sMt/3LzV+/dgoAO6ui8/t/RRF76v90BeA/39g0yTH
WOWVIGKX8NvnAsNFoGAWFsfCT5OxQHKlucysmCGm+VEqumTC3YYzrdsD/X+P3ZH9
Z07Txf4T5sdHM6xop5s8flQnT0h9Exi1sTdtTUXfGj61lB1q3LwCbeBnB2rE2jek
lwAORTVC4L4uu6IKDZh9qbS5aBzywgvUdOw33b5ARfoQCaO3L37tf14tr74+3NIk
VYEUpI+6mrf9ovOEKrq3uqQRpdwgWKCvhsVZdESdmV4t5H+gNxKRWPCB/47jw/f3
H85/NlQ8lrkJBvuRD0UKW5WP5bT8FJ5Ja6ZRjK3xR2Bj33We1xf1/JJeJ8wHYRHs
Xi8UUQm5VB4Rb2Lw9/C734+Wwi0WsLGPp3rlmXWCcKK5rDH4yv8NaF1SIUyz8ya2
AC20FmyHOXX1Eg1sTOox29S2MjqiYfuRGq/+sWaa7Q5kRh+cZuZkInFrtjJz2ufq
nPHs+VM3V5u9DEV5CvyaSMvQRZswM/A6LTlTlWEzfOKq20uAF2B7bbKyVSstdFeo
89642D1Cvxz718WKUeX+Tw8cKqhw2951VLKk1AyI31+MWixGbxk=
=mUZG
-----END PGP SIGNATURE-----

--Apple-Mail=_252D0CE2-0624-4473-BA9F-9CEB980F1CD9--
