Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1A59C77C
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 04:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfHZC43 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Aug 2019 22:56:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50970 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729360AbfHZC43 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 25 Aug 2019 22:56:29 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7Q2uDYi011295
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 25 Aug 2019 22:56:14 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D3C6442049E; Sun, 25 Aug 2019 22:56:12 -0400 (EDT)
Date:   Sun, 25 Aug 2019 22:56:12 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, adilger.kernel@dilger.ca
Subject: Re: [PATCH v5] ext4: fix potential use after free in system zone via
 remount with noblock_validity
Message-ID: <20190826025612.GB4918@mit.edu>
References: <1565869639-105420-1-git-send-email-yi.zhang@huawei.com>
 <20190825034000.GE5163@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825034000.GE5163@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I added a missing rcu_read_lock() to prevent a suspicious RCU
warning when CONFIG_PROVE_RCU is enabled:

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
 
 int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,


     				  	       	     - Ted
