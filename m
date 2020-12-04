Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5F22CF0B7
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Dec 2020 16:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgLDP3B (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Dec 2020 10:29:01 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45904 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725923AbgLDP3B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Dec 2020 10:29:01 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B4FS2Vx009470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Dec 2020 10:28:03 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 68114420136; Fri,  4 Dec 2020 10:28:02 -0500 (EST)
Date:   Fri, 4 Dec 2020 10:28:02 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4: Funny characters appended to file names
Message-ID: <20201204152802.GQ441757@mit.edu>
References: <fea4dd48-fd8b-823c-0a4b-20ebcd804597@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fea4dd48-fd8b-823c-0a4b-20ebcd804597@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 04, 2020 at 03:30:38PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Using Debian Sid/unstable with 5.9.11 (5.9.0-4-686-pae), it looks like the
> last `sudo grub-update` installed modules with corrupted file names. `/boot`
> is mounted.
> 
> > $ findmnt /boot
> > TARGET SOURCE   FSTYPE OPTIONS
> > /boot  /dev/md0 ext4   rw,relatime
> > $ ls -l /boot/grub/i386-pc/
> > insgesamt 2085
> > -rw-r--r-- 1 root root   8004 13. Aug 23:00 '915resolution.mod-'$'\205\300''u'$'\023\211''鍓]'$'\206\371\377\211\360\350''f'$'\376\377\377\205\300''ur'$'\203\354\004''V'$'\377''t$'$'\030''j'$'\002''胒'
> > -rw-r--r-- 1 root root  10596 13. Aug 23:00 'acpi.mod-'$'\205\300''u'$'\023\211''鍓]'$'\206\371\377\211\360\350''f'$'\376\377\377\205\300''ur'$'\203\354\004''V'$'\377''t$'$'\030''j'$'\002''胒'
> > […]
> > $ file /boot/grub/i386-pc/zstd.mod-��u^S�鍓\]�����f���ur��^DVt\$^Xj^B胒
> > /boot/grub/i386-pc/zstd.mod-��u�鍓]������f�����ur��V�t$j胒: ELF 32-bit
> > LSB relocatable, Intel 80386, version 1 (SYSV), not stripped
> 
> Checking the file system returned no errors.
> 
>     $ sudo umount /boot
>     $ sudo fsck.ext4 /dev/md0
>     e2fsck 1.45.6 (20-Mar-2020)
>     boot: sauber, 331/124928 Dateien, 145680/497856 Blöcke

Try forcing a full fsck:

sudo fsck.ext4 -f /dev/md0

You'll see that it takes rather longer to run....

       	   	   	 	       - Ted
