Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F0B27BADB
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Sep 2020 04:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgI2CeM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Sep 2020 22:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgI2CeM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Sep 2020 22:34:12 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5BAC061755
        for <linux-ext4@vger.kernel.org>; Mon, 28 Sep 2020 19:34:12 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q4so1860677pjh.5
        for <linux-ext4@vger.kernel.org>; Mon, 28 Sep 2020 19:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=bSq3833G+MbQtYzBgJDhmNpqCn1ALFJyhwMvof0sBIw=;
        b=avwnLj6pWWc+otDozqeIyVczTgL1Li+IX2pS+REvVawRAY7j7fjCE42DPivcKlsOHR
         cJIRhNyH8ZeSRt55Ez4MvuM1jR46d+8Nc8MjdIaxUMyks+CoQRrPNNYj04mv8QKMI3hz
         M+aA1OaQDsCfPLM0x1TGlA3yTD8gmPFiuk0v+98m+2qXvgAyNQydvBPHRTVkrC5tzTK5
         8HEiQkAAs1pIcAAjGXT0imYAHnTWweRlC0P5zILuSyL4oAfjtUfEN3+FHwDvphdpV1Pa
         DLMP+oLBFl7TenOVoVIsyeLZ8vJu0p3BLqr5OBVtH86qHeC7FkpdlOJpPWHxBTQEPRFJ
         nEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=bSq3833G+MbQtYzBgJDhmNpqCn1ALFJyhwMvof0sBIw=;
        b=KesVwSEmPU1hV5s7F7R+4Si2DmWTYIMbRWr9ykV5CFZCY2Sxmg0T/PB5SnWw+ilBhe
         CZX1OygS2+lTK2GLEiixvJh631QKRhNWQ9G0S/dveZ43+TgAk2PtmoPje7qMQDCBkUO1
         eRlmvGwjPmX9Znqwkb0rxt5ad5Sx37nuixLdpCw6GKxmt09ocvj4FN7cRxTZ5xSvhmIZ
         DZdqrtFgNz8IFfatmYNn1iXWeYVDvS9YvCvOCiEPkyHWqOcLOMETqSqs73B6RYrrgBEY
         6RXtwf03RQZmwKb7Y+grDHLMV2rjHMtbXuce9WlczzGhtyWnDwwbvoRis9bnkqrRx5Nh
         C/WQ==
X-Gm-Message-State: AOAM531IW4fp9zvv0lyoQthydB6v7CE3U3uycnWSUVSJicdRkHZTYXTW
        cvHkigDo4nNbexHhJD44aDkWaQ==
X-Google-Smtp-Source: ABdhPJzxxEepfiw1/uSSYqnHmw4lawKHHlsXvLC7sucF/e1drXYcqaT0vnA3Jd87h0sRxDAgmRihfQ==
X-Received: by 2002:a17:90b:ecc:: with SMTP id gz12mr1769695pjb.219.1601346851497;
        Mon, 28 Sep 2020 19:34:11 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id l188sm3168808pfl.200.2020.09.28.19.34.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 19:34:10 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C091902C-F3C9-4A8C-8704-DDB321FAA317@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_145085AF-F63A-4E2D-B223-D502EFE71B08";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH v4 3/4] ext4: data=journal: fixes for
 ext4_page_mkwrite()
Date:   Mon, 28 Sep 2020 20:34:09 -0600
In-Reply-To: <20200928194103.244692-4-mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
References: <20200928194103.244692-1-mfo@canonical.com>
 <20200928194103.244692-4-mfo@canonical.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_145085AF-F63A-4E2D-B223-D502EFE71B08
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 28, 2020, at 1:41 PM, Mauricio Faria de Oliveira =
<mfo@canonical.com> wrote:
>=20
> These are two fixes for data journalling required by
> the next patch, discovered while testing it.
>=20
> First, the optimization to return early if all buffers
> are mapped is not appropriate for the next patch:
>=20
> The inode _must_ be added to the transaction's list in
> data=3Djournal mode (so to write-protect pages on commit)
> thus we cannot return early there.
>=20
> Second, once that optimization to reduce transactions
> was disabled for data=3Djournal mode, more transactions
> happened, and occasionally hit this warning message:
> 'JBD2: Spotted dirty metadata buffer'.
>=20
> Reason is, block_page_mkwrite() will set_buffer_dirty()
> before do_journal_get_write_access() that is there to
> prevent it. This issue was masked by the optimization.
>=20
> So, on data=3Djournal use __block_write_begin() instead.
> This also requires page locking and len recalculation.
> (see block_page_mkwrite() for implementation details.)
>=20
> Finally, as Jan noted there is little sharing between
> data=3Djournal and other modes in ext4_page_mkwrite().
>=20
> However, a prototype of ext4_journalled_page_mkwrite()
> showed there still would be lots of duplicated lines
> (tens of) that didn't seem worth it.
>=20
> Thus this patch ends up with an ugly goto to skip all
> non-data journalling code (to avoid long indentations,
> but that can be changed..) in the beginning, and just
> a conditional in the transaction section.
>=20
> Well, we skip a common part to data journalling which
> is the page truncated check, but we do it again after
> ext4_journal_start() when we re-acquire the page lock
> (so not to acquire the page lock twice needlessly for
> data journalling.)
>=20
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Thanks for the clear commit message.  It definitely would not
be clear why the patch was structured in this way without it.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>


Cheers, Andreas






--Apple-Mail=_145085AF-F63A-4E2D-B223-D502EFE71B08
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9ynSEACgkQcqXauRfM
H+DlCg//ZgnzNQ7dy71hUok2KxfEiA3ktZyLPKjccr5Gt+OBsuQKmQBGzs9+LlzA
7+KXFJz8pmQ52pqpw3pMmhFvgYnfrRW2FyEoV1wIL/Mkk8XmGCE5sZVmmwZDFA5b
CGWWYRHPt0w81pLKO2Kr8Hmw1Off3p1EGJtBpPjCYLg08LZ8rHEIrGNSn7FDsRV6
3akvhIFN5wBBAxidM5si6GFc3lzaBJs3UfMnG0qVPxZElwnXcpTIMdsPwHKNj5p4
09ofsxfFaCSI351wt90MsO1UsWQ6GR0MOMzxPoC69H45vOCEK5bG86eKEu69FSs1
b/06vc6s870IQecdLV5UdSLtwF+Lzw+6BN7+wd4MbvBPbSCLPjLAB3wfhmTMeCRE
DQHnR+zuuKVCNi+miwhEmS7r+MIk22QZdF6dM7TLR18Js0RTXUVfUGVA8Xe8CPQs
qgzKhF3177ZcYX5AR6dUr3uX/dcAhYjbSxucGthqbSz+BrO6nUufqFDnh+veOtWC
VMmryNhs78QPpgObi46o0Il2TZ8KVXLOI0MV9qdb9yj2COt7PSc9S9zAJCH+2eGB
sY7kbn1eNdSpkSXHXODPwLTAKZYp7fgep9e4uDZdKrACsL1HK4htgMYYUg+2zUJd
TJaNJleDJcP/PUjHrmFRbUwxd37ehYFDvrZRUio6Z90catZJH/o=
=Bsxp
-----END PGP SIGNATURE-----

--Apple-Mail=_145085AF-F63A-4E2D-B223-D502EFE71B08--
