Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425803603B3
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Apr 2021 09:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhDOHtu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Apr 2021 03:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhDOHtu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 15 Apr 2021 03:49:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DA30611F1;
        Thu, 15 Apr 2021 07:49:24 +0000 (UTC)
Date:   Thu, 15 Apr 2021 09:49:21 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Theodore Ts'o <tytso@mit.edu>, Eryu Guan <guan@eryu.me>,
        Christian Brauner <brauner@kernel.org>,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH -RFC] ext4: add feature file to advertise that ext4
 supports idmapped mounts
Message-ID: <20210415074921.cf5uv4xehlctvtvv@wittgenstein>
References: <YHMH/JRmzg3ETcED@desktop>
 <20210411151249.6y34x7yatqtpcvi6@wittgenstein>
 <20210411151857.wd6gd46u53vlh2xv@wittgenstein>
 <YHMUAL/oD4fB3+R7@desktop>
 <20210411153223.vhcegiklrwoczy55@wittgenstein>
 <YHOW7DN51YuYgLPM@mit.edu>
 <20210412115426.a4bzsx4cp7jhx2ou@wittgenstein>
 <YHTMkBcVTFAGqyks@mit.edu>
 <YHdUzqZ7PZtb64zf@mit.edu>
 <20210415055408.GA8947@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210415055408.GA8947@lst.de>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 15, 2021 at 07:54:08AM +0200, Christoph Hellwig wrote:
> On Wed, Apr 14, 2021 at 04:47:10PM -0400, Theodore Ts'o wrote:
> > On Mon, Apr 12, 2021 at 06:41:20PM -0400, Theodore Ts'o wrote:
> > > In the ideal world, if the kernel wasn't compiled with the necessary
> > > CONFIG options enabled, it's desirable of the test can detect that
> > > fact and skip running the test instead failing and forcing the person
> > > running the test to try to figure out whether this is a legitmate file
> > > system bug or a just a test setup bug.
> > 
> > So it would make it easier for me to manage running xfstests on ext4
> > if I had added something like this to ext4 and sent it to Linus before
> > v5.12 is released.  What do folks think?
> 
> Completely stupid.  This is a VFS-level feature and we need to have
> proper VFS-level testing (which we have through creating a mount
> with the option), not fs-specific band aids.

Harsh words. :)
Christoph's right though I think for the xfstests we don't need it and
we're covered with what we have in the version I sent out last Sunday.

However, as a general way of advertising to users that ext4 supports
idmapped mounts I don't necessarily see a problem with that. It doesn't
have implications for other filesystems and ext4 already advertises
other features in a similar way.

Christian
