Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F416442D071
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Oct 2021 04:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhJNCdu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Oct 2021 22:33:50 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44784 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229834AbhJNCdu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Oct 2021 22:33:50 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19E2VbVR011473
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 22:31:38 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8006715C00CA; Wed, 13 Oct 2021 22:31:37 -0400 (EDT)
Date:   Wed, 13 Oct 2021 22:31:37 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     xueqingwen <xueqingwen@baidu.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhaojie <zhaojie17@baidu.com>,
        jimyan <jimyan@baidu.com>
Subject: Re: [PATCH] ext4: start the handle later in ext4_writepages() to
 avoid unnecessary wait
Message-ID: <YWeWiUQ1bSujcCzc@mit.edu>
References: <20210923121204.5772-1-xueqingwen@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923121204.5772-1-xueqingwen@baidu.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 23, 2021 at 08:12:04PM +0800, xueqingwen wrote:
>   ....
> Therefore, the handle was delayed to start until finding the pages that
> need mapping in ext4_writepages(). With this patch, the above problem did
> not recur. We had looked this patch over pretty carefully, but another pair
> of eyes would be appreciated. Please help to review whether there are
> defects and whether it can be merged to upstream.

Hi,

I've tried tests against this patch, and it's causing a large number
of hangs.  For most of the hangs, it's while running generic/269,
although there were a few other tests which would cause the kernel to
hang.

I don't have time to try to figure out why your patch might be
failing, at least not this week.  So if you could take a look at at
the test artifiacts in this xz compressed tarfile, I'd appreciate it.
The "report" file contains a summary report, and the *.serial files
contain the output from the serial console of the VM's which were
hanging with your patch applied.  Perhaps you can determine what needs
to be fixed to prevent the kernel hangs?

https://drive.google.com/file/d/1sk2wx6w3D-grO0WihbIiX2LonthjpOTf/view?usp=sharing

The above link will allow you to download 4 megabyte file:

  results.ltm-20211013191843.5.15.0-rc4-xfstests-00010-ged577e416dce.tar.xz

Cheers,

						- Ted

P.S.  What sort of testing had you run against your change before you
submitted it for upstream review?  The above set of test artifacts was
generated using gce-xfstests, and while you might not have access to
the Google Cloud Platform, the same xfstests-bld infrastructure which
I also provides kvm-xfstests.  For more information please see:

https://thunk.org/gce-xfstests
https://github.com/tytso/xfstests-bld/blob/master/Documentation/00-index.md

The above test artifact found in the Google Drive link was generated
via: 

gce-xfstests launch-ltm
gce-xfstests install-kconfig
gce-xfstests kbuild
gce-xfstests ltm full

If you are using kvm-xfstests, you can run the equivalent set of tests
via a set of commands like this:

kvm-xfstests install-kconfig
kvm-xfstests kbuild
kvm-xfstests full

But it might take over 24 hours to run, and the first time the kernel
hangs, it will stop the full test.  With gce-xfstests's lightweight
test manager (ltm), it runs the test VM's in parallel, and I can get
an e-mailed report in my inbox in roughly two and half hours.

For future reference, it would save me a lot of time ext4 developers
could run "kvm-xfstests smoke" (takes about 20 minutes) or
"kvm-xfstests -c ext4/4k -g auto" (takes about 2 hours) before
sending a patch for review.
