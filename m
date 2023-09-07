Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD717974E9
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Sep 2023 17:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjIGPmP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Sep 2023 11:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbjIGPXN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Sep 2023 11:23:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B896CC;
        Thu,  7 Sep 2023 08:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x59D2IKM2ENcunfMUi31gF7EGAqekeDkgrde65GH5Z4=; b=iaQw9YmCsXUi/lHY8+djPyx76U
        Z0erIVTGHSUeUkSH7loEZJHr6Uqyf3aNHHFmiPpJHk9WEj80MfKX6BkmDnJwWXtGxnlXvI4i6uqTD
        L6R+y9RRrGMOmC0zm7LXAmoexFqTEYUDIEjjoGAJOLKylyZ/9uX2OvSlNaCJuhKnFDihKzFWYiQXB
        7iRg3A3xTtnqZNHjzTnM6hWwxxyjrzTLT3WHCWaxxZuEf6fDfaYMXeoHEhGJvnokgJrmicL70bPrq
        4j+p3G3ISaf7pd3nx1x1IMyIiStCvkKePEtYiIgOAbeDDtTssxnsVHdSn0QW0jKA4OrbQhw0b/FZq
        huzaAurQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeFna-00BOXj-MV; Thu, 07 Sep 2023 14:15:58 +0000
Date:   Thu, 7 Sep 2023 15:15:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Zorro Lang <zlang@kernel.org>,
        linux-ext4@vger.kernel.org, fstests@vger.kernel.org,
        regressions@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [fstests generic/388, 455, 475, 482 ...] Ext4 journal recovery
 test fails
Message-ID: <ZPnbHhUDkmUQ5906@casper.infradead.org>
References: <ZPlH7rGfslnFmgYn@casper.infradead.org>
 <87r0na2jit.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0na2jit.fsf@doe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 07, 2023 at 07:05:38PM +0530, Ritesh Harjani wrote:
> Thanks Matthew for proposing the final changes using folio.
> (there were just some minor change required for fs/reiserfs/ for unused variables)
> Pasting the final patch below (you as the author with my Signed-off-by &
> Tested-by), which I have tested it on my system with "ext4/1k -g auto"

I'd rather split that patch up a bit -- I don't think the reiserfs
part fixes any actual problem.  I've pushed out
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/bh-fixes

or git clone git://git.infradead.org/users/willy/pagecache.git

I credited you as the author on the second two since I just tidied up
your proposed fixes.

I've also checked ocfs2 as the other user of JBD2 and I don't see any
problems there.
