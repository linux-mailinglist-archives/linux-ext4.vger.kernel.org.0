Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DAD286CF5
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Oct 2020 04:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgJHC5R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Oct 2020 22:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgJHC5Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Oct 2020 22:57:16 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1796C0613D2
        for <linux-ext4@vger.kernel.org>; Wed,  7 Oct 2020 19:57:16 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b19so2051904pld.0
        for <linux-ext4@vger.kernel.org>; Wed, 07 Oct 2020 19:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=XckIVsyIblzBk/4GtfSHnZglGC0EwBPyiy+d/ZSFJzo=;
        b=RkSb+3sWiY3VUeq7lGWdAbApg6SyZdFxcBQSuzn1v0cKbIXjLxRBCAD8GmP7gIOB+Z
         wgT1rh9iVSg0DkqvW74oGvFUv99QXh+rAr55kRYrmhSuz0BOswjYUQ9ZpfPX+kBQe7W5
         BqCyTu209/uIXRWdyaWmm2unu4L57mtW7kZCanNXK1UrxjlhkHpJvG1SKyldKbQmxRRc
         xDU1ZMdJ0CJ0oHS7VAkE2o55JyYwNmMAZwhUXlxnwPsw6nkK+fMmOkRTfwZIN6nzs1Qh
         7QzhOdqM22kDgXv5O82VDvKQToYwqMBXo52XpWvNMQuiGFW02xlKDpEFbd506+em5O/5
         ggwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=XckIVsyIblzBk/4GtfSHnZglGC0EwBPyiy+d/ZSFJzo=;
        b=W9cVtl7H9vt2ZBvtLLDnYXIBwCrQFJhdy/sfscuokfNTMXzO7MIU6iHOGomvMk7x2/
         UHbfqC1pLhDZoAxjzEGazSnckMEQOEif270wTMawZaXguRIvorkb+u3TVsAlK8rj/5QL
         L6B9gUzK+iKfBISEycs/z+PbRXQcq370znmn74lI+d3S9eKKZbFUzFI8ITPCvC/KWFQD
         yUFTfx5tY1uTl+4pDBzdIwu8a9RwK9Of1t3SSC6qU1HRWfsaDAoitrCaK97ZDpVttpTp
         +vrsymsd90f6ZPLuBYw+JVk4Sk5ccP5XeYh16CgkMQsvOlI2tfHKOn0ShFfQaQVLfUUc
         0gSg==
X-Gm-Message-State: AOAM530kCQueame6YkqKJbnVfoOAaNmjYFnX6PneTan+jxiEMK1e8i7K
        SMlUDewk0z2NNZY0LDKY/4aV4c5DsdeWVtue
X-Google-Smtp-Source: ABdhPJxvLq+01NtzS1nx9XirPBxYjJPSc7GN5nzPRgddSvoxu7gJ97oe/6jPG1uWcfWvvUtl6tkBvA==
X-Received: by 2002:a17:902:64c8:b029:d3:c693:8ce8 with SMTP id y8-20020a17090264c8b02900d3c6938ce8mr5644673pli.27.1602125835992;
        Wed, 07 Oct 2020 19:57:15 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id f9sm4048336pjq.26.2020.10.07.19.57.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2020 19:57:15 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F9799E9E-6AC8-4C66-B6C6-31CDFA8F55A6@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_412C097C-2A01-4EE1-8676-2B5C5C1FD48F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Date:   Wed, 7 Oct 2020 20:57:12 -0600
In-Reply-To: <20201007201424.GB15049@localhost>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Josh Triplett <josh@joshtriplett.org>
References: <CAHk-=wj-H5BYCU_kKiOK=B9sN3BtRzL4pnne2AJPyf54nQ+d=w@mail.gmail.com>
 <20201005081454.GA493107@localhost> <20201005173639.GA2311765@magnolia>
 <20201006003216.GB6553@localhost> <20201006025110.GJ49559@magnolia>
 <20201006031834.GA5797@mit.edu> <20201006050306.GA8098@localhost>
 <20201006133533.GC5797@mit.edu> <20201007080304.GB1112@localhost>
 <20201007143211.GA235506@mit.edu> <20201007201424.GB15049@localhost>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_412C097C-2A01-4EE1-8676-2B5C5C1FD48F
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Oct 7, 2020, at 2:14 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> If those aren't the right way to express that, I could potentially
> adapt. I had a similar such conversation on linux-ext4 already (about
> inline data with 128-bit inodes), which led to me choosing to abandon
> 128-byte inodes rather than try to get ext4 to support what I wanted
> with them, because I didn't want to be disruptive to ext4 for a niche
> use case. In the particular case that motivated this thread, what I was
> doing already worked in previous kernels, and it seemed reasonable to
> ask for it to continue to work in new kernels, while preserving the
> newly added checks in the new kernels.

This was discussed in the "Inline data with 128-byte inodes?" thread
back in May.  While Jan was not necessarily in favour of this, I was
actually OK with improving the ext4 code to handle this case better,
since it would (at minimum) clean up ext4 to make a clear separation
of how it is detecting data in the i_block[] array and the system.data
xattr, and I don't think it added any complexity to the code.

I even posted a WIP patch to that effect, but didn't get a response back:
https://marc.info/?l=linux-ext4&m=158863275019187

I *do* think that inline_data is an under-appreciated feature that I
would be happy to see some improvements with.  I don't think that small
files are a niche use case, and if we can clean up the inline_data code
to work with 128-byte inodes I'm not against that, even though I'm not
going to use that combination of features myself.

Cheers, Andreas






--Apple-Mail=_412C097C-2A01-4EE1-8676-2B5C5C1FD48F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9+gAkACgkQcqXauRfM
H+AFwg//YZJLR/QqnxWdf/B6mT2xxjTmP/ijQaHafPYl+mE80fRN3czAUu4ob73F
708WjYgxeY3WcID+pPgqtOXU3yp4RhMzv3rzkHaR7T8kHY314l4K7p3/4BSJT/dz
gMZ++W3kfXJy6WbmlnWMlx069epKyiuzjPDtYeq039PaEwM/NpfbJxRx3b5bPjV/
M6CALzuUoIdICzUWD680qt9IfpNABv77LHwuGg61I7NbUlwhDdESD4/j14c4oNkB
KATIXDbZEuc5xN43o8C0gfSEDy+gO8+eJkq8rPiwLjWf7bgI3LnN4EyIolP/l3Bh
PI6KOp9ZQhuw9dyl7OCcNLM0d2EGygK7G0pmpvc1ajuQnGZEZq3wF/US96NVYLgy
8k58JHhpXV6fwxmaQRHjkA954HA5GllsS1gLVTWEFR39dlvpNgiKazqEYfGR8l/9
JAuTZqd/DWX2vxZ3ViC5sAgLcfpmWYBUabWNSsvendZucRgip1g2IgXBu9S7VB2Q
vry8B/BZNzDhIJTk6NeZZg+V1+VbireWalQI0GEiW1OQkDVVKN++bRydtMMutn0v
wYMvXcHcr2Dn5tPfUoh2dkOyS54S5oX8ZiRJxdtdx69AVyfLXFAsBwcxHwKXPof8
WgOubQcTpp/xSLYBqhjJbHfrHLvp/7Se0NtxhqA2Hpv6Qcug2Ms=
=+7Es
-----END PGP SIGNATURE-----

--Apple-Mail=_412C097C-2A01-4EE1-8676-2B5C5C1FD48F--
