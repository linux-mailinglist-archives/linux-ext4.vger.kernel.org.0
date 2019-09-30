Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8BCC23E8
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2019 17:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbfI3PGL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Sep 2019 11:06:11 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38211 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726314AbfI3PGL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Sep 2019 11:06:11 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8UF5sdk019134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Sep 2019 11:05:55 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0C3E442014C; Mon, 30 Sep 2019 11:05:54 -0400 (EDT)
Date:   Mon, 30 Sep 2019 11:05:53 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     kbuild test robot <lkp@intel.com>
Cc:     Jan Kara <jack@suse.cz>, kbuild-all@01.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 17/19] jbd2: Rename h_buffer_credits to h_total_credits
Message-ID: <20190930150553.GB4001@mit.edu>
References: <20190930104339.24919-17-jack@suse.cz>
 <201909302058.uxNSY0q3%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909302058.uxNSY0q3%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 30, 2019 at 08:26:27PM +0800, kbuild test robot wrote:
> Hi Jan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on ext4/dev]
> [cannot apply to v5.3 next-20190930]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Jan-Kara/ext4-Fix-transaction-overflow-due-to-revoke-descriptors/20190930-184615
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> config: x86_64-randconfig-a004-201939 (attached as .config)
> compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    fs/jbd2/transaction.c: In function 'jbd2_journal_start_reserved':
> >> fs/jbd2/transaction.c:596:20: error: 'handle_t {aka struct jbd2_journal_handle}' has no member named 'h_buffer_credits'
>         line_no, handle->h_buffer_credits);
>                        ^

Yep, it looks like this instance of h_buffer_credits was missed in the
patch, probably because Jan wasn't building with tracepoints enabled.
I noticed this when I tried to do a test build.

       			    	   	    - Ted
