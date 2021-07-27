Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B317C3D6F62
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jul 2021 08:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbhG0GYe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Jul 2021 02:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbhG0GYd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Jul 2021 02:24:33 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EA9C061757
        for <linux-ext4@vger.kernel.org>; Mon, 26 Jul 2021 23:24:34 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f13so4131139plj.2
        for <linux-ext4@vger.kernel.org>; Mon, 26 Jul 2021 23:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=naM+GZSIoradFMO2mWgCMN9fx2tXj8ieLhdnF3YxW4I=;
        b=ArOus05d0MMBArjxD27SYg5vYyKCscaYqgEZPIEoTuBbLb/ysADII7NLhCcJNjA1fJ
         vuIlwF9umI8vAO+C+Pv+qI/u24QqiKjI5+0ENPf/JxMtuoe6btb0RCR81Foujk9HoR6p
         7EC4XEWZwlMWkFgLywIyotfXfh7R1GHbL/Ggm1DA3VwjWEwCpUNgHutIJs2rCt7kulM5
         l5Pdj7iVQXwRIK2+eawj+cIYXOjmZrFXrQWBxMrgK+jFYinD8jyQis2x/uRx1WkOQJGD
         0YVmxKicH/v+kG119AHob1nj03In5GbidFWn5H72apMtA6R/GOz6Wg9PSPKmuK5NOdyX
         vyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=naM+GZSIoradFMO2mWgCMN9fx2tXj8ieLhdnF3YxW4I=;
        b=HvJWW9xlkhnYF2YTrnTAbMS/USVrM7fGCSkCToytXlib+T2D4hULxEsqSdxNxIGKCN
         EWqzZtqmYTwmFIq3RvOw7Q8Ko3PQzWi2j0qNCskEb2OIj1Q0Xw1RFwwys/iFnhH9rXml
         N/kzPE20alyam5xrGdv6EOUYp9psoa/chSzYbsVwycfXn1k9JpNZYhqIogmoGOzKhHTX
         gzTuFLoDvxXhw6rkDPzs0JlEHrAXP4GJ0EtwYmCYtw8fMsrrESxUiyx6KuPqPlSDO91w
         rOgpq85CMAPIjzzrsIzOZXNhykeRsQUwmW5xjtWPAmdYz4+hXykHR+txVaBw4msW9jE4
         TO9A==
X-Gm-Message-State: AOAM533O1ob/gIgJGPG6KeECH1xcvWfFXJdcfrkJhrXs3quntvPa5MEf
        JmSd7GbCxb62TmuTl5HCn+d44g==
X-Google-Smtp-Source: ABdhPJxtZH1scIFkrn8R0J4A7F1TkNCqNw3GDFyKMcy6VscuSwRV61veQn6yQN/Cz++9glvtStVT/g==
X-Received: by 2002:a05:6a00:16d2:b029:300:200b:6572 with SMTP id l18-20020a056a0016d2b0290300200b6572mr21740573pfc.62.1627367073764;
        Mon, 26 Jul 2021 23:24:33 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id j13sm2097606pgp.29.2021.07.26.23.24.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jul 2021 23:24:33 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <837C41A4-B4EE-44C8-9828-55D00FB1DCF4@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B845FF8F-16FA-4BBA-9AC6-162AC00CBAF0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Is it safe to use the bigalloc feature in the case of ext4
 filesystem?
Date:   Tue, 27 Jul 2021 00:24:45 -0600
In-Reply-To: <0dc45cbd-b3b0-97ab-66a9-f68331cb483e@gmail.com>
Cc:     linux-ext4@vger.kernel.org
To:     Mikhail Morfikov <mmorfikov@gmail.com>
References: <0dc45cbd-b3b0-97ab-66a9-f68331cb483e@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_B845FF8F-16FA-4BBA-9AC6-162AC00CBAF0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jul 23, 2021, at 9:30 AM, Mikhail Morfikov <mmorfikov@gmail.com> wrote:
> 
> In the man ext4(5) we can read the following:
> 
>    Warning: The bigalloc feature is still under development,
>    and may not be fully supported with your kernel or may
>    have various bugs. Please see the web page
>    http://ext4.wiki.kernel.org/index.php/Bigalloc for details.
>    May clash with delayed allocation (see nodelalloc mount
>    option).
> 
> According to the link above, the info is dated back to 2013,
> which is a little bit ancient.
> 
> What's the current status of the feature? Is it safe to use
> bigalloc on several TiB hard disks where only big files will be
> stored?

Hi Mikhail,
I am not using bigalloc myself (and I'm not aware of its use with
any Lustre-releated ext4 filesystems), but I believe that bigalloc
is in use at some other large storage sites.  Hopefully someone
that is using it can respond here (this may be slow due to summer
vacation).

Cheers, Andreas






--Apple-Mail=_B845FF8F-16FA-4BBA-9AC6-162AC00CBAF0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmD/pq0ACgkQcqXauRfM
H+Ajnw//XPH4D+JjIvRR8SCGemiHpqFVsfTD2ors+VRmgfDA+9MrniSmboVPrC4X
dh6D1FVaMtnsmLPwvVGq6SvwnvzYR+qMd2SCTt6PurEzCYyGZrIN/f7oc/leFEsc
i70u4qupRXrUI/Jz8ce0zvafjJpmXSz3IbjlAg2WZEdrHZk/VMPJkF1kJnbSv0Ad
Vt8BvGB6ax2wCZxNVljt1VcvehKmfsT8VVa4Bcrz6GYJV83n6a1eWoRNM41BU4GD
BfPjY6eZWZ5P6xiL2SO30Y1wDyi6CCDkAKeHIQg2pOIQ6EdBCd9wa1BlkSXlSlDQ
Dj5ZnbPQL9a3BvCPtJeVoTcNJz11t97f8D7I8PvjvhBAAi5+5AkWgeh9205Kod92
ZoRtFhUcPoda1qO5a92nGEkHH0GCqY/s5sjPbXzpEQZRfASl46357ZDbVATXPvlA
j8Cgw59Uy4bIekSfWvF24auX3Nz7EKUV95ehuTpvaW47ZGBvZRR8eDw8drnBpQKo
5B92NLAJvsxQ/ar/Fet7+cm04bw1+I+Ns2UyNfbLfY/WriDkGTLIk97ZGBXIeRE8
T8M/hIbfe0nNjWadJuWElUkpkEpuEjpmVpntXzrUM49Ckpp8lYxborzsqlQEHo5j
InAmU3kSxjxnHP7H+B0/yaNLZGCzJteZWLxfe89bo4adiouCfcY=
=Hr1n
-----END PGP SIGNATURE-----

--Apple-Mail=_B845FF8F-16FA-4BBA-9AC6-162AC00CBAF0--
