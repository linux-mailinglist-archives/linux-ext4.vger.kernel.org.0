Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44217A4145
	for <lists+linux-ext4@lfdr.de>; Sat, 31 Aug 2019 02:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfHaART (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Aug 2019 20:17:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbfHaART (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 30 Aug 2019 20:17:19 -0400
Received: from zzz.localdomain (h184-61-154-48.mdsnwi.dsl.dynamic.tds.net [184.61.154.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B0E12342E;
        Sat, 31 Aug 2019 00:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567210638;
        bh=BaRI7IwsAkJrLTQzGT8uAutIa3SlxHbAfQrue2wwro0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2achGriRDM+zaayC37azxpTkHKrWmEdjmSaNVmFDlDq7wQKT+xVdwPl4KrTs/L4ba
         /ICmb5Z0huUZs/5KbSAj8IMkWwUqbir0y16NFvRKF/De776e/oRdn2bvwK/Zri52Ep
         UZZXeL8XWwkfR+aLempswLrD1Rq5OUu02/m9rbjA=
Date:   Fri, 30 Aug 2019 19:17:15 -0500
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+5bda120b4032f831c57f@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: WARNING: suspicious RCU usage in ext4_release_system_zone
Message-ID: <20190831001715.GC22191@zzz.localdomain>
Mail-Followup-To: syzbot <syzbot+5bda120b4032f831c57f@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
References: <000000000000457d1405915a9f19@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000457d1405915a9f19@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 30, 2019 at 12:28:08PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    ed858b88 Add linux-next specific files for 20190826
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=121b506c600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ee8373cd9733e305
> dashboard link: https://syzkaller.appspot.com/bug?extid=5bda120b4032f831c57f
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+5bda120b4032f831c57f@syzkaller.appspotmail.com
> 
> =============================
> WARNING: suspicious RCU usage
> 5.3.0-rc6-next-20190826 #73 Not tainted
> -----------------------------
> fs/ext4/block_validity.c:333 suspicious rcu_dereference_check() usage!
> 

#syz invalid

There was already a fix applied between ed858b88 and latest linux-next:

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 003dc1dc2da3..f7bc914a74df 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -330,11 +330,13 @@ void ext4_release_system_zone(struct super_block *sb)
 {
 	struct ext4_system_blocks *system_blks;
 
+	rcu_read_lock();
 	system_blks = rcu_dereference(EXT4_SB(sb)->system_blks);
 	rcu_assign_pointer(EXT4_SB(sb)->system_blks, NULL);
 
 	if (system_blks)
 		call_rcu(&system_blks->rcu, ext4_destroy_system_zone);
+	rcu_read_unlock();
 }
