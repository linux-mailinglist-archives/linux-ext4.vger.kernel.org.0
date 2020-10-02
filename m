Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C59280C3F
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Oct 2020 04:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbgJBCLL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Oct 2020 22:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgJBCLK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Oct 2020 22:11:10 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E499C0613D0
        for <linux-ext4@vger.kernel.org>; Thu,  1 Oct 2020 19:11:09 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z19so147256pfn.8
        for <linux-ext4@vger.kernel.org>; Thu, 01 Oct 2020 19:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=/xQlxX6Lek/7s/oeDUZeLOM5ACOBxnAo54RNuA1UjC8=;
        b=n+Epag31CGvFKfLt098ROSpNKCQST4Xzbu9RkZfRMyKUX6DAMvHAB47LmcIyJd2NfM
         Ex7oWutAAan6JcixxmubINxlYapRJbE8pjPjGey9w699HgFG3srerl/EYhEb9RL3A+fa
         WbNQST/fgoQ18CkacQE5tZtvP/vYjXARikRcCclZtO+nYBRZCR3ySaydzCI1Exh6GPEV
         G6ijFI//qAVDE4xs3DKsd5Lj3jyIwRsoH3ldb4aGtNth9zEz1PNTfqQCLgNVSI80Ei7q
         Ye4uN1VvOM/wUvMQ3R3mEdTZvGDG2XwaeZM8qL287+Av3wTB38IeIEbdUDXFDXne0xTj
         GFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=/xQlxX6Lek/7s/oeDUZeLOM5ACOBxnAo54RNuA1UjC8=;
        b=Yp9yw2AwQQj9Rqc4WUvqU34mIdo6QsY3Wr03t173qGYPm42OUV0T7Elcm7zkB0Sdt/
         xmNr29MPRAK5zizm6QESs7Q+9mQeOU2KelHz/SiySdKvdlDZ4PDDkMEVt1kFJOud5zc1
         oqRjn2n2p4G37Pc/e2srUf1NZ967YVV+54gwyecKXWZggF5Ag9oqbBEUgf2vRTDb+N2R
         oE1DA0pTe5Vk0saUvQGh4eymwzhfVlfc5V+C3jWZYyn60bjTRP1q7xd6c8gPWoa0wA9Y
         Lq0raRRtvISjLGZFGpBFc495t+9PbygyPPGu4gCOZa3k7R2hYY2qsTNFebOUiAuD2XZl
         I3Iw==
X-Gm-Message-State: AOAM533RVDGECwxw2WKUiP34Ky5EqnatL6gt9hV1gbguqzP6O0I0/0iQ
        xwwGcYkbyi6NQbBFYtppsB44b9/lTYP8Z1DA
X-Google-Smtp-Source: ABdhPJwSvY9ujNjtM5o9sjHCmA4buwmObv2OsRbANI7fXsZo/JKBHDFtFWXv9Xl/LIbngzOgxbdeMg==
X-Received: by 2002:a65:5802:: with SMTP id g2mr8413486pgr.261.1601604668798;
        Thu, 01 Oct 2020 19:11:08 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id b23sm118123pju.12.2020.10.01.19.11.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 19:11:07 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <3B21D37E-AA2D-4D54-B4C7-8D094FFB766D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5133FEA4-56C1-43B0-B9F4-EA1908785C2D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] e2fsck: skip extent optimization by default
Date:   Thu, 1 Oct 2020 20:11:06 -0600
In-Reply-To: <20201001180336.GM23474@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     "Theodore Y. Ts'o" <tytso@MIT.EDU>
References: <1600726562-9567-1-git-send-email-adilger@whamcloud.com>
 <20201001180336.GM23474@mit.edu>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_5133FEA4-56C1-43B0-B9F4-EA1908785C2D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Oct 1, 2020, at 12:03 PM, Theodore Y. Ts'o <tytso@MIT.EDU> wrote:
