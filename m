Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA5123C4B1
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Aug 2020 06:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgHEEnd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Aug 2020 00:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgHEEna (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Aug 2020 00:43:30 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64662C061756
        for <linux-ext4@vger.kernel.org>; Tue,  4 Aug 2020 21:43:30 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d22so3647047pfn.5
        for <linux-ext4@vger.kernel.org>; Tue, 04 Aug 2020 21:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=BtldnxnFGrnTj00hwH1RPWgV5daAD5Id66YyAskc8sc=;
        b=p5+bjfFzJA6jvz4xnlTy2n2YOoAvWDhX62Q7nXKj3JpIwTPRQ1biKW37VEKtaWkndg
         plNncOj6TuVYPmygNUkujOAgrQDwa/ghd5kN9Mz1l/X3r7VWGIZ4IFlauewEurlltSNq
         Qvw2rWqxamweae3XtTBk0tQ4LHoO4nx+LyFMjVWemcsEaKMeTmZqB5B/MS9ypAtHXqFq
         V22fYfmHX8+kEbiD9ZEfp/1dpzIAZKJZ0k2kCEXOvHBM3QgorSvlVGgLD46pJbHQ1Vzo
         ajzm6tA/TdyegZfYApp4HtzFiLuS1qwxgQbXq0CETCk2glzZkbfseT9OWdqcqAs1Cuwd
         c4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=BtldnxnFGrnTj00hwH1RPWgV5daAD5Id66YyAskc8sc=;
        b=NDr0ZJOVCrmnz8HHHayYg5GCTcmHHtFs5VUYflSN8SnRZIPZoNgaO28SvjHdUYjbmh
         hb5sIFdtT/z04RjpTRbP+IH+OX9yU96N/IAhxUxTD7X4D7TCRa3VunlNcuWuj9Tasa+B
         +qxqmphhIIZ8VGq3esUPO8jK+U8NTp9Zl5+Oc7N/8teKsZn2x2GbYKLlLLc3C7b2Bcgd
         9sRv7s3/Cg548VL3CGX68BrddGLBVmSI3piDUj3E/hodJkP4pCRyI1fCw2KdQqfmOpdt
         qN8RYNZWar1E3YOmyMIrkv7E7qZ/OTtLkq51h9vxf13elNMQJd2v89ay5C7zOYF+LUnh
         8v4Q==
X-Gm-Message-State: AOAM533lstfBgnQn9jbq7XwhkK3NxheigknMT+NGsgaV6EaljkQSsrjb
        eU3RSrRlWkgCANdNni9+SqyyuQ==
X-Google-Smtp-Source: ABdhPJwA32XcoJrn5trX4X7yJ+b+uKPc02HlJT5FBW7PP4dtcHntkoBIID4Z2swVxsbUpU9rImFdmg==
X-Received: by 2002:a62:2ad6:: with SMTP id q205mr1588016pfq.316.1596602609659;
        Tue, 04 Aug 2020 21:43:29 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id g14sm1012054pgi.46.2020.08.04.21.43.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 21:43:28 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <7FA38CCB-BDB3-4D35-AA73-C7604B0BCC87@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_269E6BAA-58C5-4E7B-81BA-23B491D68C63";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 1/3] ext4: reorganize if statement of
 ext4_mb_release_context()
Date:   Tue, 4 Aug 2020 22:43:24 -0600
In-Reply-To: <ad1ac152-6d52-13cd-5786-7c888bf9370d@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
References: <ad1ac152-6d52-13cd-5786-7c888bf9370d@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_269E6BAA-58C5-4E7B-81BA-23B491D68C63
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 4, 2020, at 7:01 PM, brookxu <brookxu.cn@gmail.com> wrote:
>=20
> Reorganize the if statement of ext4_mb_release_context(), make it
> easier to read.
>=20
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
>  fs/ext4/mballoc.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index c0a331e..4f21f34 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4564,20 +4564,19 @@ static int ext4_mb_release_context(struct =
ext4_allocation_context *ac)
>              pa->pa_free -=3D ac->ac_b_ex.fe_len;
>              pa->pa_len -=3D ac->ac_b_ex.fe_len;
>              spin_unlock(&pa->pa_lock);
> -        }
> -    }
> -    if (pa) {
> -        /*
> -         * We want to add the pa to the right bucket.
> -         * Remove it from the list and while adding
> -         * make sure the list to which we are adding
> -         * doesn't grow big.
> -         */
> -        if ((pa->pa_type =3D=3D MB_GROUP_PA) && likely(pa->pa_free)) =
{
> -            spin_lock(pa->pa_obj_lock);
> -            list_del_rcu(&pa->pa_inode_list);
> -            spin_unlock(pa->pa_obj_lock);
> -            ext4_mb_add_n_trim(ac);
> +
> +            /*
> +             * We want to add the pa to the right bucket.
> +             * Remove it from the list and while adding
> +             * make sure the list to which we are adding
> +             * doesn't grow big.
> +             */
> +            if (likely(pa->pa_free)) {
> +                spin_lock(pa->pa_obj_lock);
> +                list_del_rcu(&pa->pa_inode_list);
> +                spin_unlock(pa->pa_obj_lock);
> +                ext4_mb_add_n_trim(ac);
> +            }
>          }
>          ext4_mb_put_pa(ac, ac->ac_sb, pa);
>      }
>=20
> --
> 1.8.3.1
>=20


Cheers, Andreas






--Apple-Mail=_269E6BAA-58C5-4E7B-81BA-23B491D68C63
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8qOOwACgkQcqXauRfM
H+CgTxAAv9r9vdGfmUbKAhpr1+mI3LshZikFcWLsWfuvsELuHPPL8a4CqETR5cHN
waHDmp2pnvRMhBuVrsXJoLUcqT1FdxAp0TVe+h3lbQuGfM+uOtgP2fcKIz4tyyV+
4o4JSTEPn71qAsMhNK2PWod4O0rDMQbTb7bL0fl4BcMJMpXGuAdz8MbdFHlZph8I
oRgqEg3spuYSMDGzRP7K601e3yqUkvAF+POADReWtYletpTUrpphXxTFxX7+yN6F
Ad/39sEnMBtgbFKuv1C018rVszLZPMYKcZXqxC7EILqwIfSpXU3iTjvBY+a3tmhu
pWDtufpKL0/p1FR+d+Z0zELHA3YOOr883ruLasXchx9u7N2BJMZ98qKoOVnQlRo5
ozR2PNEEGdmzsKz3x0BMyX1MNNA1BFaS9S35kn6ny1beH0eitPyGV1vALg8PaUT7
IbJlWQrikT5o74aFUwaWTGDBmYpOLQcAwYIjaZWmYBcywRKRq5Bqyo+/iLva80J9
mwSZ3ynww4cEmFp51EcK/j0BsPwVmOX1kFNpP2Awre2skgjZ4hule45u0yXmLM8R
bRL/4dB6Ps+ettYaR1x7/ljXyQQyECifiD8RCvZ8+0/h8DUeeUE85lsnKs0GW66i
NI8hQgcZnLSsVgfTJE1Upt4kdJwvCOiFVvQ1urRRYcp/nc9L0as=
=/uyT
-----END PGP SIGNATURE-----

--Apple-Mail=_269E6BAA-58C5-4E7B-81BA-23B491D68C63--
