Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3820B28EDCA
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 09:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgJOHda (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 03:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgJOHda (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 03:33:30 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4457EC061755
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 00:33:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o9so1131292plx.10
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 00:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=/hk/HIQKYfs7GozySKrN4eb4M8zVFbTYMC/fKdmbg24=;
        b=0fXx/T2HNCuVdewVCFA3ng8o1eUcXyUZJPTrU0DQAObqjOrUa8Kd3MEdjtj1jeDh5b
         b2+wv12+k+NeC7e3egZDNOqHNpb9sD2b5NW8lnf09PJ2X4YvjkM9KIsqvsf9ssYzleZs
         ZL8Qd+YbZkeSm3xZW6TMswSkKA+PsdzQvqN1AoTB0kpoyWf7kv86gPk70wUT8PNvniyg
         kTMzjF3tKJuTQpREAKj9qyYeGDJKcVNtX5jURZrPdZjdJg8VGo5XDsJdrG4Z3v7c3/qw
         jE7auqjsIwIQH4B4GEldokFVr6mvSF6VyMYI88wsikjIp9TmZE1OqpLERX97n6BT/pni
         7nIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=/hk/HIQKYfs7GozySKrN4eb4M8zVFbTYMC/fKdmbg24=;
        b=CelUCWOXuuIdPsC459Ms+4PlMOHKWPcsBcMSb3L+xvzH1WiU0wCqEeii0/3Qtb9kde
         2gmfUc/1bLR2KhnFnXSSiWQ43cNqPwdxV1AcBX5XXKSLzFJT4zfLsTh1FJDGWantLrO2
         0iCDKue5aD1di49PPn3b0T0OtofDgoSIhWbc9hlaMzfMrYbz4hkHGCLomvuG6cr/P3eD
         jjSTwsVVt9shwDpVxT/l51CpeshXvCD3OVjJguTuceUjszgWP5h8S0rQvTwgudheIrlJ
         iHaj8cxrHn2fvp6tYC6zZNxn09PG1P17HXFGm18rGZkQNzWO9d6Djh0CHwGaIFiPAW0L
         p16A==
X-Gm-Message-State: AOAM532NRtmf2ZrJN1FV+seZ8cGiBFxh3nJkxQjxi5Nr+SY/o1qmlYrY
        3Wi5Hwlf2PXIq7xAO/KpTMWvzw==
X-Google-Smtp-Source: ABdhPJxGUBN5o521itdXZaHfbnKzqsI6ssFTXOYN4cZkJR1UsEGjQTXDQBi1eVkY82A9Ib2EcvlVyg==
X-Received: by 2002:a17:90a:a81:: with SMTP id 1mr3216498pjw.174.1602747209679;
        Thu, 15 Oct 2020 00:33:29 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id m13sm2024373pgb.25.2020.10.15.00.33.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 00:33:28 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <43A89FE1-E2B2-4751-B79B-C99C3F15B1A8@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_6EFBCE6B-B0DF-4A7D-8C03-E191B8C51300";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: Detect already used quota file early
Date:   Thu, 15 Oct 2020 01:33:24 -0600
In-Reply-To: <20201013132221.22725-1-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
References: <20201013132221.22725-1-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_6EFBCE6B-B0DF-4A7D-8C03-E191B8C51300
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Oct 13, 2020, at 7:22 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> When we try to use file already used as a quota file again (for the =
same
> or different quota type), strange things can happen. At the very least
> lockdep annotations may be wrong but also inode flags may be wrongly =
set
> / reset. When the file is used for two quota types at once we can even
> corrupt the file and likely crash the kernel. Catch all these cases by
> checking whether passed file is already used as quota file and bail
> early in that case.
>=20
> This fixes occasional generic/219 failure due to lockdep complaint.
>=20
> Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Patch looks OK, but a minor question/suggestion below...

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index ea425b49b345..49b2e6be35c4 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6042,6 +6042,11 @@ static int ext4_quota_on(struct super_block =
*sb, int type, int format_id,
> 	/* Quotafile not on the same filesystem? */
> 	if (path->dentry->d_sb !=3D sb)
> 		return -EXDEV;
> +
> +	/* Quota already enabled for this file? */
> +	if (path->dentry->d_inode->i_flags & S_NOQUOTA)
> +		return -EBUSY;

Any reason not to use IS_NOQUOTA(path->dentry->d_inode) here?  I was =
trying
to see where S_NOQUOTA is set, and it seems that all of the quota code =
is
using IS_NOQUOTA().


Cheers, Andreas






--Apple-Mail=_6EFBCE6B-B0DF-4A7D-8C03-E191B8C51300
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl+H+0QACgkQcqXauRfM
H+CMbw/9Esc2pAMVMsxnEHi9lWxpJhuNTByewTON5Zw3TfkhACFnh2zxMP4N7ypn
/SLPY0caD5nXZKkkVAlM7vfRXsnkGs3doV03APEr3fJKLXOz7+FLDLWdd5ZMXdRu
RMkdmDcke7upr+BrfMMxRJbd0/5bpHkdxy7aoNUtI5dlF40YUXTyCRNktDZSZhdw
2ehGQbhqRMPQNR5daKh7DwzoxGB6IX9GgwG/dRjaigKkH3fi1mTRkN2WfXDc2Und
nfOf/pGFRzXL/H5NxyYsimidX7eEZlxUOWS9JTZanX5JwdSBlSjo+5+D9cKoIuEz
z8vR36sbmV8ikQlcBvlkGj9bRhLm2AvyhE/ZD1rBqi8oqXvfgNxlMkg4iFQHEdQF
jYUA+YLK4fb/OO60QWKzRfPSqPLa4Plup/bxr1blO5rQgIsCpl+wcvU41qZOVs63
wywlsN/gY0jOtDgRTEbb5a29ITbgO+V/53c9rfAGu/RAywHau9550tos7BSuA9Dk
7Rf73XykNE5bgeQ6RQM+bqWvQoW0Jj5M6H7iCaO/wORP5ByXIDkp3ACqhedZx9+W
xQn8l1J0ob4ti9n/augf+i2P4k9hulhg4o4JhmTaM5cI2s5r1D0NQa7cs7P9y9FI
LiXtchBYc/d2SayFjLyEg0BL5cMpXiSg5dV/xMGqlOFj3yzHSac=
=G7Qk
-----END PGP SIGNATURE-----

--Apple-Mail=_6EFBCE6B-B0DF-4A7D-8C03-E191B8C51300--
