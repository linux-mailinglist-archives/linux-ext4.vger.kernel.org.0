Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B191F75BB55
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 01:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjGTXwl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jul 2023 19:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGTXwk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jul 2023 19:52:40 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE2C2733
        for <linux-ext4@vger.kernel.org>; Thu, 20 Jul 2023 16:52:35 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso739425a12.1
        for <linux-ext4@vger.kernel.org>; Thu, 20 Jul 2023 16:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1689897155; x=1690501955;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PPo83p19wj2Nu/JoWmwGqdTBKv/Me2WYrPEC1F1bR/E=;
        b=HubCPio0Fh360yXwG8jQCLkt/pbdi/Z77JMV4AjH8JUClnyIE+eSmOSOaJQtRgwv7t
         A0ebzUwT8095hwJD8wFeBo7jmdwjowcFFFRhzRdpe+8JfoI66T6NZwc0AEK6A0S6e0jB
         KjMLHQbMUxMfNxv1gJWHjPgYk7KOtxVvPkK9X430Nq6z1QL4F+88xWiY3CGINemLLmJi
         uDWNjgGepi1ebt4qtBcBR5rdSmkHxp87EEpTlNFYnXo7FDSbMufp4Da4rgnWtzabsh2c
         xBwtV11gh/pjVtb6pInCMVm+ETTwCQwFQYh+r07j2u75Ype/aLd5egtEXFbmB1Na4nQw
         BWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689897155; x=1690501955;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPo83p19wj2Nu/JoWmwGqdTBKv/Me2WYrPEC1F1bR/E=;
        b=RCGr+9/gyPN08Pz/zqLfvt5vekoVc3eN1MaeV/X7E3H9fWjdgLakvdWjGKIOG6GIdZ
         Gkg73qoaXArzFz6UL6t4wfsm7/V/fDD/MNm7QNnYTGbHJPcTyWGcSvpPuvxgxZd2dKek
         g9Df3s1cxRHK7nxSs8iH9TM1KS2691KOSKUBAIuUS/ikf/99eTDVKS5asAx+mvnKQ+y5
         2yR0uxzHMdcdEJFzii85KSxSnvLu2YWZNHxjJnJK7Tnz3vpjzCRiEPVQvTLWPHvdxaKb
         AF/iIZS71nqXhktY7eatVwI5geh0oylaxoALElZsI/rPZG01ZSs+HNcKdvr+mT4995vj
         os3w==
X-Gm-Message-State: ABy/qLYy/UV4gFTyuUWx6qZgvh3SpW92EhWtVQqfD5iAxLTCASUFv21R
        QUX9LHkIWMe8cJySUuEd3LNTNYwZeCwuHWBi5MY=
X-Google-Smtp-Source: APBJJlHeD7eEHnNgPUdrsghkhSvcZpB2l4uS8gWppMk/QxXVD7x8mqeJmQ/49gs8SITq5ukzFvOe2A==
X-Received: by 2002:a05:6a21:78a3:b0:138:198f:65ca with SMTP id bf35-20020a056a2178a300b00138198f65camr448778pzc.13.1689897155348;
        Thu, 20 Jul 2023 16:52:35 -0700 (PDT)
Received: from cabot.hitronhub.home (S0106bc4dfb596de3.ek.shawcable.net. [174.0.67.248])
        by smtp.gmail.com with ESMTPSA id w16-20020a170902a71000b001b8052d58a0sm1935093plq.305.2023.07.20.16.52.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2023 16:52:34 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <605DCBDE-A388-4B98-BF5A-38773F15E3F4@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_CEB716EB-3B38-4573-8174-C14C57FB2842";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/1] mke2fs: the -d option can now handle tarball input
Date:   Thu, 20 Jul 2023 17:53:56 -0600
In-Reply-To: <20230711235354.GE11476@frogsfrogsfrogs>
Cc:     Johannes Schauer Marin Rodrigues <josch@mister-muffin.de>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
References: <20230620121641.469078-1-josch@mister-muffin.de>
 <20230620121641.469078-2-josch@mister-muffin.de>
 <20230630155128.GA11419@frogsfrogsfrogs>
 <168836303674.2483784.4947178089926484601@localhost>
 <20230711235354.GE11476@frogsfrogsfrogs>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_CEB716EB-3B38-4573-8174-C14C57FB2842
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 11, 2023, at 5:53 PM, Darrick J. Wong <djwong@kernel.org> wrote:
>=20
> On Mon, Jul 03, 2023 at 07:43:56AM +0200, Johannes Schauer Marin =
Rodrigues wrote:
>>=20
>> Quoting Darrick J. Wong (2023-06-30 17:51:28)
>>> On Tue, Jun 20, 2023 at 02:16:41PM +0200, Johannes Schauer Marin =
Rodrigues wrote:
>>>> If archive.h is available during compilation, enable mke2fs to read =
a
>>>> tarball as input. Since libarchive.so.13 is opened with dlopen,
>>>> libarchive is not a hard library dependency of the resulting =
binary.
>>>=20
>>> I can't say I'm in favor of adding build dependencies to e2fsprogs,
>>> since the point of -d taking a directory arg was to *avoid* having =
to
>>> understand anything other than posix(ish) directory tree walking =
APIs.
>>=20
>> this is why the build dependency is optional.
>=20
> As Ted said elsewhere, the big question is (a) do we really want
> e2fsprogs depending on libarchive at all, and (b) is libarchive's API
> stable enough that you'll maintain it for us?  Merging this patch *is*
> adding to the complexity of what most distros consider to be critical
> system utility.

