Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68224315D5E
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Feb 2021 03:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbhBJCe6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Feb 2021 21:34:58 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52178 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235164AbhBJCd7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Feb 2021 21:33:59 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11A2X7Rb020699
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 Feb 2021 21:33:08 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5279515C39E3; Tue,  9 Feb 2021 21:33:07 -0500 (EST)
Date:   Tue, 9 Feb 2021 21:33:07 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH] ext4: add .kunitconfig fragment to enable ext4-specific
 tests
Message-ID: <YCNF4yP1dB97zzwD@mit.edu>
References: <20210210013206.136227-1-dlatypov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210013206.136227-1-dlatypov@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 09, 2021 at 05:32:06PM -0800, Daniel Latypov wrote:
> 
> After [2]:
>   $ ./tools/testing/kunit.py run --kunitconfig=fs/ext4/.kunitconfig

Any chance that in the future this might become:

$ ./tools/testing/kunit.py run --kunitconfig=fs/ext4

Or better yet, syntactic sugar like:

$ ./tools/testing/kunit.py test fs/ext4

would be really nice.

						- Ted
