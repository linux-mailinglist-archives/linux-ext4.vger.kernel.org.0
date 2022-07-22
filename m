Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D04D57E2B6
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 15:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiGVN7M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 09:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbiGVN6v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 09:58:51 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3349285D;
        Fri, 22 Jul 2022 06:58:43 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26MDwRgt016697
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 09:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658498310; bh=rwMfSXAuhEWsFUTOygNd9rda0/OfmfBu3Eumm0Mclbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PlF3U8Kn150/Boj/lVTzP1W9sc3hLJv3I3z9WUC6jm49MN6yCyp+K4ZSGovTu2RO5
         WZBlBsa5lBEyIk4+vEJm0IbCL5FCFVm+k+ygli4YTn9THgzj/1AeOuDIxbXSMwXH90
         fp27ZkCv1CA8GIZxpEbjoRje8n/iNzk11SlX4xp6HUplAFBK53hr1dvWez1K55uMLC
         KkDOsD26M9bGMQG+l2Xmx2HJtco7kRqFT2+KWspExsQpNB2NSIgNn6BTeGkJ665bIh
         TSxab7IedKWQsskiHjGr3l3c3iVBVzwljluBres5s1LZmg5j5ZX46LznHJ9L/ILLJf
         wYxrtp8z/OkcQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6672315C3EF7; Fri, 22 Jul 2022 09:58:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     bagasdotme@gmail.com, linux-doc@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        corbet@lwn.net, Andreas Dilger <adilger.kernel@dilger.ca>,
        wangjianjian3@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: ext4: fix cell spacing of table heading on blockmap table
Date:   Fri, 22 Jul 2022 09:58:11 -0400
Message-Id: <165849767594.303416.1089496209362973869.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220619072938.7334-1-bagasdotme@gmail.com>
References: <20220619072938.7334-1-bagasdotme@gmail.com>
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

On Sun, 19 Jun 2022 14:29:39 +0700, Bagas Sanjaya wrote:
> Commit 3103084afcf234 ("ext4, doc: remove unnecessary escaping") removes
> redundant underscore escaping, however the cell spacing in heading row of
> blockmap table became not aligned anymore, hence triggers malformed table
> warning:
> 
> Documentation/filesystems/ext4/blockmap.rst:3: WARNING: Malformed table.
> 
> [...]

Applied, thanks!

[1/1] Documentation: ext4: fix cell spacing of table heading on blockmap table
      commit: c575a1b2ca24483836031efd717ae94687bc7572

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
