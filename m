Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 560341860B4
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Mar 2020 01:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgCPALY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Mar 2020 20:11:24 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35179 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbgCPALY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Mar 2020 20:11:24 -0400
Received: by mail-pj1-f65.google.com with SMTP id mq3so7605220pjb.0
        for <linux-ext4@vger.kernel.org>; Sun, 15 Mar 2020 17:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=GnhMZeokFbzW6kVDSnfCEkuSPuSsLvvqftQyxztdC4Q=;
        b=pCZJhIfF21hQHuwzv0gm7mTBffh7euXn+tru5yHgkSZF4X8EeruJ8V06gnGkk1Dcy6
         YTxldruEcr2Z0+jbNOQ9NArEOwdKs18d4hg9a2aIM9Jc6J9bhI8+uqozq4WRSSmtR9Wk
         frkO3CvULKRP9sThzFeSUctTZBjEnsbTgZgnJ0SAUxoe25CNbILiJfnvsfLs72TXj5MV
         Bfw3fAD4a7ifVjahntHCs4AX55Er2kCXW1Gb5vnuVEjb+yEDe4sFdFkfLJeVRRFz/qe2
         7s5/3Sk8BJPl53IKOEtAGfehPjFLiA9v6fpI7HNEljIRAzunmqSD3JK89xM/0tFCS2Bl
         EpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=GnhMZeokFbzW6kVDSnfCEkuSPuSsLvvqftQyxztdC4Q=;
        b=rluVVMzvoBca/OqgFtPXq9pxE1KIPxFCw4/lzsgs103jd1a66LiarWcUxdT5vvYXtF
         8/daN6Mlj6fdVxPpC2aPbvipd+Dbg+VgmCImP8GJfvsOtDc4kncqASpg9/0VSScGghz1
         ++zmSsc9YggIdv5AJLdBP074BYUKcz8wBVkxxWFrmJlqKlGXASzkdTnsf7MpwBHoMW6K
         W8V37rBYZgg72Nw6VmyrfbqGvcBZG8O4KPLRbCIHJokM7zRzZbQ6XiYG52lvGD/KpcUA
         +k+i3b0oq12dq37qG4iyPU7fNKKHwG2w9OfK2fhv7lT6cP2R/ExTmKiTZApuc/kcYm90
         qCvw==
X-Gm-Message-State: ANhLgQ37pMObiFVrryWNinwEFHhWWj5ajuecWoUYIsa5bsxOji/g/pUD
        VnQyS9MweTb3ZEB6EfkWDzgtaw==
X-Google-Smtp-Source: ADFU+vsc3HsYcBs3OMy7BS0gWDgcVdVkmXUoBq/y0pp4M5lnwbm8rWZViZ39ekqLLclWvSRsi6J6BA==
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr23747166plf.255.1584317482965;
        Sun, 15 Mar 2020 17:11:22 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id z8sm11320599pjq.10.2020.03.15.17.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 17:11:22 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <173CAB23-6A80-44CE-AC8C-4A37E6625BFE@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_69130B7D-C680-4EA1-BD75-2A1DE933914F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 7/7] tune2fs: Update dir checksums when clearing dir_index
 feature
Date:   Sun, 15 Mar 2020 18:11:19 -0600
In-Reply-To: <20200315171520.GT225435@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
References: <20200213101602.29096-1-jack@suse.cz>
 <20200213101602.29096-8-jack@suse.cz> <20200315171520.GT225435@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_69130B7D-C680-4EA1-BD75-2A1DE933914F
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Mar 15, 2020, at 11:15 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> 
> With regards to the enum, I agree with Jan that using an enum for
> bitfields isn't a great fit.  Also, in this case, where it's for a
> static function and the definitions don't go beyond a single file, the
> advantages of using an enum so we can have strong typing is much less
> useful.

I don't think that "enum" has to mean "sequential integers", but rather
"an listing of related constants" as defined by Wikipedia:

    An enumeration is a complete, ordered listing of all
    the items in a collection.

Giving a list of related constants a name makes the code easier to
understand, especially when the variables have totally generic names
like "flags".  I'm not saying it isn't possible to figure out what
the possible values of that variable are, by hunting around the code
to see what is assigned to it, but making the code easier to understand
at first reading should have value by itself?

Cheers, Andreas






--Apple-Mail=_69130B7D-C680-4EA1-BD75-2A1DE933914F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5uxCgACgkQcqXauRfM
H+DBbw//SjaNE9owabfCllHK1L6n1Zr3rDQLRZyxOaapb1sY1CmQcHq3LlNP96mf
mCu5jaSoS4wsefy35KzzGPb7QYO6KFD8J1uC3/4A1UppU6FTzgKEtpdgPMj5KJH+
VdENxOkdEZpS17cm7Rq8u9AkZYqq4mWQ7ySj7GYND347lEyhwOmWc14JBT2Wsa3w
fdHr04i3h7VYnwm5IfBEoDaxxfPU3CMr8g72DH0cotqu7z9GANyHnU+IVZA+ydkf
CIV7yyfSCFc5cAGhXdpiHeXxQte9e2l9Av/7Y68bInALlrOK68Yunte30HFXqaNm
nrCnzx6Hiz8l4n8icUvwexqPVQmYAFkAcV3EGWHwKLSKuyz/NYvSCI2IM3f5qcc5
RXmaIyHpQR0pfpnxTrryfqDowWBNVd5jaDxJFORK3MX5Lf0l67OKO4CWQlVgvLSp
6tPVOulKpeXQTqpY5rEzVTBV8j0u4m9T1MEpDB4OS7GcAEquuAMfpwCdrZ7mLEjC
i2pwdXBOrqYLK3bPVRJ4XD2ddmhrrKZBA+EA4YuLmEM4dL2Pe1cQAvtdZPDpKkZN
G1K8W4/lwIEo6K7RjIHiFP4PJvkfySfEgJasAuRDUkCjAMHqY05TM3J+g/Y0ivZe
sP7DlSLyXsvXerX63l2XNaIRcJowMViVoAJJNnoADOlFdMnsQAU=
=I82m
-----END PGP SIGNATURE-----

--Apple-Mail=_69130B7D-C680-4EA1-BD75-2A1DE933914F--
