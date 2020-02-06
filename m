Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 515B2154F21
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2020 23:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgBFWzN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Feb 2020 17:55:13 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40208 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgBFWzN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Feb 2020 17:55:13 -0500
Received: by mail-pg1-f194.google.com with SMTP id z7so74073pgk.7
        for <linux-ext4@vger.kernel.org>; Thu, 06 Feb 2020 14:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=dsbZx04BP58Kad8ahAxrW/Em2WhpcJcnn4QtowJaqkU=;
        b=2AN2a/MDPzO60PsgFwErTS9tCXCdwb8VIzHe0aReb+owvhVG+1peh83NHm1BtW1cR2
         vdz7rI7+WKlUbCiiF/3nprHC2FmrrsOZ1r0/UgblfIp5DHtPvBCy2o5ZDT5IiGBhvYOt
         Bp1S9WEmqqNC3JzkgOB+cncaZtGkOuqYrkV38ObNsWn/FrvHO9R3s1qAXKnzO4LVlrfe
         Yb+2MsrTCFETzvSvI58PvB+xOicdUNxYlpJFL3i8/2vMWfjttbVG1ovnnzL++buHCrz7
         Yx8hrEGz0qJSYTvKF3+8q10EJRFx3YHdiYowLgzSICLwU8uEKw1TE0UXa/fsz9o2VQkj
         ZZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=dsbZx04BP58Kad8ahAxrW/Em2WhpcJcnn4QtowJaqkU=;
        b=kP0hqTWdf8Splta/9GJkMCbK/XkTOxZQUjbhY9I7mp2d/9IVzCuByo2kGe2aFYCm2p
         62TAsNGVRd1srrdz80Sy54OPW25ChyXNUMQ5cC+MlT2cANYLqbsZlYaxwO5FCGvdWnOE
         Lnvbfk/MfhQLu2G1dY1Uogq6WYJJ4S+XvcYyuSZpbaSSG3P2y3Uljcc1c1NZE/W34UiV
         suByKjMAwscWvMOaQuZTLuf8+PBds4bGTF2BfaQ6dkuISHWBOlGttta72K0suIaU4rG+
         Y6lZuQgOdGg+IrrJbGaq4LLMP3gBkOBuyLXfDwoCgDdbOPFBR+eEqetgrOWgjNbyZZRH
         l6/w==
X-Gm-Message-State: APjAAAXgQ4veR2OLRSvEfL+qhJIOCePo4ZfpnX9vqNO+yu3Asf14nfFk
        o3dvNpesPIjtGJC4S8uv1ed41KnYV/MozA==
X-Google-Smtp-Source: APXvYqwoaMFjroNsCEQhtQbHpvTRTNBsdn6OB8NGM1GnK9n1vryBCmQgALmkXEXaOzO0bubVLdUP6g==
X-Received: by 2002:a63:f402:: with SMTP id g2mr5746645pgi.405.1581029710956;
        Thu, 06 Feb 2020 14:55:10 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id x21sm411964pfn.164.2020.02.06.14.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2020 14:55:10 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <B9D2B0DE-EAD0-461B-9BA3-E55ADDE38F72@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_7CDF64A9-C7FD-4E08-9AB4-1843C57439EC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: EXT4: unsupported inode size: 4096
Date:   Thu, 6 Feb 2020 15:55:04 -0700
In-Reply-To: <20200206153542.GA30449@MAIL.13thfloor.at>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Herbert Poetzl <herbert@13thfloor.at>, Ted Tso <tytso@mit.edu>
References: <20200206153542.GA30449@MAIL.13thfloor.at>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_7CDF64A9-C7FD-4E08-9AB4-1843C57439EC
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Feb 6, 2020, at 8:35 AM, Herbert Poetzl <herbert@13thfloor.at> wrote:
> 
> 
> I recently updated one of my servers from an older 4.19
> Linux kernel to the latest 5.5 kernel mainly because of
> the many filesystem improvements, just to find that some
> of my filesystems simply cannot be mounted anymore.
> 
> The kernel reports: EXT4-fs: unsupported inode size: 4096
> 
> Here is a simple test to reproduce the issue:
> 
>  truncate --size 16G data
>  losetup /dev/loop0 data
>  mkfs.ext4 -I 4096 /dev/loop0
>  mount /dev/loop0 /media

Does this still fail if you also specify "-b 4096"?

> [33700.299204] EXT4-fs (loop0): unsupported inode size: 4096

