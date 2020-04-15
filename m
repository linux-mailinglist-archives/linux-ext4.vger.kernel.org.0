Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8142E1AB39F
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Apr 2020 00:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbgDOWId (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Apr 2020 18:08:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48836 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728137AbgDOWIM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Apr 2020 18:08:12 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03FM7qjW008851
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Apr 2020 18:07:53 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5D5F642013D; Wed, 15 Apr 2020 18:07:52 -0400 (EDT)
Date:   Wed, 15 Apr 2020 18:07:52 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, stable@kernel.org,
        syzbot+bca9799bf129256190da@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: reject mount options not supported when remounting
 in handle_mount_opt()
Message-ID: <20200415220752.GA5187@mit.edu>
References: <to=00000000000098a5d505a34d1e48@google.com>
 <20200415174839.461347-1-tytso@mit.edu>
 <20200415202537.GA2309605@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415202537.GA2309605@iweiny-DESK2.sc.intel.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 15, 2020 at 01:25:37PM -0700, Ira Weiny wrote:
> This fundamentally changes the behavior from forcing the dax mode to be the
> same across the remount to only failing if we are going from non-dax to dax,
> adding -o dax on the remount?
> 
> But going from -o dax to 'not -o dax' would be ok?
> 
> FWIW after thinking about it some I _think_ it would be ok to allow the dax
> mode to change on a remount and let the inodes in memory stay in the mode they
> are at.  And newly loaded inodes would get the new mode...  Unfortunately
> without the STATX patch I have proposed the user does not have any way of
> knowing which files are in which mode.

We don't currently support mount -o nodax.  So the intention of the
current code is that the dax mode can't change in either direction
(enabling or disabling) as a remount option.

The syzkaller report was because changing dax mode racing with other
operations given the current code base, could result in a kernel OOPS.
So we *do* need to rule it out at least for now.

I certainly don't object to allowing changing dax mode as a remount
--- so long as we have tests to make sure that if we stress opening,
reading, writing, mmap'ing files, etc., while another thread is
flipping back and forth between dax=never and dax=always is mount -o
remount --- and make sure that we don't end up crashing.

And this test needs to be in xfstests, because trying to figure out
what triggers a syzkaller failures in file system land is a pain in
the *ss so we really want a dedicated xfstests for this case.  Have
you tested your patch series to make sure we don't have some potential
races here?

    	      	     	    	      	       	   - Ted
