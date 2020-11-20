Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69F82BA140
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 04:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgKTDg3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Nov 2020 22:36:29 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52534 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726282AbgKTDg3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Nov 2020 22:36:29 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AK3a1It028283
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 22:36:01 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D84FC420107; Thu, 19 Nov 2020 22:36:00 -0500 (EST)
Date:   Thu, 19 Nov 2020 22:36:00 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     yebin <yebin10@huawei.com>, jack@suse.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix race between do_invalidatepage and
 init_page_buffers
Message-ID: <20201120033600.GA695373@mit.edu>
References: <20200822082218.2228697-1-yebin10@huawei.com>
 <20200824155143.GH24877@quack2.suse.cz>
 <5F447351.6060207@huawei.com>
 <20200825084137.GA32298@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825084137.GA32298@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 25, 2020 at 10:41:37AM +0200, Jan Kara wrote:
> On Tue 25-08-20 10:11:29, yebin wrote:
> > Your patch certainly can fix the problem with my testcases, but I don't
> > think it's a good way. There are other paths that can call
> > do_invalidatepage , for instance block ioctl to discard and zero_range.
> 
> OK, good point! So my patch is a cleanup that stands on its own and we
> should do it regardless. But I agree we need more to completely fix this.
> I don't quite like the callback you've added just for this special case
> (furthermore it grows size of every buffer_head and there can be lots of
> those). But I agree with the general idea that we shouldn't discard buffers
> that the filesystem is working with.
> 
> In fact I believe that fallocate(2) and zeroout/discard ioctls should
> return EBUSY if they are run against a mounted device because with 99%
> probability something went wrong and you're accidentally discarding the
> wrong device. But maybe I'm wrong. I'll run this idea through other fs
> developers.

I'm going through old patches, and I'm trying to figure out where did
we end up on this issue?   Did we come to a conclusion on this?

One other thing which I noticed when looking at the original patch was
shouldn't lvreduce not be allowed to run on a LV which has a mounted
file system on its block device?

					- Ted
