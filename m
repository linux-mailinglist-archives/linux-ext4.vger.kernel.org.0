Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B94346F718
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Dec 2021 23:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhLIW5e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Dec 2021 17:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhLIW5e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Dec 2021 17:57:34 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87075C061746
        for <linux-ext4@vger.kernel.org>; Thu,  9 Dec 2021 14:54:00 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id m9so8572985iop.0
        for <linux-ext4@vger.kernel.org>; Thu, 09 Dec 2021 14:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ddbCBX3awRco9qgsSJyX2GrKTiTQPUVei6yauK8tDak=;
        b=nLNFareXUNf9NtMHJArow8+361HHDPvLyLMnKzDGM976pG9dBeuVt2LPW5b2lJ6FYr
         6azknIPPghUReSoVy0B93gdVRWHk1OsBI3M+weJ6bY3Ka8dyCc/qMHzCzhSpFdTGtRbG
         7UJIHLTViVgal8V7e+3oRXPIGTZb7JCLywr/8rHvd2OLC+uKoDI+9p5fEt1ngU8E/GwI
         5Bb3KCUqYRQ8uFM12huL6jlGRsvI8vaxnYnVSkUyY/wgQ51Irst1N0pMVbBuJefwbhm+
         ww9hFyIaeQxmh5CofUIZ46S8hzHwcG+aHnlmwW71rRKbHjGk+rHMTMRpODLWUuiOIPar
         ydAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ddbCBX3awRco9qgsSJyX2GrKTiTQPUVei6yauK8tDak=;
        b=paB9mYgkyl9ItN7lPO+w0Yfx+faw3bxtzkHOCOqQp0VoYPOMFlVqvtKC9TG/Un7zug
         6j5h3pdLOEBCmriy/Cyi9VL1TupIrHyOC0Mfc4J799KH9z1wcWC9ysf7++wO+fPItEjp
         3Gfuc0xXarArVli2JjBz82rMweWgF+hM6UezPcV0YlTWaKAO6rw1FpyalKwZgp25gmHI
         1lInp58PjHYa3zFoFJK+cUT/2+/xuN6FGOwTS6pB/g0Vt0BIujEZP+4UrZxFkkPBcHfI
         X6EZsDuPJVJQZRb/uVCdWHoyC6ap2IyTIw22vCeqrem61iTpUtxmPacqTkQIwo56sPKu
         ZYZw==
X-Gm-Message-State: AOAM533PkEQnTfVXuc2z1UXjUMoZ51cmAGwAI0aRWnrNb+3ZDO3Iqfbu
        M6rTG4LwFN7MWxBo5fJGvOhKgg==
X-Google-Smtp-Source: ABdhPJwArPi/f5H92u3w8OAUw71amZt0I7qxdnW7z4fpxpa2xdb5ERwtx7ospVqk+xEC3U6vf4Tqkg==
X-Received: by 2002:a05:6638:140c:: with SMTP id k12mr13036124jad.89.1639090439941;
        Thu, 09 Dec 2021 14:53:59 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id f21sm655658iol.42.2021.12.09.14.53.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 14:53:59 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F12B316D-D695-4B38-ABEA-D5F558696E9A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C2822BFF-7698-448F-9046-0070E99BBA67";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: compare inode's i_projid with EXT4_DEF_PROJID
 rather than check EXT4_INODE_PROJINHERIT flag
Date:   Thu, 9 Dec 2021 15:53:55 -0700
In-Reply-To: <Ya+3L3gBFCeWZki7@mit.edu>
Cc:     Roman Anufriev <dotdot@yandex-team.ru>,
        linux-ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Wang Shilong <wangshilong1991@gmail.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Y. Ts'o" <tytso@MIT.EDU>
