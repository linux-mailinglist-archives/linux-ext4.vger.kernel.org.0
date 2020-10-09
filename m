Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35AB288040
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 04:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbgJICLB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Oct 2020 22:11:01 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45493 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729719AbgJICLB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Oct 2020 22:11:01 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0992Apd1003931
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Oct 2020 22:10:51 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E3854420107; Thu,  8 Oct 2020 22:10:50 -0400 (EDT)
Date:   Thu, 8 Oct 2020 22:10:50 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     linux-ext4@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Jan Kara <jack@suse.cz>, Andreas Dilger <adilger@dilger.ca>,
        dann frazier <dann.frazier@canonical.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v5 4/4] ext4: data=journal: write-protect pages on
 j_submit_inode_data_buffers()
Message-ID: <20201009021050.GH235506@mit.edu>
References: <20201006004841.600488-1-mfo@canonical.com>
 <20201006004841.600488-5-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006004841.600488-5-mfo@canonical.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 05, 2020 at 09:48:41PM -0300, Mauricio Faria de Oliveira wrote:
> This implements journal callbacks j_submit|finish_inode_data_buffers()
> with different behavior for data=journal: to write-protect pages under
> commit, preventing changes to buffers writeably mapped to userspace.
> 
> If a buffer's content changes between commit's checksum calculation
> and write-out to disk, it can cause journal recovery/mount failures
> upon a kernel crash or power loss.
> 
>     [   27.334874] EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, and O_DIRECT support!
>     [   27.339492] JBD2: Invalid checksum recovering data block 8705 in log
>     [   27.342716] JBD2: recovery failed
>     [   27.343316] EXT4-fs (loop0): error loading journal
>     mount: /ext4: can't read superblock on /dev/loop0.
> 
> In j_submit_inode_data_buffers() we write-protect the inode's pages
> with write_cache_pages() and redirty w/ writepage callback if needed.
> 
> In j_finish_inode_data_buffers() there is nothing do to.
> 
> And in order to use the callbacks, inodes are added to the inode list
> in transaction in __ext4_journalled_writepage() and ext4_page_mkwrite().
> 
> In ext4_page_mkwrite() we must make sure that the buffers are attached
> to the transaction as jbddirty with write_end_fn(), as already done in
> __ext4_journalled_writepage().
> 
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> Reported-by: Dann Frazier <dann.frazier@canonical.com>
> Reported-by: kernel test robot <lkp@intel.com> # wbc.nr_to_write
> Suggested-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
