Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74F4515374F
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Feb 2020 19:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgBESLS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Feb 2020 13:11:18 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:36093 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgBESLR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Feb 2020 13:11:17 -0500
Received: by mail-pl1-f174.google.com with SMTP id a6so1202764plm.3
        for <linux-ext4@vger.kernel.org>; Wed, 05 Feb 2020 10:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ji0daXlRV/az1/vcPqlKl5asZ9EwyeGPeruuoz06ytE=;
        b=N3CKIOXC+COVnH6IDoVou7CA4iQJcYXcFY9UzT4DpSbi9Wz9sa+cjvhdga/up2UKFZ
         apuT4szWG23ROIF+oWFEhIupNFglmQ/oUfqBYfRbD770Lu4E8o0AHN8IRhzCNNXHWLGi
         /hnm0lo5fwesWAhmJnHKB1AHPU0Iru88XBJTWPrpmahgCAvGgR8UAAvNdmmJESz/ZFRZ
         VtfTlrEg6qAT1n7BYSygsyZLTiddfy4ZG2hTurSRGMKivGnwkheQLvhvlELlcSPCXFA8
         tdQ+uxwHy3rTpjKqhNuaCpgnwLGLJ5nxWOEweF6yS9QvGp49ScCTap3Dfq4Q+r8x3Nr3
         /SIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ji0daXlRV/az1/vcPqlKl5asZ9EwyeGPeruuoz06ytE=;
        b=V5QEJkndXvuaYuhsqXC2e6c9mJz18EZtKHdYcFaiXYJ7lrJstyj9Ny0mdz6dA4h6uH
         w9ADRQODNjCm5oTXoDrI13X1kThPjc8fRSPzTPQQJwPv9bLkBEQjOolcyDn48hbjct54
         XrdggWyQ5EZ63LrmdViVVpWY4DX32z9tKBSQ3JSGwRy8l/ER8SrHeTNHW5rM7X+7N7QW
         zu8SL4C2yzRe5JtXQKfnMyuun2NbTv8BMyQzvGUrt574R9NFkhpNfD/ND6aTgRxmrf0d
         pXqDsdn78WxqSSf+2/mcaWdnTsTW9UHqPc7p82Z4G6WJO3Ew4xQSlBH4sz+j2etk2P8h
         lfzA==
X-Gm-Message-State: APjAAAURmufaqAzH6s4RMtOc+fpxGD1kB0KuIc/+LhUdnMdx9h+61hgK
        BYWQjacwXPsUdITKNERXPJewC/YAZjorJg==
X-Google-Smtp-Source: APXvYqyKyJ9UjwpjiDvMoH1A71pV8NdFodb4PlVOVgmElzV6XMn8tDIMIkg3RpumzuXfy+sQ+Sp5XA==
X-Received: by 2002:a17:90a:8545:: with SMTP id a5mr6984888pjw.43.1580926276610;
        Wed, 05 Feb 2020 10:11:16 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id bb5sm467829pjb.8.2020.02.05.10.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Feb 2020 10:11:15 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E9A04E5E-96E0-48FC-AC41-FCA8193E058E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9DB48349-7CBA-4BA2-9335-D13CADBE2ED1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/3] tests: Add tests for ext2fs_link() into htree dir
Date:   Wed, 5 Feb 2020 11:11:13 -0700
In-Reply-To: <20200205100138.30053-4-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4 <linux-ext4@vger.kernel.org>
To:     Jan Kara <jack@suse.cz>
References: <20200205100138.30053-1-jack@suse.cz>
 <20200205100138.30053-4-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_9DB48349-7CBA-4BA2-9335-D13CADBE2ED1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Feb 5, 2020, at 3:01 AM, Jan Kara <jack@suse.cz> wrote:
> 
> Add two tests adding 50000 files into a htree directory to test various
> cases of htree modification.

Note that there is already tests/f_large_dir that is creating a large
directory via debugfs.  Maybe that could be extended rather than adding
another long-running test to do almost the same thing?

Cheers, Andreas






--Apple-Mail=_9DB48349-7CBA-4BA2-9335-D13CADBE2ED1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl47BUEACgkQcqXauRfM
H+BBYhAAqULIoZNTTV2YMmMqtpb9p0+9BWXFcFGhNi0aRQCYL1zYuRR5MdvLXVv4
by73UrReZzHlFZFPcp6+3a+guL9uM6FDxNfkKWQXpOKpqTXjGQMBFNAmurKro745
aJic1K9Xp8Lj4od5fXwkyJsW3ggbULPnJl41e75um8+LicOF7c2q6mceuExZkaJm
RGRDkvBauR1N5/eYrMS1UnxrRmwqdjdYsao2JA6YO8TPlQ5KZqCJwU/rNsq3oVLP
JHu4sDGGlB4L66lHiq67DpVURaizcPGUtNpyYM8XfcX0Tdv+W+iVlXAt5ui5sp2o
lUpjcYINRT9RO8pnKyCjmhZ5nhT7YflNdlzIXPqTUyMOcnVBm8k9qRajcFpKnEhi
HAZ+DxbkZTkBdM+D+zdN42sq6BfaBu5eP6DsLcn7NTwGqkA0s4s5vvAO39UY5ywI
JIYKdLG/57xTXCJQjtEVerU6ytkcNSIYCWLyUyMkUj0puEpm4kxTn0jzLAsaJYxt
kaOYTP7DQXIItW5tWvw02/cQNNFAYHzI1TSSVsyeGsoJg1jFUCeRChN/yafY0pHq
OE5I070qurryY8cAui80qMZfqAAMqd9jRBEjpohSEDYxEHPcOma8EOXwKkmEqvt3
WZg53zx7gTPoCLM0Fb+78CmOuFWbAuPoD8bUWCYOiOCN6hRSnbk=
=rKkO
-----END PGP SIGNATURE-----

--Apple-Mail=_9DB48349-7CBA-4BA2-9335-D13CADBE2ED1--
