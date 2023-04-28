Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA1E6F1DC2
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Apr 2023 19:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346225AbjD1R7a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Apr 2023 13:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjD1R73 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Apr 2023 13:59:29 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA393C1E
        for <linux-ext4@vger.kernel.org>; Fri, 28 Apr 2023 10:59:28 -0700 (PDT)
Received: from letrec.thunk.org ([76.150.80.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33SHxKI7031286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 13:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682704764; bh=DR6/LsFVUoBJktPLFzfP5w67UsHg1xwlACx5/UCmsFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NEvxaevxNpIMZOa24NVqVc4pM1Ot5kTyA6WzDW+/U60fLNPAYLinz2jKC01rJirq2
         HAK0HuEkbdX9nKrONsSL1GK1I7lLenznIa0NeHlqZPtnMdcGHxGjpot75Rr/UESPVb
         9lIVdsnrLjc52U048U7cAh6vMXG/a1ujTdC/Spn759KrDSKsztPIbH63pJ7toj6Bqz
         vBsbYGsw2yDuSz/gaRRxz2C/cMScLHGZvnGNQ4B5ZJBbC9L+E5OSExNmI5Hy9rbBpe
         cZLkFMTlTGEP4noiZt4ekSzY9wHjR8P8tke7atZGLS1wkAuWdk10spOBuAi4nAr/L1
         d37VHgzVZ8RuA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 5E7E88C01E0; Fri, 28 Apr 2023 13:59:20 -0400 (EDT)
Date:   Fri, 28 Apr 2023 13:59:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Wu Jianyue <wujianyue000@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Put inode_operations in inode.c
Message-ID: <ZEwJeMUM3bxTLx4q@mit.edu>
References: <20230428133420.6959-1-wujianyue000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428133420.6959-1-wujianyue000@gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 28, 2023 at 09:34:20PM +0800, Wu Jianyue wrote:
> inode_operations is more suitable to put in inode.c,
> instead of file.c, so moved to inode.c.

The inode operations structure for directories is in fs/ext4/namei.c;
the inode operations for symlinks is in fs/ext4/symlink.c.  Exactly
where the structure definition is somewhat arbitrary; should it be
where the majority of the functions are defined?  Should it be
associated with the file where operations for that inode type are
located?  Should it be in the file where the structure is used (which
is actually in two files; fs/ext4/namei.c and fs/ext4/inode.c)?

Moving it is just churn and makes things less consistent, so I don't
think it's worth it to take this patch, sorry.

      	   	       	    	 	- Ted
