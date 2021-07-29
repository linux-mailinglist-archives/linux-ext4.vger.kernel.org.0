Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F783DABCC
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jul 2021 21:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhG2TXo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Jul 2021 15:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhG2TXn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Jul 2021 15:23:43 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A19C061765
        for <linux-ext4@vger.kernel.org>; Thu, 29 Jul 2021 12:23:40 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id l4so8970507ljq.4
        for <linux-ext4@vger.kernel.org>; Thu, 29 Jul 2021 12:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aUdU8xR7rdXOgEGrC/U5N8QhGqpqFhUfoEMVucqBeLM=;
        b=o6t/MfO1mxi0sC52vq8iBtiML/Vzf2lkSAENOnPIwluMKS4jq+s6nvPu8Ksp2TckYc
         k7tU0HJ+KBzo37NQMZ8+ZTgoTo8SdKobNXWfce6IDvzwMMTVZJS6h5fx7Cim8RHwSwx6
         A72XCoPjoo149Aqt0TGAG145vhlzHDBz4ypcOLGpBgiH+vlbabiGfl/cHySXjZNw9er/
         p2N/bvemxHrZ866CCokyYiauWAZ1M/SyrxPYAcxClEL3qfEixClLR6fGAmC+rlNZixZp
         DTyfkmapRLHznAvqsM3I30ydRtrLPTR/fdnSoG60RRxmHNeCnMOCGo77UltCyw2DhTxl
         pjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aUdU8xR7rdXOgEGrC/U5N8QhGqpqFhUfoEMVucqBeLM=;
        b=exLaA0/YYGlaSq/knFfMmlhE6Y2HyiO1unYRvtT3KIQFqykKlHP2hkKcMz0fuwW1LD
         14X6WPv0utycNWA/rUWN7ZZBdTdNFK93ydQZ5tjdtYE/4kqiuPvYOhmzAFICMitZpuhn
         PScvMROx2jcER++bdks2PqufHH7p0Ph0LInOmG1g+Da8txovQMKd6gswvAsQvyJIyKUl
         Sqr4AwiX3BSgD7CPh8tHD+jfzGIw3guEze492Zu9hAUjYJl7emoNRSnmMKS/WLEGiuic
         B6TBl6UeFD8zC547NdmjDHiZ7APs7fDQo9ZAen6cdWiJ4wqt8VDjilRkLWLDof168gNf
         Ku1Q==
X-Gm-Message-State: AOAM532f+q3sJGJ6pRnGS3P2rQbQtix/pdy1wKay0pmpNt4N2qwTpG/p
        6V5UgTKJAzz+QeyN2jQ3gkHsHGPyCS5yFw==
X-Google-Smtp-Source: ABdhPJxoM+HVF3m2VjW3YipTUk4MkkZq/bJEzg5AyE9H2buOJUGMippq4ybZ/FGzVuapQB/5uwXO5w==
X-Received: by 2002:a05:651c:329:: with SMTP id b9mr3875470ljp.116.1627586618407;
        Thu, 29 Jul 2021 12:23:38 -0700 (PDT)
Received: from [192.168.2.192] ([62.33.81.195])
        by smtp.gmail.com with ESMTPSA id i16sm378830lfg.139.2021.07.29.12.23.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jul 2021 12:23:37 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: bug with large_dir in 5.12.17
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <YPl/boTCfc3rlJLU@fisica.ufpr.br>
Date:   Thu, 29 Jul 2021 22:23:35 +0300
Cc:     linux-ext4@vger.kernel.org, Theodore Tso <tytso@google.com>,
        Andreas Dilger <adilger@dilger.ca>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5FE9762B-6C6B-4A44-AC99-22192B76C060@gmail.com>
References: <YPl/boTCfc3rlJLU@fisica.ufpr.br>
To:     Carlos Carvalho <carlos@fisica.ufpr.br>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

It looks like the fix b5776e7524afbd4569978ff790864755c438bba7 "ext4: =
fix potential htree index checksum corruption=E2=80=9D introduced this =
regression.
I reverted it and my test from previous message passed the dangerous =
level of 1570000 names count.
Now test is still in progress. 2520000 names are already created.

I am searching the way to fix this.

Best regards,
Artem Blagodarenko.

> On 22 Jul 2021, at 17:23, Carlos Carvalho <carlos@fisica.ufpr.br> =
wrote:
>=20
> There is a bug when enabling large_dir in 5.12.17. I got this during a =
backup:
>=20
> index full, reach max htree level :2
> Large directory feature is not enabled on this filesystem
>=20
> So I unmounted, ran tune2fs -O large_dir /dev/device and mounted =
again. However
> this error appeared:
>=20
> dx_probe:864: inode #576594294: block 144245: comm rsync: directory =
leaf block found instead of index block
>=20
> I unmounted, ran fsck and it "salvaged" a bunch of directories. =
However at the
> next backup run the same errors appeared again.
>=20
> This is with vanilla 5.2.17.

