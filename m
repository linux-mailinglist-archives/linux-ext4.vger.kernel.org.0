Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5F02D0664
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Dec 2020 18:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgLFRo7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Dec 2020 12:44:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38706 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgLFRo6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Dec 2020 12:44:58 -0500
Received: from 139.35.155.90.in-addr.arpa ([90.155.35.139] helo=riva.pelham.vpn.ucam.org)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cjwatson@ubuntu.com>)
        id 1kly50-0007Ee-MO; Sun, 06 Dec 2020 17:44:14 +0000
Received: from ns1.pelham.vpn.ucam.org ([172.20.153.2] helo=riva.ucam.org)
        by riva.pelham.vpn.ucam.org with esmtp (Exim 4.92)
        (envelope-from <cjwatson@ubuntu.com>)
        id 1kly50-0005k9-14; Sun, 06 Dec 2020 17:44:14 +0000
Date:   Sun, 6 Dec 2020 17:44:14 +0000
From:   Colin Watson <cjwatson@ubuntu.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Dimitri John Ledkov <xnox@ubuntu.com>
Subject: Re: ext4: Funny characters appended to file names
Message-ID: <20201206174414.GA21819@riva.ucam.org>
References: <fea4dd48-fd8b-823c-0a4b-20ebcd804597@molgen.mpg.de>
 <20201204152802.GQ441757@mit.edu>
 <93fab357-5ed2-403d-3371-6580aedecaf4@molgen.mpg.de>
 <20201204180541.GC577125@mit.edu>
 <51a1939c-2a99-e86a-1799-c31248e21d89@molgen.mpg.de>
 <20201206144416.GM13361@riva.ucam.org>
 <20201206151527.GE577125@mit.edu>
 <20201206173746.GN13361@riva.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206173746.GN13361@riva.ucam.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Dec 06, 2020 at 05:37:46PM +0000, Colin Watson wrote:
> I don't know why Dimitri chose to explicitly remove the new files first
> rather than just renaming over the top and then removing any leftovers
> at the end; that seems unnecessarily risky.  Though this is code that's
> apparently supposed to work on Windows as well, and the MoveFile
> function that's used to implement grub_util_rename there requires the
> destination file not to exist (sigh), so maybe it had something to do
> with that.

Incidentally, if this is actually the reason, then I think this would be
a viable replacement:

  ret = !MoveFileEx (windows_from, windows_to, MOVEFILE_REPLACE_EXISTING);

Not that I really speak the Windows API ...

-- 
Colin Watson (he/him)                              [cjwatson@ubuntu.com]
