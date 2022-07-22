Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C9C57E2C2
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 16:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbiGVN72 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 09:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbiGVN7M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 09:59:12 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE6DA876A;
        Fri, 22 Jul 2022 06:58:49 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26MDwTtk016749
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 09:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658498311; bh=H6+b1XGljPAnQPxHRmA80vmscnndF+9aute5CUNT2LQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=o6rLQ3QACSmTlWdIThexFSOpYDe0bPPu8dXn+1S3A5Rhukvd//K2g5ztlCFoyt6LC
         4tiB3303wFITXJnBTvrRXeA5EgGjCAh8RO8ZiVOXewuMLSWA4dZ+tUsnxjk6NVGBRt
         lP//PPqOQYt7jkymZaVTfzB2kLAFBWDV7Qe/JAyBuuNY05BhAT0kPzkiVt3kYNQC3p
         okBy+zrPAmQJCqKkbqSFuY1dXa6/GxJfK27MFIqSNEXceJuVYSHLxgG5hV8r+gqmBz
         dtBj1J08B4j1WBjLYKQNjlF+mMou0eMlm62oULTb+jkARxIDNA5m0IdpjH61WNn5oA
         MmF56FDZb8kyQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 74A2115C3F05; Fri, 22 Jul 2022 09:58:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, lilingfeng3@huawei.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz,
        libaokun2@huawei.com, yi.zhang@huawei.com,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        adilger.kernel@dilger.ca
Subject: Re: [PATCH -next] ext4: recover csum seed of tmp_inode after migrating to extents
Date:   Fri, 22 Jul 2022 09:58:19 -0400
Message-Id: <165849767594.303416.14308987789787240550.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220617062515.2113438-1-lilingfeng3@huawei.com>
References: <20220617062515.2113438-1-lilingfeng3@huawei.com>
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

On Fri, 17 Jun 2022 14:25:15 +0800, Li Lingfeng wrote:
> When migrating to extents, the checksum seed of temporary inode
> need to be replaced by inode's, otherwise the inode checksums
> will be incorrect when swapping the inodes data.
> 
> However, the temporary inode can not match it's checksum to
> itself since it has lost it's own checksum seed.
> 
> [...]

Applied, thanks!

[1/1] ext4: recover csum seed of tmp_inode after migrating to extents
      commit: d335dce171806dd285494cdb49ca2959825c6bb9

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
