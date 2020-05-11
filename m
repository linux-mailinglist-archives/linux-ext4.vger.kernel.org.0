Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755901CE53E
	for <lists+linux-ext4@lfdr.de>; Mon, 11 May 2020 22:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbgEKUTL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 May 2020 16:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKUTL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 May 2020 16:19:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527DCC061A0C
        for <linux-ext4@vger.kernel.org>; Mon, 11 May 2020 13:19:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s11so1576069pgv.13
        for <linux-ext4@vger.kernel.org>; Mon, 11 May 2020 13:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=50uPFL9EtfMDIgMPpMqc3z4HyaE85Elt4UROEaPJ+2c=;
        b=LgHjMGLo2UuqqVSzzMBjFP5+OR5xy7EC+VSJEihLEGMc+AOWtJo6vv/c9UlU/+SNPe
         baf3MEbARBVgTFSIuICx5T0jeWl6sH4ADiY38N2nFHNXGnWsUAub0iwGWgcXTSBvS+w+
         LrgvsWiAolCZUOfomD45T1Bi4ICNEHFoatfo3qV4dhIoe+YKYtutTdS0rrOl8QBClLcu
         YViOLzPOBcxvGMVv/4roV8fm7TEI2Hc1ck12Cz/7jOOgoMDcRCkBoLf1Y3bfOsN1kU0k
         X7lPN3JJ2jVLooc0IVWBZLBVjoCr7Gcosk/7Jq2JCcHfd907f+18ZTyPXpm9zrVYABrq
         A5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=50uPFL9EtfMDIgMPpMqc3z4HyaE85Elt4UROEaPJ+2c=;
        b=Zvh2TTJoC9miz7qNtRKy1cZ/fSBeHDDp8TgvfCjZH2yS5eOAyjhu2vmnQDuK4bIDVn
         bPIANWK5ekyJuvMiJw0au2TPafI9hbS1P83FQ4pIv/HCnfXov/pbysJF5pHj3HPk+cgQ
         M6xfgkxE00AjVEVQkDyfJahFOC2SCt7xWJmj4qUiI3yM5MOpnQhupjhOytnOKZanE22H
         OVv9XSK/DD8gCjuu47zGXjgrzQSGqEf4KWBK+3wYatJl8DIZhbSXYIE41MtFe3H6Wz+r
         v/PSdKxcNcqxO2YaxOqy04chn9b8Jg518/MXEa58kSy29zZN0KPhmYxs7Qu9kXmHF06A
         H5aA==
X-Gm-Message-State: AGi0PuYtahB1OWJsEWx2k0RhVcg79qAd/oOmwO8edu5Y0hp/bDUeLm+r
        edJPkQteI7wi7O3URDjraeqp3O7vdIR8wA==
X-Google-Smtp-Source: APiQypJfoqqfyQuhTk9k7WEza7DcJC0zSHl0mzCYpJkbFgMVs11Y3e6f9yOATdXte/Dl/Y27ePhRIg==
X-Received: by 2002:a63:5320:: with SMTP id h32mr16301345pgb.28.1589228350640;
        Mon, 11 May 2020 13:19:10 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id m63sm10210541pfb.101.2020.05.11.13.19.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2020 13:19:09 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <3DF89355-488D-47F5-857B-3B75D4E89AD3@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E97399A6-AA4C-4985-B73D-29C7E126622B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] /fs/ext4/ext4.h add a comment to ext4_dir_entry_2
Date:   Mon, 11 May 2020 14:19:06 -0600
In-Reply-To: <5b9bc322-fe02-72cc-9aa7-a27b26894ce0@jguk.org>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Jonny Grant <jg@jguk.org>
References: <5b9bc322-fe02-72cc-9aa7-a27b26894ce0@jguk.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_E97399A6-AA4C-4985-B73D-29C7E126622B
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On May 8, 2020, at 2:36 PM, Jonny Grant <jg@jguk.org> wrote:
> 
> Please find attached patch for review.
> 
> 2020-05-08  Jonny Grant  <jg@jguk.org>
> 
> 	tests: comment ext4_dir_entry_2 file_type member
> 
> Cheers, Jonny
> <ext4_ext4_dir_entry_2.patch>

Hi Jonny,
thanks for your patch.  The patch itself looks reasonable, but can
you please submit it as inline text next time.  To avoid issues with
whitespace formatting, you can use "git send-email" directly from
the command-line after making a commit with this change in it.

Also, the subject line of the patch should just have "ext4:" as the
subsystem, you don't need the whole pathname for the file, like:

    ext4: add comment for ext4_dir_entry_2 file_type member

Finally, you should add a line:

    Signed-off-by: Jonny Grant <jg@jguk.org>

to indicate that you wrote the patch and you are OK with others using it.

See Documentation/process/submitting-patches.rst for full details.

Cheers, Andreas






--Apple-Mail=_E97399A6-AA4C-4985-B73D-29C7E126622B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl65szoACgkQcqXauRfM
H+D4xw/7BbSbyLelhVI//5yx9zK5xX5L/Tjj4ed/EwJRk32Pa8CmwUa3hASbMhRz
31a9pDGq2X1Cb5bgZbRjdjIhZYW8V6h4ukjmUssIj6QcjFo2PFUoJqJy3Qfxl8He
J4d++iHSTEQbs6EI4l9BmyHCowWjxJr7IrCnJ0JirzQRH83QoVE0+Rz4hKsh61/4
x5ihL76qdYgtJBXVF+020sbOZR6mPra6UNmq0zGSD0aX3srPplrzmgptc9Fc6Yvf
HdTyxMqViLqZcOUaeTgKWBS0YnjMYFHQmyA8KBnrahUZZaBm2erk9/Xf9aamrHHE
gAdyjZ5PhiMgq2dxPv5bRqISE3EU27VKPitCIuOeEfMtrLp4VOViEBCxAevPkwSx
UEDD10J5Kehc468MMYtuNE6JFHct8Iiy5pK5is9/l7VwTv0026gzdXx+wuQCbHzU
HQXlLP07cr+WGn6CBoXu751mGkgpeBPTFa0eSNsW3efLitGpkOaITDjJy6AMfEKC
q+KNaWSHv8+M6o3IesA5x3kCNNJDsM7uFBNJmXAwaSgG08jzq1ZjF1unyEBufs2O
uQd1VW2ZGolSMu6OxlCqwefUVdghwtfh741/v0vBDABathey18xLgxchrH6aQNa7
373MZgFG8qo1lu4Kv5qTB2kpsmzTC/Pe+jT18wmJXim970gViA0=
=AwS9
-----END PGP SIGNATURE-----

--Apple-Mail=_E97399A6-AA4C-4985-B73D-29C7E126622B--
