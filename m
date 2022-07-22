Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027B257E2BD
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 15:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiGVN7U (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 09:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbiGVN7L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 09:59:11 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC770951DD;
        Fri, 22 Jul 2022 06:58:47 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26MDwTHw016750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 09:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658498311; bh=sFpZcIaOd7DnAF9OZCZNzBmIaZ7bPD9+z4NRwNzFCPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=G6679RwMknwQswmRjxtxbkeCf9ZSVtPB8x0rLCWpKdSvdTs+8g5mrTj42hH571gIJ
         90awH2+VL0bLEE2Cb4XGnEv7xEMPauskOyPXecr713XgWTEb1OGvWPhYLsu12CIkC6
         ZdhKRS1owKtpnkw3WMKSQaM3GVbysTI++rhI6DwnlRjJ6L3gTjDrXqEf7aHUu3TNO9
         kHOdlKJRLOITctal9EdjDAzYV+0HILuEcMsgZ8xNLCIDS7N5VHA3OZMABHap4EBgw4
         ffQT6VXGqxVVTRHI0Ein5x1g005kt4h5Ppi7W/dBbiF97+xzKSwJgDa8mMLbkB0e+V
         XRxNi7t29UfiQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 72D1915C3F04; Fri, 22 Jul 2022 09:58:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     libaokun1@huawei.com, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz, lczerner@redhat.com,
        yebin10@huawei.com, yi.zhang@huawei.com, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, enwlinux@gmail.com,
        adilger.kernel@dilger.ca, yukuai3@huawei.com
Subject: Re: [PATCH v3 0/4] ext4: fix use-after-free in ext4_xattr_set_entry
Date:   Fri, 22 Jul 2022 09:58:18 -0400
Message-Id: <165849767593.303416.8631216390537886242.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220616021358.2504451-1-libaokun1@huawei.com>
References: <20220616021358.2504451-1-libaokun1@huawei.com>
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

On Thu, 16 Jun 2022 10:13:54 +0800, Baokun Li wrote:
> This series adds a macro for whether there is space for xattr in
> ext4 inode, and fixes some problems with this macro.
> 
> V1->V2:
> 	Split the patch to make the logic clearer.
> 	Rename macro to EXT4_INODE_HAVE_XATTR_SPACE.
> V2->V3:
> 	Rename macro to EXT4_INODE_HAS_XATTR_SPACE.
> 
> [...]

Applied, thanks!

[1/4] ext4: add EXT4_INODE_HAS_XATTR_SPACE macro in xattr.h
      commit: ff528f6b155ce79adf38583a66867d8e54cbd460
[2/4] ext4: fix use-after-free in ext4_xattr_set_entry
      commit: 0847102f2b38b43f7352ed8a7f714a291ed1513d
[3/4] ext4: correct max_inline_xattr_value_size computing
      commit: 3d783a3751995003002a5f4f6d333c7c02c7966e
[4/4] ext4: correct the misjudgment in ext4_iget_extra_inode
      commit: 31c5d92b53629452d669980d17adbd22f2af0d26

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
