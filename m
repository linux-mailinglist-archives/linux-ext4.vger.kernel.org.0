Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295D1154F2B
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2020 00:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgBFXEV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Feb 2020 18:04:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36389 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgBFXEV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Feb 2020 18:04:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id 185so235118pfv.3
        for <linux-ext4@vger.kernel.org>; Thu, 06 Feb 2020 15:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=lDxEprEWyjgVB8CFQur8hS5vSTDwtBP1qgzCvJ8xlq4=;
        b=ZS9W7epwrqcwrAzzRJVP8/PPEXCkybHYrECSzVr4ED3MfVuO2eTY+49i0hzMCAyw2O
         65EqdJOZMdmc7s2UTv0d1YnOXwRdTP2r2HZyYzOrX6OnW4bRBAYrgY6RS+zMjXNYPcpe
         lnydhkniooQI2e80eDqpplHIUkGXZfFybLHbrDS3avaGul57Nhh22HladkV0k3+ywps8
         oQHMZbQ8h27SWomfY4z7AxILRpyV2WRkkBDXf4MkHvRSTqWpetVibx/VOMPlVSQuFtLE
         gf+u+zEIA8XClfSNKTJLF0aQ5n0CaIizcnjz/I9BgTVc3lAEXNRtrklTBU/6p3dazcqb
         dLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=lDxEprEWyjgVB8CFQur8hS5vSTDwtBP1qgzCvJ8xlq4=;
        b=VmRgD6D1bTDUORKrbfjZpScegMk4JAsxFs8s7eJCumk/Xavd4QiO33XY59H4M3/JBN
         +nUIcNr3iHKOTImglGNStdgpsGR4TkKqgUpGmgAQTi7S1O0Tg36cj24W9FaklGvnOVqS
         dWJYW8Y5LeIz3idbWdxKR/MRUn3vOfxdFBv1tHpRbyI6sSoyKwKgDmamtuxnfNmlaxXy
         oWUta2DoN2r7GhHCQ9CKGmXaTOjLsMPp4gUT8RjaRmdXyDk2cng6oD8diMNulzvldQfw
         lEN/21sLR+U9nNlh3gVJ4Wrt3LMHFlFoACb/qKmviP/aeWpxED4GQkft9ITkJSALLP3i
         tYBg==
X-Gm-Message-State: APjAAAXwqDTwF9ucbxOkmGKo69FxagQrcdwwz3BRWVZokv1MWGfap8wL
        HaoCGmChCymCL/wXa8xvKi6AX3fT6JASUw==
X-Google-Smtp-Source: APXvYqy7HA3s5RZemRjG2Jm+02ESW7pMIaleJf9NWjBjCqwDUlCLdRSzw+yoLUBaKeGBWzo6ULzajQ==
X-Received: by 2002:aa7:9567:: with SMTP id x7mr6593932pfq.133.1581030260741;
        Thu, 06 Feb 2020 15:04:20 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id c10sm425121pgj.49.2020.02.06.15.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2020 15:04:20 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <ECC8B296-AB11-46B6-898E-F7A85E8AC1EA@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_732EA6A8-496B-4E9D-988E-1C24E66C8230";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/3] tests: Add tests for ext2fs_link() into htree dir
Date:   Thu, 6 Feb 2020 16:04:16 -0700
In-Reply-To: <20200206101659.GJ14001@quack2.suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4 <linux-ext4@vger.kernel.org>
To:     Jan Kara <jack@suse.cz>
References: <20200205100138.30053-1-jack@suse.cz>
 <20200205100138.30053-4-jack@suse.cz>
 <E9A04E5E-96E0-48FC-AC41-FCA8193E058E@dilger.ca>
 <20200206101659.GJ14001@quack2.suse.cz>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_732EA6A8-496B-4E9D-988E-1C24E66C8230
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Feb 6, 2020, at 3:16 AM, Jan Kara <jack@suse.cz> wrote:
> 
> On Wed 05-02-20 11:11:13, Andreas Dilger wrote:
>> On Feb 5, 2020, at 3:01 AM, Jan Kara <jack@suse.cz> wrote:
>>> 
>>> Add two tests adding 50000 files into a htree directory to test various
>>> cases of htree modification.
>> 
>> Note that there is already tests/f_large_dir that is creating a large
>> directory via debugfs.  Maybe that could be extended rather than adding
>> another long-running test to do almost the same thing?
> 
> I didn't know tests/f_large_dir exists. Thanks for the pointer. There are
> just two problems with this:
> 
> 1) I wanted to test both with & without metadata_csum because the code
> paths are somewhat different.
> 
> 2) Currently we don't have implemented conversion of normal dir into
> indexed one so I need to start with a fs image that already has indexed
> directory.
> 
> I suppose I could modify tests/f_large_dir to start with an image to
> address 2) if people are OK with that. And I could just create
> tests/f_large_dir_csum to address 1).

This would be quite a large image?  I thought "e2fsck -fD" would re-pack
htree directories (via e2fsck/rehash.c), so it seems like you could create
a non-htree test filesystem like f_large_dir, set the feature and inode
flags, and then run e2fsck -fD on it?  That would also test the rehash code.

Cheers, Andreas






--Apple-Mail=_732EA6A8-496B-4E9D-988E-1C24E66C8230
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl48m3AACgkQcqXauRfM
H+BZXQ/9H3Tv1JpO4szq7J37MaWKW/AjAlrRY9ZPcFD9jjMeRGCb5nOcHOv380w/
Q5ELja6HywX9YgKgyxfqKDLoino4eGtIYIxHBaSdtlK6uG2UwdBlk5HccjvdamXh
nlNgnPP2N5d/eLi/hZ/rrcFco+OR6po6qRbmCKb4ORdiLRgDMfFhHwb0klod+IOw
XX723j5Z5ysp7VRDk6G24TLA2JR0UjsTyKtRQJx+Z6u06IpjxZHp36HAu+zH+gTG
CXTwB2pK8Rd1ApDB4bXYmZmjDGycKjFk70un7byAd9agvLeyT1+/sfrkKnRGpXz5
Al5Retd273IGvuOAi20aRw77BDjebyJj5Co74na9IYDwcFxQJQRcJR19IEuJkf1k
RiotTmV5lpD4bRz2HR41Oru/4Pa9o3CuJsTwM8zZxd/kL5efgPFII1OR0IdZ1/0h
6S0yZgsMh5eoLFcO8YstmiurJXq23gViYiVO2o7laTTMc4fo0qG5As8pXbSj/Wr8
qYA029DhhbMB+PlHVkmLgqzkU/sPdEFwEAr00XwFRXknvnFMOSoxujg+nvXKa9pU
Ja2q1K/XJxQ5RC78ZzgijqFELemM4tu4MwNl5vv96iPZKlufZDqEhGvlSdi9NBZk
p5OT7/mVTr9QfDCRzB06ZtIRlBL0JpTzZUe66En0Bbyzd1uRcKQ=
=ikUy
-----END PGP SIGNATURE-----

--Apple-Mail=_732EA6A8-496B-4E9D-988E-1C24E66C8230--
