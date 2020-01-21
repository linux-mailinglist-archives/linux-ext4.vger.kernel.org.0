Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2011435A0
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2020 03:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgAUCUs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Jan 2020 21:20:48 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:39912 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbgAUCUs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Jan 2020 21:20:48 -0500
Received: by mail-pl1-f181.google.com with SMTP id g6so639185plp.6
        for <linux-ext4@vger.kernel.org>; Mon, 20 Jan 2020 18:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=gKTcfiI7BEV5dBi1ZDWNcngdEzWt+y2lmf/m4gm2lFc=;
        b=VudShA98mGbVvJoRG8tQg5Vp1DBouHo07fF9kNGeXt60d/jYx4cEMqOP68Bh3EyM9R
         rZUp32fKPfOsX8yYGf/R8fpGy8UYm73pqgvVDzvej22DyN0ZpGwlV0cq71GS5E9ZO72Z
         qfEKH0RlbAmfD303U+K1+nCW9KVVed/AD/irN/Zwy6m2qCW7GHRbyhK92vHnuWDUzQQN
         +EN27FboM0bmG2qOaUuXH/tCAI7KSr0EGvkLYrvjU7b0KxABo4KYQm8yAQlLy+sXO6jZ
         5S8wpwYFry0pcd/Lfu5Pk7CoQ66vujBhaVKYwhOoieeloFWNFq6zF8cp3IzNX4x5uejX
         lF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=gKTcfiI7BEV5dBi1ZDWNcngdEzWt+y2lmf/m4gm2lFc=;
        b=XwktrvQAyrz3WeXJbZW08h532yuuQiSxEYjrhrrlI91qGbPpGblD6BdB4RzK4L8QCc
         prq0qXrKXWp+q3v5ggxaD9AaDxB/VBk3TPWrXcHFierREg5msP1xAAA68Q79Fbm+jIVv
         tNUPTkhxjluO8dEB2r0qZ2hIFqCtQA6DKhjW4Ui5/c41lr56s5UAedlUWhC9oSwzgHJX
         QnPsSu38L8eYvJACpPMAyBJdkv+Ib0jlbJMBI41uRNtveXEovpC4S9HG1+4Sn6Onk0cE
         kteE6IYGnEe6ssyljQklu5UmTa9rgbgAeiv3ctZbNzjzu2FfmIEavPIMzDk7iJADw7fe
         9dIg==
X-Gm-Message-State: APjAAAUM9mO3pWo1y4MeFcctY0mKSg7po00awQPbp2nG+0/bR7tQ8ke8
        BlvR2ppQG/zr1/qB5/g/YNuOMQ==
X-Google-Smtp-Source: APXvYqwGWT53f+KGRdJiL30xpNo0PQWt4Ed6VcKkdNsdN3/5w+/cDnCLgC8czF+++ukGisI3xdggyg==
X-Received: by 2002:a17:90a:bc41:: with SMTP id t1mr2475970pjv.137.1579573246965;
        Mon, 20 Jan 2020 18:20:46 -0800 (PST)
Received: from ?IPv6:2605:8d80:425:93b9:5dae:c2cd:919d:b9d9? ([2605:8d80:425:93b9:5dae:c2cd:919d:b9d9])
        by smtp.gmail.com with ESMTPSA id y21sm40576568pfm.136.2020.01.20.18.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2020 18:20:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: ext4 recovery
Date:   Mon, 20 Jan 2020 19:20:43 -0700
Message-Id: <1E3CE46B-2B81-42C0-A50A-02216CC6D8D1@dilger.ca>
References: <CAAMvbhGeRv1ipkUjauArjX8r03SCZnmb+aPtrtCEu4g6W8Cqcw@mail.gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>
In-Reply-To: <CAAMvbhGeRv1ipkUjauArjX8r03SCZnmb+aPtrtCEu4g6W8Cqcw@mail.gmail.com>
To:     James Courtier-Dutton <james.dutton@gmail.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

You can use "filefrag -k" to get units of KB instead of blocks for the physi=
cal offsets of the files, and "lvdisplay -m /dev/XXX" to show the mapping of=
 LVs to disks (not sure if you can get it to print different units, or just L=
E number and you gave to multiply by the LE size).  Hopefully the LV was lay=
er out linearly and is just a matter of computing "> X and < Y" to determine=
 the affected range.=20

