Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C35A30AD48
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Feb 2021 18:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhBAQ74 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Feb 2021 11:59:56 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54630 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231294AbhBAQ74 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Feb 2021 11:59:56 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 111GwwfD032019
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 Feb 2021 11:58:58 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2EEEB15C39D9; Mon,  1 Feb 2021 11:58:58 -0500 (EST)
Date:   Mon, 1 Feb 2021 11:58:58 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Vinicius Tinti <viniciustinti@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] ext4: Enable code path when DX_DEBUG is set
Message-ID: <YBgzUoq2Jla7pXAG@mit.edu>
References: <AAB32610-D238-4137-96DE-33655AAAB545@dilger.ca>
 <20210201003125.90257-1-viniciustinti@gmail.com>
 <20210201124924.GA3284018@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201124924.GA3284018@infradead.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 01, 2021 at 12:49:24PM +0000, Christoph Hellwig wrote:
> DX_DEBUG is completely dead code, so either kill it off or make it an
> actual CONFIG_* symbol through Kconfig if it seems useful.

I wouldn't call it completely dead code.  If you manually add "#define
DX_DEBUG" fs/ext4/namei.c compiles without any problems.  I believe it
was most recently used when we added large htree support.

It's true that it can only be enabled via manually enabled via manual
editing of the .c file, but it's *really* something that only
developers who are actively involved in modifying the code would want
to use.  Sure, we could add work to add debug levels to all of the
dxtrace() statements, and/or switch it all to dyndebug.  We'd also
have to figure out how to get rid of all of the KERN_CONT printk's in
the ideal world.  The question is whether doing all of this is
worth it if the goal is to shut up some clang warnings.

	      	    	     	   - Ted