References: <1638883122-8953-1-git-send-email-dotdot@yandex-team.ru>
 <alpine.OSX.2.23.453.2112071702150.70498@dotdot-osx>
 <Ya+3L3gBFCeWZki7@mit.edu>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_C2822BFF-7698-448F-9046-0070E99BBA67
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Dec 7, 2021, at 12:34 PM, Theodore Y. Ts'o <tytso@MIT.EDU> wrote:
> 
> On Tue, Dec 07, 2021 at 05:05:19PM +0300, Roman Anufriev wrote:
>>> Commit 7ddf79a10395 ("ext4: only set project inherit bit for directory")
>>> removes EXT4_INODE_PROJINHERIT flag from regular files. This makes
>>> ext4_statfs() output incorrect (function does not apply quota limits
>>> on used/available space, etc) when called on dentry of regular file
>>> with project quota enabled.
> 
> Under what circumstance is userspace trying to call statfs on a file
> descriptor?

Who knows what users do?  Calling statfs() on a regular file works fine
(returns stats for the filesystem), so I don't see why it wouldn't be
consistent when calling statfs() on a file with projid set?

Darrick, how does XFS handle this case?  I think it makes sense to be
consistent with that implementation, since that was the main reason to
remove PROJINHERIT from regular files in the first place.

> Removing the test for EXT4_INODE_PROJINHERIT will cause
> incorrect/misleading results being returned in the case where we have
> a directory where a directory hierarchy is using project id's, but
> which is *not* using PROJINHERIT.

One alternative would be to check the PROJINHERIT status of the parent
directory after calling statfs() on the regular file?  That should
keep the semantics for PROJINHERIT the same, but avoid inconsistent
results if called on a regular file:

#ifdef CONFIG_QUOTA
-	if (ext4_test_inode_flag(dentry->d_inode, EXT4_INODE_PROJINHERIT) &&
+	if (ext4_test_inode_flag(S_ISDIR(dentry->d_inode) ? dentry->d_inode :
+			   dentry->d_parent->d_inode, EXT4_INODE_PROJINHERIT) &&
	    sb_has_quota_limits_enabled(sb, PRJQUOTA))
		ext4_statfs_project(sb, EXT4_I(dentry->d_inode)->i_projid, buf);
#endif

Roman, does that work for you?

Cheers, Andreas






--Apple-Mail=_C2822BFF-7698-448F-9046-0070E99BBA67
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmGyiQMACgkQcqXauRfM
H+CCSw//c5KRr2+fNWWTam4EL3ayPROZZIzSu4GS3zoR1Ox8nWQLMuYuKm8ScxbO
INKFQgdWuJTy6+751KO8vWSU1F8kIRJYOM8cYUbyTp5xH2r/7Rnw32oXvXEDu993
ahe91eje2AtenQNugfR11YxXtTxBNyCxde97DfvFStyoLpGJOekPKcNsiHfda2mc
e2sYQKA0z5bF959O0fnOLDAYjP5Vw8AM6hS4LZaFho0V1D4u6xeJdf8OO6GN/z/3
TLRxicnax9FxdejBoNM1YsVXnXg7R3piL5sd+/X9EeRxNGUvyaxvWPd9qyGawMhh
PcRkEsQ7dsvJfwxsxDosyNLL9fg/d4kDK5OyHRWsfD1uP0NcIhWqrHQKJCvSgsG7
NW/xf/38/Ruu4JXWdaaGO7CbLt43jizTdWF6N9A+xzs1xxtQr/TgWrvzh/ODaC3M
rAwLUH44XxUSMHq9MrCdogwmN45u1QGInlOm0A7XKARHPkWiqcpoZITSkmfkler9
zL+q5OdCm1Spn/yyNtkVxuyCYJfXEyfNiWJkLhdWe9dhslSSRak8L0dYm318Rmdf
jOD1vVz4AzvGZImiLLsoxMI2fgWq7H3fwT1vMH5rnOb3kFEVry8huNbH4NJsq1zT
GpBAusFyPXZVY+tkldMFEizvBk5P1rXf0m+DOawdk6dUJLYp27E=
=zXs8
-----END PGP SIGNATURE-----

--Apple-Mail=_C2822BFF-7698-448F-9046-0070E99BBA67--
