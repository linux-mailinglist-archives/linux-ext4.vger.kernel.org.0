Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6B43FE26C
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Sep 2021 20:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbhIASd3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Sep 2021 14:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbhIASd3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Sep 2021 14:33:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753AEC061575
        for <linux-ext4@vger.kernel.org>; Wed,  1 Sep 2021 11:32:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so343054pjc.3
        for <linux-ext4@vger.kernel.org>; Wed, 01 Sep 2021 11:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=DmpEch5ev3+gTobUZKB+8VTTEvVodWKsEqQ8GZ13Y4s=;
        b=R7p2LugP07pwnViWKE72FgbMIgEoCiIrYi3+3v0YNMpGr53jmERowx51uipKmKBrvz
         px0dsxp+i9F5dQOyjctjKAPkZwrKXZmbCsHSm/JjqoBi4pg53J/+ZxFwi2nqlULlVKkK
         1JZYuuV3uRYqD6r/6MV6MYJXUIhGDcTANCfPVwBiIrjOPEAiJpfOIFqehhrcOf56F2dF
         nwCUOM5z9B9W9YyiMdQaHEX2S+zBsWlvudHBxv91xM/svz+jJEUu9YoQ7W6P3VmOnlqG
         vpfbgvvaSKR95xouL/g1+ppWZXogxxhy32SgUoZ+sSHhjO+UEwEWwue4ohm/lLOJhTqf
         TZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=DmpEch5ev3+gTobUZKB+8VTTEvVodWKsEqQ8GZ13Y4s=;
        b=OqPPCPe5sR7he1RQuhk0G743Z1DIA3eg3pNZys56D7A1hSjJvRBxETK3u1/FJx5WCJ
         l9gIfJTkCDOaWpR28oWIbGf0kwdPG8kZL5ZgOWan+Fo9OvnGEftVqQVbSzifVxet1Kq4
         3YQ8a8WnZHv8qJPMaCjV+PHkPK2tGeoTkQptZppy5iaSpwFp++OeIGkTgsIW8PiC+BKg
         e7UaBYWcod/U7YkczXPo+1MCeZ6mLwdStP4B90gqfZYJ1sxs0fDs9ffsYOCQWUWRxWgt
         PVYkfHaFniVufjvw5UDwTpeWRhdHdh3FpJXGGUmx0ycG6aHC6J9bY0rp+DLAzRH3xFzE
         wfCQ==
X-Gm-Message-State: AOAM532Aw1IxaHcLXiziReqw/O2EJqGmHpNfTIlkwpV7kzOEEj2FD2mZ
        K2+qIisoRNatVfQijPJYiNV3zA==
X-Google-Smtp-Source: ABdhPJwusXND+YHpZp1RmnFVhEwpbuM/NlMKHM2MGpjzFDgDQ3c+Hcv9+Wl7u1X1+Vn/e2JXyCEiMg==
X-Received: by 2002:a17:902:ab98:b029:12b:acc0:e18c with SMTP id f24-20020a170902ab98b029012bacc0e18cmr847025plr.10.1630521151949;
        Wed, 01 Sep 2021 11:32:31 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id t15sm217159pja.1.2021.09.01.11.32.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Sep 2021 11:32:31 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <D621A2D5-954E-4CEC-94CD-CB4D6643934B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_112E4B44-E5AA-476E-B4FB-7A497A760CDA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC] replace revoke hash table with rhashtable
Date:   Wed, 1 Sep 2021 12:32:28 -0600
In-Reply-To: <96FE09AA-171C-49B1-B434-505C15FEB435@whamcloud.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
To:     Alex Zhuravlev <azhuravlev@whamcloud.com>
References: <96FE09AA-171C-49B1-B434-505C15FEB435@whamcloud.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_112E4B44-E5AA-476E-B4FB-7A497A760CDA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Aug 31, 2021, at 8:49 AM, Alex Zhuravlev <azhuravlev@whamcloud.com> =
wrote:
>=20
> Hi,
>=20
> Not so long ago we noticed that journal replay can take quite a lot =
(hours)
> in cases where many journaled blocks were freed during a short period.

It may be worthwhile to mention this was a case with a 4GB journal size.

> I benchmarked hash table used by revoke code, basically it=E2=80=99s =
lookup+insert
> like jbd2 does at replay:
>=20
> 1048576 records - 95 seconds
> 2097152 records - 580 seconds
>=20
> Then I benchmarked rhashtable:
> 1048576 records - 2 seconds
> 2097152 records - 3 seconds
> 4194304 records - 7 seconds
>=20
> So, here is a patch replacing existing fixed-size hash table with =
rhashtable, please have a look.
>=20
> Thanks, Alex

Alex,
the patch looks good from both a performance standpoint, as well as
a good reduction in lines (and possibly memory, for the cases where
there are fewer entries in the hash than the static table size).

I did notice some lines are using 8-space indents instead of tabs.
That can be fixed if there are any other comments, and you resubmit
without [RFC].

Cheers, Andreas






--Apple-Mail=_112E4B44-E5AA-476E-B4FB-7A497A760CDA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmEvxzwACgkQcqXauRfM
H+CjwQ/+Iegi87BY3W1p9e4yC4o8HiCRo4hXAE2hxKVzH1OIwW0atb0wMacNN376
+zFxb5JU6CnIpGnOumzqggmsQ7AVzUwu0E8R8/jYpV8jUoC2/iCqKpkF3HiJAg4U
L2SOVYTptVHJPG430kuOO28dQnzKpx5jPNRGrWCc9kttiT5YZfShF7jVP3iyfpL6
qxKr/IgrRDaricIZ/aM8gVJvETW+ClkHA/QSl2MznQ5leNyREIID5BBwaF8ZKs33
NxQ5Bc7oAaYm5XIkaMsDY4cf4ZWF8jI11Qx9oUrdPiygZzIDvVv+IvF+fCzF+wbk
sgYbxq3bp/kVn3zXlpaWOdOQzG5O86OgR5yhv6Jn94cvGeVvkfkuUQWq9peG/Xqt
QDv/gaLwjJkTkgNC8s7QvwjzRWqOF31kJJYPI5Xe834m8iMrs3thLMyjylX7eCWx
1bBpoFUkPtaGIAkjNh7Rn6kUSTKF6ZcFw0rNWGXr13FP+ZCeu6FiDs7I4We2XBE4
RoEVNJ/5XlRHHz6Ciz+FPFDVkO3nHMBKLyXj6WiE/GHgbd1r14LwQd1r7FIQgLLn
LggIavk89WTkufSHki1B3YpDc3VXXrA7dPIJokZ28HsPU+fQ+RNEicSTyT2ePGsn
sXEPEvyUddKPm8m/zUgFJuVfYwV5HX1C6ij6dMe3mhPmYzxP6WM=
=md+S
-----END PGP SIGNATURE-----

--Apple-Mail=_112E4B44-E5AA-476E-B4FB-7A497A760CDA--
