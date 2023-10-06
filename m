Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C944E7BB054
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Oct 2023 04:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjJFCeG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Oct 2023 22:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjJFCeF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Oct 2023 22:34:05 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14734D8
        for <linux-ext4@vger.kernel.org>; Thu,  5 Oct 2023 19:34:02 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3962XUHp031098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 22:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1696559612; bh=h/mVb9Qv4kArSe4i2LJvatCyufDvFmKmMHUkrDAkVu4=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=E1hMy89vQgKDPjdygpxSL4i0ysYcxKI8+a1d1LqUQxikz2dsi43/M6Jl3Y7dtE45A
         7YRo/Nw5BWG/359cM2nIJxU3oWO2FRmd5ylL8RJQWkvDTsxQLO/wwkiv2lIgOJ/zIi
         5HGNL6k1OQJR6egdpu9j+4bA1VQroaPEG/KhUBHZNM5ZkR3qvKAC+mM6Ev1/W5dOBL
         pMgON0KyiLblh0V6PGZ9hxKzwI2Dgo4OLLcijQQjMI0E40bxsM2RUGru0a0OeaPXRE
         yr8Z/RKCdkNSOtvT/5oXse7kqEfes3O+wevQ3qmTK2KuN+L6/w5te52tllIIQExzSH
         o6RzdTg7Y8eXA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 39A7E15C0250; Thu,  5 Oct 2023 22:33:30 -0400 (EDT)
Date:   Thu, 5 Oct 2023 22:33:30 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH 02/16] ext4: make sure allocate pending entry not fail
Message-ID: <20231006023330.GB24026@mit.edu>
References: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
 <20230824092619.1327976-3-yi.zhang@huaweicloud.com>
 <20230830132503.6xxgb4g7xi7n6lbr@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830132503.6xxgb4g7xi7n6lbr@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 30, 2023 at 03:25:03PM +0200, Jan Kara wrote:
> On Thu 24-08-23 17:26:05, Zhang Yi wrote:
> > From: Zhang Yi <yi.zhang@huawei.com>
> > 
> > __insert_pending() allocate memory in atomic context, so the allocation
> > could fail, but we are not handling that failure now. It could lead
> > ext4_es_remove_extent() to get wrong reserved clusters, and the global
> > data blocks reservation count will be incorrect. The same to
> > extents_status entry preallocation, preallocate pending entry out of the
> > i_es_lock with __GFP_NOFAIL, make sure __insert_pending() and
> > __revise_pending() always succeeds.
> > 
> > Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Looks sensible. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, I've applied the first two patches in this series, since these
are bug fixes.  The rest of the patch series requires more analysis
and review.

						- Ted
