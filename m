Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1347E3B8793
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 19:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhF3RVT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 13:21:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42286 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232586AbhF3RVS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Jun 2021 13:21:18 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15UHIgcQ024107
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 13:18:42 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3F26B15C3C8E; Wed, 30 Jun 2021 13:18:42 -0400 (EDT)
Date:   Wed, 30 Jun 2021 13:18:42 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 5/9] generic/031: Fix the test case for 64k blocksize
 config
Message-ID: <YNyncumuIpVw/T1E@mit.edu>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
 <efd1594eeec7b893c47865ce5a94c25dc94dac28.1623651783.git.riteshh@linux.ibm.com>
 <20210630155001.GA13743@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630155001.GA13743@locust>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 30, 2021 at 08:50:01AM -0700, Darrick J. Wong wrote:
> > +# fcollapse need offset and len to be multiple of blocksize for filesystems
> > +# hence make this test work with 64k blocksize as well.
> ...
>
> What if the blocksize is 32k?

... or 8k?  or 16k?  (which might be more likely)

How bout if we change the offsets and lengths in the test so they are
all multiples of 64k, and adjusting 31.out appropriately?  That will
allow the test to work for block sizes up to 64k without needing to
having a special case for 031.out.64k.

I don't know of architectures with a page size > 64k (yet), so this
should hold us for a while.

				- Ted
