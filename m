Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D7C4CC0ED
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Mar 2022 16:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiCCPPS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Mar 2022 10:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbiCCPPN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Mar 2022 10:15:13 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3723445509;
        Thu,  3 Mar 2022 07:14:27 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 223FEGv9016300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Mar 2022 10:14:16 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0A9A315C0038; Thu,  3 Mar 2022 10:14:16 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, kernel-janitors@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] ext4: remove redundant assignment to variable split_flag1
Date:   Thu,  3 Mar 2022 10:14:09 -0500
Message-Id: <164632037182.689479.9390107109546635119.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220301121644.997833-1-colin.i.king@gmail.com>
References: <20220301121644.997833-1-colin.i.king@gmail.com>
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

On Tue, 1 Mar 2022 12:16:44 +0000, Colin Ian King wrote:
> Variable split_flag1 is being assigned a value that is never read,
> it is being re-assigned a new value in the following code block.
> The assignment is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> fs/ext4/extents.c:3371:2: warning: Value stored to 'split_flag1' is
> never read [deadcode.DeadStores]
> 
> [...]

Applied, thanks!

[1/1] ext4: remove redundant assignment to variable split_flag1
      commit: 6b71b69dd98b197deea0806417e88308e0876a10

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