It looks like this is a bug in the code?  This check is using

3641:	blocksize = sb_min_blocksize(sb, EXT4_MIN_BLOCK_SIZE);

3782:		if ((sbi->s_inode_size < EXT4_GOOD_OLD_INODE_SIZE) ||
3783:		    (!is_power_of_2(sbi->s_inode_size)) ||
3784:		    (sbi->s_inode_size > blocksize)) {
3785:			ext4_msg(sb, KERN_ERR,
3786:			       "unsupported inode size: %d",
3787:			       sbi->s_inode_size);
3788:			goto failed_mount;
3789:		}

which is set from the hardware sector size of the device, while
the ext4 filesystem blocksize is not set until later during mount:

3991:	blocksize = BLOCK_SIZE << le32_to_cpu(es->s_log_block_size);

It looks like this was just introduced in commit v5.4-rc3-96-g9803387
"ext4: validate the debug_want_extra_isize mount option at parse time"
so it is a relatively recent change, and looks to be unintentional.
This check was previously on line 4033, after "blocksize" was updated
from the superblock, but it wasn't noticed because it works for all
"normal" filesystems.

I suspect nobody has noticed because having an inode *size* of 4KB
is very unusual, while having an inode *ratio* of 4KB is more normal
(one 256-byte inode for each 4096-byte block in the filesystem).  Was
the use of "-I 4096" intentional, or did you mean to use "-i 4096"?

The only reason to have a 4096-byte inode *size* is if you have a
ton of xattrs for every file and/or you have tiny files (< 3.5KB)
and you are using inline data.

> Note: this works perfectly fine und 4.19.84 and 4.14.145.
> 
> My guess so far is that somehow the ext4 filesystem now
> checks that the inode size is not larger than the logical
> block size of the underlying block device.
> 
>  # cat /sys/block/loop0/queue/logical_block_size
>  512

Yes, this appears to be the case.  We have LOT of filesystems that
are using 1024-byte inodes, but I suspect that most of them are on
devices that report 4096-byte sector size and/or are running older
kernels that have not included this bug.

> Any ideas how to address this problem and get the file-
> systems to mount under Linux 5.5?

Probably the easiest, and likely correct, fix is to move the update
of "blocksize" from line 3991: up to before this check.  There are
a bunch of sanity checks that should also be moved for a proper patch,
but the one-line fix is enough to get your filesystems mounting again.

Cheers, Andreas






--Apple-Mail=_7CDF64A9-C7FD-4E08-9AB4-1843C57439EC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl48mUgACgkQcqXauRfM
H+ASGg/8DycAju0NbXzVaKiOvovbvjZRyJq7nF6M+KBJevm0928uLjg8qkWvIdXp
Jj1AM93mikp4A/BULggBBpa8wOCIG9Z7bx1tATaQrvQh/3cI5KuWd7ssfTR9INWJ
yzgZ1Y/1vjwiU/YD1i922CK4M3sEwmB5fzrNC/H9HruwHpuMe0ek44lNmsuNPjGh
c+hBkTFlmOPF9n9bW4mr2Da/v1BA+ffSI2NJW3TejR7k6UvvNKWpLrbzheMSMVCf
y5xuD9mWuh/1FL77tdDfDVbPo6VRS6I1JBoz14EUl9mz6IrCWulVgIIi/7NzRviF
onDLo/t3pA/2Yx5G+AAVsIM9tClXXGbNT4WquU2vrO9CdnuRT6rr1pc8vKCz7lch
2US+UhmorTVVd/NeXQMxT2i6NPNbRsoaBqxP5TcLAtp8b5aDAUCUSAHyIEWtoydm
GRPRfXZJauqBYDffGdBWsvsMmepceMC4CMiezfoIWBbfnMfH8wVI+D3qEO6gLDkr
sNm1/dl/7BfIFjF3ndItsgKTVCGIiFgQ86juEDwDwO/+UB9O9K7nngoEe0ZLt/sy
Kn7RLdkOGR689vc/1WArbM31HntWbp88xTe3s2tPlWv4r9hVZebZXFIAYrwvqviS
NrZwqOyjeAmlHWJcqaXQS7kV6tYDpT6Je7weNgZmQA1Xc7Ig12o=
=rKs+
-----END PGP SIGNATURE-----

--Apple-Mail=_7CDF64A9-C7FD-4E08-9AB4-1843C57439EC--
