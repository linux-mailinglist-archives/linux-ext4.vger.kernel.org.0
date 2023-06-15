Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9A1731C10
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jun 2023 17:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241338AbjFOPA0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 11:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345239AbjFOPAQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 11:00:16 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348EF1FFA
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 08:00:16 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-128-67.bstnma.fios.verizon.net [173.48.128.67])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35FExxqL026896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 11:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686841202; bh=GDS5qOYCrkvpT0btC8wIq61lei7488TDn18ijfW9EdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EdMBfnQvGmil2TLw8/oXgqURGpUL4gbc8ANZuoYRaAGjVQ0jsT4vDxd0vXCAzTU92
         /VTX8wKCbkj8FISLdZJZEAEUjzYHHcKqTkW+dfaGUzPcXmm0y6ae/W6TVSLL8q1Lrj
         tWldjrzqOHU9R7MF0E4ix4EcxPDGgOjDv3gNvaYyNZ0jJkcKV87DjOFg4QhZbGa7UD
         qMnxH5la6DfYy2iZSJyCXXbomckP8H0XVEQ93PTwlGqyrTsGi1IhJK/mdVtcrPwt4o
         AcCj1rmEKNC/eot3r52oO0QHvSnqqntfEYx7dA48Za3wt11j+8KH696DEmt/xoFBNY
         n1nqseAHt/xEA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D531515C02E0; Thu, 15 Jun 2023 10:59:59 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, s.l-h@gmx.de,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "ext4: remove unnecessary check in ext4_bg_num_gdb_nometa"
Date:   Thu, 15 Jun 2023 10:59:56 -0400
Message-Id: <168683994078.282246.12341856291517677835.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230613225025.3859522-1-shikemeng@huaweicloud.com>
References: <20230613225025.3859522-1-shikemeng@huaweicloud.com>
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


On Wed, 14 Jun 2023 06:50:25 +0800, Kemeng Shi wrote:
> This reverts commit ad3f09be6cfe332be8ff46c78e6ec0f8839107aa.
> 
> The reverted commit was intended to simpfy the code to get group
> descriptor block number in non-meta block group by assuming
> s_gdb_count is block number used for all non-meta block group descriptors.
> However s_gdb_count is block number used for all meta *and* non-meta
> group descriptors. So s_gdb_group will be > actual group descriptor block
> number used for all non-meta block group which should be "total non-meta
> block group" / "group descriptors per block", e.g. s_first_meta_bg.
> 
> [...]

Applied, thanks!

[1/1] Revert "ext4: remove unnecessary check in ext4_bg_num_gdb_nometa"
      commit: 19482792113fa1dc419f9bc7b04b9dbdaa5256fd

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
