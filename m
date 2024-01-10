Return-Path: <linux-ext4+bounces-770-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E51BB82A502
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jan 2024 00:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EA80B2196F
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jan 2024 23:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E614F8A0;
	Wed, 10 Jan 2024 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="gKB0ZA09"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEE050241
	for <linux-ext4@vger.kernel.org>; Wed, 10 Jan 2024 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cf23a3d3bdso743832a12.0
        for <linux-ext4@vger.kernel.org>; Wed, 10 Jan 2024 15:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1704930205; x=1705535005; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7tZ/itPf0PcmMU/D2GOEXGJ94ZxtMG4+RI+0B/8JLZ4=;
        b=gKB0ZA09t7cw40BtNgt96x++hLQcTLPFFXVLRsY3xUCwRUPgGNjHyFAov9/wfmi5yE
         rrq5KQ8z9CRAti5rRb5teo8NcmHab2BKYPtf3G5JxR1FA866OZYZPEZh3/mlOjFJjKhK
         4gu47eAqXOqPc8VcD9M6+vKzQ/y99KeiREi5ncDp4bVyzfHHtraigfZ5dMEEXgdXq0II
         n2HiHVhtO5G6hpM4hiiwGzgdgx1KkbQ76+lW37+8mO/zGl/mICyKar++YGQrbJADIyxz
         YnYnZxoa4sWR4x8Z3WvQW8caKpbmXmtSSFwPu9OEvFcOFtLXp30vtLrhNONDcLdGiigV
         dndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704930205; x=1705535005;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7tZ/itPf0PcmMU/D2GOEXGJ94ZxtMG4+RI+0B/8JLZ4=;
        b=oBNGUMhdBdlEfsrnYXEtS4MQT0tXDjuZXp2tFW6Q73ZumMqDJjFiik/FuCM1qbLOjV
         iDQZl7kS7BGU6UttYhy9NFxjbFKY1tIYNPvbt4SYEBDtRYfmlqjLWi6Oq3EnHw6dIl3K
         ZJUTYrSarrqX9zThzVbuquN5JlxouIFb1Dw2zO9ALKcBAr/OllwrcFCJNsBD9TCYCnMu
         JQtfGKv48CoXVuBZd33XsZW5vy0illf1Ox4NZyoaLIgmbwaVTqkE3tGmaRSze/QUk1+Z
         crCcyjUmQulIILQiZrTGSz4B/WkPiEqF996JNz3zFQolVrQzxbEjLCj4CMfRY4iBFx2V
         pYXg==
X-Gm-Message-State: AOJu0Yw5FIFAirsQmCZPtFklHoRtUT/gX+OLtFNile/PVxbZU/S0xMV7
	XYZv/1qFYxxLf67KdxBI8OG+6sFAVke//OLqoMBx4kWUD3I=
X-Google-Smtp-Source: AGHT+IGdei13IR7xgwTve8y28E+k7Eq7BrruBBRCbOcTFHFWVv26V5QM1BJXoWVIwkLmcoRsdtFBng==
X-Received: by 2002:a17:903:2784:b0:1d4:d0e8:f9d2 with SMTP id jw4-20020a170903278400b001d4d0e8f9d2mr304012plb.93.1704930205515;
        Wed, 10 Jan 2024 15:43:25 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902a70d00b001d54c41d8b6sm4178153plq.45.2024.01.10.15.43.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jan 2024 15:43:25 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <89CC4453-BFA0-485C-8532-B0B38D60B6D4@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_68609F1E-ECC5-4322-BEF6-564449462057";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: e2scrub finds corruption immediately after mounting
Date: Wed, 10 Jan 2024 16:43:23 -0700
In-Reply-To: <20240110180614.GE722946@frogsfrogsfrogs>
Cc: "Brian J. Murrell" <brian@interlinx.bc.ca>,
 linux-ext4@vger.kernel.org
