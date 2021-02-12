Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66D7319914
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Feb 2021 05:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBLEXs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 23:23:48 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37800 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229582AbhBLEXo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Feb 2021 23:23:44 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11C4MrdU001928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 23:22:54 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8A9D215C3601; Thu, 11 Feb 2021 23:22:53 -0500 (EST)
Date:   Thu, 11 Feb 2021 23:22:53 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH] ext4: add .kunitconfig fragment to enable ext4-specific
 tests
Message-ID: <YCYCnaEMc95hDfso@mit.edu>
References: <20210210013206.136227-1-dlatypov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210013206.136227-1-dlatypov@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 09, 2021 at 05:32:06PM -0800, Daniel Latypov wrote:
> As of [1], we no longer want EXT4_KUNIT_TESTS and others to `select`
> their deps. This means it can get harder to get all the right things
> selected as we gain more tests w/ more deps over time.
> 
> This patch (and [2]) proposes we store kunitconfig fragments in-tree to
> represent sets of tests. (N.B. right now we only have one ext4 test).
> 
> There's still a discussion to be had about how to have a hierarchy of
> these files (e.g. if one wanted to test all of fs/, not just fs/ext4).
> 
> But this fragment would likely be a leaf node and isn't blocked on
> deciding if we want `import` statements and the like.
> 
> Usage
> =====
> 
> Before [2] (on its way to being merged):
>   $ cp fs/ext4/.kunitconfig .kunit/
>   $ ./tools/testing/kunit.py run
> 
> After [2]:
>   $ ./tools/testing/kunit.py run --kunitconfig=fs/ext4/.kunitconfig

Thanks, applied, with one minor fixup.  The path to kunit.py is

./tools/testing/kunit/kunit.py

						- Ted
