Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F159C781
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 05:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfHZDFm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Aug 2019 23:05:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42367 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbfHZDFm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 25 Aug 2019 23:05:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id i30so10785890pfk.9
        for <linux-ext4@vger.kernel.org>; Sun, 25 Aug 2019 20:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=2n8AFGb1haPv4O5LvrHC2E9r72jJ24DzV0ZxWr0N0U4=;
        b=hfnl4AM0Ia9/R09meSEARjLcj1PwH3bBLmLkPfBPqITNN2EZQIaFMVy+ArarSIl+AZ
         i9qyDivlWJNPCRHxdPnHTsMvpQpL0ld4Bqi9mbm+1/5wrvJOT74+anbA9PTrWJsyrmBc
         qtoik0reiljuyZv8qViTU+BP44QbyVFSErsKEphnHrDrAWraLgOD61ErUruBX9hPK8B1
         XgdtNqhql+hGU8MBSk3JzSm5d0BdZ9yvvZWIMxM6WqSpS982tPF5eZqJkRX602GU2djm
         COVczBTEk+z9Hdr5Lgg44OPN/X7AAvyAlOQv3EhvZd0MSRc8KMWPpDilmeSiCBa8LaVe
         eXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=2n8AFGb1haPv4O5LvrHC2E9r72jJ24DzV0ZxWr0N0U4=;
        b=A4LntNTW2ye/RWfHS/fvmV4zyFcoQb1AKIZCua/SO1wStxg34Z2mDu6qFuNLj2VkJt
         7HFRlNxLemqlNP0ilp3AB48JzEPveXQBoaHtanxql+XsSFf0zmve/iV3rjjvfg5YbfQi
         bvaHvElcppwer4EAWyLa3sPLOjXTlLlCV/karIQQ2xDAtfQJJ4AgejtfZkxnMMCeV0JB
         qCIQyraQoTUp3kprCppz8EC0FVaYAUwh5SpmpIbRBnUlmUjjR0LIZQpr0KJcDRqHHSz+
         KVgDwOkC5STbTmm8tlRBvDA8MkKROO92JTBZD8Ui0pqDIOvv06+Dfk80Z1qdKya5+rQr
         7t3g==
X-Gm-Message-State: APjAAAWZZpxSnxwN/FKbrpUZ8EhbcFJ/E98Ga+ehHaXAjX1cP3UDqHiU
        lGvlvw/hzncwmBmAN7hMe4H60y9o4F6t4w==
X-Google-Smtp-Source: APXvYqx11XZSNKCAGApcwH4yvyro9Pq8Vet9EiCAY7++Ma48DVZdZc0bnanGO5WpKMO71jyR9uMV5w==
X-Received: by 2002:aa7:8c03:: with SMTP id c3mr17577111pfd.139.1566788741628;
        Sun, 25 Aug 2019 20:05:41 -0700 (PDT)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id d129sm9409948pfc.168.2019.08.25.20.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 20:05:40 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <FF31C738-6B87-434B-9736-76286ED0F8E3@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_2D7617C9-7671-4181-8623-2CDE31F792D1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: question about jbd2 checksum v2 and v3 flag
Date:   Sun, 25 Aug 2019 21:05:36 -0600
In-Reply-To: <CAPLK-i8xE4n8BJ-Beu0f80PC2W6b-A30nwcz+V_bCb_iAyB++Q@mail.gmail.com>
Cc:     linux-ext4@vger.kernel.org
To:     Shehbaz Jaffer <shehbazjaffer007@gmail.com>
References: <CAPLK-i8xE4n8BJ-Beu0f80PC2W6b-A30nwcz+V_bCb_iAyB++Q@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_2D7617C9-7671-4181-8623-2CDE31F792D1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 16, 2019, at 5:55 PM, Shehbaz Jaffer <shehbazjaffer007@gmail.com> =
wrote:
>=20
> Hello,
>=20
> I am trying to understand jbd2 checksumming procedure. I reboot ext4
> in the middle of a metadata intensive operation using echo b>
> /proc/sysrq-trigger. I see that the journal gets replayed on next
> mount using prinks in jbd2/recovery.c: do_one_pass() function.
>=20
> I then corrupt intermediate metadata logged on jbd2 and I still see
> the journal being replayed without multiple error messages which
> should ideally get printed when one of the two following flags -
> JBD2_FEATURE_INCOMPAT_CSUM_V2 or JBD2_FEATURE_INCOMPAT_CSUM_V3 are
> set.
>=20
> I have 2 questions:
>=20
> 1. Are the two flags: JBD2_FEATURE_INCOMPAT_CSUM_V2 and
> JBD2_FEATURE_INCOMPAT_CSUM_V3 set by default? If not, how do we set
> them so that the journal will detect and respond to injected
> corruptions?

See set_journal_csum_feature_set() for details on how these flags are =
set.

> 2. this is very naive question, but what do compat and incompat
> options mean? If flag X in incompat is set, does this mean the feature
> does not exist?

See description of the compat/incompat/ro_compat fields at:

https://ext4.wiki.kernel.org/index.php/Ext4_Disk_Layout#The_Super_Block

Cheers, Andreas






--Apple-Mail=_2D7617C9-7671-4181-8623-2CDE31F792D1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1jTIAACgkQcqXauRfM
H+CSuw/+L6P9LCAX8Ops0SwB3z0BRzmJ1AQAOjexJ0sAbu86uFz8rdSGhrWo32H+
J/sPn75DNkXeZemwIm5luN3Mz17SpVCTzSzicGqmc8c+ULOWAM4fUEmGSPxWNFXC
oaUfUHzD1HesI1XsU0kHbFeyJj+dLquKv6JM+V9fx/nPDfiNK2vtqnazqIovV05I
2ylNwn2aYbHoUNszjCHwe15MIjE2iWF1VNFeQ+lKLgBhY76iKA/nVIStx54I8R5B
xzpFIrXed+OQRMRYF05n4oQu7WI5tFOCD2v/x1iGmwKJ4q7KnN/RkA/C9VqGyU3d
NC6ucr77wzu13EDOviwdku5KSYIu1ezf3WuO9/3puyt8BTeveKVnFeCkr1MYOTW2
IRYE/yIEm0qPIqRlRoLZXq+sGRlv5GpajhkHtG/GxmlZOqPhP8p08bqll3pFi9xW
gzNPgKHlWHnTjzVNqq9ElkxBTU8bW8RGypDmF0h+9nBsBH9nG2g76RT766d+2VQU
NGIANP6e6D1y2F1XjscKP+lPhkYLv9vF47fewkwrufIz0p6C6zQpnb1OVzfJgcSp
/EycehQyzXluN6P29oqKsHppMCHhYgp/z+ds4DOx/tQ2Pqf5692N3vG54tNKeZYK
YczribrV7cqtthHiZWyq3mJ3VxT72Pf5S1h97BZVdxsQryzTS0k=
=wr7g
-----END PGP SIGNATURE-----

--Apple-Mail=_2D7617C9-7671-4181-8623-2CDE31F792D1--
