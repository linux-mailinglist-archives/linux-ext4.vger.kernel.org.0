Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC05EF7AB7
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2019 19:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfKKSY2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Nov 2019 13:24:28 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55736 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726821AbfKKSY2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Nov 2019 13:24:28 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xABIOH6Y022708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 13:24:18 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 16C0A4202FD; Mon, 11 Nov 2019 13:24:17 -0500 (EST)
Date:   Mon, 11 Nov 2019 13:24:17 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     syzbot <syzbot+9567fda428fba259deba@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Jan Kara <jack@suse.cz>
Subject: Re: general protection fault in ext4_writepages
Message-ID: <20191111182417.GB5165@mit.edu>
References: <00000000000073d3a70597069799@google.com>
 <20191111051236.2717D11C05B@d06av25.portsmouth.uk.ibm.com>
 <20191111053231.F129B11C04C@d06av25.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111053231.F129B11C04C@d06av25.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 11, 2019 at 11:02:31AM +0530, Ritesh Harjani wrote:
> 
> Updating the link.
> 
> On 11/11/19 10:42 AM, Ritesh Harjani wrote:
> > Hello Ted,
> > 
> > This issue seems to be coming via fault injection failure in slab
> > allocation. This should be fixed via below patch on your latest ext4
> > branch.
> > 
> > https://marc.info/?l=linux-ext4&m=804&w=2
> https://marc.info/?l=linux-ext4&m=157303310723804&w=2

Agreed, although unfortunately I wasn't able to make the reproducer
cause a failure _without_ the patch.  Perhaps something other than
enabling FAILSLAB and KASAN was needed?

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test

Let's see if the Syzbot can confirm that the patch addresses the problem.

      	     	 	    	    	 - Ted
