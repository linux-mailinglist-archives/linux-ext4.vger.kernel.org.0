Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5380C5F033D
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Sep 2022 05:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiI3DVI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 23:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiI3DUj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 23:20:39 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF33474C2
        for <linux-ext4@vger.kernel.org>; Thu, 29 Sep 2022 20:20:11 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28U3JpBO002543
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 23:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664507993; bh=XdarjUWVbKjgyXKB8T04eWwJ13J3nKwEei6rPN90rmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AIUHhkJ0EoCH2SuU2jchyhhyE7kxd7h+WwFXiR6xx9wqu4S6Lozb96vGCNkFWCJDk
         Ifmdrj4j4i9VLjPuhCNzTEQFJjXonIPWR3fwZMfoujgn9QznD2FoTqRjZlyZuhbE9R
         CjPF6OLQt1WGT60sYcXKBlL0c7kynp1BG4B9ZiXEUE5bPcXMlHjcHJA8+jG4evAUoA
         iG7jjvMfGsT9alOCJFqvFPC+SKb1mkADIqoPXOlU8v6JjX8V+CYOpGALKbtJMO/zZr
         9fvvVhDc9G74F81hdq1OyT9X7hRBDeIdv6qXawPCVisqpix4Cu7yozePDLO/s/fwIc
         EqGeRQNy+dXCw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A402915C3710; Thu, 29 Sep 2022 23:19:47 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        openglfreak@googlemail.com, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: ext4_read_bh_lock() should submit IO if the buffer isn't uptodate
Date:   Thu, 29 Sep 2022 23:19:46 -0400
Message-Id: <166450797715.256913.16436347919601739345.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220831074629.3755110-1-yi.zhang@huawei.com>
References: <20220831074629.3755110-1-yi.zhang@huawei.com>
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

On Wed, 31 Aug 2022 15:46:29 +0800, Zhang Yi wrote:
> Recently we notice that ext4 filesystem occasionally fail to read
> metadata from disk and report error message, but the disk and block
> layer looks fine. After analyse, we lockon commit 88dbcbb3a484
> ("blkdev: avoid migration stalls for blkdev pages"). It provide a
> migration method for the bdev, we could move page that has buffers
> without extra users now, but it lock the buffers on the page, which
> breaks the fragile metadata read operation on ext4 filesystem,
> ext4_read_bh_lock() was copied from ll_rw_block(), it depends on the
> assumption of that locked buffer means it is under IO. So it just
> trylock the buffer and skip submit IO if it lock failed, after
> wait_on_buffer() we conclude IO error because the buffer is not
> uptodate.
> 
> [...]

Applied, thanks!

[1/1] ext4: ext4_read_bh_lock() should submit IO if the buffer isn't uptodate
      commit: 07e3f4273ff54a4c891f05e9f0f0c842b46578a7

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
