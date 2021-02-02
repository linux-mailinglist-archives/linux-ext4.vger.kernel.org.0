Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023CC30B935
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Feb 2021 09:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhBBIF7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Feb 2021 03:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhBBIFz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Feb 2021 03:05:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD6DC061573;
        Tue,  2 Feb 2021 00:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GXKqg1wRs9RGvWZ1qTCHS+IG1zrHxoDxyev40JGQz0I=; b=FvPEpVXTiLIYOeqFYYGPHgfynw
        qZSL+6qvKRod0FOYIr48Dq6CWFH57jO2SiQzmAeOgGPYaBReWQ7b9l5/ioC5fjYRq/7JZPFEFr1ff
        f9qVB+5NtXQGwCORhFaTCqwyqIgWBWEjFVAn1ng8LV0OyVptXLlr6VLjDSAD0GmKXLqjspJRraDOR
        M/hg4oywu3pbkaN9MmTWUO6NbeHYeDjHu2K74GV1nbyEQIhys+yPQi7HkpvggU8ishRP9vnkyM7Jo
        HKGXREw7QzRQDRUE/aAem5OqUUfgG7/wCszzhqhpzcBqGUr10QhObKSbsqpsAigK8aYyQKFTzXQrB
        cL2VrZpQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l6qgO-00Eto6-7S; Tue, 02 Feb 2021 08:05:08 +0000
Date:   Tue, 2 Feb 2021 08:05:08 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Vinicius Tinti <viniciustinti@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] ext4: Enable code path when DX_DEBUG is set
Message-ID: <20210202080508.GA3550351@infradead.org>
References: <AAB32610-D238-4137-96DE-33655AAAB545@dilger.ca>
 <20210201003125.90257-1-viniciustinti@gmail.com>
 <20210201124924.GA3284018@infradead.org>
 <CALD9WKxc0kMPCHSoikko+qYk2+ZLUy73+ryKGW9qMSpyzAobLA@mail.gmail.com>
 <YBg20AuSC3/9w2zz@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBg20AuSC3/9w2zz@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 01, 2021 at 12:13:52PM -0500, Theodore Ts'o wrote:
> However, if there *is* a bug, having an early detection that the
> representation invariant of the data structure has been violated can
> be useful in root causing a bug.  This would probably be clearer if
> the code was pulled out into a separate function with comments
> explaining that this is a rep invariant check.
> 
> The main thing about DX_DEBUG right now is that it is **super**
> verbose.  Unwary users who enable it.... will be sorry.  If we want to
> make it to be a first-class feature enabled via CONFIG_EXT4_DEBUG, we
> should convert all of the dx_trace calls to use pr_debug so they are
> enabled only if dynamic debug enables those pr_debug() statements.
> And this should absolutely be a separate patch.

Yes.  The problem with a non-Kconfig ifdef is that is is almost
guaranteed to bitrot very fast, so you might as well just remove the
code.  The "if (0)", while ugly, at least ensures the code still
actually is seen and checked by the compiler.
