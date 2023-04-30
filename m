Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538DD6F2A1A
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Apr 2023 19:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjD3R7i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Apr 2023 13:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjD3R7g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Apr 2023 13:59:36 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1603B1997
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 10:59:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33UHx8AI016299
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 13:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682877552; bh=TBaeqbVigzavvegKuyag16It+JOOeNz6ljB+DqYzo3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Oec5ufHms1Zl3Cbq+u5Ys2pcLz5DF01ISyISynPvCMemG6AnEf7ZQILKx5NyAjWX9
         bKe1UnKevfGmDcib5lZ71Tahg2jPSfLcXAwb7mXpBGpZYOfmqGtrSoN1jZn1K+Kl5x
         uD93sqsFB+fqiATIYdktMgDiGr/PEYDqWCEPkZidYX6CWwm/HLStVBu7BpFToL0gnH
         OO0kJtSZz4IluRk1DpuAM8MiUz4lB6C+Uew7Yht/VND1/0QLfj47wivAJ02pn+RQLw
         R8l1IBMpt7k/ozQEjE0PvCI5Yb2z/ZR+Ea/8XdkCf+V/K1DZMuBrs8O/kp3x75EyWL
         meiq3auflAUdg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 891FC15C02E4; Sun, 30 Apr 2023 13:59:08 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, yebin10@huawei.com, jack@suse.cz,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, enwlinux@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        joneslee@google.com,
        syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com
Subject: Re: [RESEND PATCH] ext4: fix use-after-free Read in ext4_find_extent for bigalloc + inline
Date:   Sun, 30 Apr 2023 13:59:07 -0400
Message-Id: <168287753834.584010.2057559370526197114.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230406111627.1916759-1-tudor.ambarus@linaro.org>
References: <20230406111627.1916759-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Thu, 06 Apr 2023 11:16:27 +0000, Tudor Ambarus wrote:
> Syzbot found the following issue:
> loop0: detected capacity change from 0 to 2048
> EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: none.
> ==================================================================
> BUG: KASAN: use-after-free in ext4_ext_binsearch_idx fs/ext4/extents.c:768 [inline]
> BUG: KASAN: use-after-free in ext4_find_extent+0x76e/0xd90 fs/ext4/extents.c:931
> Read of size 4 at addr ffff888073644750 by task syz-executor420/5067
> 
> [...]

Applied, thanks!

[1/1] ext4: fix use-after-free Read in ext4_find_extent for bigalloc + inline
      commit: 835659598c67907b98cd2aa57bb951dfaf675c69

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
