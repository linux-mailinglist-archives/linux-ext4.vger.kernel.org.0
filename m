Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1706360D4F
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Apr 2021 17:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhDOPBa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Apr 2021 11:01:30 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53899 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234884AbhDOPAG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Apr 2021 11:00:06 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13FExS1V031149
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 10:59:29 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 547EE15C3B35; Thu, 15 Apr 2021 10:59:28 -0400 (EDT)
Date:   Thu, 15 Apr 2021 10:59:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christoph Hellwig <hch@lst.de>, Eryu Guan <guan@eryu.me>,
        Christian Brauner <brauner@kernel.org>,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH -RFC] ext4: add feature file to advertise that ext4
 supports idmapped mounts
Message-ID: <YHhU0MGFgiXMRrBn@mit.edu>
References: <20210411151249.6y34x7yatqtpcvi6@wittgenstein>
 <20210411151857.wd6gd46u53vlh2xv@wittgenstein>
 <YHMUAL/oD4fB3+R7@desktop>
 <20210411153223.vhcegiklrwoczy55@wittgenstein>
 <YHOW7DN51YuYgLPM@mit.edu>
 <20210412115426.a4bzsx4cp7jhx2ou@wittgenstein>
 <YHTMkBcVTFAGqyks@mit.edu>
 <YHdUzqZ7PZtb64zf@mit.edu>
 <20210415055408.GA8947@lst.de>
 <20210415074921.cf5uv4xehlctvtvv@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415074921.cf5uv4xehlctvtvv@wittgenstein>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 15, 2021 at 09:49:21AM +0200, Christian Brauner wrote:
> Harsh words. :)
> Christoph's right though I think for the xfstests we don't need it and
> we're covered with what we have in the version I sent out last Sunday.

Sorry, I had missed your v13 patch set and that it had included tests
for the existence of idmapped.  I had sent out the RFC patch because I
was under the impression that we hadn't made forward progress on
testing for the support idmapped mounts.

If we have a way of doing this, and you're comfortable that it is
reliable (e.g., that a bug might cause the test to be skipped because
it thinks the file system doesn't support idmapped mount, when really
it was caused by a regression), and I'm happy to just rely on the
method you've used in the v13 fstests patch set.

That being said, I still think it would be helpful to have a
VFS-standard way for userspace to be able to test for the presence of
a particular kernel feature/capability without having to do a test
mount, possibly requiring setting up a test user_ns, etc., etc.  But
that isn't as urgent as making sure we can easily the feature without
needing manual customization of the test suite as file systems add
support for the feature, or as the feature gets backported to
enterprise distro kernels.

Cheers,

					- Ted
