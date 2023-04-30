Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD416F2966
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Apr 2023 17:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjD3PnX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Apr 2023 11:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjD3PnX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Apr 2023 11:43:23 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD93019BF
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 08:43:21 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33UFhG9l021719
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 11:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682869397; bh=YC9ba268K0vxehl5iucExDq+7LgLn+6XHes3k47ez5I=;
        h=From:To:Cc:Subject:Date;
        b=UFiaQquXoUyXFpAj+qHc9RpNrxaxHv+Tj9R0h8NODDu/Wwv5PCRHAo4DVjYi7fkfx
         rPiZwdOgf1P4dfg4NFTjixj/cpuUQxb3tsI4QX66jBVYG7Umamu6II22Uhr/xgrT5v
         zzUqgwRzXXxAtW9IW9Oz6d6r1hygEns3C3lzLhBWb+0H+WkIMZ1+hc2yXWIXRh4VCB
         I4Lm5xndFiIijMnVIKE1CtRYmFBpRdLXOHhbeEU8i0cbUTWEwMIor9lBj3yD4z9Pbd
         7RM0X5/qYAZdfU90uAFtQEPtMvxsnkbdb9FSQ7dXvwuDJ2GS4MrMZaLrjDSab/7SqK
         h01+8hqhgF1fA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5F54C15C02E2; Sun, 30 Apr 2023 11:43:16 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/2] ext4: fix syzbot report: kernel BUG in ext4_get_group_info
Date:   Sun, 30 Apr 2023 11:43:09 -0400
Message-Id: <20230430154311.579720-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

These two patches address this syzbot report[1].  See also the
discussion here[2].

[1] https://syzkaller.appspot.com/bug?id=69b28112e098b070f639efb356393af3ffec4220
[2] https://lore.kernel.org/r/ZE3YkAiGVLXMbHmb@mit.edu

Theodore Ts'o (2):
  ext4: allow ext4_get_group_info() to fail
  ext4: remove a BUG_ON in ext4_mb_release_group_pa()

 fs/ext4/balloc.c  | 19 +++++++++++-
 fs/ext4/ext4.h    | 15 ++-------
 fs/ext4/ialloc.c  | 12 +++++---
 fs/ext4/mballoc.c | 78 +++++++++++++++++++++++++++++++++++++++--------
 fs/ext4/super.c   |  2 ++
 5 files changed, 96 insertions(+), 30 deletions(-)

-- 
2.31.0

