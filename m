Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410FC6D0AB
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jul 2019 17:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfGRPGR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jul 2019 11:06:17 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39368 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726040AbfGRPGR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jul 2019 11:06:17 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-99.corp.google.com [104.133.0.99] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6IF5kNj016263
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 11:05:47 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 32AA7420054; Thu, 18 Jul 2019 11:05:46 -0400 (EDT)
Date:   Thu, 18 Jul 2019 11:05:46 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     yangerkun <yangerkun@huawei.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org, houtao1@huawei.com,
        yi.zhang@huawei.com, miaoxie@huawei.com
Subject: Re: [PATCH v2] ext4: fix warning when turn on dioread_nolock and
 inline_data
Message-ID: <20190718150546.GA20078@mit.edu>
References: <1562313694-60126-1-git-send-email-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562313694-60126-1-git-send-email-yangerkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 05, 2019 at 04:01:34PM +0800, yangerkun wrote:
> mkfs.ext4 -O inline_data /dev/vdb
> mount -o dioread_nolock /dev/vdb /mnt
> echo "some inline data..." >> /mnt/test-file
> echo "some inline data..." >> /mnt/test-file
> sync
> 
> The above script will trigger "WARN_ON(!io_end->handle && sbi->s_journal)"
> because ext4_should_dioread_nolock() returns false for a file with inline
> data. Move the check to a place after we have already removed the inline
> data and prepared inode to write normal pages.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Thanks, applied.

					- Ted
