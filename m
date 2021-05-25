Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E847390C81
	for <lists+linux-ext4@lfdr.de>; Wed, 26 May 2021 00:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhEYXAX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 May 2021 19:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhEYXAX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 May 2021 19:00:23 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A0FC061574
        for <linux-ext4@vger.kernel.org>; Tue, 25 May 2021 15:58:52 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q15so23941506pgg.12
        for <linux-ext4@vger.kernel.org>; Tue, 25 May 2021 15:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=hX/rBRm4QBlH/CR3lcT9LZd/ibBac3+Los/O0LgpfN8=;
        b=JPaJiOKAFtl4YgkTR2sFRag6X4h46sqRtvl5nPyZF0O9mwHyddop5CtADZ+IoEYJ7u
         ZhWdjnIGzXZIlPe0JfgZiGlVDe8LTr07UOQpub3mZp8GoE+Eq9tCbYOO0g7s17G36yX7
         aIyjMTk+DiPtxJY7ndeSaQ2JPhNatVClFD6f/WPfwVfIps28iyX9YqO7cBEBweUnxMZM
         6l/9msuNuvIv5qxB+dahsJXKedXf87+BfoapTwN/fjjljnSBIuWKFy0lzktcj52jk4x9
         DL6qHmZKvtfYrIzgTMpLhOrHKknNMcrt/ayup5WfeQcCVjeYDB26nhgyIyqsnGJUX046
         xrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=hX/rBRm4QBlH/CR3lcT9LZd/ibBac3+Los/O0LgpfN8=;
        b=o9czPNPeITQ/yoSx81o2H2YpU+iBDyDHq9TT0Xu88U9OoAr5AACxrx/PpsNpk6QhfG
         i2rD9mGcfQ3Def583W938ZANobfrsmeqsEr+ZevqCQCZOq8L+qbtiefC4A9tcog5Bwpf
         YyzxeCS1cvZwjtpOHxpoUazNS8fDLyREn3kOKO1mke90GvFQerj8DI9sJjaa7LTfgi/l
         3wmw15k/VKO/BaCC0df8aV/trZyg1BeD/S1bFyl5qTJ0TniELh64dC1RvGriR9sDLhzL
         tm7t6sYmJcfeEfkQ7pIiXxPLqMMlt/VKnhMxhMz7o6U5GCQL8u+lbEaatVkgxVodSXMr
         vDNw==
X-Gm-Message-State: AOAM531yCxxIAvbSawMy4mximUCqeRoPqCRXqBZIf3IwPs5eFg368tH5
        pNGd0W5I2z6QQ+oYTaF0O3Cphw==
X-Google-Smtp-Source: ABdhPJyQrIl3kRoE1Ih5TyGz1SYTeMGl+VDTZuFHOs62rbg/s1kQA6rx87GCdoklhMLU3ZT66ZNPlA==
X-Received: by 2002:a63:175e:: with SMTP id 30mr21625140pgx.48.1621983531380;
        Tue, 25 May 2021 15:58:51 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id pg5sm10748895pjb.28.2021.05.25.15.58.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 May 2021 15:58:50 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <00224B62-4903-4D33-A835-2DC8CC0E3B4D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_3D8A3B39-D089-4DAF-B1B2-AD38E7039117";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: How capacious and well-indexed are ext4, xfs and btrfs
 directories?
Date:   Tue, 25 May 2021 16:58:48 -0600
In-Reply-To: <4169583.1621981910@warthog.procyon.org.uk>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-cachefs@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
To:     David Howells <dhowells@redhat.com>
References: <6E4DE257-4220-4B5B-B3D0-B67C7BC69BB5@dilger.ca>
 <206078.1621264018@warthog.procyon.org.uk>
 <4169583.1621981910@warthog.procyon.org.uk>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_3D8A3B39-D089-4DAF-B1B2-AD38E7039117
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 25, 2021, at 4:31 PM, David Howells <dhowells@redhat.com> wrote:
>=20
> Andreas Dilger <adilger@dilger.ca> wrote:
>=20
>> As described elsewhere in the thread, allowing concurrent create and =
unlink
>> in a directory (rename probably not needed) would be invaluable for =
scaling
>> multi-threaded workloads.  Neil Brown posted a prototype patch to add =
this
>> to the VFS for NFS:
>=20
> Actually, one thing I'm looking at is using vfs_tmpfile() to create a =
new file
> (or a replacement file when invalidation is required) and then using
> vfs_link() to attach directory entries in the background (possibly =
using
> vfs_link() with AT_LINK_REPLACE[1] instead of unlink+link).
>=20
> Any thoughts on how that might scale?  vfs_tmpfile() doesn't appear to =
require
> the directory inode lock.  I presume the directory is required for =
security
> purposes in addition to being a way to specify the target filesystem.

I don't see how that would help much?  Yes, the tmpfile allocation would =
be
out-of-line vs. the directory lock, so this may reduce the lock hold =
time
by some fraction, but this would still need to hold the directory lock
when linking the tmpfile into the directory, in the same way that create
and unlink are serialized against other threads working in the same dir.

Having the directory locking scale with the size of the directory is =
what
will get orders of magnitude speedups for large concurrent workloads.
In ext4 this means write locking the directory leaf blocks =
independently,
with read locks for the interior index blocks unless new leaf blocks are
added (they are currently never removed).

It's the same situation as back with the BKL locking the entire kernel,
before we got fine-grained locking throughout the kernel.

>=20
> David
>=20
> [1] =
https://lore.kernel.org/linux-fsdevel/cover.1580251857.git.osandov@fb.com/=

>=20


Cheers, Andreas






--Apple-Mail=_3D8A3B39-D089-4DAF-B1B2-AD38E7039117
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmCtgSgACgkQcqXauRfM
H+CDVxAAnze/K3njMsggycsga9Pgt7jRP/ffBygbtoqyKa4k3uzv2ENQ2Ldlf8KL
qgBUHNOQFTohqS3ZxcLCKB8pSYPk6MFO6dddL9sLO5iKEr3NSQtWoN55tCQOGAgw
zB9WAVud0IkDzW8Eppy0bo5YEH6ELgxp2uCNssdGAN24UQsK5s6HdxWWZNTkiJLE
U88ttdsgVNls0mNovoSebNVnO0ka5XFofqzCnALYcq8hI8N2Q4JmRXz2TTkmiwZY
TURlyBIMCa07a8l8ga7htpXjN8FqkB+XVcC5tPzrMUEtfVlll8mrZIoBo8oxiHIg
yWhNiqsV1N5HzXc6ME5LtyXaUzuuWug8fGI4+ryFRedEp1Nio5NV8gtfT7gZl9Fr
sI3JoMyJg5W14TiYAqw3+CbvtUpBaPaG0I5mFKFyrfXKoFL+gDinonnaV5iu1bXX
a/ra56wsobuoIDFOFftXW4U74MLHU0z63zgmhFjtt2PSgf62Tl8QYQYwusjFOuuD
qsXcuwdRm+7JWSNSeyQDCIC8JSiqOzhbWx6lApiBGAB2wPrOZeJFmGbGChD2YByR
GolsClW3YvJf2gYkOd/pHjgYpUqiqTKtvfieKPGI4Auy0AW0ibPzFzsMpL9NnI7M
iU4n2bpxBVaUuk3KxJqHkKE9+0/aNcE/Orq4ULkO50hfDlwaUTY=
=V/Um
-----END PGP SIGNATURE-----

--Apple-Mail=_3D8A3B39-D089-4DAF-B1B2-AD38E7039117--
