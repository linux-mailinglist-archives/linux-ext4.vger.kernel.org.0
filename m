Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885EB4CC0F4
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Mar 2022 16:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbiCCPPj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Mar 2022 10:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiCCPP1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Mar 2022 10:15:27 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6660748300;
        Thu,  3 Mar 2022 07:14:33 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 223FEGgg016302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Mar 2022 10:14:16 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1136015C374D; Thu,  3 Mar 2022 10:14:16 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        lczerner@redhat.com, jack@suse.cz
Subject: Re: [PATCH v3] ext4:fix file system corrupted when rmdir non empty directory with IO error
Date:   Thu,  3 Mar 2022 10:14:13 -0500
Message-Id: <164632037181.689479.14788491798802895933.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220228024815.3952506-1-yebin10@huawei.com>
References: <20220228024815.3952506-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 28 Feb 2022 10:48:15 +0800, Ye Bin wrote:
> We inject IO error when rmdir non empty direcory, then got issue as follows:
> step1: mkfs.ext4 -F /dev/sda
> step2: mount /dev/sda  test
> step3: cd test
> step4: mkdir -p 1/2
> step5: rmdir 1
> 	[  110.920551] ext4_empty_dir: inject fault
> 	[  110.921926] EXT4-fs warning (device sda): ext4_rmdir:3113: inode #12:
> 	comm rmdir: empty directory '1' has too many links (3)
> step6: cd ..
> step7: umount test
> step8: fsck.ext4 -f /dev/sda
> 	e2fsck 1.42.9 (28-Dec-2013)
> 	Pass 1: Checking inodes, blocks, and sizes
> 	Pass 2: Checking directory structure
> 	Entry '..' in .../??? (13) has deleted/unused inode 12.  Clear<y>? yes
> 	Pass 3: Checking directory connectivity
> 	Unconnected directory inode 13 (...)
> 	Connect to /lost+found<y>? yes
> 	Pass 4: Checking reference counts
> 	Inode 13 ref count is 3, should be 2.  Fix<y>? yes
> 	Pass 5: Checking group summary information
> 
> [...]

Applied, thanks!

[1/1] ext4:fix file system corrupted when rmdir non empty directory with IO error
      commit: 7aab5c84a0f6ec2290e2ba4a6b245178b1bf949a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
