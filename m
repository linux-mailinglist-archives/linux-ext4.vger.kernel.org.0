Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA655F033B
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Sep 2022 05:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiI3DVD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 23:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiI3DUj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 23:20:39 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECF4474D7;
        Thu, 29 Sep 2022 20:20:11 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28U3JoM8002495
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 23:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664507992; bh=InwxxtZzPcg1a2jnoqdl/qmDf0hT2VtYsjfVKFLr6Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DZbI3KE6nvZ+c/Qirh+L04wCJiZ8w/FuzhOYn/kg0QsrxHDLY3dCJmfO4GswJPtNf
         xspgNmbs5Qdholt/hFvnBrdwoITY/VvLqPNw/hYeylUDW2dJ2yccFZk/UyMO51x7uu
         IvBy8Le6SY1otxavF9oYIZrnVy+erDzXY7vKSKvlVBUM9/QBPZ0phbpl9/ZiBjzy7j
         DpwmnhPVKeM7YTL6W9MobcrucxhW5P//g6b2hJNaj4Zala1h1LZWoSDWgEDzf0kGJa
         acqpBGvRm0eDlA+E1fR2bOfQ6IUwPYFwjPoO1KscpmTpIIuFoLuvp60qsLqHdrVEXj
         aRXZSyMhL+Rhw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A0B2815C35F2; Thu, 29 Sep 2022 23:19:47 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        yebin10@huawei.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v2 0/2] some refactor of ext4_fc_track_inode
Date:   Thu, 29 Sep 2022 23:19:44 -0400
Message-Id: <166450797716.256913.3861377771149654034.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220916083836.388347-1-yebin10@huawei.com>
References: <20220916083836.388347-1-yebin10@huawei.com>
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

On Fri, 16 Sep 2022 16:38:34 +0800, Ye Bin wrote:
> diff v2 vs v1:
> Add detail changelog for patch:"ext4: adjust fast commit disable judgement
> order in ext4_fc_track_inode".
> 
> Ye Bin (2):
>   ext4: factor out ext4_fc_disabled()
>   ext4: adjust fast commit disable judgement order in
>     ext4_fc_track_inode
> 
> [...]

Applied, thanks!

[1/2] ext4: factor out ext4_fc_disabled()
      commit: 4396ba8a73535e95ec16aedb9ef7a3cecdf385b4
[2/2] ext4: adjust fast commit disable judgement order in ext4_fc_track_inode
      commit: 79329f86d0e4dfc192579ed08039b89e6e8d4211

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