FWIW, I've been looking at using ext4 filesystem images as random-access
archive files that can be directly mounted and used, rather than having
application workflows untar many small files into the filesystem, read
them for a short time, and then delete them again.  That is especially
important for workflows like AI/ML or genomics that are only reading a
subset of the files on each pass.

Storing all of the small files into an ext4 image would allow it to be
loopback mounted and accessed directly without the added write/unlink
overhead for each job.

Being able to import a tarball (or zipfile, or whatever libarchive =
allows)
directly into an ext4 image would be super convenient for this, so I'd
be in favor of including this functionality into mke2fs.  I hadn't even
though of this aspect of the workflow, but it would certainly simplify
things.

>> It should be perfectly possible to build e2fsprogs without libarchive
>> as well. I copied the pattern that was already implemented for =
libmagic
>> which is also not a hard dependency but gets dlopened-ed at runtime.
>> If this mechanism is fine for libmagic it should be fine for others, =
no?

IMHO, yes, if the code is sufficiently isolated and doesn't cause much
ongoing maintenance effort.

Having just looked through the patch, I think it could use some cleanup.
Basic code style issues:
- wrapping lines at 80-columns
- avoid use of C++ comments in the code
- split large highly-indented code blocks into helper functions
- consistent indentation for continued lines
- consistent one blank line between functions
- consistent one blank line after variable declarations

In terms of code structure, refactoring it to put libarchive handling
in a separate file  (e.g. mke2fs-archive.c or similar) would also make
the maintenance easier, since it can be added/removed from the build
more easily, and (if necessary) removed from the tree if it is no longer
working.

Then have only a couple of small function calls in the main mke2fs.c
code that are accessing the libarchive functionality if it is built-in,
or being no-ops (or just printing the error message) if libarchive is
unavailable.

Cheers, Andreas






--Apple-Mail=_CEB716EB-3B38-4573-8174-C14C57FB2842
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmS5yRQACgkQcqXauRfM
H+CIkA/8DtcnQiyLoESrbVulUPYbXq5Wy+W9/rwxCQ/bXWhwfvSy3JnHBsQDzF7a
EWtkLXsLrtU7yTTyAgq2ON4afUQPQUdehqmmVvJ96OTgNmNc+Wg0mM5dUzYzVDdk
amCws6Lh285LtGDSWeqcGMAvM8DQ3Kso2jx/hHIGBAZrhFwBJXFrN92wqEcbqLLc
NxlWbLfzf+qNugm35sajRLdiqZ4fMVD3efTswQ8qLO4/ZrPT4LqawnI2/RN8XpHY
lmnidc7sGBiDVgJPtJRDqn/ki7Fy+t2qL/ZrbicMBOfkrMrAcKLnc+vMBLBjrOTX
ugFEMctDU2tqFO3D//Vj/vpaUgE40vue3T/fUTJXtUBUM26K3ai0xm4Q4NAEzhbm
oG4ElX5uqFD/4gR+/7rxr4Ouqffb3ES0ltH3ytlrP8xoPtdCNiPsGmz/BtYpF40I
HMSsiV9jsz3CbqtXAwiNRzf9qqzfECQX8VRjY40t3CzWraQ68u3wHppuAclnkVDO
Zs2uLqQtJicWUOy4q+sNUnctTjamu2NO8ypHvPj2DsqXNpZMq5d/p80hFgATQgsQ
tb4+SrbDDgL3tO+Vz7i68fII58edj/ihYiAIFcsyWq+MuXleAL9qHQPBvUZ/WIhH
GlHPr47wRwv36RtSkGZ16wGvJP6BZdQrJBPGhKhRElkYwtLlPjg=
=0Bf1
-----END PGP SIGNATURE-----

--Apple-Mail=_CEB716EB-3B38-4573-8174-C14C57FB2842--
