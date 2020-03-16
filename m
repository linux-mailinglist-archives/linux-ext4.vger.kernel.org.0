Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C591867D4
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Mar 2020 10:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgCPJ1s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Mar 2020 05:27:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:33650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730025AbgCPJ1r (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 16 Mar 2020 05:27:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DB992AD2A;
        Mon, 16 Mar 2020 09:27:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 798DC1E10DA; Mon, 16 Mar 2020 10:27:46 +0100 (CET)
Date:   Mon, 16 Mar 2020 10:27:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 7/7] tune2fs: Update dir checksums when clearing
 dir_index feature
Message-ID: <20200316092746.GC12783@quack2.suse.cz>
References: <20200213101602.29096-1-jack@suse.cz>
 <20200213101602.29096-8-jack@suse.cz>
 <20200315171520.GT225435@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315171520.GT225435@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 15-03-20 13:15:20, Theodore Y. Ts'o wrote:
> On Thu, Feb 13, 2020 at 11:16:02AM +0100, Jan Kara wrote:
> > When clearing dir_index feature while metadata_csum is enabled, we have
> > to rewrite checksums of all indexed directories to update checksums of
> > internal tree nodes.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Thanks, applied.
> 
> With regards to the enum, I agree with Jan that using an enum for
> bitfields isn't a great fit.  Also, in this case, where it's for a
> static function and the definitions don't go beyond a single file, the
> advantages of using an enum so we can have strong typing is much less
> useful.
> 
> One thing which I did notice when trying to test this patch is that
> 
> mke2fs -t ext4 -d /usr/projects/e2fsprogs /tmp/foo.img 1G
> 
> ...does not create any indexed directories.  That's because the
> changes to ext2fs_link() only teach e2fsprogs how to add a link to a
> directory which is already indexing.  We don't have code which takes a
> directory with a single directory block and which doesn't have
> directory indexing flag enabled, and converts to a indexed directory.

Yes, I know and it's kind of deliberate because not all users of
ext2fs_link() want that to happen (e.g. linking into lost+found). So I
wasn't sure what a proper API for this functionality would be and decided
to leave that decision for later. Maybe we could export the "optimize dir"
functionality from e2fsck to be generally available in libext2fs?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
