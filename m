Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D89B1B4E3A
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Apr 2020 22:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgDVUPf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Apr 2020 16:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgDVUPf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Apr 2020 16:15:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3103C03C1A9
        for <linux-ext4@vger.kernel.org>; Wed, 22 Apr 2020 13:15:33 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 18so1685045pfx.6
        for <linux-ext4@vger.kernel.org>; Wed, 22 Apr 2020 13:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ID66N5DaQPu168etE7RPXy1RvQHMYJsyPG47BKglEgg=;
        b=GmvhqTKlBOR9juqAC8Ia42qla91QlFU7OZCea2YuQoN2cBC0t6FVvGz9XGwjv8ecOM
         CQhuIqJ/kVTUEKLPuPOSj4MBakp+WpDLxzF9Np4tZymLw2nzLnDAn3ibabWge7C81ED5
         7keHuZhmq3kNPeZcazAOVZGp2oWBTRV3FfwVPzH/b7knmraOjpsjve+aXe7ie+WTQg6j
         Z7m1jYRtwmIRMrdhMPUJcj0ubLa6KPh/kU32SWd/G9eGyncKov6rAT5IhWsdLl4iFE7T
         21Kssxr1AcImHNec3ARaN5EdcUPLNjtdU5jV65lURhSG7ypkQLtQlzX0r6LENqKK4G5T
         FwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ID66N5DaQPu168etE7RPXy1RvQHMYJsyPG47BKglEgg=;
        b=PtEbGdRoIkIGE9RJfacaMWgPtVbJDF46eqP0HTVHYQ+5vYdf3Dq/xiV2q93ujC71fQ
         hIwRuPGknUzdL707h6d3rAIzud+0NDmB2LwmJ8b4eWBULfXVaWFlKa6tqc90vzrZCXLs
         cjYlOXh+8lFYUsjjmVy4y1f8aJ8zly8e3DjdK0/j3A9UueW1oyDe27doTdb5F3wNaP2R
         SaxNvvmTJyZYkOte0hND62GQcdnTrzfxRATSshcXEmw4MP4tqiCVNvRVboEz+POy3bFP
         cFEj04ohMIwRYJ37wNOSPusCxCNn8isWjOliAAQgdIlYVsrsFGu4uouzG7ljSx0NGgAd
         qwGQ==
X-Gm-Message-State: AGi0PuaLZvUXraqqezCHH+6gjXJ0FtCjrMElPUEY7sYfqSudVft2uFoK
        jRHme3QvygFyj512CZMcueTgGy8QX4U=
X-Google-Smtp-Source: APiQypKEPYrLeyWue+WMo3uaoROJbvM+Zbkn1V4pnvCJ0O2TqLwJaiDIQXI7qwj6Czjyj3q5IqLTlA==
X-Received: by 2002:a63:50f:: with SMTP id 15mr709591pgf.267.1587586533378;
        Wed, 22 Apr 2020 13:15:33 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id z7sm343747pff.47.2020.04.22.13.15.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 13:15:31 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <331CEA49-83E0-462C-A70D-479F17A4FAB2@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_41251E72-9075-4224-B207-F3AB9394B244";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Inline data with 128-byte inodes?
Date:   Wed, 22 Apr 2020 14:15:28 -0600
In-Reply-To: <20200422160045.GC20756@quack2.suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Jan Kara <jack@suse.cz>, Josh Triplett <josh@joshtriplett.org>
References: <20200414070207.GA170659@localhost>
 <20200422160045.GC20756@quack2.suse.cz>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_41251E72-9075-4224-B207-F3AB9394B244
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Apr 22, 2020, at 10:00 AM, Jan Kara <jack@suse.cz> wrote:
> 
> On Tue 14-04-20 00:02:07, Josh Triplett wrote:
>> Is there a fundamental reason that ext4 *can't* or *shouldn't* support
>> inline data with 128-byte inodes?
> 
> Well, where would we put it on disk? ext4 on-disk inode fills 128-bytes
> with 'osd2' union...

