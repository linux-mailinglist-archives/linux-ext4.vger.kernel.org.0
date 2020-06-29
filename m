Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6469520D853
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Jun 2020 22:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgF2TiP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Jun 2020 15:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgF2TiO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Jun 2020 15:38:14 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9170AC03E979
        for <linux-ext4@vger.kernel.org>; Mon, 29 Jun 2020 12:38:14 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id f6so4406796pjq.5
        for <linux-ext4@vger.kernel.org>; Mon, 29 Jun 2020 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=0ryUmBIXvqF0ehEsTIaT5RWh+d1nXbMdnC4ihUlBvMg=;
        b=DVRlnzQLRI+2EKcoZR+dE3xOEuG4PAToPYl6njfk7OyjaYDqGsDgap4goOVg0gizCw
         eF9LT/12PggVAX2eqSgwpxxanZRiH5i3IXYuvimzKSdOZHTQUS4Z3EtxPmygeHca2chT
         45uyF31rKxNBQfCsETSDhwWFT7oWb0yCkQ357VvgPtZaHqUBvssEYGs4XtVIPfz5yMin
         +HzMAXrg9FrzP0ky5SEw6OA3oz7ZJTKC5+t2vvUTcH1UtSjyuz9470tpl1BtQSBGYf8G
         VbnBNEG3GEFlYaz6jaqWbZeLe5Ql7HHNruRLTIH+V7OutXRlYOSaMs2uTcQG2RQJfHhO
         sLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=0ryUmBIXvqF0ehEsTIaT5RWh+d1nXbMdnC4ihUlBvMg=;
        b=G4QPeTuu6Xp2oj4De1lD/9cjf/+CSqZ3e+JbgSjPOH/M10YbUBWo9CF9BVY5tBd1Ik
         FdEdmNNEVOg8Hkn5UZhqGxHBclZTzckqgrd/PoxIIGKUyVpoiLZHEH9i5TJR6x67hmvV
         dgC7E11ocgyyjDoSEff3CR5DeHN/c+2OzYTpl64IMtm26fIYmGZBztItqQuTjxkVDPY1
         As/tg8kY/eNobwRrCfwyd6pn2cvAfUX4SBLmfE84EoXsj5MB04dyGVge3Ql47bgqYkM2
         XFBv++gh5chV0Iqqvm7JMegPGB+c5gaTLBHFsLYkqjsJX7YPgmtQcO6rVgu759OS4GDi
         CYdQ==
X-Gm-Message-State: AOAM533lQ9d+wiKGSzlbZqb2sCbD+ofN5alqG4G2/kZ+ItvRr8KEvlOh
        PhNDRrW2W4QwPOMaUeRir5J6bw==
X-Google-Smtp-Source: ABdhPJzyQjGilSKi6BvB3ozqw0oeYOeO+jTw9iOZflvDPodqBpvbkP3yRIgKWiJoaIdbnCWK5pms4g==
X-Received: by 2002:a17:90a:5d85:: with SMTP id t5mr19518355pji.154.1593459494070;
        Mon, 29 Jun 2020 12:38:14 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id h6sm458486pfg.25.2020.06.29.12.38.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 12:38:13 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E3E19655-BCA9-4629-9B6E-24B698777E15@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_6534FF77-2DD9-4226-BC1E-C816C3D14666";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: lost matching-pair of trace in ext4_truncate
Date:   Mon, 29 Jun 2020 13:38:47 -0600
In-Reply-To: <20200629021341.36129-1-zhengliang6@huawei.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     zhengliang <zhengliang6@huawei.com>
References: <20200629021341.36129-1-zhengliang6@huawei.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_6534FF77-2DD9-4226-BC1E-C816C3D14666
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 28, 2020, at 8:13 PM, zhengliang <zhengliang6@huawei.com> wrote:
>=20
> If truncate inline data successfully, it shoule call trace exit.
>=20
> Signed-off-by: zhengliang <zhengliang6@huawei.com>
> ---
> fs/ext4/inode.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e416096fc081..6d24ed658e30 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4171,8 +4171,10 @@ int ext4_truncate(struct inode *inode)
> 		err =3D ext4_inline_data_truncate(inode, &has_inline);
> 		if (err)
> 			return err;
> -		if (has_inline)
> +		if (has_inline) {
> +			trace_ext4_truncate_exit(inode);
> 			return 0;
> +		}
> 	}

