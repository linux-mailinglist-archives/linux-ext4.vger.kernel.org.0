Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5913057E100
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 13:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiGVLw1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 07:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiGVLw1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 07:52:27 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25256BA4FC;
        Fri, 22 Jul 2022 04:52:25 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26MBpvxx025939
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 07:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658490719; bh=DaSiO2VrSxn5dx8LEYgeq0ewiMxUiFzJ+ygINv6L9OM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=c5vb4i77Su5dD09fsEmttsiqtAdFdHChNqHPeFf7HviNL1+h/4iQDXtA6BX13nDXR
         gdVqClKO9dCKEwQcWmD7HTiTA6QX7F1syzjyHk+AJAH7jr3XHCqgqHk4CkZGb3TR1H
         zz3KPFC6GxNVqSCSjApUQfxraW+F9ftVbkUtZUt7sA/6iFoW+skdwX7O4Lk4aM161f
         Tr9qXtE2p5dKOoq+HX5XJJqrHT8U17f/i9Ro2ZJPOKM2DjEWH7k/VvbEMIQmOl4S0e
         +RLZFLh8mMzATb2+Rz6NRQR7CJQEOLZ9+nOo2NicqZ6/cLOgmPhZDkqsrkj9ulsSnY
         GPT5uTEz2nHJA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A880315C3EF7; Fri, 22 Jul 2022 07:51:57 -0400 (EDT)
Date:   Fri, 22 Jul 2022 07:51:57 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sun Ke <sunke32@huawei.com>
Cc:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ext4: resize fs after resize_inode without e2fsck
Message-ID: <YtqPXcFbbrFBr1om@mit.edu>
References: <20220713092859.3881376-1-sunke32@huawei.com>
 <20220713092859.3881376-2-sunke32@huawei.com>
 <20220714154607.qq6cqgvncxhsn66w@zlang-mailbox>
 <YtCSAjiMc9RElnHu@mit.edu>
 <20220715180815.gegmapvruor6vin3@zlang-mailbox>
 <b424fd69-aeb4-f749-d09b-5d824454dd94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b424fd69-aeb4-f749-d09b-5d824454dd94@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 22, 2022 at 04:16:26PM +0800, Sun Ke wrote:
> 
> 1. The test run fsck automatically, and complain inconsistent，I think it
> need not run fsck.

The check script always run fscks after the test.  In order to
suppress the fsck complaint, we'll need to add this after the
resize2fs invocation:

_scratch_unmount
$DEBUGFS_PROG -w -R "set_super_value s_reserved_gdt_blocks 0" $SCRATCH_DEV \
        >>$seqres.full 2>&1

This resets the s_reserved_gdt_blocks field back to zero, so the fsck
doesn't fail.  Which is fine, because the point of the test is to see
whether the kernel dereferences a NULL pointer or not.

> 2. It warn missing kernel fix, but the commit had merged.

The way _fixed_by_kernel_commit works is if the test fails (for any
reason), it prints that you MAY be missing the bugfix commit:

> HINT: You _MAY_ be missing kernel fix:
>       b55c3cd102a6 ext4: add reserved GDT blocks check

		     	       		- Ted
