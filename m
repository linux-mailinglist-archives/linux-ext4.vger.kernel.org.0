Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC4870112E
	for <lists+linux-ext4@lfdr.de>; Fri, 12 May 2023 23:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbjELV3d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 May 2023 17:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbjELV3Z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 May 2023 17:29:25 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9146493F6
        for <linux-ext4@vger.kernel.org>; Fri, 12 May 2023 14:28:55 -0700 (PDT)
Received: from letrec.thunk.org (vancouverconventioncentre.com [72.28.92.214] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34CLSaWE024212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 17:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683926919; bh=Aj9BnkNGw6/2uvxB0BDTpN1Mfq0EuWdf9g6cRmD5wug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MN6iDq0eUf2x+oWww7mcG40HWDhdFb9ErMDx+HCB+0S+ZXBleRvVi3s75gpxtJ6CC
         2ttGhOzBOOUuia2FZ3cA8PxHB5ihsi9cONwUM9eC98hPfOCVmz8RDHSv4ZbjLCl7+S
         Ai7tpBb1zh0qa7difrHKAUytaPTYf6kktZrU9McAsRWwUc1bIJpZChVrkr+eri/UgI
         XmzcpIxPARvCXrAoIYkxnywRfaZ31GorD+ZJ1A9cKM54AgxDeG1HlH+tn9/jxN5mVx
         0JBL5X9G8LkPYiY4oON6im7fReYWB5zC2qLsznLUSFKPb8SNqGk1PJduoi14Lt8VdT
         5gPEAy1DNuirg==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 0585A8C0439; Fri, 12 May 2023 17:28:36 -0400 (EDT)
Date:   Fri, 12 May 2023 17:28:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+1966db24521e5f6e23f7@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in
 get_max_inline_xattr_value_size
Message-ID: <ZF6vgw+DUP7/orzj@mit.edu>
References: <000000000000cdfab505f819529a@google.com>
 <20230421084431.ynek7epoy3mceecr@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421084431.ynek7epoy3mceecr@quack3>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 21, 2023 at 10:44:31AM +0200, Jan Kara wrote:
> The problem seems to be that get_max_inline_xattr_value_size() is iterating
> xattr space like:
> 
>         for (; !IS_LAST_ENTRY(entry); entry = EXT4_XATTR_NEXT(entry)) {
>                 if (!entry->e_value_inum && entry->e_value_size) {
>                         size_t offs = le16_to_cpu(entry->e_value_offs);
>                         if (offs < min_offs)
>                                 min_offs = offs;
>                 }
>         }
> 
> without checking for validity of the structures and we can reach this path
> without verifying xattrs are valid. Perhaps we should verify in-inode xattr
> data as part for __ext4_iget()?

We do check that the xattrs are valid when the inline file is opened,
and we would reject the open in that case, so the write system call
would never be able to operate on the corrupted inode....  except when
the reproducer has opened the block device and starts scribbling on
the inode table.

The only way we can stop this particular out-of-bounds read is to add
bounds checking in the above loop.  Patch follows (which has been
tested by syzbot).

						- Ted
