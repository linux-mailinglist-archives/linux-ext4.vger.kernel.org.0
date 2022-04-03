Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC574F0A6E
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Apr 2022 16:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbiDCOzr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Apr 2022 10:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359106AbiDCOze (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 Apr 2022 10:55:34 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F77120B7;
        Sun,  3 Apr 2022 07:53:38 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 233ErMd0020997
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 3 Apr 2022 10:53:22 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 22D9615C3E9E; Sun,  3 Apr 2022 10:53:22 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, Ye Bin <yebin10@huawei.com>,
        linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, lczerner@redhat.com,
        linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH -next v2] ext4: fix use-after-free in ext4_search_dir
Date:   Sun,  3 Apr 2022 10:53:19 -0400
Message-Id: <164899700423.964485.9819897021180386715.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220324064816.1209985-1-yebin10@huawei.com>
References: <20220324064816.1209985-1-yebin10@huawei.com>
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

On Thu, 24 Mar 2022 14:48:16 +0800, Ye Bin wrote:
> We got issue as follows:
> EXT4-fs (loop0): mounted filesystem without journal. Opts: ,errors=continue
> ==================================================================
> BUG: KASAN: use-after-free in ext4_search_dir fs/ext4/namei.c:1394 [inline]
> BUG: KASAN: use-after-free in search_dirblock fs/ext4/namei.c:1199 [inline]
> BUG: KASAN: use-after-free in __ext4_find_entry+0xdca/0x1210 fs/ext4/namei.c:1553
> Read of size 1 at addr ffff8881317c3005 by task syz-executor117/2331
> 
> [...]

Applied, thanks!

[1/1] ext4: fix use-after-free in ext4_search_dir
      commit: 44c0286d878598b59225b95596e8a19b3516fafc

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
