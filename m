Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E156AFDE4
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 05:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCHEdr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 23:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCHEdl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 23:33:41 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030BD98E8F
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 20:33:37 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3284XTIK021511
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 23:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678250011; bh=AtGTfNGVlTo+6qf8F2BUGuKXyT5UAFpW1qsSK4MUwZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=N6rBG8VbznZJf9ZhRgu+VWz4soc+gNPXYU0mryllFMj1AVwbrc3W/DYjDoitZBY6I
         6/p/50ej8ke5DXjhy7n+0JnM+a3TlGAZchu0oIvdUDB3VH2LkV73ChH+wgr9DEDtBp
         Cm5dXvx2CUhDsmFF1r9YXwV+SBBtXp2nnyhNOtvOpHTbijY0X3nzsV22LQxSIHAJj4
         /9H1MoP/ygh+biDqBGrGY/+CXNVvK7qVA9Pu883lEMqk2tsbZi0sCtHoXvz9tlEzyb
         pHHlYvXAeB+O3SYd4CwhYHQofhomsmB1dKZGQVzEFhOFZukbvEC9FnLkAN7JM03rDk
         lR+KYcDlnZDGQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D33FC15C348C; Tue,  7 Mar 2023 23:33:29 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        syzbot+9d16c39efb5fade84574@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: Fix deadlock during directory rename
Date:   Tue,  7 Mar 2023 23:33:24 -0500
Message-Id: <167824999283.2129363.13902737390476485440.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230301141004.15087-1-jack@suse.cz>
References: <20230301141004.15087-1-jack@suse.cz>
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

On Wed, 1 Mar 2023 15:10:04 +0100, Jan Kara wrote:
> As lockdep properly warns, we should not be locking i_rwsem while having
> transactions started as the proper lock ordering used by all directory
> handling operations is i_rwsem -> transaction start. Fix the lock
> ordering by moving the locking of the directory earlier in
> ext4_rename().
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix deadlock during directory rename
      commit: 3c92792da8506a295afb6d032b4476e46f979725

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
