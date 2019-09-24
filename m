Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5DD3BD3E9
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Sep 2019 22:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633461AbfIXU5a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Sep 2019 16:57:30 -0400
Received: from h-163-233.A498.priv.bahnhof.se ([155.4.163.233]:48224 "EHLO
        mail.kenjo.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbfIXU53 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 24 Sep 2019 16:57:29 -0400
X-Greylist: delayed 1185 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Sep 2019 16:57:28 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kenjo.org;
         s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=19E64vm8RRgmAsEKmLZbmxug/FG1/uAhHiL+c4K0QG0=; b=hgDQcYqY1gbjeSJVqSfpn021vU
        Jw+v5TJMgwAdlUMBKl3X4A0tDl8+jpERZZMs83PRgd+Xc4yVMz5jkU0EapEM3ivxrPZ+9zb9VMZfx
        t4vmpMXJczv+prqFwpuAz6BTEqinANHxaVG0b5B7qAIZ1KrJVwqyCfh5MRL8G9FaL5Tw=;
Received: from brix.kenjo.org ([172.16.2.16])
        by mail.kenjo.org with esmtp (Exim 4.89)
        (envelope-from <ken@kenjo.org>)
        id 1iCrZ6-0004bn-A5
        for linux-ext4@vger.kernel.org; Tue, 24 Sep 2019 22:37:40 +0200
To:     linux-ext4@vger.kernel.org
From:   Kenneth Johansson <ken@kenjo.org>
Subject: e2fsck ends up taking taking way to much time
Message-ID: <9065f0c0-42f8-5fb1-b66f-db536a573c05@kenjo.org>
Date:   Tue, 24 Sep 2019 22:37:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

So I was going to resize the fileystem something I done several times 
but this time something went wrong. I hit the 16GB limit and had to use 
the -b flag to resize. This is the commands I used

-----

# e2fsck -C 0 -f /dev/mapper/bfd_uc
e2fsck 1.45.2 (27-May-2019)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/mapper/bfd_uc: 78660/1021870080 files (16.1% non-contiguous), 
3928630907/4087464448 blocks

-----

so long everything worked.

-----

# resize2fs  /dev/mapper/bfd_uc
resize2fs 1.45.2 (27-May-2019)
resize2fs: New size too large to be expressed in 32 bits

-----

ok letsa try that.

---------------

# resize2fs  -b -p /dev/mapper/bfd_uc
resize2fs 1.45.2 (27-May-2019)
Converting the filesystem to 64-bit.
Begin pass 2 (max = 22287)
Relocating blocks XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Begin pass 3 (max = 124740)
Scanning inode table XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Begin pass 5 (max = 2)
Moving inode table XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
The filesystem on /dev/mapper/bfd_uc is now 4087464448 (4k) blocks long.

  resize2fs  /dev/mapper/bfd_uc
resize2fs 1.45.2 (27-May-2019)
Resizing the filesystem on /dev/mapper/bfd_uc to 4355899904 (4k) blocks.
The filesystem on /dev/mapper/bfd_uc is now 4355899904 (4k) blocks long.

-----

Still no problems but when I tried to mount it the kernel refused. so I 
run fsck again and now there is a lot of issues.

-----

  e2fsck -C 0 -f /dev/mapper/bfd_uc
e2fsck 1.45.2 (27-May-2019)
Pass 1: Checking inodes, blocks, and sizes
Inode 29360452 extent tree (at level 1) could be narrower. Optimize<y>? yes
Inode 29360454 extent tree (at level 1) could be narrower. Optimize<y>? yes
Inode 29360456 extent tree (at level 1) could be narrower. Optimize<y>? yes
Inode 29360457 extent tree (at level 1) could be narrower. Optimize<y>? yes
Inode 29360458 extent tree (at level 1) could be narrower. Optimize<y>? yes
Inode 29360459 extent tree (at level 1) could be narrower. Optimize<y>? yes
yInode 29361103 extent tree (at level 1) could be narrower. Optimize<y>? yes
Inode 313786521 extent tree (at level 1) could be narrower. Optimize<y>? 
yes
Inode 313786522 extent tree (at level 1) could be narrower. Optimize<y>? yes
Inode 400425891 extent tree (at level 1) could be narrower. Optimize 
('a' enables 'yes' to all) <y>? yes to all
Inode 400427369 extent tree (at level 2) could be narrower. Optimize? yes

Inode 401735804 extent tree (at level 1) could be narrower. Optimize? yes

and so on. not sure where they came from but the real issue is that I 
cant get e2fsck to complete. I eventually get lots and lots of things 
like this

Inode 1021871069 block 336 conflicts with critical metadata, skipping 
block checks.

the same inode is used on hundreds of lines. looks like the inode is 
random data more or less. I used debugfs and clri to delete it but I 
just end up in the same error on another inode and I cant solve it this 
way as it is manual work.


here is parts of "debugfs stat" on another of this inodes. debugfs 
enters the same loop as fsck I think as it hangs here.

-----------

Inode: 1021870344   Type: regular    Mode:  04565   Flags: 0x9f6845b
Generation: 3754451681    Version: 0x0cec5d88:0cee9f57
User: 1240871040   Group: -228176346   Size: 7783179247692111229
File ACL: 87875029679583
Links: 57617   Blockcount: 203042659658940
Fragment:  Address: -1951344957    Number: 0    Size: 0
  ctime: 0x162ec9d3:d145c3fc -- Sat Oct 17 12:11:15 1981
  atime: 0x4471cfa3:1a4a9fbf -- Thu Sep 11 12:14:59 2414
  mtime: 0x2997b943:178e01cf -- Fri Jun  2 09:18:27 2400
crtime: 0x42faeff4:02752ab4 -- Thu Aug 11 08:28:04 2005
Size of extra inode fields: 28
BLOCKS:
(0):3868683678, (1):2003982397, (2):620007688, (3):4267941890, 
(4):3725597703, (5):3651320496, (6):738218534, (7):2119776579, 
(8):160072405, (9):4132595055, (10):1419200473, (11):772345008, 
(IND):137269137, (12):4163901537, (13):344587808, (14):1106180479, 
(15):3742206454, (16):1735251710, (17):709071450, (18):1481240729,79_
---------


so I need to tell fsck to just ignore any inode that has like a filesize 
larger than say 50G or some reasonable value so it does not scan the 
whole blody disk or whatever its doing. right now It will never finish 
this disk once it hit this type of inode data and I have no idea how 
much of this exists. could be alot as I added 1T to the partition and 
its from lvm so it could be any data that is now added to the 
partition/disk

so far I have had problems on this inode numbers

1021871069
1021871209
1021870852
1021870344

so it looks like there could be a lot of them.