To: "Darrick J. Wong" <djwong@kernel.org>
References: <536d25b24364eaf11a38b47e853008c3115d82b8.camel@interlinx.bc.ca>
 <20240104045540.GD36164@frogsfrogsfrogs>
 <cf4fb33f3a60629d3b6108c1c206aa5b931d8498.camel@interlinx.bc.ca>
 <01b2c55a334cf970e49958a5f932d5822bfa74b4.camel@interlinx.bc.ca>
 <20240109060629.GA722946@frogsfrogsfrogs>
 <20240110053135.GB722946@frogsfrogsfrogs>
 <36ab91c95ce476cdf38977c8f2a8ca4c4fdf2a47.camel@interlinx.bc.ca>
 <20240110180614.GE722946@frogsfrogsfrogs>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_68609F1E-ECC5-4322-BEF6-564449462057
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jan 10, 2024, at 11:06 AM, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> On Wed, Jan 10, 2024 at 08:44:31AM -0500, Brian J. Murrell wrote:
>> On Tue, 2024-01-09 at 21:31 -0800, Darrick J. Wong wrote:
>>> 
>>> AHA!  This is an ext2 filesystem, since it doesn't have the
>>> "has_journal" or "extents" features turned on:
>> 
>> This is very odd.  I haven't (intentionally) created a ext2 filesystem
>> since ext3 became available.  :-)
> 
> Huh.  Do you remember the exact command that was used to format this
> filesystem?  "mke2fs" still formats ext2 filesystems unless you pass
> -T ext4 or call its cousin mkfs.ext4.
> 
>> Moreover /proc/mounts says it's an ext4 filesystem:
>> 
>> /dev/mapper/rootvol_tmp-almalinux8_opt /opt ext4 rw,seclabel,relatime 0 0
> 
> Check /etc/fstab -- if the type is specified as ext4, then that's what
> ends up in /proc/mounts, even if it's an ext2 filesystem.
> 
>> Do ext2 filesystems actually mount successfully and quietly when
>> mounted as ext4?
> 
> Yes.  Most distros enable ext4.ko and do not enable ext2.ko, and the
> ext4 driver is happy to mount ext2 filesystems but report them as ext4.
> 
>> Surely if one asks to mount an ext2 filesystem as ext4 mount should
>> fail and complain, yes?
> 
> Nope.  ext4 is really just ext2 plus a bunch of new features (journal,
> extents, uninit_bg, dir_index).  Or another way to look at it is that
> ext2 is really just ext4 minus a bunch of features.
> 
> Muddying the water here is the fact that you're allowed to turn /off/
> all these new features from the past 20 years, which means that the
> integer after "ext" is not actually a gestalt id.
> 
>> Is https://ext4.wiki.kernel.org/index.php/UpgradeToExt4 still
>> considered accurate, in terms of an in-place upgrade of ext2 to ext4
>> being sub-optimal?
> 
> Yes, that's accurate.  It's suboptimal in the sense that you ought to
> back up the directory tree before running any of those commands in case
> something goes wrong (program bug, power outage, etc) but if you have a
> backup, you might as well format fresh and restore the backup.
> 
>> Is metadata locality the only thing you don't get with an in-place
>> upgrade?  If so, how important is that, really?
> 
> IIRC I think you don't get flex_bg, which means that the bitmaps are
> every 128M instead of every 1G or so, which leads to more seeking.
> 
>>> Thanks for the
>>> metadump, it was very useful for root cause analysis.
>> 
>> NPAA.  Thank-you very much for your time and analysis on this issue.
> 
> No problem.  It's always fun to do a bit of Why, Tho? ;)

Hello Brian, long time no see!

I was wondering if this might be a case where e2fsck removed the journal
on an ext4 filesystem, and then it wasn't recreated (e.g. if e2fsck was
killed before it finished cleanly).

However, looking at the features enabled on the filesystem, it definitely
looks like this was originally formatted as ext4.  Like Darrick mentioned,
it is missing flex_bg, along with a whole slew of newer features.  On one
of my local ext4 filesystems it has:

 Filesystem features:      has_journal ext_attr resize_inode dir_index
     filetype extent flex_bg sparse_super large_file huge_file uninit_bg
     dir_nlink extra_isize

compared to your filesystem:

 Filesystem features:      ext_attr resize_inode dir_index filetype
     sparse_super large_file

Many of these features can be enabled on an existing filesystem, like
has_journal (ext3/4 journal), extents (improved large file allocation),
huge_file (> 2TB files), dir_nlink (> 32000 subdirs) if you want them.
I _think_ uninit_bg (e2fsck skip unused metadata may) is included here.

Some cannot be enabled on an existing filesystem like flex_bg (localized
metadata), and extra_isize (fast xattrs).

Whether that is worthwhile for you to enable, or just backup/reformat/sync
is up to you.

Cheers, Andreas






--Apple-Mail=_68609F1E-ECC5-4322-BEF6-564449462057
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmWfK5sACgkQcqXauRfM
H+BgnxAAuiMB8PPsERjKRiYuLNzjGLa0tKFH0xWMqB1WwyDofru97K1ayRaz3IZ1
WUGkDk7PbEQQ7dHaSUmEdeG7LpmQ0IUyiYrvNan490anmFtJH9tfSaJBLGstFDXx
iJHcoAlRVux+JcB1TauVnXEiK9Xy+RlXK8bNPxUkv5B9APDgwno4zXUYbXggPjOY
PFHtf/qsoVUHbU/cGSr6FodDf9nOEM5wDSYQuw2d31qoy7P1V8EJbEhY0T9y5BlQ
owLcXvDarwPVwmNzCnR9ssddgAbq3XOqu8Aycg78K/7qppGFyN5KKNI7Sf7BC1ne
O5RBVQMN0MUvnu2Mq/8Y0PT85W772/Emsx8l1jq2nXZHL/nipT0abkG4gZNLTdtx
2Y9Efc4Q4TXXX3XV2WJAHTMvCcALxARZNVoG1ImnAYNRTPubT4IFnntd/J3oLrKG
tBJZY4Q3W3+TOPwV+XaUoPp2sNrfeyNLXw57ccbTxNjAZpCs46JXCMY6Gisn+7RC
DI/C2XRpcDZGL+nVHTHbESHPTJeakf8NFEowoowYzMuN+cX94h69+amp0g05uI1Z
ZRBeycplkrQOf1c0GEhqMVAceTTUsjCqomX27FYSK9JAtemgZFAJkqo+PfSUwmEf
RXX/4OSiHCHiNUlIqvQ331z6IhpGeSbtdDPR1dz2hOvYjLwHp7g=
=75Nw
-----END PGP SIGNATURE-----

--Apple-Mail=_68609F1E-ECC5-4322-BEF6-564449462057--

