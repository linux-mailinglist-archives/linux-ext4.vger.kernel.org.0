Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A959AE337E
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Oct 2019 15:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502229AbfJXNJK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Oct 2019 09:09:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:56092 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730867AbfJXNJK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 24 Oct 2019 09:09:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A006AB91;
        Thu, 24 Oct 2019 13:09:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 63E1A1E155F; Thu, 24 Oct 2019 15:09:08 +0200 (CEST)
Date:   Thu, 24 Oct 2019 15:09:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/19 v3] ext4: Fix transaction overflow due to revoke
 descriptors
Message-ID: <20191024130908.GO31271@quack2.suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191019191933.GA25841@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191019191933.GA25841@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 19-10-19 15:19:33, Theodore Y. Ts'o wrote:
> Hi Jan,
> 
> I've tried applying this patch set against 5.4-rc3, and I'm finding a
> easily reproducible failure using:
> 
> 	kvm-xfstests -c ext3conv ext4/039
> 
> It is the BUG_ON in fs/jbd2/commit.c, around line 570:
> 
> 	J_ASSERT(commit_transaction->t_nr_buffers <=
> 		 atomic_read(&commit_transaction->t_outstanding_credits));
> 
> The failure (with the obvious debugging printk added) is:
> 
> ext4/039		[15:13:16][    6.747101] run fstests ext4/039 at 2019-10
> -19 15:13:16
> [    7.018766] Mounted ext4 file system at /vdc supports timestamps until 2038 (
> 0x7fffffff)
> [    8.227631] JBD2: t_nr_buffers 226, t_outstanding_credits=223
> [    8.229215] ------------[ cut here ]------------
> [    8.230249] kernel BUG at fs/jbd2/commit.c:573!
>      	       ...
> 
> The full log is attached (although the stack trace isn't terribly
> interesting, since this is being run out of kjournald2).

Thanks! Somehow this escaped my testing although I thought I have run ext3
configuration... Anyway we are reserving too few space in this case - with
some debugging added:

[   80.296029] t_buffers: 222, t_outstanding_credits: 219,
t_revoke_written: 23, t_revoke_reserved: 12, t_revoke_records_written
11432, t_revoke_records_reserved 11432, revokes_per_block: 1020

Which is really puzzling because it would suggest that revokes_per_block is
actually wrong. Digging more into this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
