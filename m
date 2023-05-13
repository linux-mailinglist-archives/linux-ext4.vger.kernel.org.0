Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CF270146C
	for <lists+linux-ext4@lfdr.de>; Sat, 13 May 2023 06:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjEME7t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 May 2023 00:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjEME7n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 13 May 2023 00:59:43 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567F2448C
        for <linux-ext4@vger.kernel.org>; Fri, 12 May 2023 21:59:41 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34D4xXx7020074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 May 2023 00:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683953975; bh=JgT6MXwFkpkZalz3HTYTVOmzQyxjoNMOhgEf0DOUK5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ImHvIF6iApVntoqxiF9FuKrgoxp6E8aGg7AegX18ART/lq20U272DteD6+Ju/Jlpt
         Uy1tlkhlsKJw4vahAA5/ApOx14iiHByu0pDfJ0abwjAgRutpdxo8BihNZZ/yKqj2c6
         vnBVdKK24k2OeSroGm9e7lLubcI5hmjyZtzok1tTIZ9iMfC5PKx84fqgq+4guGhtit
         u/J9+YTYHfNyw7xuLJQTaPWUsfQq37opFlC67eh0TJdz+td3Gp9R1bFNSr2UMKssia
         Q7yMKIJCdLC3J2klvWLO3oOkN7fRgrzJc3Iq2KDkruObvBqHgpkQdowPWDEzJP8wsA
         3p8yZIoLkfv/A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 72E3B15C02E6; Sat, 13 May 2023 00:59:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        syzbot+6898da502aef574c5f8a@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] ext4: Avoid deadlock in fs reclaim with page writeback
Date:   Sat, 13 May 2023 00:59:27 -0400
Message-Id: <168395396132.1443054.4355645347214924381.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230504124723.20205-1-jack@suse.cz>
References: <20230504124723.20205-1-jack@suse.cz>
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


On Thu, 04 May 2023 14:47:23 +0200, Jan Kara wrote:
> Ext4 has a filesystem wide lock protecting ext4_writepages() calls to
> avoid races with switching of journalled data flag or inode format. This
> lock can however cause a deadlock like:
> 
> CPU0                            CPU1
> 
> ext4_writepages()
>   percpu_down_read(sbi->s_writepages_rwsem);
>                                 ext4_change_inode_journal_flag()
>                                   percpu_down_write(sbi->s_writepages_rwsem);
>                                     - blocks, all readers block from now on
>   ext4_do_writepages()
>     ext4_init_io_end()
>       kmem_cache_zalloc(io_end_cachep, GFP_KERNEL)
>         fs_reclaim frees dentry...
>           dentry_unlink_inode()
>             iput() - last ref =>
>               iput_final() - inode dirty =>
>                 write_inode_now()...
>                   ext4_writepages() tries to acquire sbi->s_writepages_rwsem
>                     and blocks forever
> 
> [...]

Applied, thanks!

[1/1] ext4: Avoid deadlock in fs reclaim with page writeback
      commit: 568e5b263e8bf81ffb575686f980bd18fdb7428f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