This only handles one of many similar cases in this function.  That is =
why
the preferred code style is to have a single exit path with labels that
handle the cleanup in reverse order from the setup.  This avoids the =
need
to have multiple copies of the cleanup code in each error case, and =
avoids
bugs where some of the cleanup steps are missed.  Something like:

	trace_ext4_truncate_enter(inode);

        if (!ext4_can_truncate(inode))
                goto out_trace;

        ext4_clear_inode_flag(inode, EXT4_INODE_EOFBLOCKS);

        if (inode->i_size =3D=3D 0 && !test_opt(inode->i_sb, =
NO_AUTO_DA_ALLOC))
                ext4_set_inode_state(inode, EXT4_STATE_DA_ALLOC_CLOSE);

        if (ext4_has_inline_data(inode)) {
                int has_inline =3D 1;

                err =3D ext4_inline_data_truncate(inode, &has_inline);
                if (err || has_inline)
			goto out_trace;
        }

        /* If we zero-out tail of the page, we have to create jinode for =
jbd2 */
        if (inode->i_size & (inode->i_sb->s_blocksize - 1)) {
                if (ext4_inode_attach_jinode(inode) < 0)
                        goto out_trace;
        }

        handle =3D ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
        if (IS_ERR(handle)) {
                err =3D PTR_ERR(handle);
		goto out_trace;
	}
	:
	:

out_trace:
	trace_ext4_truncate_exit(inode);
	return err;

Cheers, Andreas






--Apple-Mail=_6534FF77-2DD9-4226-BC1E-C816C3D14666
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl76Q0gACgkQcqXauRfM
H+BOgBAAqnUx1EUXaP+fUUxRCt/idxAuYlR0GbWiz1EKIoESWvEl9TfmsFiF8Q1e
EqyCyfTJrWt/W2rXtWav7wzETuyO7yDq19VKy3DsWMgV5hacGd0xKXci3PtRhHij
z9OLCwBwYaw5veCEX+msuil9IN1p6zfz7rPh5ORVTrUfUX+WEWeByDnBwBCSEM5n
uOr5aqpUi5WAtj4ffQTVnuheWBg5J8i9+YtbKCJT82jW76A6nyWaUBsqeYa3hj7P
egJqcb0F2pJfyM6mTenwTJ7HrG/dbrfi8kRDMYvPdNbz/6MitwzbJHIjMot1/ZIa
+7uOhc+4EIUkk7qSXHL/tU0FRxZj2WUHzgUv1ZoAr5XCyduwePCUpZv2M0VujIYU
f2qFv1pa97KaNcYteA4DKqPA9OGHgbLZ74tk9YmM/TiibD6SZy/4FUgBNNGcblaU
iGib8WsDGSYonNYnQcXWeGtd2Qo3py089sVv6HKwz3NpOMpnG1NNV5qG+S8uBDpm
TWAEqVY0DUpLh7c58PoHI4SgYjO9ou8UAHaF+GpHAmIU76BUWIv+xbnerpbocJhU
Yl6qXgMQHWlPT3fryc4zq6l18R5nRONaYCQ5JdlkE7adfJcOYfqd2Uge91afIlMf
bpmfTjkJTXD8a2B70woVtyLZ2nHFjNtgZpuhzL/tjr+M9bWGYmE=
=OqFv
-----END PGP SIGNATURE-----

--Apple-Mail=_6534FF77-2DD9-4226-BC1E-C816C3D14666--
