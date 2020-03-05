Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB2417AC87
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Mar 2020 18:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCEROe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Mar 2020 12:14:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:52008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbgCEROd (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 5 Mar 2020 12:14:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 03F87AD20;
        Thu,  5 Mar 2020 17:14:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B3AF01E0FC2; Thu,  5 Mar 2020 18:14:31 +0100 (CET)
Date:   Thu, 5 Mar 2020 18:14:31 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: Inode ENOSPC due to recently_deleted()
Message-ID: <20200305171431.GM21048@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

Recently, I've got a bug report about ext4 driver regressing compared to
the old ext2 driver. The problem is that the filesystem is small and they
fill the fs (use all inodes), then delete some files, and then want to use
the inodes for other files but recently_deleted() logic makes the freed
inodes unusable and thus inode allocation fails with ENOSPC.

AFAIU the logic implemented by recently_deleted() is more of a preference
than a hard rule and we should rather reuse recently deleted inodes than
return ENOSPC. Am I right?

Also I'd note that the detection whether the inode was written out in
recently_deleted() is very inaccurate - one of the problems is that if
several inodes in the same inode table block are deleted, then after
writing out that block we'll be able to reuse only one of these inodes
because by doing that, we certainly cache and dirty the inode block and
thus the recently_deleted() logic for other deleted inodes will start to
apply. But I think we can just live with that if we stop making
recently_deleted() a hard rule...

What do people think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
