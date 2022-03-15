Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE994DA1A8
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Mar 2022 18:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350797AbiCORz7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Mar 2022 13:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350793AbiCORz5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Mar 2022 13:55:57 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A27D593B4
        for <linux-ext4@vger.kernel.org>; Tue, 15 Mar 2022 10:54:40 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22FHsPUh006667
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 13:54:26 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BC6BE15C3E98; Tue, 15 Mar 2022 13:54:25 -0400 (EDT)
Date:   Tue, 15 Mar 2022 13:54:25 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linfeilong <linfeilong@huawei.com>,
        liuzhiqiang26@huawei.com
Subject: Re: e2fsck: do not skip deeper checkers when s_last_orphan list has
 truncated inodes
Message-ID: <YjDS0SLV+jqHfgPm@mit.edu>
References: <647cc60d-18d4-ab53-6c91-52c1f6d29c3a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <647cc60d-18d4-ab53-6c91-52c1f6d29c3a@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 15, 2022 at 04:01:45PM +0800, zhanchengbin wrote:
> If the system crashes when a file is being truncated, we will get a
> problematic inode,
> and it will be added into fs->super->s_last_orphan.
> When we run `e2fsck -a img`, the s_last_orphan list will be traversed and
> deleted.
> During this period, orphan inodes in the s_last_orphan list with
> i_links_count==0 can
> be deleted, and orphan inodes with  i_links_count !=0 (ex. the truncated
> inode)
> cannot be deleted. However, when there are some orphan inodes with
> i_links_count !=0,
> the EXT2_VALID_FS is still assigned to fs->super->s_state, the deeper
> checkers are skipped
> with some inconsistency problems.

That's not supposed to happen.  We regularly put inodes on the orphan
list when they are being truncated so that if we crash, the truncation
operation can be completed as part of the journal recovery and remount
operation.  This is true regardles sof whether the recovery is done by
e2fsck or by the kernel.

If a crash during a truncate leads to an inconsistent file system
after the file system is mounted, or after e2fsck does the journal
replay and orphan inode list processing, that's a kernel bug, and we
should fix the bug in the kernel.

Do you have a reliable reproducer for this situation?

Thanks,

						- Ted
