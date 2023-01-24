Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB8C67A519
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Jan 2023 22:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjAXVjQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Jan 2023 16:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjAXVjQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Jan 2023 16:39:16 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869D08A51
        for <linux-ext4@vger.kernel.org>; Tue, 24 Jan 2023 13:39:14 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30OLcjNj030842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 16:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1674596327; bh=O5N7Xg6veebdPaCi7Eif48ddS2q+Z0a9/L1ouarvedo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=U0jZZuSj3/EVgXimBEuKdxyPPa0xZ3ohtyft9dMp/qtFYKo/INkBSwelVSMmcTN+o
         TMHQ01H7maU4y+fG52XS39wYC/Yfl9EcxMRiOCgGsk2WNvpEiMJPvSCrIqwnHMFKpo
         q4FwmdPdka4Vpx4bVlPqcvcTSg+pLb7X6ap3+L/k0i5P3v5l9tW3ZYEiX/QoiC3Ugw
         8yv23i+8Yzsd6AG0581cKo4J2bdQk47xFU2zNo3tiJ9lPEzXrZ8Ht5aHD8fGHN4RhO
         SDj64NXPqdvMHPrczHl4utg4PvP74EZB098ouv87vniNx+GDi+eEmlqfITOUxL4I3I
         HnMD+2r7UWdwg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6682D15C469B; Tue, 24 Jan 2023 16:38:45 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "lihaoxiang (F)" <lihaoxiang9@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        linux-ext4@vger.kernel.org, linfeilong@huawei.com,
        louhongxiang@huawei.com
Subject: Re: [PATCH] debugfs:fix repeated output problem with `logdump -O -n <num_trans>`
Date:   Tue, 24 Jan 2023 16:38:43 -0500
Message-Id: <167459631656.3471295.11722805770295332844.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <6ab429c0-6dd0-968f-d4e0-54035d177dbf@huawei.com>
References: <6ab429c0-6dd0-968f-d4e0-54035d177dbf@huawei.com>
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

On Tue, 15 Nov 2022 16:29:55 +0800, lihaoxiang (F) wrote:
> Previously, patch 6e4cc3d5eeb2dfaa055e652b5390beaa6c3d05da introduces
> the function of printing the specified number of logs. But there exists
> a shortage when n is larger than the total number of logs, it dumped the
> duplicated records circulately.
> 
> For example, the disk sda only has three records, but using instruction logdump
> -On5, it would output the result as follow:
> ----------------------------------------------------------------------
> Journal starts at block 1, transaction 6
> Found expected sequence 6, type 1 (descriptor block) at block 1
> Found expected sequence 6, type 2 (commit block) at block 4
> No magic number at block 5: end of journal.
> Found sequence 2 (not 7) at block 7: end of journal.
> Found expected sequence 2, type 2 (commit block) at block 7
> Found sequence 3 (not 8) at block 8: end of journal.
> Found expected sequence 3, type 1 (descriptor block) at block 8
> Found sequence 3 (not 8) at block 15: end of journal.
> Found expected sequence 3, type 2 (commit block) at block 15
> Found sequence 6 (not 9) at block 1: end of journal.       <---------begin loop
> Found expected sequence 6, type 1 (descriptor block) at block 1
> Found sequence 6 (not 9) at block 4: end of journal.
> Found expected sequence 6, type 2 (commit block) at block 4
> Found sequence 2 (not 10) at block 7: end of journal.
> Found expected sequence 2, type 2 (commit block) at block 7
> logdump: short read (read 0, expected 1024) while reading journal
> 
> [...]

Applied, thanks!

[1/1] debugfs:fix repeated output problem with `logdump -O -n <num_trans>`
      commit: 9562cfca93da6d70494c3a66bddbc9d439410a34

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
