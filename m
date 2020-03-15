Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6DB2185EA0
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Mar 2020 18:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgCORP3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Mar 2020 13:15:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56579 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728634AbgCORP2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Mar 2020 13:15:28 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02FHFKDt006146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Mar 2020 13:15:21 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 41358420EBA; Sun, 15 Mar 2020 13:15:20 -0400 (EDT)
Date:   Sun, 15 Mar 2020 13:15:20 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 7/7] tune2fs: Update dir checksums when clearing
 dir_index feature
Message-ID: <20200315171520.GT225435@mit.edu>
References: <20200213101602.29096-1-jack@suse.cz>
 <20200213101602.29096-8-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213101602.29096-8-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 13, 2020 at 11:16:02AM +0100, Jan Kara wrote:
> When clearing dir_index feature while metadata_csum is enabled, we have
> to rewrite checksums of all indexed directories to update checksums of
> internal tree nodes.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied.

With regards to the enum, I agree with Jan that using an enum for
bitfields isn't a great fit.  Also, in this case, where it's for a
static function and the definitions don't go beyond a single file, the
advantages of using an enum so we can have strong typing is much less
useful.

One thing which I did notice when trying to test this patch is that

mke2fs -t ext4 -d /usr/projects/e2fsprogs /tmp/foo.img 1G

...does not create any indexed directories.  That's because the
changes to ext2fs_link() only teach e2fsprogs how to add a link to a
directory which is already indexing.  We don't have code which takes a
directory with a single directory block and which doesn't have
directory indexing flag enabled, and converts to a indexed directory.

That might be a nice thing to add at some point.

     	      	     	      	     - Ted
