Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108BF23D631
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Aug 2020 06:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgHFErM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Aug 2020 00:47:12 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44156 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726225AbgHFErM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Aug 2020 00:47:12 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0764l3lb020269
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Aug 2020 00:47:04 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 89DD4420263; Thu,  6 Aug 2020 00:47:03 -0400 (EDT)
Date:   Thu, 6 Aug 2020 00:47:03 -0400
From:   tytso@mit.edu
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Wang Shilong <wshilong@ddn.com>,
        Shuichi Ihara <sihara@ddn.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH v3 1/2] ext4: introduce EXT4_BG_WAS_TRIMMED to optimize
 trim
Message-ID: <20200806044703.GC7657@mit.edu>
References: <1592831677-13945-1-git-send-email-wangshilong1991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592831677-13945-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 22, 2020 at 10:14:36PM +0900, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> Currently WAS_TRIMMED flag is not persistent, whenever filesystem was
> remounted, fstrim need walk all block groups again, the problem with
> this is FSTRIM could be slow on very large LUN SSD based filesystem.
> 
> To avoid this kind of problem, we introduce a block group flag
> EXT4_BG_WAS_TRIMMED, the side effect of this is we need introduce
> extra one block group dirty write after trimming block group.
> 
> And When clearing TRIMMED flag, block group will be journalled
> anyway, so it won't introduce any overhead.

This persistent flag will not be accurate if there are blocks that
were freed in the block group in the same transaction, before
EXT4_BG_WAS_TRIMMED flag is set.

That's because we can't trim (or reuse) a block which has been
released until the transaction has committed, since if we crash before
it is commited, the file unlink or truncate will not have happened,
and so we can't trash the block until after the deallocation has been
freed.

This problem is also there with a non-persistent flag, granted; but
when the file system is unmounted and remounted, we will eventually
trim the block via a fstrim.  When we make the flag persistent, the
problem becomes worse, since it might mean that there are some blocks
that have been released, that might never get discarded.

I suppose the question is whether the sysadmin really wants unused
blocks to be discarded, either to not leak blocks in some kind of
thin-provisioned storage device, or if the sysadmin is depending on
the discard for some kind of security/privacy application (because
they know that a particular storage device actually has reliable,
secure discards), and how does that get balanced with sysadmins think
performance of fstrim is more important, especially if the device is
really slow at doing discard.

					- Ted
