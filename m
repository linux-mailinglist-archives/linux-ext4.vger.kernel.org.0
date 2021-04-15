Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9C03603FA
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Apr 2021 10:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhDOINr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Apr 2021 04:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231215AbhDOINq (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 15 Apr 2021 04:13:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 705696113D;
        Thu, 15 Apr 2021 08:13:21 +0000 (UTC)
Date:   Thu, 15 Apr 2021 10:13:18 +0200
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
Message-ID: <20210415081318.lmvxgztvlynbc4sq@wittgenstein>
References: <20210411151857.wd6gd46u53vlh2xv@wittgenstein>
 <YHMUAL/oD4fB3+R7@desktop>
 <20210411153223.vhcegiklrwoczy55@wittgenstein>
 <YHOW7DN51YuYgLPM@mit.edu>
 <20210412115426.a4bzsx4cp7jhx2ou@wittgenstein>
 <YHTMkBcVTFAGqyks@mit.edu>
 <YHdUzqZ7PZtb64zf@mit.edu>
 <20210415055408.GA8947@lst.de>
 <20210415074921.cf5uv4xehlctvtvv@wittgenstein>
 <20210415075537.GA12220@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210415075537.GA12220@lst.de>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 15, 2021 at 09:55:37AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 15, 2021 at 09:49:21AM +0200, Christian Brauner wrote:
> > However, as a general way of advertising to users that ext4 supports
> > idmapped mounts I don't necessarily see a problem with that. It doesn't
> > have implications for other filesystems and ext4 already advertises
> > other features in a similar way.
> 
> I still think that is a very bad idea.  idmapped mounts are foremost
> a VFS feature, with just a tiny bit of glue in every file system that
> does not affect the on-disk format.  So any discovery for it needs
> to be using VFS infrastructure.  IMHO just trying to mount is the
> proper way to do it, but if people want some other form of discovery
> it needs to be something in generic code.

I agree with you there.
I think fsinfo() (Arguably a slimmed-down version of it.) would've been
the best place for this.
