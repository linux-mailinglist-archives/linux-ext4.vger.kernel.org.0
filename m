Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F73591811
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Aug 2022 03:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbiHMBNA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Aug 2022 21:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbiHMBNA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Aug 2022 21:13:00 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78580A598E
        for <linux-ext4@vger.kernel.org>; Fri, 12 Aug 2022 18:12:59 -0700 (PDT)
Received: from letrec.thunk.org (c-24-1-67-28.hsd1.il.comcast.net [24.1.67.28])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 27D1Caj8017402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 21:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1660353160; bh=wQTOZ+5lmtGEG/Z9z9CrhJNlvAKNDyqhDvVtzO7xgek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=a5NHcN3DM/wqB//ZKzdEOgT/BZbiz04sRy9Bz2yd6vImd8emqndHVj+O4ZN3JKJ0I
         WgKWmclKXFbCUZnlYrOnd2cSNSIbE6DJFCVnG9VscxyJYcv6pkD7K6Mw6qO5KZXejG
         o5XOKljqc2Zl6h7wNAzdJodcO6a6mqaVuTAvAaLaJgYayfexBT0yCE3APSsGUXxHqT
         3bhcOdYXaafY/iCqb68gQ11RH0bu56Xtf7sSvk5QBIT54wlB+OIfQ+aecFP75CAVDD
         e8uWOvKAiuEVoX3QyO7Jpez9Tpv4teVFV3/StVT1Vj+kFTEjoYqRVbsTEV3nYScL8s
         sTcfKtaAsFj/Q==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id A3B2A8C2DE9; Fri, 12 Aug 2022 21:12:36 -0400 (EDT)
Date:   Fri, 12 Aug 2022 21:12:36 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linfeilong <linfeilong@huawei.com>,
        liuzhiqiang26@huawei.com, liangyun2@huawei.com,
        Alexey Lyahkov <alexey.lyashkov@gmail.com>
Subject: Re: [PATCH] tune2fs: do not change j_tail_sequence in journal
 superblock
Message-ID: <Yvb6hPI1tinxoEgW@mit.edu>
References: <3d484b33-410a-c912-a776-28767b381f7a@huawei.com>
 <3f55f3ad-ba78-e590-65b7-07ff95c78ed1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f55f3ad-ba78-e590-65b7-07ff95c78ed1@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 04, 2022 at 06:33:39PM +0800, zhanchengbin wrote:
> The function recover_ext3_journal in debugfs/journal.c, if the log replay is
> over,
> the j_tail_sequence in journal superblock is not changed to the value of the
> last
> transaction sequence, this will cause subsequent log commitids to count from
> the
> commitid in last time.
> After tune2fs -e, the log commitid is counted from the commitid in last
> time, if
> the log ID of the current operation overlaps with that of the last
> operation, this
> will cause logs that were previously replayed by tune2fs to be replayed
> here.
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Signed-off-by: liangyun <liangyun2@huawei.com>

Applied, thanks!

					- Ted
