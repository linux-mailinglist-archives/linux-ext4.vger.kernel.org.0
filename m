Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADA71F5811
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jun 2020 17:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgFJPqI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Jun 2020 11:46:08 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56549 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728075AbgFJPqH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 Jun 2020 11:46:07 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 05AFjhUl030042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 11:45:44 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5489B4200DD; Wed, 10 Jun 2020 11:45:43 -0400 (EDT)
Date:   Wed, 10 Jun 2020 11:45:43 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "zhangyi (F)" <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 00/10] ext4: fix inconsistency since reading old metadata
 from disk
Message-ID: <20200610154543.GI1347934@mit.edu>
References: <20200526071754.33819-1-yi.zhang@huawei.com>
 <20200608082007.GJ13248@quack2.suse.cz>
 <cc834f50-95f0-449a-0ace-c55c41d2be1c@huawei.com>
 <20200609121920.GB12551@quack2.suse.cz>
 <45796804-07f7-2f62-b8c5-db077950d882@huawei.com>
 <20200610095739.GE12551@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610095739.GE12551@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 10, 2020 at 11:57:39AM +0200, Jan Kara wrote:
> > So I guess it may still lead to inconsistency. How about add this checking
> > into ext4_journal_get_write_access() ?
> 
> Yes, this also occured to me later. Adding the check to
> ext4_journal_get_write_access() should be safer.

There's another thing which we could do.  One of the issues is that we
allow buffered writeback for block devices once the change to the
block has been committed.  What if we add a change to block device
writeback code and in fs/buffer.c so that optionally, the file system
can specify a callback function can get called when an I/O error has
been reflected back up from the block layer?

It seems unfortunate that currently, we can immediately report the I/O
error for buffered writes to *files*, but for metadata blocks, we
would only be able to report the problem when we next try to modify
it.

Making changes to fs/buffer.c might be controversial, but I think it
might be result in a better solution.

     	       	       	    	      - Ted
