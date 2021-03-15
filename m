Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C1F33C71F
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Mar 2021 20:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhCOTw5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Mar 2021 15:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbhCOTw0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Mar 2021 15:52:26 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD06C06174A
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 12:52:26 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 16so7277274pfn.5
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 12:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=/PS79nxD8r7ohwoB69Y1qVrRHWHvME7yAAmSp2KTntw=;
        b=fb5hGKXJu0Lvwhukp4bBI3Q8w+vPxMPJAYveP1bDAcehX1zjLuV7rleqhLlYvrwbDG
         cC4oNWKYXpznuSjIyFi6i1iOKvXB1lZheCrNVRQPRUyX1V9Pz0WnBn2xviU/hcboTV8Y
         huMJdmUgosrNdVzNu1DDYjlrfG/ZigE/0vBrWgzmmOpAfw00jeCwz7HvR3dQRMMGQzUv
         QbsnpdEn6ZsXahhP2Wbb3GHiWk399Zv1eCS7Wan8AgCxp+P0IuqsaIJzqb2DPSv9oggw
         qmu8L7WwSnvBkCFBVrBBrqaxZLExL8vImctMMXtVbCBxDGUYCfl7PsnZ9jEKvp8OEzXS
         EalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=/PS79nxD8r7ohwoB69Y1qVrRHWHvME7yAAmSp2KTntw=;
        b=nhf08cTbEqLzvBhlCqjbJtHxkCUoKcbV3KGIoXwORdOrgKmkkwapUVvS3FB3EhN9Xn
         1Vjw6xyXNpMPEo9gNMa0uX+OQ3FvUBrvqHjhuCqADSRgW+iKr5tjh9rlqRVh709L1tSN
         4aVUFOT8KlFZ+ZPSsQ0IcQCZCryocu5T3ytzsxIQPOIDwPloDbKCz++Ji+Inxt5jNI0z
         MLWdWqaOAht3K5BBYqoCSDC3J7QIR70TPLdZnyb9IODgAZdmktzATFitlNNMQ3fz3SCv
         dVYNy+H6ytga6kiuYPevQ/R6YVFm2zt4271hCromrOcRR3lWhfp0t5TkYmWGlyZoYc7d
         aNWA==
X-Gm-Message-State: AOAM533MN+8oe91CRZXN9YuMSw7l/tRgbOuDcVTVd2WxPWaJk0j0TGz3
        KN566eSzIX8q3ev9TLZIyo6J1w==
X-Google-Smtp-Source: ABdhPJyNReUtr1JuhwBFbbGHANCnDLQZcM1c756WU7TG0fEbna2ux1ntbxz6tK8XrFQ7eYlbO2eQyA==
X-Received: by 2002:aa7:9081:0:b029:1f9:26c9:1609 with SMTP id i1-20020aa790810000b02901f926c91609mr25728958pfa.54.1615837945705;
        Mon, 15 Mar 2021 12:52:25 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id r184sm14163622pfc.107.2021.03.15.12.52.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 12:52:24 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C365A06E-B5FD-46D6-8B1C-6EC91B4CB6EF@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_CB8C92FC-EB48-4063-BDBB-F8DDE775D396";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Block allocator improvements
Date:   Mon, 15 Mar 2021 13:52:21 -0600
In-Reply-To: <20210315173716.360726-1-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20210315173716.360726-1-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_CB8C92FC-EB48-4063-BDBB-F8DDE775D396
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 15, 2021, at 11:37 AM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> Created a highly fragmented disk of size 65TB. The disk had no
> contiguous 2M regions. Following command was run consecutively for 3
> times:
>=20
> time dd if=3D/dev/urandom of=3Dfile bs=3D2M count=3D10
>=20
> Here are the results with and without cr 0/1 optimizations:
>=20
> |---------+------------------------------+---------------------------|
> |         | Without CR 0/1 Optimizations | With CR 0/1 Optimizations |
> |---------+------------------------------+---------------------------|
> | 1st run | 5m1.871s                     | 2m47.642s                 |
> | 2nd run | 2m28.390s                    | 0m0.611s                  |
> | 3rd run | 2m26.530s                    | 0m1.255s                  |
> |---------+------------------------------+---------------------------|

IMHO, it would be useful to include this into the 5/6 patch commit
message, so that it is available with the patch in the future.
That will show the workload and basic test environment used to
justify this change, in case there are problems/changes in the future.

Cheers, Andreas






--Apple-Mail=_CB8C92FC-EB48-4063-BDBB-F8DDE775D396
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmBPuvYACgkQcqXauRfM
H+CfmQ/9EeQ6wJd9v13Pj7JnxYJ6hOfbZ6ZPgxS+amKc4y4fxGsgbjOwThzcZ7S3
6iwwPTUI26CrBaeOLazkEhFryYdRkZYekP6NDSJEmxVTKdDeLZs+KyjkedxmpSJ9
RkD7RwK2i8leksLQcomVpKQEzi2PYvkFwuLzve6ltANVgyK081sIqIWbfqe5//Zf
HEEaex9Ip7XGv9KUH1B+5P1DyfLZqB//glcPpJmYTGw/zNS7QE2VyB1/K3OM+0XX
ndtqTCcj57ciCl4U5B6jhJdvI0y0uCJpJRsTQyuD4wT6Z34Xp2gvdzREZCaBdvVP
A7yxvnIl8DR9q2riK2u5e6gOytj985/MSfsEXPirOVxsi8olRU8geRsrbzpqDxme
ZvQ+6c+9ysVfBSqR+B3G6U/HT2umZYWPa+IC+Il+7LdG151jJClYSSyAu76dOF3b
DCF4Yk/mLL/hNNdXeAdD2DkA8Gxra6BfZs+spX+BEEUYbTKXzm5/9/QbI2MfXQKG
dQzX/TD5Kfihga2X1KRqBLFSISw9d91L55IPYp2qbpuLTSB+9dV4mw3kS43Dcpqv
+mebHbgSXQ8Ywa5CLVHhC5Ocqu2Lxhcg4CKCG94KW/CK9CHTixrmW7y/4WTG28ey
5wv2EYm4TsLhLG+UHOuoHIfvvASvR6de9lFnXTijhUTIhs4sB1E=
=6Rag
-----END PGP SIGNATURE-----

--Apple-Mail=_CB8C92FC-EB48-4063-BDBB-F8DDE775D396--
