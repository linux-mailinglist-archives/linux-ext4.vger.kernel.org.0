Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C96B2D059E
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Dec 2020 16:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgLFPQd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Dec 2020 10:16:33 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44296 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726198AbgLFPQd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Dec 2020 10:16:33 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B6FFRN8007311
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 6 Dec 2020 10:15:28 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 937F0420136; Sun,  6 Dec 2020 10:15:27 -0500 (EST)
Date:   Sun, 6 Dec 2020 10:15:27 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Colin Watson <cjwatson@debian.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Dimitri John Ledkov <xnox@ubuntu.com>
Subject: Re: ext4: Funny characters appended to file names
Message-ID: <20201206151527.GE577125@mit.edu>
References: <fea4dd48-fd8b-823c-0a4b-20ebcd804597@molgen.mpg.de>
 <20201204152802.GQ441757@mit.edu>
 <93fab357-5ed2-403d-3371-6580aedecaf4@molgen.mpg.de>
 <20201204180541.GC577125@mit.edu>
 <51a1939c-2a99-e86a-1799-c31248e21d89@molgen.mpg.de>
 <20201206144416.GM13361@riva.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201206144416.GM13361@riva.ucam.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Dec 06, 2020 at 02:44:16PM +0000, Colin Watson wrote:
> > Colin, the modules in `/boot/grub/i386-pc` look funny, and can’t be loaded
> > by GRUB anymore.
> > 
> > ```
> > $ ls -lt /boot/grub/i386-pc/
> > insgesamt 2085
> > -rw-r--r-- 1 root root    512 13. Aug 23:00 'boot.img-'$'\205\300''u'$'
> > \023\211''鍓]'$'\206\371\377\211\360\350''f'$'\376\377\377\205

I think Colin theory makes sense.  Note the hypthen after "boot.img".
That corresponds with the 'i' in the code below:

> Now that I look at it more closely, some of the changes to
> clean_grub_dir_real look suspicious:
> 
> +         char *srcf = grub_util_path_concat (2, di, de->d_name);
> +
> +         if (mode == CREATE_BACKUP)
> +           {
> +             char *dstf = grub_util_path_concat_ext (2, di, de->d_name, "-");
> +             if (grub_util_rename (srcf, dstf) < 0)
> +               grub_util_error (_("cannot backup `%s': %s"), srcf,
> +                                grub_util_fd_strerror ());
> +             free (dstf);
> +           }

... however, if I'm understanding the code correctly, this is the
codepath used to create the backup file (e.g., the previous version of
boot.img).  So shouldn't there be a "boot.img" file in
/boot/grub/i386-pc which would be the newly installed version of that
file, and so the system would actually be booting correctly?

Or am I misunderstanding what is going on?  Paul, I thought you said
your system wasn't able to boot because the needed files in
/boot/grub/i386-pc had apparently been corrupted?

Essentially, there are three possibilities:

1)  A hardware corruption which corrupted the directory.

2)  A kernel bug which corrupted the directory.

3) The file system isn't actually corrupted, but the filename with the
random garbage in the filename was created because a userspace
application so requested it.

The fact that all of the filenames have the a similar pattern of
corruption to them would tend to rule out #1.  And the fact that
e2fsck didn't notice any other corruptions would tend to argue against
#1 and #2.  So #3 does seem to be the most likely.

       	       	       	       	      	   - Ted
