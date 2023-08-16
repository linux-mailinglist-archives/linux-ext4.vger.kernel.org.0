Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62E277D8C6
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 05:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjHPDD1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 23:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241448AbjHPDDZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 23:03:25 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC6998
        for <linux-ext4@vger.kernel.org>; Tue, 15 Aug 2023 20:03:23 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-114-154.bstnma.fios.verizon.net [173.48.114.154])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37G33BE2002921
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 23:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692154993; bh=H9A+uWFdC1TFRZ7nZo3ksCU3X8C8VooTWyzDXDEJ/S4=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=CW+YhaAFhxxNbN/k4QYzxpBjs/QN0k6EKOKCzrCbEb8G7pa5LJOe9+OlIDNZ5wlnx
         yP71uaXTRpthmic/clCh0cN/o3kPEWWQgjYgIW4aHhEeS4dlZppmWxK9UBMv/tXodS
         R/L+i/fgvYIrOy98qmphzTqLOZsev9o2QJT29Zct9QG8Y3+JFBuDUiwqOj0DsL2+Pb
         YpIMJRlrT6UAcUll4/6TFWWrObRR9U3KYDBKJFNvl9Gl+TSppKl5G3QrIQMLiWrgAm
         SqVv72TC6WL/f6YKoXLmr8FSC67qbsseA8J9PzKjuzZKvsquRZ/qbQECBx5XImBz5H
         luUvnE6/JSg7w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0CB6315C0292; Tue, 15 Aug 2023 23:03:11 -0400 (EDT)
Date:   Tue, 15 Aug 2023 23:03:11 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] ext4: correct offset of gdb backup in non meta_bg
 group to update_backups
Message-ID: <20230816030311.GJ2247938@mit.edu>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-2-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629120044.1261968-2-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 29, 2023 at 08:00:32PM +0800, Kemeng Shi wrote:
> Commit 0aeaa2559d6d5 ("ext4: fix corruption when online resizing a 1K
> bigalloc fs") found that primary superblock's offset in its group is not
> equal to offset of backup superblock in its group when block size is 1K
> and bigalloc is enabled. As group descriptor blocks are right after
> superblock, we can't pass block number of gdb to update_backups for
> the same reason.
> The root casue of the issue above is that leading 1K padding block is
> count as data block offset for primary block while backup block has
> no padding block offset in its group.
> Remove padding data block count to fix the issue for gdb backups.
> 
> For meta_bg case, update_backups treat blk_off as block number, do no
> conversion in this case.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