Note that it is likely that some files which were on the second disk will no=
t show anything from filefrag since the inodes were zeroed out by dd_rescue.=
 Some files on the second disk that _do_ show blocks that were allocated on t=
hat disk may just have zeroes for the data.=20

Cheers, Andreas

> On Jan 20, 2020, at 15:07, James Courtier-Dutton <james.dutton@gmail.com> w=
rote:
>=20
> =EF=BB=BFOn Tue, 14 Jan 2020 at 21:25, Theodore Y. Ts'o <tytso@mit.edu> wr=
ote:
>>=20
>>> On Tue, Jan 14, 2020 at 04:03:53PM +0000, James Courtier-Dutton wrote:
>>>=20
>>> Say I started with 1 disk using LVM with an ext4 partition.
>>> I then added another disk. Added it to the LVM group, expanded the
>>> ext4 partition to then fill 2 disks.
>>> I then added another disk. Added it to the LVM group, expanded the
>>> ext4 partition to then fill 3 disks.
>>=20
>> Where you using RAID 0, or some more advanced RAID level?
>>=20
>>> One of the disk has now failed.
>>=20
>> How has it failed?  It is dead dead dead?  Or are there a large number
>> of sector errors?
>>=20
>>> Are there any tools available for ext4 that could help recover this?
>>> Note, I am a single user, not a company, so there is no money to give
>>> to a data recovery company, so I wish to try myself.
>>=20
>> How valuable is your data?  The first thing I would recommend, if your
>> data is worth it (and only you can make that decision) is to create a
>> new RAID set (using larger disks if that helps reduce the price) so
>> you can make an block-level image backup using the dd_rescue program.
>>=20
>> If you can, then run e2fsck on the backup copy, and then see what you
>> can recover from that image set.  This will save time (how much is
>> your time worth?) and perhaps increase the amount of data you can
>> recover (how much is your data worth?).
>>=20
>>                                        - Ted
>=20
> Hi,
>=20
> Thank you all for the help.
> I have made some progress.
> Disk 1 is 100% OK.
> Disk 2 did dd_rescue and recovered about 30% of the sectors.
> Disk 3 is 100% OK.
>=20
> I have made images of all of that. LVM worked out what order they went
> in, and ext4 even let me mount the LVM volume.
> I have managed to recover a lot of the data, so thank you for the hints.
> What I would like to do now is find out which files were on Disk 2.
> I have found the fiemap  IOCTL that gives me the logical sectors for
> the file itself.
> How do I convert the value from the IOCTL into a physical sector, or
> at least an offset into the LVM volume?
> I can then work at that sector 0 to A is on Disk 1,  A to B is on Disk
> 2, and B to C is on Disk 3.
>=20
> For example, this is how it is done on btrfs. What is the equivalent on ex=
t4?
>=20
> $ sudo filefrag -v UEFI_Spec_2_8_final.pdf
> Filesystem type is: 9123683e
> File size of UEFI_Spec_2_8_final.pdf is 18586279 (4538 blocks of 4096 byte=
s)
> ext:     logical_offset:        physical_offset: length:   expected: flags=
:
>   0:        0..    4537:    9798022..   9802559:   4538:             last,=
eof
> UEFI_Spec_2_8_final.pdf: 1 extent found
> $ sudo btrfs-map-logical -l $[9798022*4096] /dev/nvme0n1p7
> mirror 1 logical 40132698112 physical 31475654656 device /dev/nvme0n1p7
> $ sudo dd if=3D/dev/nvme0n1p7 bs=3D1
> skip=3D31475654656 count=3D64 2>/dev/null | hexdump -C
> 00000000  25 50 44 46 2d 31 2e 36  0d 25 e2 e3 cf d3 0d 0a  |%PDF-1.6.%...=
...|
> 00000010  33 30 35 35 31 39 20 30  20 6f 62 6a 0d 3c 3c 2f  |305519 0 obj.=
<</|
> 00000020  46 69 6c 74 65 72 2f 46  6c 61 74 65 44 65 63 6f  |Filter/FlateD=
eco|
> 00000030  64 65 2f 46 69 72 73 74  20 31 31 37 39 2f 4c 65  |de/First 1179=
/Le|
> 00000040
>=20
>=20
> Kind Regards
>=20
> James
