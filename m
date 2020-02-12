Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF97159E84
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2020 02:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgBLBJY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Feb 2020 20:09:24 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46839 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgBLBJY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Feb 2020 20:09:24 -0500
Received: by mail-yb1-f194.google.com with SMTP id p129so102292ybc.13
        for <linux-ext4@vger.kernel.org>; Tue, 11 Feb 2020 17:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=H+HbvfQWq7VopowzNbs3yNhMY4Q3zAaWtLHIniT5vr8=;
        b=YsXiC0TS2hDW+RXnOaxxey7WiAK/lP0VnDhIH9/s7Immcl2KJU34KtHUL2ejx80hDS
         c72xroiRBV/dftsrwIKqEiTXQqfwwoTEAt6byHI6kMrjnCCmY3VfGaluOlQT0LCVsbF4
         mEeIOu3ViM3mJNIQL9T8yvulzA0CymuJRTXxCLzpk9stjuFEgvNgIhi9zQC49o2NChtK
         ewXTgKIHz3B17kqcFJ+cG+HpuKeRCwZGS9W+zEfHowRVSFHSLRQV2pG42uYtqVdZGxYJ
         iigzVikU2c4RUdnAx6daxbZppro2p9bYmhRVSK8NWSOaYBymwBFCiJs/jLmbPeFD1yE2
         bBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=H+HbvfQWq7VopowzNbs3yNhMY4Q3zAaWtLHIniT5vr8=;
        b=Crayd0NgDqh6UgV4fPirbCci4tEJjRrSNdNzCXEZaoBT3C22Fe2z0TOvPBOaujijc1
         PBkOvY5qw9N+mJkGjZz9VRszMFzqJ7hp2Fcqjb87TFbWTdjQiVZsRLvnB1N9pxP4E5Eo
         QUXEHoo7F5P55s8o9qwbEBIS/JL/xphxgcArH854fqTVOlfZgpBplck5N83g+cWSA2yK
         OslYPxXZsD5VoTGnbZHLoPTN98pRqv5nwXb1ikAet0DyoRhvjyPJBSjNleS9YZQ5tK9F
         zUVN7mzqaaSTSRzZML4+RvVmlxIdZN9V7vkNrZBNcj4hXSheLlQCMVP51FC35zpQRY8w
         2mpw==
X-Gm-Message-State: APjAAAV+teqBl533mIcqKs4Ptx+rbZ7Gpp3Pau2KD7svOwuXzqjGippv
        VoV82NI3Axz408qTAK8WJltfIw==
X-Google-Smtp-Source: APXvYqzkS/ceEMYuI8fJnY3s+qt1vltPPT0fckaQimf8nQ1UgOZyKqKCcF0pKK6y7L6dHhfWKQXyiA==
X-Received: by 2002:a25:5d8:: with SMTP id 207mr7828365ybf.433.1581469763135;
        Tue, 11 Feb 2020 17:09:23 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id p204sm2764242ywp.14.2020.02.11.17.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 17:09:22 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E55E0D11-55B4-45BD-BA99-2E839A403AF9@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C31E42C7-EA80-4076-9EE6-29E77F0BBD5B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] misc: handle very large files with filefrag
Date:   Tue, 11 Feb 2020 18:09:20 -0700
In-Reply-To: <1581469085-85472-1-git-send-email-adilger@whamcloud.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
To:     Ted Tso <tytso@mit.edu>
References: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
 <1581469085-85472-1-git-send-email-adilger@whamcloud.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_C31E42C7-EA80-4076-9EE6-29E77F0BBD5B
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Feb 11, 2020, at 5:58 PM, Andreas Dilger <adilger@whamcloud.com> wrote:
> 
> Avoid overflowing the column-width calc printing files over 4B blocks.
> 
> Document the [KMG] suffixes for the "-b <blocksize>" option.
> 
> The blocksize is limited to at most 1GiB blocksize to avoid shifting
> all extents down to zero GB in size.  Even the use of 1GB blocksize
> is unlikely, but non-ext4 filesystems may use multi-GB extents.
> 
> Signed-off-by: Andreas Dilger <adilger@dilger.ca>
> Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13197

Sorry,
this one was a repeat.  I actually meant to actually send the other patch
"e2fsck: avoid overflow with very large dirs", which was accidentally
dropped from my previous patch series.

Cheers, Andreas






--Apple-Mail=_C31E42C7-EA80-4076-9EE6-29E77F0BBD5B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5DUEAACgkQcqXauRfM
H+Bo4g/9FpBsBOfNANlJGAJCO7ggExg/sMeqtgL7vlg2BMGlYXuMb6DFGyv8eOaS
5udP2ONc7brE1j31Sdg6MTclTp9DfMBm5yVBMnhN5hbCoOPCy4C4Aqypi9LL/5PI
VVf1FXpLUI78xf5TGL6YsO6BpNcoxtMdqOxlN2spJMOKkXQLXkQdWmBW0YYOTuJN
qtF+J/rCRcv6wr4/Ydj7WDyM/zKIfZCEYe3r9bQLwVAQkMb99X/r9Af8Y0nnNz4l
oFmETO42URxdSrBejmb9Aje9yD0A15hBzIOU3CM3aYzOkk4A+vX2BGpb9KzSP6NW
TKE2s3bbAvh8bXoI+bMt1n1K3MmvFjqlFFphj5O6oPCptrmvcqlXo0nmyI6n/rDN
Pe/+oU4umg7lddbHlWgQO9nTNJ3JD/Io5m1IGv+Uj020ddaZNYx/PM5KF8NfZBI9
w6HtUI8Rn+ML4mk8RP6PduqbXl1VV8D6eEOB/k51O4H/4IKRDDn7+xjyGdvCkMdy
lgx9NO7QpJYo75EpcpcQ61sZh8opBjBUpPAm1DDI7bmRaIHsBQJHExnrozv7pQ/I
lcYCUv9q0E8DoYWOPVDOOjLGriJ/vkLFBOuZF4Gqk/PB2rgmDlmvyPc5Q12k0jkY
4v4DyvXb6lJtYSkNmi/i0r/C2f5idg182Eey/OR3TkP/wX5Rm00=
=bP4L
-----END PGP SIGNATURE-----

--Apple-Mail=_C31E42C7-EA80-4076-9EE6-29E77F0BBD5B--