> On Mon, Sep 21, 2020 at 04:16:02PM -0600, adilger@whamcloud.com wrote:
>> From: Andreas Dilger <adilger@whamcloud.com>
>>=20
>> The e2fsck error message:
>>=20
>>    inode nnn extent tree (at level 1) could be narrower. Optimize<y>?
>>=20
>> can be fairly verbose at times, and leads users to think that there
>> may be something wrong with the filesystem.  Basically, almost any
>> message printed by e2fsck makes users nervous when they are facing
>> other corruption, and a few thousand of these printed may hide other
>> errors.  It also isn't clear that saving a few blocks optimizing the
>> extent tree noticeably improves performance.
>>=20
>> This message has previously been annoying enough for Ted to add the
>> "-E no_optimize_extents" option to disable it.  Just enable this
>> option by default, similar to the "-D" directory optimization option.
>>=20
>> Signed-off-by: Andreas Dilger <adilger@dilger.ca>
>=20
> Applying this patch causes a whole bunch of tests fail:
>=20
> 348 tests succeeded 9 tests failed
> Tests failed: d_punch_bigalloc d_punch f_collapse_extent_tree
>      f_compress_extent_tree_level f_extent_bad_node =
f_extent_int_bad_magic
>      f_extent_leaf_bad_magic f_extent_oobounds f_quota_extent_opt

Sorry about that, I usually *do* run the tests after every patch, I'm =
not
sure why I didn't for this patch.

>> @@ -1051,6 +1053,11 @@ static errcode_t PRS(int argc, char *argv[], =
e2fsck_t *ret_ctx)
>> 	if (c)
>> 		ctx->options |=3D E2F_OPT_NOOPT_EXTENTS;
>>=20
>> +	profile_get_boolean(ctx->profile, "options", "optimize_extents",
>> +			    0, 0, &c);
>> +	if (c)
>> +		ctx->options &=3D ~E2F_OPT_NOOPT_EXTENTS;
>> +
>=20
> We already have a no_optimize_extents option supported in e2fsck.conf.
> So if we want to change the default, a simpler way to do this might be
> to edit e2fsck.conf.5.in to simply add "no_optimize_extents=3Dtrue" to
> the default version of e2fsck.conf defined by default.

Does that mean you *don't* want a refresh of this patch that fixes the
test cases?  Lukas had also been discussing how to change e2fsck so it
still fixed the inodes, but didn't print a message for each one, though
it wasn't clear to me that there is much benefit to this at all.

> As a reminder, for future changes, when we add a new tunable to
> e2fsck.conf or mke2fs.conf, the man page should be edited.

Yes, I did edit the e2fsck.8.in man page to describe the change in
default behavior.

Cheers, Andreas






--Apple-Mail=_5133FEA4-56C1-43B0-B9F4-EA1908785C2D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl92jDoACgkQcqXauRfM
H+DU2RAAkiBjFfpTq5Qy8ILi/ITFrndgR9V0qLx8lIn1Ksz+K71msZR3jolQNzle
1l/aonECbYactt1pDSZqoCnWvr+bdQtR5VZ4HK77C6N/oRniEdFpvdnPnk8gXIK+
Dy/MaapfJN1rkHgj8oTZPLhOmVEv98PDfkog3GgWDKGAkMzXkXShwtGHibxXuAk4
ipJB1yCTTxZS5y5jZBVLvwaaHX/i8NIMSMSwCb6nAs+aLR61Pto8DP2wN4AdBMNX
GEQGiKLLxzy0V0uKJHjTURt4fTxPXYo6iUn9yhMVwA0o4g1Gr+qd6qHF0IrAGWjC
xY8jIeyWB8Vl4TjQ0pyX6UOJVtjCw2yjcNGiTzPAQA9NKj2LTCGz4CF56Hyk0Guj
9MwykZF2Bkrm7ipeM06tyk6OwjVCehTMEKVVvztqjadZnu0Ccysv6KkNDpoLwlFX
KwAheWwBhES9QVRby4UOW32NePDuJFRbh94z7HiAX+C+RaUt3l365ayPL+g07QpG
s50OakzdSUKtg1oFDw9MDUwlhBrdcehkAMYDqUY+e6capw/4BRnzxM6kLJX+qbnb
nmvXyQQLxOPLZFPFyzCNg9MjdzTpcmDLXB2mtcpEDP+Won4aaUdOxiFBTMxj67k/
SNC2o/AypcLZXNzE82FeT5AhWMqr4zbJO7L/F+TIZl0aX8ciDWA=
=eUva
-----END PGP SIGNATURE-----

--Apple-Mail=_5133FEA4-56C1-43B0-B9F4-EA1908785C2D--
