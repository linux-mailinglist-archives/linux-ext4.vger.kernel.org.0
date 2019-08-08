Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B389A86640
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Aug 2019 17:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403961AbfHHPut (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Aug 2019 11:50:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36971 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728380AbfHHPus (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Aug 2019 11:50:48 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-107.corp.google.com [104.133.0.107] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x78FofOW028778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Aug 2019 11:50:42 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DFC084218EF; Thu,  8 Aug 2019 11:50:40 -0400 (EDT)
Date:   Thu, 8 Aug 2019 11:50:40 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Chandan Rajendra <chandan@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        harish@linux.ibm.com, jack@suse.cz
Subject: Re: [PATCH V2] jbd2: flush_descriptor(): Do not decrease buffer
 head's ref count
Message-ID: <20190808155040.GF3340@mit.edu>
References: <20190805040800.31743-1-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805040800.31743-1-chandan@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 05, 2019 at 09:38:00AM +0530, Chandan Rajendra wrote:
> When executing generic/388 on a ppc64le machine, we notice the following
> call trace,
> 
> VFS: brelse: Trying to free free buffer
> WARNING: CPU: 0 PID: 6637 at /root/repos/linux/fs/buffer.c:1195 __brelse+0x84/0xc0
> 
> Call Trace:
>  __brelse+0x80/0xc0 (unreliable)
>  invalidate_bh_lru+0x78/0xc0
>  on_each_cpu_mask+0xa8/0x130
>  on_each_cpu_cond_mask+0x130/0x170
>  invalidate_bh_lrus+0x44/0x60
>  invalidate_bdev+0x38/0x70
>  ext4_put_super+0x294/0x560
>  generic_shutdown_super+0xb0/0x170
>  kill_block_super+0x38/0xb0
>  deactivate_locked_super+0xa4/0xf0
>  cleanup_mnt+0x164/0x1d0
>  task_work_run+0x110/0x160
>  do_notify_resume+0x414/0x460
>  ret_from_except_lite+0x70/0x74
> 
> The warning happens because flush_descriptor() drops bh reference it
> does not own. The bh reference acquired by
> jbd2_journal_get_descriptor_buffer() is owned by the log_bufs list and
> gets released when this list is processed. The reference for doing IO is
> only acquired in write_dirty_buffer() later in flush_descriptor().
> 
> Reported-by: Harish Sriram <harish@linux.ibm.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>

Thanks, applied.

					- Ted
