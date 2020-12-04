Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7192CF0E6
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Dec 2020 16:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgLDPjz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Dec 2020 10:39:55 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:41991 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728950AbgLDPjz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 4 Dec 2020 10:39:55 -0500
Received: from [192.168.0.2] (ip5f5af1d8.dynamic.kabel-deutschland.de [95.90.241.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 244AF20647D92;
        Fri,  4 Dec 2020 16:39:13 +0100 (CET)
Subject: Re: ext4: Funny characters appended to file names
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
References: <fea4dd48-fd8b-823c-0a4b-20ebcd804597@molgen.mpg.de>
 <20201204152802.GQ441757@mit.edu>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <93fab357-5ed2-403d-3371-6580aedecaf4@molgen.mpg.de>
Date:   Fri, 4 Dec 2020 16:39:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201204152802.GQ441757@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Dear Theodore,


Am 04.12.20 um 16:28 schrieb Theodore Y. Ts'o:
> On Fri, Dec 04, 2020 at 03:30:38PM +0100, Paul Menzel wrote:

>> Using Debian Sid/unstable with 5.9.11 (5.9.0-4-686-pae), it looks like the
>> last `sudo grub-update` installed modules with corrupted file names. `/boot`
>> is mounted.
>>
>>> $ findmnt /boot
>>> TARGET SOURCE   FSTYPE OPTIONS
>>> /boot  /dev/md0 ext4   rw,relatime
>>> $ ls -l /boot/grub/i386-pc/
>>> insgesamt 2085
>>> -rw-r--r-- 1 root root   8004 13. Aug 23:00 '915resolution.mod-'$'\205\300''u'$'\023\211''鍓]'$'\206\371\377\211\360\350''f'$'\376\377\377\205\300''ur'$'\203\354\004''V'$'\377''t$'$'\030''j'$'\002''胒'
>>> -rw-r--r-- 1 root root  10596 13. Aug 23:00 'acpi.mod-'$'\205\300''u'$'\023\211''鍓]'$'\206\371\377\211\360\350''f'$'\376\377\377\205\300''ur'$'\203\354\004''V'$'\377''t$'$'\030''j'$'\002''胒'
>>> […]
>>> $ file /boot/grub/i386-pc/zstd.mod-��u^S�鍓\]�����f���ur��^DVt\$^Xj^B胒
>>> /boot/grub/i386-pc/zstd.mod-��u�鍓]������f�����ur��V�t$j胒: ELF 32-bit
>>> LSB relocatable, Intel 80386, version 1 (SYSV), not stripped
>>
>> Checking the file system returned no errors.
>>
>>      $ sudo umount /boot
>>      $ sudo fsck.ext4 /dev/md0
>>      e2fsck 1.45.6 (20-Mar-2020)
>>      boot: sauber, 331/124928 Dateien, 145680/497856 Blöcke
> 
> Try forcing a full fsck:
> 
> sudo fsck.ext4 -f /dev/md0
> 
> You'll see that it takes rather longer to run....

Only two or three seconds on this system. (It’s only 486,2M.)

> $ sudo LANG=C fsck.ext4 -f /dev/md0
> e2fsck 1.45.6 (20-Mar-2020)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> boot: 327/124928 files (17.7% non-contiguous), 126021/497856 blocks

I can’t remember if that was an Ext2 or Ext3 when created several years ago.


Kind regards,

Paul
