Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A5763CA41
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Nov 2022 22:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbiK2VNX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Nov 2022 16:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236897AbiK2VMq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Nov 2022 16:12:46 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6E5140B2;
        Tue, 29 Nov 2022 13:12:45 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2ATLCL58029764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 16:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1669756343; bh=D4a/3OPtZsqgpt2hLjT/spZXJ5i2lRaG6hjXHLv4JK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=F0uSkDmTjmuyjsShwB+ilh1uCEHO5lqLqRhx+CnDiHHwA7Se+f3vg+iMneibYTzZr
         jZEb0GVelkCKevtPkd+riaeK8VidvmA9rx+BQOboGGhypIu3VpcXlZRIRhfSQbYytW
         VJ37HTXTIa8kK57DIeL71m5qVasey0Wex6BaeMz/II1LAd9tSv2vmkglZaR3siVBBw
         CGigGw88b3mOYe0k7U4o/mqpYVUfGeSCQ1uqNlMcAcxnkoktP2nn+n0iR2S6KMRp5o
         3+S5aQbMMMpRoVH2jqJZW4dCbK/Mq1b242YNNiZqULC9ZX3+VZeWQ1n74VwgNQ8+r9
         jDXelHBqWqlxg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6B72915C3ACA; Tue, 29 Nov 2022 16:12:19 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        enwlinux@gmail.com, jack@suse.cz, lczerner@redhat.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, yebin10@huawei.com,
        ritesh.list@gmail.com, adilger.kernel@dilger.ca
Subject: Re: [PATCH 0/2] ext4: fix a infinite loop in do_writepages after online resizing
Date:   Tue, 29 Nov 2022 16:12:14 -0500
Message-Id: <166975630697.2135297.7495422853696969304.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220817132701.3015912-1-libaokun1@huawei.com>
References: <20220817132701.3015912-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 17 Aug 2022 21:26:59 +0800, Baokun Li wrote:
> We got a issue: the ext4 writeback process was stuck in do_writepages and
> do_writepages kept retrying. However, '-ENOMEM' is returned each time, even
> if there is still free memory on the current machine.
> 
> We find that the direct cause of this issue is that the bg_inode_table_hi
> in the group descriptor is written to an incorrect value, which causes the
> inode block found through the inode table to exceed the end_ block。Then,
> sb_getblk always returns null, __ext4_get_inode_loc returns `-ENOMEM`,
> and do_writepages keeps retrying.
> 
> [...]

Applied, thanks!

[1/2] ext4: fix GDT corruption after online resizing with bigalloc enable and blocksize is 1024
      commit: 496fb12f8e236f303de6bc73a0334dd50c4eb64a
[2/2] ext4: add inode table check in __ext4_get_inode_loc to aovid possible infinite loop
      commit: bfb0625e8e86f8797264b1c7d10e146afe243d23

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
