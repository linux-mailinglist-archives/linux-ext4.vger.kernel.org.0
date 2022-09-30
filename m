Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894BD5F0338
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Sep 2022 05:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiI3DVA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 23:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiI3DUi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 23:20:38 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD44E43322;
        Thu, 29 Sep 2022 20:20:09 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28U3Jn7c002433
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 23:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664507992; bh=5SVdgaNLhrOI7w/ZQg3N4vSzmXahsvbRHSlrOALTj8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=McMTlkrMxWdgtYmAVDfLmUpg6ENA1bwwQ4IU4ieAeDQW2ZZ4avW6590rjAM3S8KI6
         Nt0VxybxSIOcQQMWGnKzFtki7dy/colE5A+b51P4spiRUHOPL4FZg+CYvAzQKrG3qV
         8ryRsC+q0GVpgzEaPcICXxL+HFE8IPn+q2RQtSEFsJ1W94mhJfvjRYGPio4pFdouE6
         DtAec6KtnaionF0YtvyUn5YOPGcxE1ZAA2yNKFXLRr4M0rd6o0pvfxRpekicjrpHJc
         Xr2k++Sdz4pivJw8F40UIkc/qMXWmPUC4Js6UfBUYSE+4cKTwkkU6JJaTA6S/9JTL8
         z8Ofpcqxow4RA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9193C15C3448; Thu, 29 Sep 2022 23:19:47 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        bigeasy@linutronix.de, LKML <linux-kernel@vger.kernel.org>,
        efault@gmx.de
Subject: Re: [PATCH] mbcache: Avoid nesting of cache->c_list_lock under bit locks
Date:   Thu, 29 Sep 2022 23:19:36 -0400
Message-Id: <166450797715.256913.1802115613587243672.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220908091032.10513-1-jack@suse.cz>
References: <20220908091032.10513-1-jack@suse.cz>
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

On Thu, 8 Sep 2022 11:10:32 +0200, Jan Kara wrote:
> Commit 307af6c87937 ("mbcache: automatically delete entries from cache
> on freeing") started nesting cache->c_list_lock under the bit locks
> protecting hash buckets of the mbcache hash table in
> mb_cache_entry_create(). This causes problems for real-time kernels
> because there spinlocks are sleeping locks while bitlocks stay atomic.
> Luckily the nesting is easy to avoid by holding entry reference until
> the entry is added to the LRU list. This makes sure we cannot race with
> entry deletion.
> 
> [...]

Applied, thanks!

[1/1] mbcache: Avoid nesting of cache->c_list_lock under bit locks
      commit: 9cbf99ae41e3a051cc9ec738f2c436ec1725e0e8

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
