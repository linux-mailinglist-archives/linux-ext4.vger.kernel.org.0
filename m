Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E18278110A
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 18:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378813AbjHRQyw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 12:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355377AbjHRQyr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 12:54:47 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DD92D69
        for <linux-ext4@vger.kernel.org>; Fri, 18 Aug 2023 09:54:45 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-121-162.bstnma.fios.verizon.net [173.48.121.162])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37IGsWlp025845
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 12:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692377674; bh=3TBPcwwvT45h+S8+BZpfunIVBWZbSc/tBCiYkHiH5Do=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=GE/sCRk5Uh4mO84f8iimShE/tdUxBFbblaH2UCoRWav2vN469ki9w9ZEoE1KXlOwM
         nVuQyLQEdCAV0+p2+Jlqm1f6XNNGNgSEC5dW/TNLJmJ443lJV/EuxeyjXNUbW2KPOQ
         fxIk943RRXhEPqCt1Kzj2IBnY3qlcJMceuVWfwnGyw7gIjAiHLKu4OqQmuIFUfe+8q
         LPnqdA7fLbDNhGy7atPAN7UuPEjPl3vBUbgiUVUrvs5OGYmUC4xve1bLa8KFfpPquS
         pDLwekow0wVEL2PrrimO9ptXwWRnEyrn3Wj1EPk+egvfdYu9Ubb4rgEw4V7YueyL6m
         R5HY1CeeB/kyg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 90D1015C0501; Fri, 18 Aug 2023 12:54:32 -0400 (EDT)
Date:   Fri, 18 Aug 2023 12:54:32 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] ext4: correct gdblock calculation in
 add_new_gdb_meta_bg to support non first group
Message-ID: <20230818165432.GB3515079@mit.edu>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-12-shikemeng@huaweicloud.com>
 <20230816034543.GS2247938@mit.edu>
 <29c9e94f-63b3-e757-9d6d-c9beaa0e0c19@huaweicloud.com>
 <20230817140328.GY2247938@mit.edu>
 <e9215048-8a10-bb3e-93f7-0bf840997027@huaweicloud.com>
 <20230818040751.GF3464136@mit.edu>
 <797c2dff-1858-9e4b-bda7-d6106d5ff844@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <797c2dff-1858-9e4b-bda7-d6106d5ff844@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 18, 2023 at 03:09:35PM +0800, Kemeng Shi wrote:
> > Is following comment looks good to you:
>
> When all reserved primary blocks are consumed, we create meta_bg group and
> allocate new primary block at first block or block after backup superblock
> (if exsiting) in first group of meta_bg group.
> This function is only called when first group of meta_bg is added.

Well, it's possible to create a file system where all of the block
group descriptors use meta_bg, and there are no "traditional" block
group descriptors.  And so what happens is if there is no available
space in the existing block group descriptors for the new block group,
and there are no reserved block group descriptors (I'd remove
"primary" as that's not something that we've used traditionally), then
what happens is that the meta_bg feature will get enabled, and
es->s_first_meta_bg will get set to the first block group that is
managed using meta_bg.  s_first_meta_bg must be a multiple of
EXT4_DESC_PER_BLOCK(sb).

Some of this is documented in Documentation/filesystems/ext4/blockgroup.rst
already.

Cheers,

						- Ted
