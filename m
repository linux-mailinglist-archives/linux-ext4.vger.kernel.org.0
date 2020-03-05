Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1161F17B021
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Mar 2020 21:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgCEU53 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Mar 2020 15:57:29 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52278 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726049AbgCEU53 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Mar 2020 15:57:29 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 025KvP3n009056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Mar 2020 15:57:25 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 90F0842045B; Thu,  5 Mar 2020 15:57:24 -0500 (EST)
Date:   Thu, 5 Mar 2020 15:57:24 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: remove EXT4_EOFBLOCKS_FL and associated code
Message-ID: <20200305205724.GE20967@mit.edu>
References: <20200211210216.24960-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211210216.24960-1-enwlinux@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 11, 2020 at 04:02:16PM -0500, Eric Whitney wrote:
> The EXT4_EOFBLOCKS_FL inode flag is used to indicate whether a file
> contains unwritten blocks past i_size.  It's set when ext4_fallocate
> is called with the KEEP_SIZE flag to extend a file with an unwritten
> extent.  However, this flag hasn't been useful functionally since
> March, 2012, when a decision was made to remove it from ext4.
> 
> All traces of EXT4_EOFBLOCKS_FL were removed from e2fsprogs version
> 1.42.2 by commit 010dc7b90d97 ("e2fsck: remove EXT4_EOFBLOCKS_FL flag
> handling") at that time.  Now that enough time has passed to make
> e2fsprogs versions containing this modification common, this patch now
> removes the code associated with EXT4_EOFBLOCKS_FL from the kernel as
> well.
> 
> This change has two implications.  First, because pre-1.42.2 e2fsck
> versions only look for a problem if EXT4_EOFBLOCKS_FL is set, and
> because that bit will never be set by newer kernels containing this
> patch, old versions of e2fsck won't have a compatibility problem with
> files created by newer kernels.
> 
> Second, newer kernels will not clear EXT4_EOFBLOCKS_FL inode flag bits
> belonging to a file written by an older kernel.  If set, it will remain
> in that state until the file is deleted.  Because e2fsck versions since
> 1.42.2 don't check the flag at all, no adverse effect is expected.
> However, pre-1.42.2 e2fsck versions that do check the flag may report
> that it is set when it ought not to be after a file has been truncated
> or had its unwritten blocks written.  In this case, the old version of
> e2fsck will offer to clear the flag.  No adverse effect would then
> occur whether the user chooses to clear the flag or not.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>

Applied, thanks.

							- Ted
