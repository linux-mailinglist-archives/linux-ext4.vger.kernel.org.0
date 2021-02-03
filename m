Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B938B30D321
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Feb 2021 06:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhBCFkF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Feb 2021 00:40:05 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51259 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229502AbhBCFkD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Feb 2021 00:40:03 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1135d3Oe004504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 Feb 2021 00:39:04 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 63F7215C39E2; Wed,  3 Feb 2021 00:39:03 -0500 (EST)
Date:   Wed, 3 Feb 2021 00:39:03 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Vinicius Tinti <viniciustinti@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3] ext4: Enable code path when DX_DEBUG is set
Message-ID: <YBo29/SdgCkZZinT@mit.edu>
References: <20210202080508.GA3550351@infradead.org>
 <20210202162837.129631-1-viniciustinti@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202162837.129631-1-viniciustinti@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 02, 2021 at 04:28:37PM +0000, Vinicius Tinti wrote:
> Clang with -Wunreachable-code-aggressive is being used to try to find
> unreachable code that could cause potential bugs. There is no plan to
> enable it by default.
> 
> The following code was detected as unreachable:
> 
> fs/ext4/namei.c:831:17: warning: code will never be executed
> [-Wunreachable-code]
>                         unsigned n = count - 1;
>                                      ^~~~~
> fs/ext4/namei.c:830:7: note: silence by adding parentheses to mark code as
> explicitly dead
>                 if (0) { // linear search cross check
>                     ^
>                     /* DISABLES CODE */ ( )
> 
> This has been present since commit ac27a0ec112a ("[PATCH] ext4: initial
> copy of files from ext3") and fs/ext3 had it present at the beginning of
> git history. It has not been changed since.
> 
> This patch moves the code to a new function `htree_rep_invariant_check`
> which only performs the check when DX_DEBUG is set. This allows the
> function to be used in other parts of the code.
> 
> Suggestions from: Andreas, Christoph, Nathan, Nick and Ted.
> 
> Signed-off-by: Vinicius Tinti <viniciustinti@gmail.com>

Thanks, applied, although I rewrote the commit description:

    ext4: factor out htree rep invariant check
    
    This patch moves some debugging code which is used to validate the
    hash tree node when doing a binary search of an htree node into a
    separate function, which is disabled by default (since it is only used
    by developers when they are modifying the htree code paths).
    
    In addition to cleaning up the code to make it more maintainable, it
    silences a Clang compiler warning when -Wunreachable-code-aggressive
    is enabled.  (There is no plan to enable this warning by default, since
    there it has far too many false positives; nevertheless, this commit
    reduces one of the many false positives by one.)

The original description buried the lede, in terms of the primary
reason why I think the change was worthwhile (although I know you have
different priorities than mine :-).

Thanks for working to find a way to improve the code in a way that
makes both of us happy!

					- Ted
