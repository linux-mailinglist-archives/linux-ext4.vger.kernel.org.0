Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B11657E486
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 18:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbiGVQhR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 12:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiGVQhR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 12:37:17 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80FF93694;
        Fri, 22 Jul 2022 09:37:15 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26MGaxo1007545
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 12:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658507820; bh=V4B0S7YlVC/I6JJKkg4wR+2YzppJ/F016/91YQyybNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WwPmIZpPGwXATxQ5Mpx5IszodLJJdsnNqzyV6W+P7IG3c7rSLUkSyakfeG/TvJvYS
         iR7Ro+p+g512QJmiP5dh1f+KIKnQFOlFmu/EALiaLVT9PcuHXMWw6TSxR5tExXwmZB
         USUT+3rauJtGeWA1H8SGEv+T7+ZyCHfGXNXz1HOVhvzFcrMyqma6CGz39waCnN1AI1
         5l9WCnX7VXUDohBK9bx1oPJzd5Swecgb8UvECBHBkVRxbuPK7m4n8CpFQQwlos9vPv
         iBKH9hevuXuWpBv55YkLdW0HjpY0GdT3lLAuL6cQD3iJKi4FxN7vVG9GHogk5HN6h/
         Gy4GUOwDgCqUw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 215ED15C3EF7; Fri, 22 Jul 2022 12:36:59 -0400 (EDT)
Date:   Fri, 22 Jul 2022 12:36:59 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ext4: resize fs after resize_inode without e2fsck
Message-ID: <YtrSK+qUm9+xRI7L@mit.edu>
References: <20220713092859.3881376-1-sunke32@huawei.com>
 <20220713092859.3881376-2-sunke32@huawei.com>
 <20220714154607.qq6cqgvncxhsn66w@zlang-mailbox>
 <YtCSAjiMc9RElnHu@mit.edu>
 <20220715180815.gegmapvruor6vin3@zlang-mailbox>
 <b424fd69-aeb4-f749-d09b-5d824454dd94@huawei.com>
 <YtqPXcFbbrFBr1om@mit.edu>
 <20220722151114.c4w7s6v6fu5hphf5@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722151114.c4w7s6v6fu5hphf5@zlang-mailbox>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 22, 2022 at 11:11:14PM +0800, Zorro Lang wrote:
> > This resets the s_reserved_gdt_blocks field back to zero, so the fsck
> > doesn't fail.  Which is fine, because the point of the test is to see
> > whether the kernel dereferences a NULL pointer or not.
> 
> Or maybe just replace _reuqire_scratch with _require_scratch_nocheck, if we
> corrupt the fs on SCRATCH_DEV intentionally?

Agreed, that would be a better solution.

					- Ted
