Return-Path: <linux-ext4+bounces-2147-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8438AA541
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Apr 2024 00:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83871F22058
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Apr 2024 22:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A3D199E8E;
	Thu, 18 Apr 2024 22:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="t8bAtUlY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E612F30
	for <linux-ext4@vger.kernel.org>; Thu, 18 Apr 2024 22:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477857; cv=none; b=ad0+hNfn7W34CvxfofFRFSxof5SIdilEFvz+ZXfmHPRomBn06AVc1nneVlV2eMXZvJrsKLdHZlZeP+y2e9MoH7qeVhxiiv7LsTIJtTd2EKkIIgLHxqB55dxQ1nSkDJIw3J1X+tcioJ1Rilp0UT0YbjJO/it7EfGawoPOn6OjX3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477857; c=relaxed/simple;
	bh=kcYu3RN08eDHSXAfkoY+Ojnnoa2LO4E047wWjBG+Z/Y=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=MHq0D3Dx2p9uYItTKNmcwDqstzJivzYmFx/RrptYM+9CWDdBWOQ+fiFH8Gw8CcAJ5Ah5JxPtVoX5CKzZoaP2YCJwsnGwmuPhHBICrxhOoKEmzq7HYATjbe9kxQJLE0LHHn1uN2pTUhxmEn7Ta47NpnI3Z93VXsQUSwDG7xKpE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=t8bAtUlY; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso1038309a12.3
        for <linux-ext4@vger.kernel.org>; Thu, 18 Apr 2024 15:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1713477854; x=1714082654; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rw6VV6j4UUrPhkwSmItUpVtljlOi3p1SxescW109M3Y=;
        b=t8bAtUlYU5pdsV0f412lYWFh85kMLZV9JR8Mkso0MG1IUPw+2XNanmXDP6igUqniOC
         pHUuWoOpuGlCS//Dh+kTOmH7IEgcI86jKdyZ2IOs1UQVhUMkk5OlUWk5Eh0qid57vlJ6
         EZOj1k+T0MtJtfpPBT4LVwKKfY2mVxZV5rb2AuqXLyDsgF8AYhwuqHD3ZBdEZfDsagOR
         bVaaGj92U1o//0MOlapENyTtEuXJMcRVS4gbyyjFsYND4bCGwPRzj856uWstGDtvcTdP
         TAF5qhDPpmIgtPde5QrGCQf9WezUNCPTSye35c1u9LPi4cf8Flo4bYqcJbjqBIlTuxX3
         E8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713477854; x=1714082654;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rw6VV6j4UUrPhkwSmItUpVtljlOi3p1SxescW109M3Y=;
        b=u2htH9auMT4TsNoc6tUhTlRzIcmPrfV3dW0GW+Y3RP86Oq7FbdfhLR/Wt3tq7mFAMq
         wYN9YwztKuHXGut3stS5LFtQSiqfWJd4Y1qEqBhDKlRcFxWHL6LOb0dbzft22XIOmCr+
         RoVo/073X53ibgZcfYPaCPCxr4i1DioMpXGS+HrEWXVa4eAG1ROY2lI76BOrGI+DaFTv
         0EqGo1AS7rvqbxvqA4viLlAQENxwrVpaIB5LdMmplizeNtgnRuT5CIuTERj17I8mBC3l
         efQQNIQSKNLoi/BuG846vT9i+yYK7TV8lqUQzwiTdEkFvj7311kcB80YyRMkqw5vY61X
         NZjA==
X-Gm-Message-State: AOJu0Yw4miSitjLXCzms4uFjurRLfYY7in1y4TQcbu1xigWVHW6xxRlH
	Q+IH6HFGsgmge9nZaXWBLyqTwbGht6qqhB2Z18ScHrEtCBv5xpoBkexhNQ9VDW+PFnpIjKA8MPt
	Z
X-Google-Smtp-Source: AGHT+IEHQnClFM/3lIWYJYhgiU6EoTwx2dRfiLPNPkDyaryCht2zxm3FWYk1NxmA5Em25a3coTXCow==
X-Received: by 2002:a05:6a21:2d8c:b0:1a3:5f56:779e with SMTP id ty12-20020a056a212d8c00b001a35f56779emr587544pzb.53.1713477853862;
        Thu, 18 Apr 2024 15:04:13 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id lw4-20020a056a00750400b006ea9108ec12sm1965068pfb.115.2024.04.18.15.04.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2024 15:04:13 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <E44A9FB1-280E-4EB7-9092-856E200EE500@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_68ED42E6-2BA3-4024-850D-77F8474F0A11";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] misc: add 2038 timestamp support
