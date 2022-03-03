Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4394CC0EF
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Mar 2022 16:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiCCPPU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Mar 2022 10:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbiCCPPN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Mar 2022 10:15:13 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39CA457B5;
        Thu,  3 Mar 2022 07:14:27 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 223FEGs2016301
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Mar 2022 10:14:16 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0F8B515C3448; Thu,  3 Mar 2022 10:14:16 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] ext4: Fix ext4_mb_clear_bb() kernel-doc comment
Date:   Thu,  3 Mar 2022 10:14:12 -0500
Message-Id: <164632037182.689479.11338880157247326730.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220301092136.34764-1-yang.lee@linux.alibaba.com>
References: <20220301092136.34764-1-yang.lee@linux.alibaba.com>
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

On Tue, 1 Mar 2022 17:21:36 +0800, Yang Li wrote:
> Remove the excess description of @bh in ext4_mb_clear_bb() kernel-doc
> comment to remove warnings found by running scripts/kernel-doc, which
> is caused by using 'make W=1'.
> 
> fs/ext4/mballoc.c:5895: warning: Excess function parameter 'bh'
> description in 'ext4_mb_clear_bb'
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix ext4_mb_clear_bb() kernel-doc comment
      commit: fd9b6fad667c7516a130cf0f3caddcb965710c12

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
