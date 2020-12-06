Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900C52D05A7
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Dec 2020 16:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgLFPYZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Dec 2020 10:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgLFPYZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Dec 2020 10:24:25 -0500
X-Greylist: delayed 2356 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Dec 2020 07:23:45 PST
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A303C0613D1
        for <linux-ext4@vger.kernel.org>; Sun,  6 Dec 2020 07:23:45 -0800 (PST)
Received: from f.b.1.7.2.1.e.f.f.f.a.c.5.0.a.6.4.1.b.e.2.f.f.b.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:bff2:eb14:6a05:caff:fe12:71bf] helo=riva.pelham.vpn.ucam.org)
        by b-painless.mh.aa.net.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <cjwatson@debian.org>)
        id 1klvHE-0002yI-26; Sun, 06 Dec 2020 14:44:40 +0000
Received: from ns1.pelham.vpn.ucam.org ([172.20.153.2] helo=riva.ucam.org)
        by riva.pelham.vpn.ucam.org with esmtp (Exim 4.92)
        (envelope-from <cjwatson@debian.org>)
        id 1klvGq-00029w-ET; Sun, 06 Dec 2020 14:44:16 +0000
Date:   Sun, 6 Dec 2020 14:44:16 +0000
From:   Colin Watson <cjwatson@debian.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Dimitri John Ledkov <xnox@ubuntu.com>
Subject: Re: ext4: Funny characters appended to file names
Message-ID: <20201206144416.GM13361@riva.ucam.org>
References: <fea4dd48-fd8b-823c-0a4b-20ebcd804597@molgen.mpg.de>
 <20201204152802.GQ441757@mit.edu>
 <93fab357-5ed2-403d-3371-6580aedecaf4@molgen.mpg.de>
 <20201204180541.GC577125@mit.edu>
 <51a1939c-2a99-e86a-1799-c31248e21d89@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51a1939c-2a99-e86a-1799-c31248e21d89@molgen.mpg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Dec 05, 2020 at 08:34:34PM +0100, Paul Menzel wrote:
> [Cc: +Colin]

Also CCing Dimitri, whose GRUB patch this may be related to.  Dimitri,
see https://marc.info/?l=linux-ext4&m=160719695914303&w=2 for the full
message I'm replying to.

> Am 04.12.20 um 19:05 schrieb Theodore Y. Ts'o:
> > On Fri, Dec 04, 2020 at 04:39:12PM +0100, Paul Menzel wrote:
> 
> Colin, the modules in `/boot/grub/i386-pc` look funny, and can’t be loaded
> by GRUB anymore.
> 
> ```
> $ ls -lt /boot/grub/i386-pc/
> insgesamt 2085
> -rw-r--r-- 1 root root    512 13. Aug 23:00 'boot.img-'$'\205\300''u'$'
> \023\211''鍓]'$'\206\371\377\211\360\350''f'$'\376\377\377\205
> \300''ur'$'\203\354\004''V'$'\377''t$'$'\030''j'$'\002''胒'
> -rw-r--r-- 1 root root  30893 13. Aug 23:00 'core.img-'$'\205\300''u'$'
> \023\211''鍓]'$'\206\371\377\211\360\350''f'$'\376\377\377\205
> \300''ur'$'\203\354\004''V'$'\377''t$'$'\030''j'$'\002''胒'
> […]
> ```
[...]
> > When was the last time the directory was OK?  Do you know when it may
> > have gotten corrupted?
> 
> The last reboot before. But I am really confused now though.
> 
>     $ ls -ld /boot/grub/i386-pc
>     drwxr-xr-x 2 root root 28672 29. Nov 12:13 /boot/grub/i386-pc
> 
> But the module files in there are all from August 2020.
> 
>     -rw-r--r-- 1 root root   2400 Aug 13 23:00 'part_gpt.mod-'$'\205\300''u'$'\023\211\351\215\223'']'$'\206\371\377\211\360\350''f'$'\376\377\377\205\300''ur'$'\203\354\004''V'$'\377''t$'$'\030''j'$'\002\350\203\222'
> 
> The characters in the file name look like some character encoding. Do you
> know hat that is? UTF-8? The dumped output viewed in an editor shows a
> “Asian” looking characters 胒.

It seems rather more likely to be junk from uninitialised memory.

>     2020-11-29 11:38:06 upgrade grub2-common:i386 2.04-9 2.04-10
>     […]
>     2020-11-29 12:04:00 status installed linux-image-5.9.0-4-686-pae:i386
> 5.9.11-1
>     […]
>     2020-11-29 12:13:24 configure grub-pc:i386 2.04-10 <none>
>     2020-11-29 12:13:24 status unpacked grub-pc:i386 2.04-10
>     2020-11-29 12:13:24 status half-configured grub-pc:i386 2.04-10
>     [Dialog waited for my confirmation: Some GRUB warning regarding block
> devices, which I always “ignore”, that means tell GRUB to be upgraded]

You need to actually look into this and fix it properly rather than
ignoring it.  It's probably related to this problem, since a successful
installation doesn't go down the RESTORE_BACKUP path which I think is
the suspicious one here.

>     2020-11-29 12:43:21 status installed grub-pc:i386 2.04-10
>     […]
> 
> So, afterward I was able to reboot without any issues.
[...]
> Do you want me to re-install grub to see if it’s a problem introduced in
> Debian’s GRUB 2.04-10?

Now that I look at it more closely, some of the changes to
clean_grub_dir_real look suspicious:

+         char *srcf = grub_util_path_concat (2, di, de->d_name);
+
+         if (mode == CREATE_BACKUP)
+           {
+             char *dstf = grub_util_path_concat_ext (2, di, de->d_name, "-");
+             if (grub_util_rename (srcf, dstf) < 0)
+               grub_util_error (_("cannot backup `%s': %s"), srcf,
+                                grub_util_fd_strerror ());
+             free (dstf);
+           }
+         else if (mode == RESTORE_BACKUP)
+           {
+             char *dstf = grub_util_path_concat_ext (2, di, de->d_name);
+             dstf[strlen (dstf) - 1] = 0;
+             if (grub_util_rename (srcf, dstf) < 0)
+               grub_util_error (_("cannot restore `%s': %s"), dstf,
+                                grub_util_fd_strerror ());
+             free (dstf);
+           }
+         else
+           {
+             if (grub_util_unlink (srcf) < 0)
+               grub_util_error (_("cannot delete `%s': %s"), srcf,
+                                grub_util_fd_strerror ());
+           }
+         free (srcf);

grub_util_path_concat is a helper that joins its arguments with "/";
grub_util_path_concat_ext does likewise except the last argument is
appended as an extension without first appending "/".  The first
argument to both of these functions is "n": grub_util_path_concat
expects n further argument, while grub_util_path_concat_ext expects n +
1 further arguments.

So, in the RESTORE_BACKUP case, shouldn't that be:

  char *dstf = grub_util_path_concat (2, di, de->d_name);

... rather than grub_util_path_concat_ext?  Otherwise it seems to me
that it's going to try to append an additional argument which doesn't
exist, and may well add random uninitialised stuff from memory.  Running
grub-install under valgrind would probably show this up (I can't get it
to do it for me so far, but most likely I just haven't set up quite the
right initial conditions).

This looks more likely to be a userspace problem rather than filesystem
corruption.  I think this should likely be refiled as a bug against
Debian's grub2 package.

-- 
Colin Watson (he/him)                              [cjwatson@debian.org]