There are 60 bytes in the "i_block" field that can be used by inline_data.

> Or do you mean we should put inline data in an external xattr block?

Using an 4KB xattr block would IMHO be worse than just using a regular
file block for such files, if they don't fit into the 60 i_block bytes.
That makes the data handling more complex (data copies each time in/out
of the xattr) and has performance impact (all writes essentially data
journal because they go via the setxattr code path.

The only time it _might_ be useful is if there are other xattrs that are
shared in the external block with inline_data.  However, at that point
I think you are better off to just create larger inodes to hold the
xattrs to avoid the seeking needed to load the external block...

Given the prevalence of xattrs today (SELinux springs to mind), I'd be
surprised whether this combination shows any improvement in real life,
but I don't have an _objection_ to allowing this combination (e.g. for
ultra-compact /etc or boot filesystem images.

Maybe there is a bigger win for small directories avoiding 4KB leaf blocks?

That said, I'd be happy to see some numbers to show this is a win, and
I'm definitely not _against_ allowing this to work if there is a use for it.

Cheers, Andreas

>> As far as I can tell, the kernel ext4 implementation only allows inline
>> data with 256-byte or larger inodes, because it requires the system.data
>> xattr to exist, even if the actual data requires 60 bytes or less. (The
>> implementation in debugfs, on the other hand, handles inline data in
>> 128-byte inodes just fine. And it seems like it'd be fairly
>> straightforward to change the kernel implementation to support it as
>> well.)
>> 
>> For filesystems that don't need to store xattrs in general, and can live
>> with the other limitations of 128-byte inodes, using a 128-byte inode
>> can save substantial space compared to a 256-byte inode (many megabytes
>> worth of inode tables, versus 4k for each file between 61-160 bytes),
>> and many small files or small directories would still fit in 60 bytes.
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR






--Apple-Mail=_41251E72-9075-4224-B207-F3AB9394B244
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6gpeAACgkQcqXauRfM
H+Cxiw//UtPXgAlqlfQ4fWDBHFocITU/qPt1qh0JFMCWjwi57MJuBJMzTixcicts
0zOYtjJw4HrQq6EkPeKwik45sS2KgMuHbXoqUF7R9hlaIfFcmZY3CIxyEwsLr5VG
vxr3Fkq4SvT4qXcR95T2D1g1sEvT2N7C7mtaaepnuEUrJzllfqQdtZlBrGRSSAnQ
fdqM4Qy4HrEVpScoTDA9VK6BgzEK6TA50b2BYSOupjbew5FiKmo7hYq+RnJlK3fY
ODFg4VVD5mMNF0+uFvdlXZH4lnUN+pQwWUw2fK/4KnGdmCnSjS2tjQivC689gDns
gIx2Hurj3g6r5CjiZPSfBCCDSWZCaIds5O26qpxAj5YIxIJr53xTI+TL2BsFP5qx
AaLBXyp4hNWOQKs/Aw21FAWdHtMIdj6iAQjERURjSmMTDxZ1RxJR5D2aHbuNtTKU
EIHKGiHD4QELdifsdz5cRqpfgTJ4FsLRMbL9rYPEv6tkAL6Iavl9yKIpj5oNdmxb
x2TsYO3w4rUEkIsVZRCrF9LF2KkGb1BTpWSp9o2mcUOWVO7sop719tEdsB2OhXfl
KigmaMSrPdTNeNASbsjHbZ775pol+vLEbfuHQHQc1DAGP1UZU+idJVUDpICM2/tg
g6WwGleU7OkD8iZrO8vHK6dqltfs5Y4fFp1imGzfvfh1WUCMWy0=
=+/UI
-----END PGP SIGNATURE-----

--Apple-Mail=_41251E72-9075-4224-B207-F3AB9394B244--
