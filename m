Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580076AD132
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Mar 2023 23:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCFWJb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Mar 2023 17:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCFWJa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Mar 2023 17:09:30 -0500
X-Greylist: delayed 434 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Mar 2023 14:09:28 PST
Received: from gimli.rothwell.id.au (gimli.rothwell.id.au [103.230.158.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C4F3A86A;
        Mon,  6 Mar 2023 14:09:28 -0800 (PST)
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.rothwell.id.au (Postfix) with ESMTPSA id 4PVsxT2rNJz10D8;
        Tue,  7 Mar 2023 09:02:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothwell.id.au;
        s=201702; t=1678140128;
        bh=CT3TMcpY6lA0teNpfbCN+jQnW4E+gRCV+4UTTjMGssc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lnIMNfLIUI7olNLDKs9n+tXXOi8l7ihqREx1UhulmGiXDoQ11PR1r+P1Et1pck5kh
         YEfAWenwbH616KGWrC10Feqk9XWjVtzo4p8sHbV1mSSRMcsWlCBdreo/w91nIEA/yQ
         CybzKjirCMvMcAx5dEy/2vHq7BKbSt266tIeBbHBo6HhYYXLqd+JMsd/s9VP2POfuK
         bTHdZsqk5sG8L0OXGksmFi572maPf8/gMr8arwdGMeu2zse4/ni3TaiOGG36D4k7NB
         VpcHZAUMecXBk/RRhY6Rw0lLKmbhXBS3XLZCbxPjkAy9sLTEvHAhbzJenE4gP6K57A
         E2lzj/xiwtoAg==
Date:   Tue, 7 Mar 2023 09:02:03 +1100
From:   Stephen Rothwell <sfr@rothwell.id.au>
To:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        ext4 Development <linux-ext4@vger.kernel.org>
Subject: Re: The state of ext4 tree merging (was Re: Linux 6.3-rc1)
Message-ID: <20230307090203.56c41488@oak.ozlabs.ibm.com>
In-Reply-To: <20230306124134.hmeuvjhihs4ubpmz@quack3>
References: <CAHk-=wgr1D8hb75Z+nn+4LXUnosp0HM+gP+YJEcEav1DgTC=Cw@mail.gmail.com>
        <ZAVbZJSyOdF0BxAJ@debian.me>
        <20230306124134.hmeuvjhihs4ubpmz@quack3>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/azmCj37hp48XC88B.Q0BoGS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--Sig_/azmCj37hp48XC88B.Q0BoGS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 6 Mar 2023 13:41:34 +0100 Jan Kara <jack@suse.cz> wrote:
>
> To be fair, the data=3Djournal cleanups got held back only partially due =
to
> the merge issues. Another problem is that they somehow make problems with
> filesystem freezing in data=3Djournal mode more frequent and we wanted to
> understand (and hopefully fix) that. Of course if Ted could look into this
> earlier or I could earlier debug these issues, we could have merged the
> cleanups but that's always the case that you have to prioritize and these
> cleanups don't have that high priority...

In that case, it would be nice (for me at least) if the ext4 tree was
now reset to be v6.3-rc1 i.e. get rid of the duplicate commits and the
new stuff that is still being worked on.

--=20
Cheers,
Stephen Rothwell

--Sig_/azmCj37hp48XC88B.Q0BoGS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQGYtsACgkQAVBC80lX
0Gzs2wgAjNS8RWpLPCi6vkgiXrAVXehIVNeARS5omvrCfoPz7D00jC2QkzjfjV69
IskkliLupht9ZvOllPkerP5ToqZSof+qDQZBJqGUkbPnK/+jnq1mvPn1OLdjYR6A
7PBWiBhcJ3nyU7wxLmdu5GPt1ETViOgWl6SM7Cj+y482kfM0+OiTbdN8Xtfyj8rD
i0Z7J50DlFFq6xqKCPhUvZiYj1L7L1vHX3klSGbjc3AW5VFjkJfJXELUS0P4foOu
v17o7RbnjlA1UMFFdXQyNg9PEG4lf68vNUmiKR6MW5KPzJ0i2BDuRpe77plBzE1o
gBaFfrT0rplyWiWfJHBWVi81NFohJA==
=z0a5
-----END PGP SIGNATURE-----

--Sig_/azmCj37hp48XC88B.Q0BoGS--
