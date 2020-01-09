Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED1F135958
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jan 2020 13:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbgAIMeq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jan 2020 07:34:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:38186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731071AbgAIMeq (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 9 Jan 2020 07:34:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 91B69B2220;
        Thu,  9 Jan 2020 12:34:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CE00F1E0798; Thu,  9 Jan 2020 13:34:27 +0100 (CET)
Date:   Thu, 9 Jan 2020 13:34:27 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, Jan Kara <jack@suse.cz>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        joseph.qi@linux.alibaba.com, Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: Discussion: is it time to remove dioread_nolock?
Message-ID: <20200109123427.GD22232@quack2.suse.cz>
References: <20191226153118.GA17237@mit.edu>
 <9042a8f4-985a-fc83-c059-241c9440200c@linux.alibaba.com>
 <20200106122457.A10F7AE053@d06av26.portsmouth.uk.ibm.com>
 <20200107004338.GB125832@mit.edu>
 <20200107082212.GA25547@quack2.suse.cz>
 <20200107171109.GB3619@mit.edu>
 <20200107172236.GJ25547@quack2.suse.cz>
 <20200108104520.3BC4A4203F@d06av24.portsmouth.uk.ibm.com>
 <20200108174259.GD263696@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108174259.GD263696@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 08-01-20 12:42:59, Theodore Y. Ts'o wrote:
> On Wed, Jan 08, 2020 at 04:15:13PM +0530, Ritesh Harjani wrote:
> > > Yes, that's a good point. And I'm not opposed to that if it makes the life
> > > simpler. But I'd like to see some performance numbers showing how much is
> > > writeback using unwritten extents slower so that we don't introduce too big
> > > regression with this...
> > > 
> > 
> > Yes, let me try to get some performance numbers with dioread_nolock as
> > the default option for buffered write on my setup.
> 
> I started running some performance runs last night, and the

Thanks for the numbers! What is the difference between 'default-1' and
'default-2' configurations (and similarly between dioread_nolock-1 and -2
configurations)?

> interesting thing that I found was that fs_mark actually *improved*
> with dioread_nolock (with fsync enabled).  That may be an example of
> where fixing the commit latency caused by writeback can actually show
> up in a measurable way with benchmarks.

Yeah, that could be.

> Dbench was slightly impacted; I didn't see any real differences with
> compilebench or postmark.

Interestingly, dbench is also fsync(2)-bound workload (because the working
set is too small for anything else to actually reach the disk in
contemporary systems). But file sizes with dbench are smaller (under 100k)
than with fs-mark (1MB) so probably that's what makes the difference.

>  dioread_nolock did improve fio with
> sequential reads; which is interesting, since I would have expected
> with the inode_lock improvements, there shouldn't have been any
> difference.  So that may be a bit of wierdness that we should try to
> understand.

Yes, this is indeed strange. I don't see anything the DIO read path where
dioread_nolock would actually still matter.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
