Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A63221C09A
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Jul 2020 01:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgGJXNV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Jul 2020 19:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgGJXNV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Jul 2020 19:13:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D15C08C5DC
        for <linux-ext4@vger.kernel.org>; Fri, 10 Jul 2020 16:13:21 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w17so2844956ply.11
        for <linux-ext4@vger.kernel.org>; Fri, 10 Jul 2020 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:subject:message-id:date:to;
        bh=9LEsx+uGwwz2yP/pSJVU4xdqkqez6Vp/AtoMQ6PZPLU=;
        b=i2VFBxn6DnRy9v4IGAZSuDpsEUIPmAPNee3OtsyL8tQ10di1XFpRYukEOAbMBJL8Jp
         3A9h+Wg3dJ3XZ0xaz1zWe4tlzrdxQsza5bh2UCXng/8ZjmszfMvjUwXY2XN+N9k0uJRC
         mz0QVVRxFL2GwoWnHxBF5GOpRFAdB62AK+vE9B+oVdEy2caIKzUaHfOQLcp26d7NC7sh
         022C1/ETR5r0d4vj8wo3L5D4y4T/CJSqbw7FRTc92wiUGXABjHACFURwKp6VzJ97xgBd
         mRvgyMz5Mzp1K9Ld2Oc0uSYhWI/yvAmHlc8MHIK7oVpePE4R7dg++ho6tZoWXhQ6bgdT
         2gEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:message-id:date:to;
        bh=9LEsx+uGwwz2yP/pSJVU4xdqkqez6Vp/AtoMQ6PZPLU=;
        b=CR51s5jXcc4/kbszfG74kAI6ffgV3nlT30/Q7KuTfwSfI8iWt3Rz6dEiKPXJ+stzDA
         EP+seRoqy7vl2l2IsoSzmCQRGgrH04ZoQECeosaViiJIntEXlrRLMmukith6Bcjf7D7E
         0cPIP+sD2JBj0YfmrHA7l0tRCpAufz20Rwn8JVZHzr+t++pUyfVLPFUMDMUKhuRkCya4
         ZttfGNxfp/oKZyCVICL4mW0ijM+BIoT3IqOS4nsW1sa9wr4JpyhT3sPZB2OA0xau9Zjf
         rlwOEhpPAmo6YBAKg6Dkg7t2LqkfqKSbHW3WN2IKhoLujIsTrUttzLEOycYBFnjTuf9B
         0nQA==
X-Gm-Message-State: AOAM53080cupizEXWW8WSLXvCISgGGxsQBCYh1QCHbTxIdDh2IznlJwv
        kOkEad5d906AYPZ1FpG3N6obmNl1lRJ7zQ==
X-Google-Smtp-Source: ABdhPJyE7OhNsWwL07rdx3EMVYfNbBKfoRJbbFjTHYretJWgs3Oesd7q5T23fR3jl4lFqwBT6x/X7Q==
X-Received: by 2002:a17:902:b18b:: with SMTP id s11mr53366089plr.92.1594422800297;
        Fri, 10 Jul 2020 16:13:20 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id q24sm7284127pfg.34.2020.07.10.16.13.19
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2020 16:13:19 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_96EA3BE2-04C3-4E5B-8C63-7CDAC1AD9DD9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: [RFC] quiet "inode nnn extent tree could be narrower"?
Message-Id: <DFA6A826-D165-48E9-8AF1-22653A34BEA6@dilger.ca>
Date:   Fri, 10 Jul 2020 17:13:16 -0600
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_96EA3BE2-04C3-4E5B-8C63-7CDAC1AD9DD9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

The e2fsck error message:

    inode nnn extent tree (at level 1) could be narrower. Optimize<y>?

can be fairly verbose at times, and leads users to think that there may =
be
something wrong with the filesystem.  Basically, almost anything printed =
by
e2fsck makes users nervous when they are facing other corruption, and a
few thousand of these printed may hide other errors.  It also isn't =
clear
that saving a few blocks optimizing the extent tree noticeably improves =
performance.  Obviously it has been annoying enough for Ted to add the
"-E no_optimize_extents" option to disable it.

I'm wondering if a patch would be accepted to disable this optimization =
by
default, and add a "-E optimize_extents" option to enable it if needed?
It would be more akin to "-D" to optimize htree directories if =
requested.
The "no_optimize_extents" option would still be accepted, but would be a
no-op unless both options are specified, in which case the last one =
wins.

Cheers, Andreas






--Apple-Mail=_96EA3BE2-04C3-4E5B-8C63-7CDAC1AD9DD9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8I9g0ACgkQcqXauRfM
H+AZjRAAn7TJOQ/7AdjaIOnHGvOsiHxcSeyb4jGBT81lzR/3Kwm4/plLUxa216LI
ep1kPfrMUZNQol7TCC41F+R9vSKVtcF4xL4IL+zK2NT2Hpixf6oeU43Q9jkm4QSH
NoI1DAyMuziYxssoEmfWOrfZ9N4iy0UwD/dq3Fm2Mpn4ulLOsepeYFl7yciwPmcl
fJFaL0iH+4JGDWyDTkQONPgmiKQAqK4a/OnXOIZH34dbwnUmZmWdsa2QksNZ2wyr
dP0dk4/BDUfzNMbdc/0Alna25ApkXWTs9+GLa6cpoQgtmd/B6O2S0/RtdnZ4WvZw
2tw3Wh/Rg3av4XZbVpIwKTRvuFrN897GCDO5nEvd+Tegb+vSJ1PSecGNH5caPVhQ
cfANg4t95gByTRo+5MWJxy//s7X5PzNPjiavLFmvKXd8UEhiCV5Bm9zJOG9TQva0
y9GBdjLM0PT9TOXJPorKKkh6kARnqHzhaaMjEF6+qlsRbPxeohOHV7ivHTShMKcd
fVSINwMf1aJdJCRU55+y0NlGfyj1kksAnfkt0gHTIwpapTVJxf4LhcO9o3ZZCsFB
7ABwc/19Ng5kgWaFtoz1knIR3S5AiclOu4kvHwiwEWJD6xzZJ6UQPXmOweUIfUWP
yamyJ7rJMZO/vSHR0RyX8s+q4vyIlzufY8Ttwl+8epcnpwoPUnY=
=jId9
-----END PGP SIGNATURE-----

--Apple-Mail=_96EA3BE2-04C3-4E5B-8C63-7CDAC1AD9DD9--
