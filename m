Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCE7C250F
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2019 18:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbfI3QZT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Sep 2019 12:25:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:58112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727767AbfI3QZT (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Sep 2019 12:25:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C2474ACC0;
        Mon, 30 Sep 2019 16:25:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E8A581E3C1B; Mon, 30 Sep 2019 18:25:36 +0200 (CEST)
Date:   Mon, 30 Sep 2019 18:25:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     kbuild test robot <lkp@intel.com>, Jan Kara <jack@suse.cz>,
        kbuild-all@01.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 17/19] jbd2: Rename h_buffer_credits to h_total_credits
Message-ID: <20190930162536.GB13973@quack2.suse.cz>
References: <20190930104339.24919-17-jack@suse.cz>
 <201909302058.uxNSY0q3%lkp@intel.com>
 <20190930150553.GB4001@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930150553.GB4001@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 30-09-19 11:05:53, Theodore Y. Ts'o wrote:
> On Mon, Sep 30, 2019 at 08:26:27PM +0800, kbuild test robot wrote:
> > Hi Jan,
> > 
> > I love your patch! Yet something to improve:
> > 
> > [auto build test ERROR on ext4/dev]
> > [cannot apply to v5.3 next-20190930]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Jan-Kara/ext4-Fix-transaction-overflow-due-to-revoke-descriptors/20190930-184615
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> > config: x86_64-randconfig-a004-201939 (attached as .config)
> > compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    fs/jbd2/transaction.c: In function 'jbd2_journal_start_reserved':
> > >> fs/jbd2/transaction.c:596:20: error: 'handle_t {aka struct jbd2_journal_handle}' has no member named 'h_buffer_credits'
> >         line_no, handle->h_buffer_credits);
> >                        ^
> 
> Yep, it looks like this instance of h_buffer_credits was missed in the
> patch, probably because Jan wasn't building with tracepoints enabled.
> I noticed this when I tried to do a test build.

The problem was that my patches were based on a kernel that didn't have
this code yet. I've rebased now on current Linus' tree and fixed this up in
my local tree (along with couple documentation warnings). But I don't think
it's worth resending just for this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