Date: Thu, 18 Apr 2024 16:04:10 -0600
In-Reply-To: <20240418143611.GA3373668@mit.edu>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
References: <20230927054016.16645-1-adilger@dilger.ca>
 <20240418143611.GA3373668@mit.edu>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_68ED42E6-2BA3-4024-850D-77F8474F0A11
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Apr 18, 2024, at 8:36 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> 
> On Tue, Sep 26, 2023 at 11:40:16PM -0600, Andreas Dilger wrote:
>> The ext4 kernel code implemented support for s_mtime_hi,
>> s_wtime_hi, and related timestamp fields to avoid timestamp
>> overflow in 2038, but similar handling is not in e2fsprogs.
>> ...
> 
> Hey Andreas,
> 
> I had recently taken this patch, but I've since found that it was
> causing a number of problems.  These have been fixed on the next
> branch, but if you have your own build of e2fsprogs, you might want to
> make sure you have these two fixups.  The second is especially
> important if you plan to use debugfs's set_super_value command on
> customer file systems....

Ted, thanks for catching this.  Indeed, I had not tested this on 32-bit
systems (I think even my watch is 64-bit?), but as other recent posts
attest there are still 32-bit systems in use somewhere in the world.

This y2038 patch hasn't been in use anywhere in production. I had just
noticed while looking at the code that it was inconsistent with the
ext4 code and thought I'd "do the right thing" and submit a patch to
fix it.  It only had manual bench testing and "make check".  Sorry to
have introduced a broken patch.

> In the future, I strongly suggest that large patches to e2fsprogs are
> run with make check run with trees built with "configure
> --enable-ubsan" and "configure -enable-asan".  If you have a github
> account, pushing the changes so that the github actions will do a CI
> using github actions to make sure that there aren't build problems on
> i386, Windows, MacOS, and Android is also a good thing to do.

I've never used Github actions for this. If I fork tytso/e2fsprogs and
push to adilger/e2fsprogs, are those actions automated already with a
config file inside the repo, or do I need to set that up myself?

PS: the kernel.org repo looks like it has not been updated in 4 months,
despite emails that you have landed patches. I was pulling from there
and didn't notice until now that you have been pushing only to github.

Cheers, Andreas

> commit 5b599a325c1af94111940c14d888ade937f29d19
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Wed Apr 17 23:47:02 2024 -0400
> 
>    Fix 32-bit build and test failures
> 
>    Commit ca8bc9240a00 ("Add post-2038 timestamp support to e2fsprogs")
>    was never built or tested on a 32-bit.  It introduced some build
>    problems when time_t is a 32-bit integer, and it exposed some test
>    bugs.  Fix them.
> 
>    Fixes: ca8bc9240a00 ("Add post-2038 timestamp support to e2fsprogs")
>    Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> commit 9103e1e792170a836884db4ee9f2762bf1684f09
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Thu Apr 18 10:04:27 2024 -0400
> 
>    debugfs: fix set_field's handling of timestamps
> 
>    How timestamps are encoded in inodes and superblocks are different.
>    Unfortunately, commit ca8bc9240a00 which added post-2038 timestamps
>    was (a) overwriting adjacent superblock fields and/or attempting
>    unaligned writes to a 8-bit field from a 32-bit pointer, and (b) using
>    the incorrect encoding for timestamps stored in inodes.  Fix both of
>    these issues, which were found thanks to UBSAN.
> 
>    Fixes: ca8bc9240a00 ("Add post-2038 timestamp support to e2fsprogs")
>    Signed-off-by: Theodore Ts'o <tytso@mit.edu>


Cheers, Andreas






--Apple-Mail=_68ED42E6-2BA3-4024-850D-77F8474F0A11
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYhmNoACgkQcqXauRfM
H+CkCg/+Ot8YN6S95JeGw2SEMbS18mNRFT92ilF4P1AfaWyJKquEDzzkB//J3rM0
7lB+qvEZ6kyrZTHfBoNZuFz+ogjBc9C2a4scX7jOyilOb4xgVM7DXBlxTeUSbx3p
I9EZCFjWOaI1k7yBVti1+pD0Hw8/rkU59ADTlzYH9qJlQvEWoMmXr8UJgEQYVA3Z
TAQ2sAVgAqmsKuH11fYoQMTghKg45LZpD7hMbjEmqCtc5ackcxx4buEFNbRlgdv2
iH9Si/fmWGBnSIeEBgS0+T5Gfz3+z886lSvldSpyBbsWtTRRVMGK742shUdlZQFA
wcUyP3il7pHGjBn4NGA3MlyiLVHT5lgOv9BeUrbGSLbUKPW0MiPwb59AP+XaQzgG
fg8NUdUhfrKX6dCmiN8por6sNNCkh4kFK7UU7BCdmZToZllsGLq6JTz1p0H6gAKS
bFRsGAGbvMq2+fEHLiwPp/rY3SSzUaRTM0+lbrwRVVsJNq0SVmkY5m7/GOWmlPPO
F3OCUtF5qCXI8b346jGKlRUYZZ01n8BekK0mXmIAYvW/hMEaPpBypE5VHJwW8TN1
ArGUbzrmv7N9Bkm58rL2P5oJOHfFnoiKbUeM02hND68kewIf1BoBmsT2I/NMkI51
T9OxpVynvR2RfbnUEKWOLkJpU4B+hyy+Nxn+08K9vfA+bPBbhVQ=
=zOzO
-----END PGP SIGNATURE-----

--Apple-Mail=_68ED42E6-2BA3-4024-850D-77F8474F0A11--

