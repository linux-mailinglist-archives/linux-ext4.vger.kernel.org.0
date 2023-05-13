Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91333701471
	for <lists+linux-ext4@lfdr.de>; Sat, 13 May 2023 07:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjEMFAM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 May 2023 01:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjEMFAH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 13 May 2023 01:00:07 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F2E44A9
        for <linux-ext4@vger.kernel.org>; Fri, 12 May 2023 22:00:06 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34D4xXJu020089
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 May 2023 00:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683953977; bh=3cYKK25EswvhdkzrkxW4KZHCJziteD1QnNs0r+BrdZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=f7ZattjaUyZ7+bAGNm6LN4lQrBJ6yOnp2LFLNef58m5b630kBXjbQXP4t0AN+8yZj
         GpP9ft5b02WCWjb+l+F+7SBQ8Op9KXaXPkFhpO9col+gVr1o9Lk/xW1DVKJlVyIUE6
         AwYeVEwle/xLMk697ODq/rLNUNJ0X4oIMiza2xcD8KC2QAt5TjKfaTr0iFH5pvzjxV
         3guSccT/cBTZ+FBifkWVJBDf0dwLNIodLETFyV33qrreq5bXFwffKf2y44IyAWAPlw
         dXPffJnHsz6OfN/TSEuk8CxTXrwmsf7AFEOyKLp3OBSvr2vfv27HGhB+Om844VIDst
         aLMdUhCShe4XQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 77FE515C02EA; Sat, 13 May 2023 00:59:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
        syzbot+08106c4b7d60702dbc14@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: check iomap type only if ext4_iomap_begin() does not fail
Date:   Sat, 13 May 2023 00:59:30 -0400
Message-Id: <168395396130.1443054.3104410044543843151.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230505132429.714648-1-libaokun1@huawei.com>
References: <20230505132429.714648-1-libaokun1@huawei.com>
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


On Fri, 05 May 2023 21:24:29 +0800, Baokun Li wrote:
> When ext4_iomap_overwrite_begin() calls ext4_iomap_begin() map blocks may
> fail for some reason (e.g. memory allocation failure, bare disk write), and
> later because "iomap->type ! = IOMAP_MAPPED" triggers WARN_ON(). When ext4
> iomap_begin() returns an error, it is normal that the type of iomap->type
> may not match the expectation. Therefore, we only determine if iomap->type
> is as expected when ext4_iomap_begin() is executed successfully.
> 
> [...]

Applied, thanks!

[1/1] ext4: check iomap type only if ext4_iomap_begin() does not fail
      commit: 705c514635a4b6fd0ee321bcf1a9bd75c3629b71

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
