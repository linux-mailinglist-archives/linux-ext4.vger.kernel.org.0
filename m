Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6072D0680
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Dec 2020 19:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgLFS2o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Dec 2020 13:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgLFS2o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Dec 2020 13:28:44 -0500
Received: from alt.a-painless.mh.aa.net.uk (a-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3035C0613D0
        for <linux-ext4@vger.kernel.org>; Sun,  6 Dec 2020 10:28:03 -0800 (PST)
Received: from f.b.1.7.2.1.e.f.f.f.a.c.5.0.a.6.4.1.b.e.2.f.f.b.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:bff2:eb14:6a05:caff:fe12:71bf] helo=riva.pelham.vpn.ucam.org)
        by a-painless.mh.aa.net.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <cjwatson@debian.org>)
        id 1klylO-00010V-Gy; Sun, 06 Dec 2020 18:28:02 +0000
Received: from ns1.pelham.vpn.ucam.org ([172.20.153.2] helo=riva.ucam.org)
        by riva.pelham.vpn.ucam.org with esmtp (Exim 4.92)
        (envelope-from <cjwatson@debian.org>)
        id 1klylB-00088b-0M; Sun, 06 Dec 2020 18:27:49 +0000
Date:   Sun, 6 Dec 2020 18:27:48 +0000
From:   Colin Watson <cjwatson@debian.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Dimitri John Ledkov <xnox@ubuntu.com>
Subject: Re: ext4: Funny characters appended to file names
Message-ID: <20201206182748.GA30693@riva.ucam.org>
References: <fea4dd48-fd8b-823c-0a4b-20ebcd804597@molgen.mpg.de>
 <20201204152802.GQ441757@mit.edu>
 <93fab357-5ed2-403d-3371-6580aedecaf4@molgen.mpg.de>
 <20201204180541.GC577125@mit.edu>
 <51a1939c-2a99-e86a-1799-c31248e21d89@molgen.mpg.de>
 <20201206144416.GM13361@riva.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206144416.GM13361@riva.ucam.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Dec 06, 2020 at 02:44:16PM +0000, Colin Watson wrote:
> So, in the RESTORE_BACKUP case, shouldn't that be:
> 
>   char *dstf = grub_util_path_concat (2, di, de->d_name);
> 
> ... rather than grub_util_path_concat_ext?  Otherwise it seems to me
> that it's going to try to append an additional argument which doesn't
> exist, and may well add random uninitialised stuff from memory.  Running
> grub-install under valgrind would probably show this up (I can't get it
> to do it for me so far, but most likely I just haven't set up quite the
> right initial conditions).

While I couldn't reproduce this on amd64 (and valgrind didn't show any
errors), I can reproduce it just fine on i386, which is what Paul is
using.  I guess the va_list layout in memory is different enough between
the two ABIs to tickle this.

I'll apply this patch for Debian grub2 2.04-11, which I've confirmed
fixes it for me:

diff --git a/util/grub-install-common.c b/util/grub-install-common.c
index a883b6dae..61f9075bc 100644
--- a/util/grub-install-common.c
+++ b/util/grub-install-common.c
@@ -247,7 +247,7 @@ clean_grub_dir_real (const char *di, enum clean_grub_dir_mode mode)
 	    }
 	  else if (mode == RESTORE_BACKUP)
 	    {
-	      char *dstf = grub_util_path_concat_ext (2, di, de->d_name);
+	      char *dstf = grub_util_path_concat (2, di, de->d_name);
 	      dstf[strlen (dstf) - 1] = 0;
 	      if (grub_util_rename (srcf, dstf) < 0)
 		grub_util_error (_("cannot restore `%s': %s"), dstf,

Dimitri, I know Ubuntu isn't very interested in supporting i386, but IMO
you should apply this patch to Ubuntu in any case; it might affect other
architectures, and anyway leaving known undefined behaviour around isn't
a good idea.

Paul, note that you'll also need to run "sudo rm -f
/boot/grub/i386-pc/*.{img,lst,mo,mod,o,sh}-*" to clean up the stray
files created by this bug.

-- 
Colin Watson (he/him)                              [cjwatson@debian.org]
