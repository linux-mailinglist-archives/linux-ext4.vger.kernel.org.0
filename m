Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1041B287C73
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Oct 2020 21:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgJHT0H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Oct 2020 15:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJHT0E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Oct 2020 15:26:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C132C0613D2
        for <linux-ext4@vger.kernel.org>; Thu,  8 Oct 2020 12:26:02 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n14so4798936pff.6
        for <linux-ext4@vger.kernel.org>; Thu, 08 Oct 2020 12:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=rpeOZ1vxB9EM6X8ZqyNAyaqAd68EOHQNDaaTI04T7OI=;
        b=f3wL8oboNe0fc2hvQ64df0VfJCwBNB9k4XLj+f3qzW0QgRMuTr5bwHPffyhvPdcUa6
         Z8SHH8aXU5yA7Kl85aSGaRX8d9CH3+eMu3spM5TezyuJVLnFKHvIbkTpNqdRg88uC4qY
         +h6nK1P9YLKa6iwNdus3Ci/HhIbJnXQCabA9etMYNtfXsOGPAdDkTF0AAdOr2Ond2Qcs
         yLm3k4pPqnX+NQDCHdat+pFotDnsOiXmJPCgekMh9yGjggIieo7pnJ5zdzj27EO2gwra
         EFUtS+5ipiedN16WrbjNOmQXFE3udhXENh5uhjDIX24Sembi4+++Ijz3KXE+/32kILYh
         Nyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=rpeOZ1vxB9EM6X8ZqyNAyaqAd68EOHQNDaaTI04T7OI=;
        b=D76ElaR6V3E3fXMVnvgojDbAmgHfMwMSTqE4Watmw4OYCZnv1S0R5KjZGAE8E0oNns
         50KSpaQ5ox55ucRGwpX6fu+WTczyTRva9snNYP00vgOQp2XU3JGoxk/KIr151CrI/YYW
         f6MRdMB3uptki/7ROX0Hae7383wURywm6we9POp2Q6oD9dOd8oOQmcK5m9meDSmnPoSb
         ijh8MvgW1ppiFsPoicsRJ8Ivj9Qi9WdpeV+RklHfWVtdQTLia0TbTbyy6qQoqL6k78GX
         n9cS51Y3KuTfPfdB9IMorykjRIZ/xoixWJ368rjBRAQpQyKSBaLcO178eyLdY6u0QyJV
         qrhw==
X-Gm-Message-State: AOAM531mjyfY/1a+c1ey2kYobUE+FeO3W29bVlNKpfYb+r/qt3rKuDtB
        wJcM5vHG9QnKi/Ls3M7pMHtQMQ3EEv8aujNw
X-Google-Smtp-Source: ABdhPJxyQ8OqVGwcv703r2fMPvW45/ErynOrWJzvzXETXTqtJHNwbZ9F4kqMnpCygeq2flt8VhxP2Q==
X-Received: by 2002:a62:fcd0:0:b029:152:28de:e20 with SMTP id e199-20020a62fcd00000b029015228de0e20mr8798846pfh.28.1602185161868;
        Thu, 08 Oct 2020 12:26:01 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id cx20sm7743738pjb.4.2020.10.08.12.26.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Oct 2020 12:26:01 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <FEB46ECD-BE83-41E7-B765-ACD310823BB3@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_6DBF9FDB-B669-4219-BEC8-0FC03D99FE44";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Date:   Thu, 8 Oct 2020 13:25:57 -0600
