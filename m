Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8D077D8FD
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 05:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241479AbjHPDW5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 23:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241443AbjHPDWZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 23:22:25 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FDA2135
        for <linux-ext4@vger.kernel.org>; Tue, 15 Aug 2023 20:22:24 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-114-154.bstnma.fios.verizon.net [173.48.114.154])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37G3MC32010591
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 23:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692156134; bh=2YCC1NcwmWW7Qb/h+7kZZXiWFa2gKiyFGvH9ROIIpCE=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=W2qLASmjBfwbAOL1rSCHm5GJYc9roCcq754bDgbbx9CVUS4FPw0z3KLLvQVK6lR5m
         3g0dTG5zH+5ieZoXOGuXTLEe1wsSfwKC8YlIi4oaz49lEv5q8cdHG+JyYva856r+6f
         3+wlWm71VVmMYKzgFSP8laBA07nW8Y4O3FQbEfVms9bh78S6uhYfEH4u0XIvZa3/tF
         WLwd/HZnvB+qGwkRLBTzgMgTdQ0JBZauDe4UOYf4S41/omUGrvaIfDlX8s2+VOnuyh
         EGlEi6zHo0xR4//q2DFuCOIVRZ/dHmWdxXwm1GNmd38z3alkVPEZNfL4LE9etBcjJm
         Cb7972xVNcr8g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7D52C15C0292; Tue, 15 Aug 2023 23:22:12 -0400 (EDT)
Date:   Tue, 15 Aug 2023 23:22:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] ext4: calculate free_clusters_count in cluster
 unit in verify_group_input
Message-ID: <20230816032212.GP2247938@mit.edu>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-9-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629120044.1261968-9-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 29, 2023 at 08:00:39PM +0800, Kemeng Shi wrote:
> We treat free_clusters_count in cluster unit while free_blocks_count is
> in block unit. Convert free_blocks_count to cluster unit to match the
> unit.
> Currently, verify_group_input is only called from ext4_ioctl_group_add
> which does not support bigalloc yet. The dismatch is easily ingored
> when we try to support bigalloc in ext4_ioctl_group_add (ext4_resize_fs
> already supports resize with bigalloc enabled). Just fix this in
> advance.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

I'd rewrite the commit description a bit:

The field free_cluster_count in struct ext4_new_group_data should be
in units of clusters.  In verify_group_input() this field is being
filled in units of blocks.  Fortunately, we don't support online
resizing of bigalloc file systems, and for non-bigalloc file systems,
the cluster size == block size.  But fix this in case we do support
online resizing of bigalloc file systems in the future.

Other than that:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
