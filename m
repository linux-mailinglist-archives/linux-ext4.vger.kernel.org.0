Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2272D065E
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Dec 2020 18:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgLFRic (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Dec 2020 12:38:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38672 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgLFRic (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Dec 2020 12:38:32 -0500
Received: from 139.35.155.90.in-addr.arpa ([90.155.35.139] helo=riva.pelham.vpn.ucam.org)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cjwatson@ubuntu.com>)
        id 1klxyl-0006xS-Hi; Sun, 06 Dec 2020 17:37:47 +0000
Received: from ns1.pelham.vpn.ucam.org ([172.20.153.2] helo=riva.ucam.org)
        by riva.pelham.vpn.ucam.org with esmtp (Exim 4.92)
        (envelope-from <cjwatson@ubuntu.com>)
        id 1klxyk-0005bT-Pp; Sun, 06 Dec 2020 17:37:46 +0000
Date:   Sun, 6 Dec 2020 17:37:46 +0000
From:   Colin Watson <cjwatson@ubuntu.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Dimitri John Ledkov <xnox@ubuntu.com>
Subject: Re: ext4: Funny characters appended to file names
Message-ID: <20201206173746.GN13361@riva.ucam.org>
References: <fea4dd48-fd8b-823c-0a4b-20ebcd804597@molgen.mpg.de>
 <20201204152802.GQ441757@mit.edu>
 <93fab357-5ed2-403d-3371-6580aedecaf4@molgen.mpg.de>
 <20201204180541.GC577125@mit.edu>
 <51a1939c-2a99-e86a-1799-c31248e21d89@molgen.mpg.de>
 <20201206144416.GM13361@riva.ucam.org>
 <20201206151527.GE577125@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206151527.GE577125@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Dec 06, 2020 at 10:15:27AM -0500, Theodore Y. Ts'o wrote:
> On Sun, Dec 06, 2020 at 02:44:16PM +0000, Colin Watson wrote:
> > Now that I look at it more closely, some of the changes to
> > clean_grub_dir_real look suspicious:
> > 
> > +         char *srcf = grub_util_path_concat (2, di, de->d_name);
> > +
> > +         if (mode == CREATE_BACKUP)
> > +           {
> > +             char *dstf = grub_util_path_concat_ext (2, di, de->d_name, "-");
> > +             if (grub_util_rename (srcf, dstf) < 0)
> > +               grub_util_error (_("cannot backup `%s': %s"), srcf,
> > +                                grub_util_fd_strerror ());
> > +             free (dstf);
> > +           }
> 
> ... however, if I'm understanding the code correctly, this is the
> codepath used to create the backup file (e.g., the previous version of
> boot.img).  So shouldn't there be a "boot.img" file in
> /boot/grub/i386-pc which would be the newly installed version of that
> file, and so the system would actually be booting correctly?

Not quite.  What's described here as "backup/restore" thing is used as
follows:

 * rename old modules aside as a backup
 * do the rest of the installation (writing to the MBR or similar, as
   well as copying in new modules)
 * if installation succeeds, remove the backup files
 * if installation fails, then:
  * remove the newly-created modules
  * move the backup files back into place

But if the restored file names are computed wrongly, then this leaves
the system in a bad state as Paul described.

I don't know why Dimitri chose to explicitly remove the new files first
rather than just renaming over the top and then removing any leftovers
at the end; that seems unnecessarily risky.  Though this is code that's
apparently supposed to work on Windows as well, and the MoveFile
function that's used to implement grub_util_rename there requires the
destination file not to exist (sigh), so maybe it had something to do
with that.

> Essentially, there are three possibilities:
> 
> 1)  A hardware corruption which corrupted the directory.
> 
> 2)  A kernel bug which corrupted the directory.
> 
> 3) The file system isn't actually corrupted, but the filename with the
> random garbage in the filename was created because a userspace
> application so requested it.
> 
> The fact that all of the filenames have the a similar pattern of
> corruption to them would tend to rule out #1.  And the fact that
> e2fsck didn't notice any other corruptions would tend to argue against
> #1 and #2.  So #3 does seem to be the most likely.

Yep.

-- 
Colin Watson (he/him)                              [cjwatson@ubuntu.com]
