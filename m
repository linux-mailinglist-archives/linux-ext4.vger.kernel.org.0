Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 885E3425E2
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jun 2019 14:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438997AbfFLMcG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Jun 2019 08:32:06 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48390 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2438952AbfFLMcF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Jun 2019 08:32:05 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5CCW0Ri020181
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jun 2019 08:32:01 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6EEBC420484; Wed, 12 Jun 2019 08:32:00 -0400 (EDT)
Date:   Wed, 12 Jun 2019 08:32:00 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
Subject: Re: [PATCH v3 2/2] shared/012: Add tests for filename casefolding
 feature
Message-ID: <20190612123200.GA2736@mit.edu>
References: <20190610173541.20511-1-krisman@collabora.com>
 <20190610173541.20511-2-krisman@collabora.com>
 <20190611121546.GC2774@mit.edu>
 <85y327z9ad.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85y327z9ad.fsf@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 12, 2019 at 01:01:46AM -0400, Gabriel Krisman Bertazi wrote:
> > I tried out this test, and it's apparently failing for me using
> > e2fsprogs 1.45.2; it looks like it's a whitespace issue?
> 
> Hi Ted,
> 
> Yes, definitely just whitespace.  But i don't understand why you are
> getting this behavior.  I tried both with the master branch of e2fsprogs
> and the tagged commit of v1.45.2 and on both occasions the test succeed
> in my system.  For sure I can use filter_spaces but I'm puzzled why I
> can't reproduce this.

That's wierd.  The kvm-xfstests appliance VM that's uploaded to

https://mirrors.edge.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests/

shows the problem.  With your patch applied to the xfstests-dev
directory after checking out xfstests-bld (see [1] for more
information if you haven't used kvm-xfstests before), it's reproducible via:

kvm-xfstests -I ../out_dir/root_fs.img.amd64 --update-xfstests-tar -c 4k shared/012

[1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

						- Ted