In-Reply-To: <20201008191231.GA44285@localhost>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Josh Triplett <josh@joshtriplett.org>
References: <20201005173639.GA2311765@magnolia>
 <20201006003216.GB6553@localhost> <20201006025110.GJ49559@magnolia>
 <20201006031834.GA5797@mit.edu> <20201006050306.GA8098@localhost>
 <20201006133533.GC5797@mit.edu> <20201007080304.GB1112@localhost>
 <20201007143211.GA235506@mit.edu> <20201007201424.GB15049@localhost>
 <F9799E9E-6AC8-4C66-B6C6-31CDFA8F55A6@dilger.ca>
 <20201008191231.GA44285@localhost>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_6DBF9FDB-B669-4219-BEC8-0FC03D99FE44
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Oct 8, 2020, at 1:12 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> 
> On Wed, Oct 07, 2020 at 08:57:12PM -0600, Andreas Dilger wrote:
>> On Oct 7, 2020, at 2:14 PM, Josh Triplett <josh@joshtriplett.org> wrote:
>>> If those aren't the right way to express that, I could potentially
>>> adapt. I had a similar such conversation on linux-ext4 already (about
>>> inline data with 128-bit inodes), which led to me choosing to abandon
>>> 128-byte inodes rather than try to get ext4 to support what I wanted
>>> with them, because I didn't want to be disruptive to ext4 for a niche
>>> use case. In the particular case that motivated this thread, what I was
>>> doing already worked in previous kernels, and it seemed reasonable to
>>> ask for it to continue to work in new kernels, while preserving the
>>> newly added checks in the new kernels.
>> 
>> This was discussed in the "Inline data with 128-byte inodes?" thread
>> back in May.  While Jan was not necessarily in favour of this, I was
>> actually OK with improving the ext4 code to handle this case better,
>> since it would (at minimum) clean up ext4 to make a clear separation
>> of how it is detecting data in the i_block[] array and the system.data
>> xattr, and I don't think it added any complexity to the code.
>> 
>> I even posted a WIP patch to that effect, but didn't get a response back:
>> https://marc.info/?l=linux-ext4&m=158863275019187
> 
> My apologies, I thought I responded to that. It looks promising to me,
> though I wouldn't have the bandwidth to take it to completion anytime
> soon.

NP, I don't have bandwidth to work on it right now either.

>> I *do* think that inline_data is an under-appreciated feature that I
>> would be happy to see some improvements with.  I don't think that small
>> files are a niche use case, and if we can clean up the inline_data code
>> to work with 128-byte inodes I'm not against that, even though I'm not
>> going to use that combination of features myself.
> 
> I'd love to see that happen. At the time, it seemed like too large of a
> change to block on, which is why I ended up deciding to switch to
> 256-byte inodes.

Does that mean you are using inline_data with 256-byte inodes?  That would
also be good to know, since there haven't been any well-known users of
this feature so far (AFAIK).  Since you are using this in a read-only
manner, you won't hit the one know issue when an inline_data inode is
extended to use an external block that may temporarily leave the inode
in an inconsistent state.

Cheers, Andreas






--Apple-Mail=_6DBF9FDB-B669-4219-BEC8-0FC03D99FE44
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9/Z8YACgkQcqXauRfM
H+C5Sw//QSjCWYZ3wpCS+oREwRzyVaaOSbU3V+5IW6t03loY5rW6cTcIIuSLwqXL
4iEkf+/VyUCsjGSvzst7NrCE47kyHTgQemQ/duRqHpRNf8TINmoKyyf4ahzAl133
ooL/NfVIF2iIGkvLQc8DtkDxRPdIzFtcoIpb36AGotx2cYcXC0yEIAvDkh2UMF+z
aTu87NiqOFD8wSnle+41txo72ISuimsPzgK/s1CHJ+VCflbj3igeu3Wu8iKfdIwT
AlhpX5TJe+SN+QsQmnHiifdvJ+T1/akIJik3S2i40RLqEBPwFTzVmOjDasZsV0Y6
vHw1AxLoyIYZpoJKL7+7wOwnmul6xsUkNtauZ6WApUAgOlE5kx00bhVnULLC1BJu
MapXwOHUiJpV8lytIPF0RLEPpPrRo0G9zUw3IUuGY05GHlLE0CZR9MvOo25Oroeh
84hJygt3fY4/O6tqngKHAu4QWgSb8MqqhecExmerZn+KfG+T4e4Tp+CAnaXruB5r
qzAMOuPf93h3pF9kMyX4gkEBlZaCAsu5kCxzBTQRVCv3YzBwMC8ukoccR846sEln
6Vyyiph5hCyviwyY16TItncBiVU3i6ruXUEXX/BUzx3FA+yRypo7hAUOOQq8hgYq
j8UaAnABjWuCe/gsoDs5RyOBJU9GHX1Wsg1QC+Th2DGCNsVOBf4=
=Xc01
-----END PGP SIGNATURE-----

--Apple-Mail=_6DBF9FDB-B669-4219-BEC8-0FC03D99FE44--
