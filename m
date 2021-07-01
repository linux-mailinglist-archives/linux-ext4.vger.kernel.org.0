Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0701F3B93A2
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Jul 2021 16:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhGAPCO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Jul 2021 11:02:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57061 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233009AbhGAPCN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Jul 2021 11:02:13 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 161ExTM8001736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jul 2021 10:59:30 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CD4D415C3CE1; Thu,  1 Jul 2021 10:59:29 -0400 (EDT)
Date:   Thu, 1 Jul 2021 10:59:29 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin10@huawei.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH RFC v2] ext4:fix warning in mark_buffer_dirty as IO error
 when mount with errors=continue
Message-ID: <YN3YURikQ5SdEFLs@mit.edu>
References: <20210615090537.3423231-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615090537.3423231-1-yebin10@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks, applied.  I reworded the commit description a bit, putting the
explanation first, and cleaning up the text a bit to make it more
readable:

commit 558d6450c7755aa005d89021204b6cdcae5e848f
Author: Ye Bin <yebin10@huawei.com>
Date:   Tue Jun 15 17:05:37 2021 +0800

    ext4: fix WARN_ON_ONCE(!buffer_uptodate) after an error writing the superblock
    
    If a writeback of the superblock fails with an I/O error, the buffer
    is marked not uptodate.  However, this can cause a WARN_ON to trigger
    when we attempt to write superblock a second time.  (Which might
    succeed this time, for cerrtain types of block devices such as iSCSI
    devices over a flaky network.)
    
    Try to detect this case in flush_stashed_error_work(), and also change
    __ext4_handle_dirty_metadata() so we always set the uptodate flag, not
    just in the nojournal case.
    
    Before this commit, this problem can be repliciated via:
    
    1. dmsetup  create dust1 --table  '0 2097152 dust /dev/sdc 0 4096'
    2. mount  /dev/mapper/dust1  /home/test
    3. dmsetup message dust1 0 addbadblock 0 10
    4. cd /home/test
    5. echo "XXXXXXX" > t
    
    After a few seconds, we got following warning:

    ... <rest of commit description was unchanged, and omitted here>
